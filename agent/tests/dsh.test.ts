import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync, cpSync, mkdirSync } from 'node:fs';
import { join, relative, isAbsolute } from 'node:path';
import { tmpdir } from 'node:os';
import { randomUUID } from 'node:crypto';
import { Context } from '@deepseek-ai/cordis';
import Llm, { LlmAdapter, ToolCallId, type GenerateOptions, type StreamChunk } from '@deepseek-ai/dsh-llm';
import Agents from '@deepseek-ai/dsh-agent';
import Sessions, { SessionId } from '@deepseek-ai/dsh-session';
import SystemPrompt from '@deepseek-ai/dsh-system-prompt';
import Tools from '@deepseek-ai/dsh-tools';
import AgentLoop from '@deepseek-ai/dsh-agent-loop';
import Projections from '@deepseek-ai/dsh-session-projection';
import * as Persistence from '@deepseek-ai/dsh-session-persistence-jsonl';
import * as Checkpoint from '@deepseek-ai/dsh-session-checkpoint-policy';
import { DshHostAdapter } from '../src/runtime/host-adapter.js';
import { type HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, agentRoot } from './helpers.js';
import type { Config } from '../src/config.js';
import type { TokenUsage } from '@deepseek-ai/dsh-llm';
import { Store } from '../src/storage/database.js';
import { DailyBudget } from '../src/budget/daily-budget.js';
import { Sandbox } from '../src/runtime/sandbox.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import { channelTools } from '../src/tools/channel-tools.js';
import LocalAttachments from '@deepseek-ai/dsh-attachment-local';
import { pngFixture } from './media-helpers.js';
import { createHash } from 'node:crypto';

class Model extends LlmAdapter {
  calls: GenerateOptions[] = [];
  waitForAbort = false;
  usage?: TokenUsage;
  failFirst = false;
  toolName?: string;
  toolPlan?: { name: string; args: Record<string, unknown> }[];
  imagesEnabled = false;
  answer = '真实宿主回复';
  override async resolveModel(provider: string, model: string) {
    return { provider, id: model, name: model, inputModalities: this.imagesEnabled ? ['text' as const, 'image' as const] : ['text' as const] };
  }
  async *stream(options: GenerateOptions): AsyncIterable<StreamChunk> {
    this.calls.push(options);
    const planned = this.toolPlan?.[this.calls.length - 1];
    if (planned || this.toolName && this.calls.length === 1) {
      const block = { type: 'tool-call' as const, id: ToolCallId('tool-call-' + this.calls.length), name: planned?.name ?? this.toolName!, arguments: JSON.stringify(planned?.args ?? { path: 'note.txt', text: 'sandbox text' }) };
      yield { type: 'block-start', index: 0, blockType: 'tool-call' };
      yield { type: 'block-end', index: 0, block };
      if (this.usage) yield { type: 'usage', usage: this.usage };
      yield { type: 'finish', reason: { kind: 'tool-calls' } }; return;
    }
    yield { type: 'block-start', index: 0, blockType: 'text' };
    yield { type: 'text-delta', index: 0, text: this.answer };
    if (this.waitForAbort) {
      await new Promise<void>(resolve => options.signal?.addEventListener('abort', () => resolve(), { once: true }));
      yield { type: 'finish', reason: { kind: 'aborted', failure: { code: 'ABORTED', message: 'cancelled' } } }; return;
    }
    yield { type: 'block-end', index: 0, block: { type: 'text', text: this.answer } };
    if (this.usage) yield { type: 'usage', usage: this.usage };
    if (this.failFirst && this.calls.length === 1) {
      yield { type: 'finish', reason: { kind: 'error', failure: { code: 'TEST_RETRY', message: 'simulated retry' } } }; return;
    }
    yield { type: 'finish', reason: { kind: 'stop' } };
  }
}

