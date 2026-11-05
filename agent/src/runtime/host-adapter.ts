import type { Context } from '@deepseek-ai/cordis';
import type { Agent, AgentHandle, CreateAgentOptions } from '@deepseek-ai/dsh-agent';
import { SessionId, type SessionEvent } from '@deepseek-ai/dsh-session';
import { MessageId, type GenerateOptions, type StreamChunk } from '@deepseek-ai/dsh-llm';
import '@deepseek-ai/dsh-tools';
import type { ToolDefinition } from '@deepseek-ai/dsh-tools';
import '@deepseek-ai/dsh-system-prompt';
import '@deepseek-ai/dsh-session-persistence';
import { Sandbox } from './sandbox.js';
import type { Config } from '../config.js';
import type { HostAdapter, HostInput, HostResult, WorkObservation } from '../contracts.js';
import type { DailyBudget } from '../budget/daily-budget.js';
import type { ImageBlock } from '@deepseek-ai/dsh-llm';
import '@deepseek-ai/dsh-attachment';
import { decodeReply } from '../egress/reply-format.js';
import { randomUUID } from 'node:crypto';
import { normalizeUsage } from '../budget/pricing.js';
import type { TraceObservation } from '../storage/trace.js';

/** The sole SDK boundary. Each conversation resumes one durable DSH session and appends only identified new input. */
export class DshHostAdapter implements HostAdapter {
  private recordWork?: (input: HostInput, event: WorkObservation) => void;
  setWorkRecorder(record: (input: HostInput, event: WorkObservation) => void) { this.recordWork = record; }
  private handles = new Set<AgentHandle>();
  private inputs = new Map<string, { input: HostInput; agent: Agent }>();
  private budget?: DailyBudget;
  private observe?: (inputId: string, event: TraceObservation, key?: string) => void;
  setTrace(observe: (inputId: string, event: TraceObservation, key?: string) => void) { this.observe = observe; }
  private trace(inputId: string, event: TraceObservation, key?: string) {
    // Observability must not change model/send behavior if an optional trace write fails.
    try { this.observe?.(inputId, event, key); } catch { /* Core durable run/outbox rows remain authoritative. */ }
  }
  private removeMeter: () => void;
  channelTools?: (input: HostInput, signal: AbortSignal) => ToolDefinition[];
  available(provider: string) { return this.ctx.llm.listProviders().some(p => p.id === provider); }
  setBudget(budget: DailyBudget) { this.budget = budget; }
  async imageAttachment(input: HostInput, data: Uint8Array, mediaType: ImageBlock['attachment']['mediaType'], name: string, signal: AbortSignal) {
    signal.throwIfAborted();
    const model = await this.ctx.llm.resolveModelInfo(input.provider, input.model, signal);
    if (!model.inputModalities?.includes('image')) throw Error('model_image_input_not_supported');
    const attachments = this.ctx.get('attachments');
    if (!attachments) throw Error('image_attachment_store_unavailable');
    const ref = await attachments.saveImage({ data, mediaType, name });
    signal.throwIfAborted(); return ref;
  }
  constructor(readonly ctx: Context, readonly config: Config) {
    for (const service of ['agents', 'sessionPersistence', 'sessions', 'tools', 'systemPrompt'])
      if (!ctx.get(service)) throw Error('missing_host_service:' + service);
    this.removeMeter = ctx.on('llm/stream', (options, next) => this.meter(options, next));
  }
  private async *meter(options: GenerateOptions, next: () => AsyncIterable<StreamChunk>): AsyncIterable<StreamChunk> {
    const owner = [...this.inputs.values()].find(({ input }) => options.messages.some(m => m.id === input.inputId));
    if (!owner) { yield* next(); return; }
    const id = this.budget && this.config.budget.enabled ? this.budget.reserve(owner.input, options, owner.agent.session.seq) : undefined;
    const requestId = id ?? randomUUID();
    this.trace(owner.input.inputId, { phase: 'request', state: 'started', details: { requestId } });
    let complete = false;
    try {
      for await (const chunk of next()) {
        if (chunk.type === 'usage') {
          if (id) this.budget!.recordUsage(id, chunk.usage);
          try {
            const usage = normalizeUsage(chunk.usage);
            this.trace(owner.input.inputId, { phase: 'request', state: 'usage', details: { requestId,
              inputTokens:usage.inputTokens,outputTokens:usage.outputTokens,
              ...(chunk.usage.cacheReadTokens === undefined ? {} : {cacheReadTokens:usage.cacheReadTokens}),
              ...(chunk.usage.cacheWriteTokens === undefined ? {} : {cacheWriteTokens:usage.cacheWriteTokens}) } });
          } catch { /* Invalid usage is never invented. */ }
        }
        if (chunk.type === 'finish') {
          complete = ['stop', 'tool-calls', 'max-tokens'].includes(chunk.reason.kind);
          const failure = chunk.reason.kind === 'error' ? chunk.reason.failure.code : undefined;
          const code = chunk.reason.kind === 'max-tokens' ? 'MAX_TOKENS' : failure && ['TRANSPORT', 'RATE_LIMIT', 'TIMEOUT', 'CONNECTION', 'OVERLOADED'].includes(failure) ? failure : undefined;
          this.trace(owner.input.inputId, { phase: 'request', state: 'finished', details: { requestId, reason: chunk.reason.kind, ...(code ? { code } : {}) } });
        }
        yield chunk;
      }
    } catch (error) {
      if (error instanceof Error && error.message === 'invalid_budget_accounting') this.budget?.stop('budget_accounting_unavailable');
      this.trace(owner.input.inputId, { phase: 'request', state: 'failed', details: { requestId, code: 'model_request_error' } });
      throw error;
    } finally { if (id) this.budget!.finish(id, complete); }
  }
  async execute(input: HostInput, signal: AbortSignal): Promise<HostResult> {
    if (signal.aborted) return { status: 'cancelled', replies: [] };
    const id = SessionId(input.executionId);
    const exists = !!await this.ctx.sessionPersistence.stat(id);
    if (exists) {
      const reader = await this.ctx.sessionPersistence.open(id, 'read');
      let accepted: boolean;
      try { accepted = (await reader.read()).events.some(e => e.type === 'user/message' && e.data.id === input.inputId); }
      finally { await reader.close(); }
      if (accepted) return await this.reconcile(input) ?? { status: 'needs_review', replies: [] };
    }
    const cwd = new Sandbox(this.config.root, input.session.key).root;
    const modelInfo = await this.ctx.llm.resolveModelInfo(input.provider, input.model, signal);
    const memoryEffort = input.purpose === 'memory' ? modelInfo.reasoning?.efforts[0]?.id : undefined;
    const options: Omit<CreateAgentOptions, 'sessionId' | 'meta'> = { signal,
      agentOptions: { provider: input.provider, model: input.model, maxTokens: input.purpose === 'reply' ? 4096 : input.purpose === 'memory' ? 4096 : 1600,
        ...(memoryEffort === undefined ? {} : { reasoningEffort: memoryEffort }) },
      setup: async agentCtx => {
        const tools = input.purpose === 'reply' && !input.proactive ? this.channelTools?.(input, signal) ?? [] : [];
        const allowed = new Set(tools.map(t => t.name));
        agentCtx.tools.presentAs('native');
        agentCtx.tools.restrict({ allow: [] });
        let workPersistenceFailed = false;
        for (const tool of tools) agentCtx.tools.register({ ...tool, execute: async (...args) => {
          const callId = args[1].callId;
          try { this.recordWork?.(input, { callId, name: tool.name, arguments: args[0], state: 'started' }); }
          catch { workPersistenceFailed = true; throw Error('work_persistence_failed'); }
          this.trace(input.inputId, { phase: 'tool', state: 'started', details: { callId, name: tool.name } });
          let result;
          try {
            result = await tool.execute(...args);
          } catch (error) {
            const code = error instanceof Error && /^[a-z][a-z0-9_]{0,79}$/.test(error.message) ? error.message :
              ['EACCES','ENOENT','EPERM','EISDIR','ENOTDIR'].includes((error as NodeJS.ErrnoException)?.code ?? '') ? (error as NodeJS.ErrnoException).code! :
              error instanceof Error && error.name === 'TimeoutError' ? 'tool_timeout' : error instanceof Error && error.name === 'AbortError' ? 'tool_aborted' : 'tool_execution_error';
            this.recordWork?.(input, { callId, name: tool.name, state: 'failed', result: { error: code } });
            this.trace(input.inputId, { phase: 'tool', state: 'failed', details: { callId, name: tool.name, code } });
            throw error;
          }
          // Persist before returning to the model; a persistence failure must not rerun a side effect.
          try { this.recordWork?.(input, { callId, name: tool.name, state: 'completed', result }); }
          catch { workPersistenceFailed = true; throw Error('work_persistence_failed'); }
          this.trace(input.inputId, { phase: 'tool', state: 'completed', details: { callId, name: tool.name } });
          return result;
        } });
        let steps = 0;
        agentCtx.tools.guard(exec => !workPersistenceFailed && allowed.has(exec.name) && ++steps <= this.config.runtime.maxToolSteps ? undefined : 'wechat_tool_denied');
        agentCtx.on('agent/pre-step', async (payload, next) => payload.step > this.config.runtime.maxToolSteps ? { kind: 'reject' } : next());
        agentCtx.systemPrompt.section({ name: 'wechat:trusted', order: 0, text: input.system, complete: true, interpolate: false });
        // Freeze the conversation's leading instruction prefix; never inject sliding history or summaries each turn.
        agentCtx.on('system-prompt/assemble', async (_assembly, _context, next) => {
          const assembly = await next(); return { ...assembly, contexts: [], tools: assembly.tools.filter(t => allowed.has(t.name)) };
        });
      },
    };
    const handle = exists ? await this.ctx.agents.resume({ resumeSessionId: id, ...options }) :
      await this.ctx.agents.create({ sessionId: id, meta: { cwd }, ...options });
    this.handles.add(handle);
    this.inputs.set(input.inputId, { input, agent: handle.agent });
    const cancel = () => handle.agent.cancel({ kind: 'user' });
    signal.addEventListener('abort', cancel, { once: true });
    try {
      if (signal.aborted) return { status: 'cancelled', replies: [] };
      handle.agent.followup({ id: MessageId(input.inputId), role: 'user', source: { kind: 'user' },
        content: [{ type: 'text', text: input.context }] });
      await handle.agent.whenIdle();
      // whenIdle is not itself a persistence barrier in this locked SDK.
      if (!await this.ctx.sessions.flush(handle.agent.session)) throw Error('host_session_not_persisted');
      const result = await this.reconcile(input) ?? { status: 'needs_review' as const, replies: [] };
      if (result.contextUsage && modelInfo.context) result.contextUsage.windowTokens = modelInfo.context.contextWindow;
      return result;
    } finally {
      signal.removeEventListener('abort', cancel);
      await handle.dispose(); this.handles.delete(handle); this.inputs.delete(input.inputId);
    }
  }
  async reconcile(input: HostInput): Promise<HostResult | undefined> {
    const id = SessionId(input.executionId);
    if (!await this.ctx.sessionPersistence.stat(id)) return undefined;
    // Read stored logs without resuming an orphaned driver or draining its inbox.
    const reader = await this.ctx.sessionPersistence.open(id, 'read');
    try {
      const events = (await reader.read()).events;
      this.budget?.reconcile(input.executionId, events);
      const start = events.find(e => e.type === 'user/message' && e.data.id === input.inputId)?.seq ?? Infinity;
      const stop = events.find(e => e.type === 'user/message' && e.seq > start)?.seq ?? Infinity;
      for (const event of events) {
        if (event.type !== 'tool/call' || event.seq <= start || event.seq >= stop) continue;
        const result = events.find(e => e.type === 'tool/result' && e.data.message.toolCallId === event.data.callId);
        let argumentsValue: unknown = event.data.arguments;
        try { argumentsValue = JSON.parse(event.data.arguments); } catch { /* Retain invalid arguments as evidence. */ }
        this.recordWork?.(input, { callId: event.data.callId, name: event.data.name, arguments: argumentsValue,
          state: result?.type === 'tool/result' ? result.data.message.isError ? 'failed' : 'completed' : 'unknown',
          result: result?.type === 'tool/result' ? result.data.message.content : { unavailable: 'interrupted_tool_call_do_not_retry_side_effects' } });
      }
      return projectCommitted(input, events);
    }
    finally { await reader.close(); }
  }
  async close() { await Promise.all([...this.handles].map(h => h.dispose())); this.handles.clear(); this.inputs.clear(); this.removeMeter(); }
}

