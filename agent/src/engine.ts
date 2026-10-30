import { randomUUID } from 'node:crypto';
import type { Config } from './config.js';
import { conversationConfig } from './config.js';
import { hash, type HostAdapter, type HostInput, type HostResult, type Message, type Session } from './contracts.js';
import { type Bridge, policyDiagnostics } from './bridge/client.js';
import { Store, type Row } from './storage/database.js';
import { Outbox } from './egress/outbox.js';
import { PromptRegistry } from './prompts/registry.js';
import { Memory, fitJson, summarySchema } from './memory/memory.js';
import { replyFormatInstruction } from './egress/reply-format.js';
import { parseDecision } from './participation/decision.js';
import { Interactions } from './interactions/registry.js';
import { Resources } from './media/resources.js';
import { relative, resolve, isAbsolute } from 'node:path';
import { DailyBudget } from './budget/daily-budget.js';
import { beijingDay, nextBeijingMidnight } from './budget/pricing.js';

interface Active { controller: AbortController; task: Promise<void>; sender: string; autonomous: boolean }
export class Engine {
  readonly prompts: PromptRegistry;
  readonly memory: Memory;
  readonly outbox: Outbox;
  readonly interactions: Interactions;
  readonly resources: Resources;
  readonly budget: DailyBudget;
  readonly active = new Map<string, Active>();
  state = 'starting';
  diagnostics: string[] = [];
  private stopping = false;
  private modelReady = false;
  private failureCount = 0;
  private timer?: ReturnType<typeof setTimeout>;
  private leaseTimer?: ReturnType<typeof setInterval>;
  private pumping?: Promise<void>;
  private loop?: Promise<void>;
  private artifactRoots: string[] = [];
  private budgetCancellations: Promise<unknown> = Promise.resolve();
  constructor(readonly config: Config, readonly store: Store, readonly bridge: Bridge, readonly host: HostAdapter,
    readonly log: (event: Record<string, unknown>) => void = event => console.log(JSON.stringify(event))) {
    this.prompts = new PromptRegistry(config); this.memory = new Memory(store);
    this.outbox = new Outbox(store, bridge, undefined, () => this.publishStatus()); this.interactions = new Interactions(store);
    this.resources = new Resources(store, bridge);
    this.budget = new DailyBudget(store);
    this.budget.onStop = status => this.stopForBudget(status.reason!);
    this.host.setBudget?.(this.budget);
  }
  async start() {
    this.leaseTimer = setInterval(() => {
      try { this.store.heartbeat(); } catch { this.modelReady = false; this.state = 'blocked'; for (const a of this.active.values()) a.controller.abort(); }
    }, 5000);
    await this.recover();
    const loop = async () => {
      if (this.stopping) return;
      this.loop = this.tick();
      try { await this.loop; } catch { this.state = 'blocked'; this.log({ event: 'tick_failed' }); }
      if (!this.stopping) {
        let wait = this.failureCount ? Math.min(30000, 1000 * 2 ** Math.min(5, this.failureCount - 1)) * (0.8 + Math.random() * 0.4) : this.config.bridge.pollMs;
        if (this.budget.status().stopped) wait = Math.min(wait, nextBeijingMidnight(this.store.clock()) - this.store.clock());
        this.timer = setTimeout(() => void loop(), wait);
      }
    };
    void loop();
  }
  async recover() {
    this.interactions.invalidate();
    this.store.exec("UPDATE inbox SET state='needs_review',reason='interrupted_control' WHERE state='control_running'");
    for (const run of this.store.all("SELECT * FROM runs WHERE state='dispatching'")) {
      const input = JSON.parse(run.input) as HostInput;
      let result: HostResult;
      try { result = await this.host.reconcile(input) ?? { status: 'needs_review', replies: [] }; }
      catch { result = { status: 'needs_review', replies: [] }; }
      // A persisted group answer needs fresh participation review before projection.
      if (this.budget.status().stopped) { this.stopForBudget(this.budget.status().reason!); result = { status: 'cancelled', replies: [] }; }
      else if (this.store.one("SELECT value FROM metadata WHERE key='budget_paused_day'")) result = { status: 'cancelled', replies: [] };
      if (input.purpose === 'reply' && result.status === 'completed') {
        const current = this.store.one('SELECT * FROM session_map WHERE key=?', input.session.key);
        const sources: string[] = JSON.parse(run.source_ids);
        const sourceRows = sources.map(id => this.store.one('SELECT * FROM inbox WHERE id=?', id)).filter(Boolean) as Row[];
        const isFresh = sourceRows.length && sourceRows.every(r => this.fresh(JSON.parse(r.payload)));
        if (!current || current.generation !== input.session.generation || !isFresh || input.session.scope === 'group') result = { status: 'needs_review', replies: [] };
        else for (const reply of result.replies) this.prepareOutput(input.session, reply.id, reply.text, reply.messages);
      }
      this.store.completeRun(input.inputId, result.status, result);
      if (result.status === 'needs_review') this.store.exec("UPDATE outbox SET state='needs_review' WHERE route=? AND submitted=0 AND state='prepared'", input.session.key);
    }
  }
  async tick() {
    this.store.heartbeat(); this.store.sweep();
    if (!this.checkBudget()) { this.publishStatus(); return; }
    try {
      const health = await this.bridge.health();
      this.diagnostics = policyDiagnostics(this.config, health);
      if (this.host.available && !this.host.available(this.config.runtime.provider)) this.diagnostics.push('model_provider_not_registered');
      this.artifactRoots = Array.isArray(health.config?.send?.media_roots) ? health.config.send.media_roots : [];
      this.modelReady = health.send_ready === true && health.receive_ready === true && !this.diagnostics.length && health.state !== 'blocked';
      this.state = health.state === 'blocked' ? 'blocked' : this.modelReady ? 'running' : 'degraded';
      const cp = this.store.checkpoint();
      if (health.receive_ready === true) this.store.ingest(await this.bridge.events(cp.cursor));
      const next = this.store.checkpoint();
      if (health.receive_ready === true) this.resources.prefetch();
      if (next.paused) this.state = 'paused_gap'; else if (next.baseline) this.state = 'baselining';
      if (!this.checkBudget()) return;
      await this.controls();
      if (!next.paused && !next.baseline) { this.cancelOutdatedGroupOutput(); await this.outbox.tick(); }
      if (this.modelReady && !next.paused && !next.baseline) {
        const urgent = this.store.all('SELECT * FROM session_map').some(s => this.memory.backlog(s.key) >= this.config.memory.priorityMessages);
        if (urgent) await this.memoryTick();
        await this.pump(); if (!urgent) await this.memoryTick();
      }
      this.failureCount = 0;
    } catch (error) {
      this.modelReady = false; this.failureCount++; this.state = 'degraded';
      this.log({ event: 'bridge_unavailable', attempt: this.failureCount,
        error: error instanceof Error ? error.name : 'unknown',
        location: error instanceof Error ? error.stack?.split('\n').slice(1, 4) : undefined });
    } finally { this.publishStatus(); }
  }
  private publishStatus() {
    this.store.exec('INSERT OR REPLACE INTO metadata VALUES(?,?)', 'runtime_status', JSON.stringify({
      pid: process.pid, owner: this.store.owner, updated: this.store.clock(), state: this.state,
      diagnostics: this.diagnostics, cursor: this.store.checkpoint().cursor,
    }));
  }
  private stopForBudget(reason: string) {
    const day = beijingDay(this.store.clock());
    const already = this.store.one("SELECT value FROM metadata WHERE key='budget_paused_day'")?.value === day;
    this.state = reason.startsWith('daily_budget') ? 'budget_exhausted' : 'budget_blocked';
    this.modelReady = false; this.outbox.stopping = true;
    for (const active of this.active.values()) active.controller.abort();
    this.interactions.invalidate();
    if (already) return;
    this.store.exec("INSERT OR REPLACE INTO metadata VALUES('budget_paused_day',?)", day);
    this.store.exec("UPDATE inbox SET state='cancelled',reason='daily_budget_stop' WHERE state='pending'");
    const routes = this.store.all("SELECT DISTINCT route FROM outbox WHERE state IN ('prepared','queued')");
    this.budgetCancellations = Promise.allSettled(routes.map(r => this.outbox.cancel(r.route)));
    this.log({ event: 'budget_stopped', day, reason, dailyLimitCny: this.config.budget.dailyLimitCny });
  }
  private checkBudget() {
    const status = this.budget.status();
    if (status.stopped) { this.stopForBudget(status.reason!); return false; }
    const paused = this.store.one("SELECT value FROM metadata WHERE key='budget_paused_day'");
    if (paused) {
      if (this.active.size) return false;
      // Discard the stopped period's backlog before responding to new activity.
      const gap = this.store.checkpoint().paused;
      this.store.acceptBaseline();
      if (gap) this.store.exec('UPDATE source_checkpoints SET paused=? WHERE id=1', gap);
      this.store.exec("UPDATE outbox SET state='cancelled' WHERE submitted=0 AND state='prepared'");
      this.store.exec("DELETE FROM metadata WHERE key='budget_paused_day'");
      this.outbox.stopping = false;
      this.log({ event: 'budget_resumed', day: status.day });
    }
    return true;
  }
  private fresh(m: Message) {
    return this.store.clock() - m.timestampMs <= this.config.ingress.maxMessageAgeSeconds * 1000 && m.timestampMs <= this.store.clock() + 30000;
  }
  private cancelOutdatedGroupOutput() {
    const outputs = this.store.all("SELECT o.* FROM outbox o JOIN session_map s ON o.route=s.key WHERE s.scope='group' AND o.state='prepared' AND o.submitted=0");
    for (const output of outputs) {
      if (output.reply.startsWith('command:')) continue;
      const run = this.store.all("SELECT * FROM runs WHERE route=? AND purpose='reply' AND result IS NOT NULL ORDER BY created DESC", output.route)
        .find(r => JSON.parse(r.result).replies?.some((reply: { id: string }) => reply.id === output.reply));
      if (!run) continue;
      const ids: string[] = JSON.parse(run.source_ids);
      const watermark = Math.max(0, ...ids.map(id => Number(this.store.one('SELECT sequence FROM inbox WHERE id=?', id)?.sequence ?? 0)));
      if (this.store.messages(output.route, 1)[0]!.sequence > watermark)
        this.store.exec("UPDATE outbox SET state='cancelled' WHERE reply=? AND submitted=0", output.reply);
    }
  }
  private prepareOutput(session: Session, eventId: string, text: string, messages?: string[]) {
    if (this.budget.status().stopped) return;
    this.store.heartbeat();
    try { this.store.prepareMessages(session, eventId, messages ?? [text]); }
    catch (error) {
      if (!(error instanceof Error) || error.message !== 'reply_requires_artifact') throw error;
      const artifact = this.resources.artifact(session, eventId, text);
      const covered = this.canSendArtifact(artifact.path);
      if (this.config.egress.sendArtifacts && covered) {
        this.store.prepareFile(session, eventId, artifact.path);
        this.store.exec('UPDATE artifacts SET refs=1 WHERE id=?', artifact.id);
      } else this.store.prepareReply(session, eventId, '回复较长，已保存在本机。需要管理员配置附件交付后才能发送完整文件。');
    }
  }
  canSendArtifact(path: string) {
    return this.artifactRoots.some(root => { const rel = relative(resolve(root), path); return rel && !rel.startsWith('..') && !isAbsolute(rel); });
  }
  private administrator(session: Session, sender: string) {
    return this.config.access.owners.includes(sender) || (conversationConfig(this.config, session.scope, session.conversation)?.administrators ?? []).includes(sender);
  }
  private async controls() {
    const rows = this.store.all("SELECT * FROM inbox WHERE state='pending' ORDER BY sequence");
    for (const row of rows) {
      const m: Message = JSON.parse(row.payload);
      if (!this.fresh(m)) { this.store.exec("UPDATE inbox SET state='ignored',reason='stale' WHERE id=?", row.id); continue; }
      if (!m.text.startsWith('/bot ')) {
        if (m.scope === 'group' && /^(请|先)?(别说话|不要回答|不用回答|保持安静)[。！!\s]*$/.test(m.text.trim())) {
          const session = this.store.session(m);
          this.store.exec('UPDATE session_map SET quiet=1 WHERE key=?', session.key);
          this.active.get(session.key)?.controller.abort();
          await this.outbox.cancel(session.key);
          this.store.exec("UPDATE inbox SET state='observed' WHERE id=?", row.id);
        }
        continue;
      }
      const session = this.store.session(m);
      this.store.exec("UPDATE inbox SET state='control_running' WHERE id=? AND state='pending'", row.id);
      const [, command, ...args] = m.text.trim().split(/\s+/);
      const admin = this.administrator(session, m.senderId);
      let response: string;
      switch (command) {
        case 'help': response = '/bot status | new | stop | compact | model [别名] | persona [别名] | resume\n/bot answer <ID> <内容> | allow <ID> | deny <ID>\n群设置与重置需本地配置管理员。'; break;
        case 'status': {
          const count = this.store.one("SELECT count(*) n FROM outbox WHERE route=? AND state NOT IN ('server_confirmed','cancelled')", session.key)!.n;
          response = `当前会话第 ${session.generation} 代；${this.active.has(session.key) ? '处理中' : '空闲'}；待跟踪输出 ${count}。发送状态不代表实际收件。`; break;
        }
        case 'stop': {
          const active = this.active.get(session.key);
          if (!admin && (m.scope === 'group' || (active && active.sender !== m.senderId))) { response = '没有停止此任务的权限。'; break; }
          active?.controller.abort(); await this.outbox.cancel(session.key); this.interactions.invalidate(session.key);
          this.store.exec("UPDATE inbox SET state='cancelled' WHERE route=? AND state='pending' AND id<>?", session.key, row.id);
          response = '已停止可取消的任务；已开始发送的消息仍需跟踪。'; break;
        }
        case 'new': {
          if (m.scope === 'group' && !admin) { response = '群会话重置需要本地配置管理员。'; break; }
          const active = this.active.get(session.key); active?.controller.abort(); if (active) await active.task;
          await this.outbox.cancel(session.key); this.interactions.invalidate(session.key);
          this.store.exec("UPDATE inbox SET state='cancelled' WHERE route=? AND state='pending' AND id<>?", session.key, row.id);
          this.store.exec('UPDATE session_map SET id=?,generation=generation+1 WHERE key=?', randomUUID(), session.key);
          response = '已创建新的执行会话，当前会话域内的记忆仍保留。'; break;
        }
        case 'compact':
          response = '当前保留最近200条连续消息（含机器人回复）；旧对话独立分段总结，按需检索摘要和历史。固定提示词不占聊天额度。'; break;
        case 'resume':
          if (!admin) { response = '恢复群参与需要本地配置管理员。'; break; }
          this.store.exec('UPDATE session_map SET quiet=0 WHERE key=?', session.key); response = '已恢复当前会话参与。'; break;
        case 'model': {
          if (!args.length) { response = `当前模型别名：${session.model}。可用：default、${Object.keys(this.config.runtime.models).join('、')}`; break; }
          if (m.scope === 'group' && !admin) { response = '没有修改群模型的权限。'; break; }
          if (args[0] !== 'default' && !this.config.runtime.models[args[0]!]) { response = '未知的模型别名。'; break; }
          this.store.exec('UPDATE session_map SET model=? WHERE key=?', args[0]!, session.key); response = '模型将在下一轮生效。'; break;
        }
        case 'persona': {
          if (!args.length) { response = `可用人格档：${Object.keys(this.config.promptProfiles).join('、') || 'default'}`; break; }
          if (m.scope === 'group' && !admin) { response = '没有修改群人格的权限。'; break; }
          if (!this.config.promptProfiles[args[0]!]) { response = '未知的人格别名。'; break; }
          this.store.exec('UPDATE session_map SET persona=? WHERE key=?', args[0]!, session.key); response = '人格将在下一轮生效，权限保持原配置。'; break;
        }
        case 'preset': response = '当前预设：assistant。工作工具只能通过本机配置启用。'; break;
        case 'answer': case 'allow': case 'deny': {
          const kind = command === 'answer' ? 'question' : 'approval';
          const answer = command === 'answer' ? args.slice(1).join(' ') : command;
          response = args[0] && answer && this.interactions.settle(session, m.senderId, args[0], answer, kind) ? '已记录。' : '交互不存在、已过期或不属于你。'; break;
        }
        default: response = '未知命令，请用 /bot help。';
      }
      // The command output identity is stable across crashes between prepare and completion.
      if (this.budget.status().stopped) {
        this.store.exec("UPDATE inbox SET state='cancelled',reason='daily_budget_stop' WHERE id=?", row.id); continue;
      }
      this.store.prepareReply(session, 'command:' + row.id, response);
      this.store.exec("UPDATE inbox SET state='completed' WHERE id=?", row.id);
    }
  }
  async pump() {
    if (this.pumping) return this.pumping;
    this.pumping = this.schedule();
    try { await this.pumping; } finally { this.pumping = undefined; }
  }
  private async schedule() {
    if (this.stopping || !this.checkBudget()) return;
    const routes = this.store.all("SELECT route,min(sequence) seq FROM inbox WHERE state='pending' GROUP BY route ORDER BY seq");
    for (const { route } of routes) {
      if (this.active.size >= this.config.runtime.maxConcurrentRuns) break;
      if (this.active.has(route) || this.store.one("SELECT id FROM runs WHERE route=? AND state='needs_review'", route) ||
          this.store.one("SELECT id FROM inbox WHERE route=? AND state='needs_review'", route) ||
          this.store.one("SELECT id FROM outbox WHERE route=? AND state IN ('unknown','needs_review')", route)) continue;
      const queue = this.store.all("SELECT * FROM inbox WHERE route=? AND state='pending' ORDER BY sequence", route);
      const first: Message = JSON.parse(queue[0]!.payload);
      const session = this.store.session(first);
      const modelRoute = session.model === 'default' ? this.config.runtime : this.config.runtime.models[session.model];
      if (!modelRoute || this.host.available && !this.host.available(modelRoute.provider)) continue;
      if (session.scope === 'direct') {
        const trigger = conversationConfig(this.config, 'direct', first.conversationId)?.directTrigger ?? this.config.access.direct.trigger;
        if (trigger !== 'all' && !first.text.startsWith(this.config.access.prefix)) {
          this.store.exec("UPDATE inbox SET state='observed' WHERE id=?", queue[0]!.id); continue;
        }
        this.launch(session, [queue[0]!], first.senderId);
      } else {
        const p = { ...this.config.participation, ...conversationConfig(this.config, 'group', session.conversation)?.participation };
        const last = queue[queue.length - 1]!;
        if (this.store.clock() - last.created < p.debounceMs && this.store.clock() - queue[0]!.created < p.maxBatchWaitMs) continue;
        const state = this.store.one('SELECT * FROM session_map WHERE key=?', route)!;
        if (state.quiet || this.store.clock() - state.last_reply < p.cooldownSeconds * 1000) continue;
        const replies = this.store.one('SELECT count(DISTINCT reply) n FROM outbox WHERE route=? AND created>?', route, this.store.clock() - 60000)!.n;
        if (replies >= p.maxRepliesPerMinute) continue;
        const decisions = this.store.one("SELECT count(*) n FROM participation_decisions WHERE route=? AND created>? AND state<>'waiting'", route, this.store.clock() - 60000)!.n;
        if (decisions >= p.maxDecisionsPerMinute) continue;
        this.launch(session, queue.slice(0, 30), first.senderId);
      }
    }
  }
  private launch(session: Session, rows: Row[], sender: string) {
    const controller = new AbortController();
    const task = Promise.resolve().then(() => this.run(session, rows, controller.signal)).catch(error => {
      this.log({ event: 'run_failed', route: hash(session.key).slice(0, 12),
        code: error instanceof Error && /^[a-z_]+$/.test(error.message) ? error.message : 'run_error',
        location: error instanceof Error ? error.stack?.split('\n').slice(1, 3) : undefined });
      for (const row of rows) this.store.exec("UPDATE inbox SET state='failed' WHERE id=? AND state='pending'", row.id);
    }).finally(() => this.active.delete(session.key));
    this.active.set(session.key, { controller, task, sender, autonomous: session.scope === 'group' });
  }
  private async call(session: Session, purpose: HostInput['purpose'], context: string, ids: string[], signal: AbortSignal,
    stableId?: string): Promise<{ input: HostInput; result: HostResult }> {
    if (!this.checkBudget()) throw Error('daily_budget_stopped');
    const inputId = stableId ?? randomUUID();
    const existing = this.store.one('SELECT * FROM runs WHERE id=?', inputId);
    if (existing) {
      const input = JSON.parse(existing.input) as HostInput;
      const result = existing.result ? JSON.parse(existing.result) : await this.host.reconcile(input) ?? { status: 'needs_review', replies: [] };
      return { input, result };
    }
    const snapshot = this.prompts.snapshot(session, purpose, this.store);
    const allowance = purpose === 'memory' ? this.config.memory.inputBytes : this.config.runtime.chatContextBytes;
    // Fixed prompts have their own validated ceiling; they never consume the chat allowance.
    if (Buffer.byteLength(context) > allowance) throw Error('context_budget_exceeded');
    const route = session.model === 'default' ? this.config.runtime : this.config.runtime.models[session.model];
    if (!route) throw Error('unknown_model_alias');
    const system = snapshot.system + (purpose === 'reply' ? replyFormatInstruction : '');
    if (Buffer.byteLength(system) > 32000) throw Error('effective_prompt_too_large');
    const input: HostInput = { inputId, executionId: randomUUID(), session, purpose, system,
      context, provider: route.provider, model: route.model };
    if (purpose === 'reply') input.replyFormat = 'messages-v1';
    if (purpose === 'reply') {
      const senders = new Set(ids.map(id => this.store.one('SELECT sender FROM inbox WHERE id=?', id)?.sender).filter(Boolean));
      if (senders.size === 1) input.initiatorId = [...senders][0];
    }
    this.store.startRun(input, ids);
    this.store.exec('INSERT OR REPLACE INTO context_audit VALUES(?,?,?,?)', inputId, session.key,
      JSON.stringify({ purpose, systemBytes: Buffer.byteLength(input.system), contextBytes: Buffer.byteLength(context),
        allowanceBytes: allowance, ...JSON.parse(context).contextStats }), this.store.clock());
    const timeout = AbortSignal.timeout(this.config.runtime.turnTimeoutSeconds * 1000);
    let result: HostResult;
    try { result = await this.host.execute(input, AbortSignal.any([signal, timeout])); }
    catch { result = await this.host.reconcile(input).catch(() => undefined) ?? { status: 'needs_review', replies: [] }; }
    if (purpose !== 'reply') this.store.completeRun(inputId, result.status, result);
    return { input, result };
  }
  private async decision(session: Session, messages: Message[], signal: AbortSignal, suffix = '', candidate?: string) {
    const watermark = Math.max(...messages.map(m => m.sequence));
    const id = hash(['decision', session.key, session.generation, watermark, suffix]);
    const p = { ...this.config.participation, ...conversationConfig(this.config, session.scope, session.conversation)?.participation };
    const recent = this.memory.recent(session, this.config.runtime.chatContextBytes - 2048);
    // The participation model has no tools. Don't expose read-tool directives/paths that invite fake tool calls.
    const decisionRecent = recent.recent.map(({ attachment, ...m }) => ({ ...m,
      ...(attachment ? { attachment: { kind: attachment.kind, state: attachment.state, format: attachment.format } } : {}) }));
    const context = JSON.stringify({ stage: suffix ? 'before_send' : 'participation', candidateReply: candidate?.slice(0, 1000),
      recent: decisionRecent, contextStats: { available: recent.availableMessages, included: recent.includedMessages, truncated: recent.truncated } });
    this.store.exec('INSERT OR IGNORE INTO participation_decisions VALUES(?,?,?,?,0,NULL,?)', id, session.key, watermark, 'pending', this.store.clock());
    const record = this.store.one('SELECT * FROM participation_decisions WHERE id=?', id)!;
    if (record.result) return parseDecision(record.result, messages);
    const { result } = await this.call(session, 'decision', context, [], signal, id);
    if (result.status !== 'completed' || !result.replies[0]) throw Error('decision_failed');
    let parsed;
    try { parsed = parseDecision(result.replies[0].text, messages); }
    catch {
      this.log({ event: 'decision_format_retry', route: hash(session.key).slice(0, 12) });
      const repairContext = JSON.stringify({ ...JSON.parse(context), formatCorrection:
        '上次输出格式或引用无效。当前没有工具，不要输出工具调用或XML。只返回规定的action/reason/sourceMessageIds/topicId/replyToSenderId JSON；所有ID必须来自本窗口。需要看图时选择reply，由后续回复阶段读取图片。' });
      const repair = await this.call(session, 'decision', repairContext, [], signal, hash([id, 'format-repair-v1']));
      if (repair.result.status !== 'completed' || !repair.result.replies[0]) throw Error('decision_failed');
      parsed = parseDecision(repair.result.replies[0].text, messages);
    }
    this.store.exec('UPDATE participation_decisions SET state=?,result=? WHERE id=?', parsed.action, JSON.stringify(parsed), id);
    return parsed;
  }
  private async run(session: Session, rows: Row[], signal: AbortSignal) {
    const messages = rows.map(r => JSON.parse(r.payload) as Message);
    let originalTopic: string | undefined;
    if (messages.some(m => !this.fresh(m))) {
      for (const row of rows) this.store.exec("UPDATE inbox SET state='observed' WHERE id=?", row.id); return;
    }
    const media = [];
    for (const m of messages.filter(m => m.kind !== 'text').slice(0, 3)) {
      try { media.push(await this.resources.describe(m, signal)); }
      catch { media.push({ messageId: m.messageId, kind: m.kind, state: 'unavailable', note: '媒体读取失败，不能猜测内容。' }); }
    }
    if (session.scope === 'group') {
      const window = this.store.timeline(session.key).map(b => b.message);
      let decision = await this.decision(session, window, signal);
      if (decision.action === 'wait') {
        // One bounded timer/retry, persisted via a second stable decision identity.
        const key = hash(['wait', session.key, Math.max(...window.map(m => m.sequence))]);
        const timer = this.store.one('SELECT * FROM participation_decisions WHERE id=?', key);
        if (!timer) {
          this.store.exec('INSERT INTO participation_decisions VALUES(?,?,?,?,1,NULL,?)', key, session.key,
            Math.max(...window.map(m => m.sequence)), 'waiting', this.store.clock()); return;
        }
        if (this.store.clock() - timer.created < this.config.participation.maxBatchWaitMs) return;
        if (this.config.participation.maxWaitRetries) decision = await this.decision(session, window, signal, 'wait_retry');
      }
      if (decision.action !== 'reply') {
        for (const row of rows) this.store.exec("UPDATE inbox SET state='observed' WHERE id=?", row.id); return;
      }
      originalTopic = decision.topicId;
    }
    if (signal.aborted) return;
    const budget = this.config.runtime.chatContextBytes;
    const boundedMedia = fitJson(media, Math.min(16384, Math.floor(budget / 4)));
    const recent = this.memory.recent(session, budget - Buffer.byteLength(JSON.stringify(boundedMedia)) - 2048);
    // Current messages appear once in the timeline; IDs identify which ones need a response.
    const context = JSON.stringify({ currentMessageIds: messages.map(m => m.messageId), recent: recent.recent,
      media: boundedMedia, evidenceOnly: true,
      contextStats: { available: recent.availableMessages, included: recent.includedMessages, truncated: recent.truncated },
      memoryInstruction: '先用当前连续对话回答。涉及此前约定、往事、人物背景或指代不明时自主调用 memory_search；先读摘要，必要时再查对应历史。不要猜测。' });
    const { input, result } = await this.call(session, 'reply', context, rows.map(r => r.id), signal);
    let status: HostResult['status'] = signal.aborted ? 'cancelled' : result.status;
    if (status === 'completed' && session.scope === 'group') {
      const window = this.store.timeline(session.key).map(b => b.message);
      const oldWatermark = Math.max(...messages.map(m => m.sequence));
      if (Math.max(...window.map(m => m.sequence)) > oldWatermark) {
        const check = await this.decision(session, window, signal, 'before_send:' + input.inputId, result.replies.map(r => r.text).join('\n'));
        if (check.action !== 'reply' || check.topicId !== originalTopic || !check.sourceMessageIds.some(id => messages.some(m => m.messageId === id)) ||
            this.store.timeline(session.key, 1)[0]!.message.messageId !== window[window.length - 1]!.messageId) status = 'cancelled';
      }
    }
    const cp = this.store.checkpoint();
    if (signal.aborted || cp.paused || cp.baseline || messages.some(m => !this.fresh(m))) status = 'cancelled';
    if (status === 'completed') {
      for (const reply of result.replies) this.prepareOutput(session, reply.id, reply.text, reply.messages);
      if (result.replies.length) this.store.exec('UPDATE session_map SET last_reply=? WHERE key=?', this.store.clock(), session.key);
    }
    this.store.completeRun(input.inputId, status, result);
  }
  async memoryTick() {
    if (!this.config.memory.enabled || this.active.size >= this.config.runtime.maxConcurrentRuns || !this.modelReady || !this.checkBudget()) return;
    const now = this.store.clock();
    if (this.store.one("SELECT count(*) n FROM runs WHERE purpose='memory' AND created>?", now - 3600000)!.n >= this.config.memory.maxCallsPerHour) return;
    const sessions = (this.store.all('SELECT * FROM session_map') as Session[])
      .sort((a, b) => this.memory.backlog(b.key) - this.memory.backlog(a.key));
    for (const session of sessions) {
      const activeKey = 'memory:' + session.key;
      if (this.active.has(activeKey) || !this.memory.due(session)) continue;
      const retryKey = 'summary_retry:' + session.key;
      if (Number(this.store.one('SELECT value FROM metadata WHERE key=?', retryKey)?.value ?? 0) > now) continue;
      const batch = this.memory.pending(session);
      const prefix: typeof batch = []; let used = 512;
      for (const item of batch) {
        const bytes = Buffer.byteLength(JSON.stringify(this.memory.source(item.message))) + 1;
        if (used + bytes > this.config.memory.inputBytes) break;
        prefix.push(item); used += bytes;
      }
      if (!prefix.length) { this.log({ event: 'summary_message_too_large', route: hash(session.key).slice(0, 12) }); continue; }
      const controller = new AbortController();
      const extractor = hash(this.prompts.snapshot(session, 'memory').sections.map(s => [s.type, s.hash]));
      const context = JSON.stringify({ startPosition: prefix[0]!.position, endPosition: prefix[prefix.length - 1]!.position,
        messages: prefix.map(b => this.memory.source(b.message)) });
      const prior = this.store.all("SELECT state,created FROM runs WHERE route=? AND purpose='memory' AND json_extract(input,'$.context')=? ORDER BY created DESC", session.key, context);
      if (prior[0] && prior[0].state !== 'completed' && now - prior[0].created < 60000) continue;
      const attempts = prior.filter(r => r.state !== 'completed').length;
      const batchId = hash(['summary-v2', session.key, prefix.map(b => [b.position, hash(b.message)]), extractor, attempts]);
      const task = this.call(session, 'memory', context, [], controller.signal, batchId)
        .then(({ result }) => {
          try {
            if (result.status !== 'completed' || !result.replies[0]) throw Error('summary_model_failed');
            summarySchema.parse(JSON.parse(result.replies[0].text));
            if ([...JSON.parse(result.replies[0].text).summary].length > this.config.memory.summaryMaxChars) throw Error('summary_too_long');
          } catch (error) { this.store.exec("UPDATE runs SET state='failed' WHERE id=?", batchId); throw error; }
          const id = this.memory.commitSummary(session, prefix, result.replies[0].text, extractor);
          this.store.exec('DELETE FROM metadata WHERE key=?', retryKey);
          this.log({ event: 'summary_saved', segmentId: id, messages: prefix.length, remaining: this.memory.backlog(session.key) });
        })
        .catch(() => {
          // Invalid output retries after backoff; valid model output is reused if file/DB publication fails.
          this.store.exec('INSERT OR REPLACE INTO metadata VALUES(?,?)', retryKey, String(this.store.clock() + 60000));
          this.log({ event: 'memory_extract_failed', route: hash(session.key).slice(0, 12) });
        })
        .finally(() => this.active.delete(activeKey));
      this.active.set(activeKey, { controller, task, sender: '', autonomous: true }); return;
    }
  }
  async drain() { await Promise.all([...this.active.values()].map(a => a.task)); }
  async close() {
    this.stopping = true; this.state = 'stopping'; if (this.timer) clearTimeout(this.timer);
    this.outbox.stopping = true;
    for (const active of this.active.values()) active.controller.abort();
    await this.loop; await this.drain(); await this.resources.close(); await this.budgetCancellations; await this.host.close();
    if (this.leaseTimer) clearInterval(this.leaseTimer);
    this.store.close();
  }
}