test('real dsh final multi-message envelope survives cold replay and leaves legacy/decision/memory outputs unchanged', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-messages-')), first = await kernel(root);
  const envelope = JSON.stringify({ messages: ['孩子们，在呢。', '有什么事？'] });
  first.model.answer = envelope;
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', replyFormat: 'messages-v1',
    system: '', context: '测试多条', provider: 'mock', model: 'test',
    session: { key: 'multi-' + randomUUID(), id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
  try {
    const result = await first.adapter.execute(input, new AbortController().signal);
    assert.deepEqual(result.replies[0]!.messages, ['孩子们，在呢。', '有什么事？']);
    assert.equal(result.replies[0]!.text, '孩子们，在呢。\n\n有什么事？');
    await first.ctx.fiber.dispose();
    const second = await kernel(root);
    try {
      assert.deepEqual(await second.adapter.execute(input, new AbortController().signal), result);
      assert.equal(second.model.calls.length, 0);
      second.model.answer = envelope;
      for (const purpose of ['reply', 'decision', 'memory'] as const) {
        const legacy = { ...input, inputId: randomUUID(), executionId: randomUUID(), purpose, replyFormat: undefined };
        const output = await second.adapter.execute(legacy, new AbortController().signal);
        assert.equal(output.replies[0]!.text, envelope); assert.equal(output.replies[0]!.messages, undefined);
      }
    } finally { await second.ctx.fiber.dispose(); }
  } finally { await first.ctx.fiber.dispose(); rmSync(root, { recursive: true, force: true }); }
});

test('real dsh read_image loads the sandbox copy through durable attachments and meters subsequent image requests', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-image-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  mkdirSync(join(root, 'config'));
  cpSync(join(agentRoot, 'config/pricing.deepseek.2026-10-29.json'), join(root, 'config/pricing.deepseek.2026-10-29.json'));
  const c = { ...config({ media: { enabled: true }, budget: { enabled: true },
    runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } }), root };
  const bytes = pngFixture(), bridge = Object.assign(new FakeBridge(), {
    mediaMetadata: async () => ({ state: 'ready', name: 'photo.png', variants: { content: {
      size: bytes.length, sha256: createHash('sha256').update(bytes).digest('hex'), mime: 'image/png' } } }),
    mediaContent: async () => bytes,
  });
  const host = await kernel(root, c), store = new Store(c, ':memory:', () => now), engine = new Engine(c, store, bridge, host.adapter, () => {});
  try {
    const message = normalize(event(1, 'contact-a', '[image]', { message_type: 'image', media: { id: 'photo-1' } }), c)!;
    const session = store.session(message), descriptor = await engine.resources.describe(message, new AbortController().signal);
    host.model.imagesEnabled = true;
    host.model.usage = { inputTokens: 1500, outputTokens: 20 };
    host.model.toolPlan = [{ name: 'read_image', args: { path: descriptor.path } }];
    host.adapter.channelTools = (input, signal) => channelTools(engine, input, signal);
    const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), session, purpose: 'reply',
      system: '使用read_image查看图片，不猜测。', context: JSON.stringify({ path: descriptor.path }), provider: c.runtime.provider, model: c.runtime.model };
    const result = await host.adapter.execute(input, new AbortController().signal);
    assert.equal(result.status, 'completed'); assert.equal(host.model.calls.length, 2);
    assert.ok(!host.model.calls[0]!.messages.some(m => m.content.some(b => b.type === 'image')));
    const image = host.model.calls[1]!.messages.flatMap(m => m.content).find(b => b.type === 'image');
    assert.equal(image?.type, 'image');
    if (image?.type !== 'image') throw Error('missing_image');
    const saved = await host.ctx.attachments.readImage(image.attachment);
    assert.ok(saved.data.byteLength > 0); assert.equal(saved.ref.width, 2); assert.equal(saved.ref.height, 2);
    assert.equal(engine.budget.status().requestCount, 2); assert.equal(engine.budget.status().uncertainRequests, 0);
    const reservations = store.all('SELECT reserved_nanos FROM budget_requests ORDER BY started,start_seq');
    assert.ok(reservations[1]!.reserved_nanos > reservations[0]!.reserved_nanos);
    host.model.imagesEnabled = false;
    await assert.rejects(host.adapter.imageAttachment(input, bytes, 'image/png', 'photo.png', new AbortController().signal), /not_supported/);
  } finally { await engine.close(); await host.ctx.fiber.dispose(); rmSync(root, { recursive: true, force: true }); }
});