export function projectCommitted(input: HostInput, events: readonly SessionEvent[]): HostResult {
  const accepted = events.find(e => e.type === 'user/message' && e.data.id === input.inputId);
  if (!accepted) return { status: 'needs_review', replies: [] };
  const nextInput = events.find(e => e.type === 'user/message' && e.seq > accepted.seq)?.seq ?? Infinity;
  const own = events.filter(e => e.seq > accepted.seq && e.seq < nextInput);
  const end = own.findLast(e => e.type === 'turn/end');
  if (!end || end.type !== 'turn/end') return { status: 'needs_review', replies: [] };
  const usageEvent = own.findLast(e => e.type === 'assistant/message' || e.type === 'assistant/attempt');
  const usage = usageEvent && (usageEvent.data as { usage?: { inputTokens: number; outputTokens?: number; cacheReadTokens?: number; cacheWriteTokens?: number } }).usage;
  const context = usage ? { contextUsage: { inputTokens: usage.inputTokens + (usage.cacheReadTokens ?? 0) + (usage.cacheWriteTokens ?? 0), outputTokens: usage.outputTokens ?? 0 } } : {};
  if (end.data.reason.kind !== 'completed') {
    const reason = end.data.reason;
    const failureCode = reason.kind === 'max-tokens' ? 'MAX_TOKENS' : reason.kind === 'error' && ['TRANSPORT', 'RATE_LIMIT', 'TIMEOUT', 'CONNECTION', 'OVERLOADED', 'CONTEXT_WINDOW_EXCEEDED'].includes(reason.error.code ?? '') ? reason.error.code : undefined;
    return { status: reason.kind === 'aborted' ? 'cancelled' : 'failed', replies: [], ...context, ...(failureCode ? { failureCode } : {}) };
  }
  const message = own.findLast(e => e.type === 'assistant/message' && e.seq < end.seq);
  if (!message || message.type !== 'assistant/message') return { status: 'completed', replies: [], ...context };
  const text = message.data.message.content.filter(b => b.type === 'text').map(b => b.type === 'text' ? b.text : '').join('\n').trim();
  if (input.purpose === 'reply') {
    const decoded = decodeReply(text);
    return { status: 'completed', replies: decoded.messages.length ? [{ id: `${input.executionId}:${message.seq}`, ...decoded }] : [], ...context };
  }
  return { status: 'completed', replies: text ? [{ id: `${input.executionId}:${message.seq}`, text }] : [], ...context };
}