test('real dsh performs scoped memory index, summary and history tool round trips without injecting summaries upfront', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-recall-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const c = { ...config({ runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } }), root };
  const host = await kernel(root, c), store = new Store(c, ':memory:', () => now);
  const engine = new Engine(c, store, new FakeBridge(), host.adapter, () => {});
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    store.ingest({ cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '约定周六一起打篮球')] });
    const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
    const id = engine.memory.commitSummary(session, engine.memory.pending(session), JSON.stringify({ title: '篮球约定',
      summary: '群友提出周六一起打篮球，尚未确认参与者。', tags: { topics: ['篮球'], entities: [], states: ['提议'], aliases: [] } }), 'v2');
    host.model.toolPlan = [{ name: 'memory_search', args: { keywords: ['篮球'] } },
      { name: 'memory_read', args: { ids: [id] } }, { name: 'history_read', args: { segmentId: id } }];
    host.adapter.channelTools = (input, signal) => channelTools(engine, input, signal);
    const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), session, purpose: 'reply',
      system: '必要时查询记忆，先摘要再历史。', context: '之前约定哪天打篮球？', provider: c.runtime.provider, model: c.runtime.model };
    const result = await host.adapter.execute(input, new AbortController().signal);
    assert.equal(result.status, 'completed'); assert.equal(host.model.calls.length, 4);
    assert.ok(!JSON.stringify(host.model.calls[0]!.messages).includes('群友提出周六'));
    assert.ok(host.model.calls[2]!.messages.some(m => m.role === 'tool' && JSON.stringify(m).includes('群友提出周六')));
    assert.ok(host.model.calls[3]!.messages.some(m => m.role === 'tool' && JSON.stringify(m).includes('约定周六一起打篮球')),
      JSON.stringify(host.model.calls[3]!.messages.filter(m => m.role === 'tool')));
    assert.ok(store.one('SELECT * FROM context_audit WHERE input_id=?', input.inputId + ':recall'));
  } finally {
    await engine.close(); await host.ctx.fiber.dispose(); rmSync(root, { recursive: true, force: true });
  }
});

test('real dsh exposes only scoped sandbox/web tools and meters the request after a file-tool result', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-sandbox-'));
  const c = config({ budget: { enabled: true }, runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } });
  const host = await kernel(root, c); const store = new Store(c, ':memory:', () => Date.parse('2026-10-29T10:00:00+08:00'));
  const budget = new DailyBudget(store); host.adapter.setBudget(budget); host.model.toolName = 'workspace_write';
  host.model.usage = { inputTokens: 100, outputTokens: 20 };
  let outsideCalls = 0;
  const output = { schema: { type: 'object' as const }, render: (_args: unknown, value: unknown) => [{ type: 'text' as const, text: JSON.stringify(value) }] };
  host.ctx.tools.register({ name: 'shell', description: 'must never be inherited', parameters: { type: 'object' }, output, execute: async () => { outsideCalls++; return {}; } });
  const scope = 'sandbox-' + randomUUID(), sandbox = new Sandbox(c.root, scope);
  host.adapter.channelTools = () => [
    { name: 'workspace_write', description: 'sandbox writer', parameters: { type: 'object' }, output, execute: async (args: any) => sandbox.write(args.path, args.text) },
    { name: 'web_fetch', description: 'public web', parameters: { type: 'object' }, output, execute: async () => ({}) },
    { name: 'web_search', description: 'public search', parameters: { type: 'object' }, output, execute: async () => ({}) },
  ];
  try {
    const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', system: '', context: 'write note', provider: 'deepseek-official', model: 'deepseek-flash',
      session: { key: scope, id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
    const result = await host.adapter.execute(input, new AbortController().signal);
    assert.equal(result.status, 'completed'); assert.equal(sandbox.read('note.txt'), 'sandbox text');
    assert.deepEqual(host.model.calls[0]!.tools?.map(t => t.name).sort(), ['web_fetch', 'web_search', 'workspace_write']);
    assert.equal(outsideCalls, 0); assert.equal(host.model.calls.length, 2); assert.equal(budget.status().requestCount, 2);
    assert.ok(host.model.calls[1]!.messages.some(m => m.role === 'tool')); assert.equal(budget.status().heldCny, 0);
    // Even a hallucinated call to a hidden global tool must never reach its implementation.
    host.model.calls.length = 0; host.model.toolName = 'shell';
    await host.adapter.execute({ ...input, inputId: randomUUID(), executionId: randomUUID() }, new AbortController().signal);
    assert.equal(outsideCalls, 0);
    assert.ok(host.model.calls[1]!.messages.some(m => m.role === 'tool' && m.isError));
    host.model.calls.length = 0; host.model.toolName = undefined;
    await host.adapter.execute({ ...input, inputId: randomUUID(), executionId: randomUUID(), purpose: 'decision' }, new AbortController().signal);
    assert.deepEqual(host.model.calls[0]!.tools ?? [], []);
  } finally {
    await host.ctx.fiber.dispose(); store.close();
    const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true });
    const dir = relative(c.root, sandbox.root); assert.ok(dir.startsWith('data') && !isAbsolute(dir)); rmSync(sandbox.root, { recursive: true, force: true });
  }
});
async function kernel(root: string, c: Config = config()) {
  // Only tests assemble a kernel; deployment always uses the official dsh profile launcher.
  const ctx = new Context();
  await ctx.plugin(Llm);
  await ctx.plugin(Sessions);
  await ctx.plugin(LocalAttachments, { dshHome: root, maxImageBytes: 10 * 1024 * 1024 });
  await ctx.plugin(Agents);
  await ctx.plugin(Projections);
  await ctx.plugin(SystemPrompt, { includeHarnessIdentity: false, includeRuntimeContext: false });
  await ctx.plugin(Tools, { mode: 'native' });
  await ctx.plugin(Persistence, { root, compression: 'none' });
  await ctx.plugin(Checkpoint);
  await ctx.plugin(AgentLoop, { agents: [] });
  const model = new Model(); ctx.llm.registerAdapter(['mock', 'deepseek-official'], model);
  return { ctx, model, adapter: new DshHostAdapter(ctx, c) };
}
test('locked dsh kernel persists identified input and final output; cold restart projects without calling model', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-'));
  const first = await kernel(root);
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', system: '可信系统规则', context: '仅当前群的消息',
    provider: 'mock', model: 'model', session: { key: 'test-scope', id: randomUUID(), generation: 1, scope: 'group', conversation: 'group-a@chatroom', model: 'default', persona: null } };
  try {
    const result = await first.adapter.execute(input, new AbortController().signal);
    assert.equal(result.status, 'completed'); assert.equal(result.replies[0]?.text, '真实宿主回复');
    assert.equal(first.model.calls.length, 1); assert.deepEqual(first.model.calls[0]!.tools ?? [], []);
    assert.equal(first.model.calls[0]!.messages.filter(m => m.role === 'user').length, 1);
    await first.ctx.fiber.dispose();
    const second = await kernel(root);
    try {
      assert.deepEqual(await second.adapter.reconcile(input), result);
      assert.deepEqual(await second.adapter.execute(input, new AbortController().signal), result);
      assert.equal(second.model.calls.length, 0);
      const handle = await second.ctx.agents.resume({ resumeSessionId: SessionId(input.executionId) });
      assert.equal(handle.agent.id, input.executionId); await handle.dispose();
    } finally { await second.ctx.fiber.dispose(); }
  } finally {
    await first.ctx.fiber.dispose();
    const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel));
    rmSync(root, { recursive: true, force: true });
  }
});
test('real dsh request middleware meters reply, decision and memory calls and never rebills replay', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-budget-'));
  const c = config({ budget: { enabled: true }, runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } });
  const host = await kernel(root, c); const store = new Store(c, ':memory:', () => Date.parse('2026-10-29T10:00:00+08:00'));
  const budget = new DailyBudget(store); host.adapter.setBudget(budget);
  host.model.usage = { inputTokens: 100, cacheReadTokens: 1000, outputTokens: 20 };
  try {
    for (const purpose of ['reply', 'decision', 'memory'] as const) {
      const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose, system: '系统', context: '当前域资料', provider: 'deepseek-official', model: 'deepseek-flash',
        session: { key: 'budget-scope', id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
      const result = await host.adapter.execute(input, new AbortController().signal);
      assert.equal(result.status, 'completed'); await host.adapter.reconcile(input); await host.adapter.reconcile(input);
    }
    assert.equal(host.model.calls.length, 3); assert.equal(budget.status().requestCount, 3);
    assert.equal(budget.status().spentCny, .0012); assert.equal(budget.status().heldCny, 0);
    assert.equal(store.all('SELECT DISTINCT purpose FROM budget_requests').length, 3);
  } finally { await host.ctx.fiber.dispose(); store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
test('real dsh adapter is never invoked when the request cannot fit its daily allowance', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-budget-refuse-'));
  const c = config({ budget: { enabled: true, dailyLimitCny: .000001 }, runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } });
  const host = await kernel(root, c); const store = new Store(c, ':memory:', () => Date.parse('2026-10-29T10:00:00+08:00'));
  const budget = new DailyBudget(store); host.adapter.setBudget(budget);
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', system: '系统', context: '请求', provider: 'deepseek-official', model: 'deepseek-flash',
    session: { key: 'budget-denied', id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
  try {
    const result = await host.adapter.execute(input, new AbortController().signal);
    assert.notEqual(result.status, 'completed'); assert.equal(host.model.calls.length, 0); assert.equal(budget.status().stopped, true);
  } finally { await host.ctx.fiber.dispose(); store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
test('real dsh retries are metered separately, including the failed attempt', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-budget-retry-'));
  const c = config({ budget: { enabled: true }, runtime: { provider: 'deepseek-official', model: 'deepseek-flash' } });
  const host = await kernel(root, c); const store = new Store(c, ':memory:', () => Date.parse('2026-10-29T10:00:00+08:00'));
  const budget = new DailyBudget(store); host.adapter.setBudget(budget);
  host.model.usage = { inputTokens: 1000, outputTokens: 100 }; host.model.failFirst = true; let retried = false;
  host.ctx.on('agent/request-error', async (_payload, next) => {
    if (!retried) { retried = true; return { kind: 'retry' }; } return next();
  });
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', system: '系统', context: '请求', provider: 'deepseek-official', model: 'deepseek-flash',
    session: { key: 'retry-scope', id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
  try {
    const result = await host.adapter.execute(input, new AbortController().signal);
    assert.equal(result.status, 'completed'); assert.equal(host.model.calls.length, 2);
    assert.equal(budget.status().requestCount, 2); assert.equal(budget.status().spentCny, .0056);
    assert.equal(budget.status().uncertainRequests, 1);
    await host.adapter.reconcile(input); assert.equal(budget.status().spentCny, .0056);
  } finally { await host.ctx.fiber.dispose(); store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
test('locked dsh cancellation settles the turn and suppresses interrupted partial text', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-dsh-cancel-')); const host = await kernel(root);
  host.model.waitForAbort = true; const controller = new AbortController();
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), purpose: 'reply', system: '系统', context: '请求', provider: 'mock', model: 'model',
    session: { key: 'cancel-scope', id: randomUUID(), generation: 1, scope: 'direct', conversation: 'contact-a', model: 'default', persona: null } };
  try {
    const timer = setTimeout(() => controller.abort(), 100);
    const result = await host.adapter.execute(input, controller.signal); clearTimeout(timer);
    assert.equal(result.status, 'cancelled'); assert.equal(result.replies.length, 0);
    assert.equal(host.ctx.agents.get(SessionId(input.executionId)), undefined);
  } finally {
    await host.ctx.fiber.dispose(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true });
  }
});
