import { DatabaseSync, type SQLInputValue } from 'node:sqlite';
import { existsSync } from 'node:fs';
import { resolve } from 'node:path';
import type { Config } from '../config.js';
import { budgetStatus } from '../budget/daily-budget.js';

type Row = Record<string, any>;
export const parse = (text: unknown): any => { try { return typeof text === 'string' ? JSON.parse(text) : {}; } catch { return {}; } };
/** Preserve chat text, but mask credential-shaped strings. Never project config/prompts/raw errors. */
export function safeText(value: unknown, max = 24000): string {
  return typeof value !== 'string' ? '' : value.slice(0, max)
    .replace(/\b(?:sk-[a-zA-Z0-9_-]{8,}|Bearer\s+[a-zA-Z0-9._~+\/-]+=*)/gi, '[REDACTED]')
    .replace(/((?:api[_-]?key|access[_-]?token|authorization|password|secret|cookie)["']?\s*[:=]\s*["']?)[^\s,"';}]+/gi, '$1[REDACTED]');
}
export const code = (value: unknown): string | null => typeof value === 'string' && /^[a-z][a-z0-9_:-]{0,100}$/i.test(value) ? value : null;
const detailKeys = new Set(['reason','purpose','part','kind','submitted','requestId','name','callId','inputTokens','outputTokens','cacheReadTokens','cacheWriteTokens','code']);
export function safeDetails(value: unknown) {
  const object = value && typeof value === 'object' ? value as Row : {};
  return Object.fromEntries(Object.entries(object).filter(([k,v]) => detailKeys.has(k) && (v === null || typeof v === 'boolean' || typeof v === 'number' && Number.isFinite(v) || typeof v === 'string'))
    .map(([k,v]) => [k, typeof v === 'string' ? safeText(v, 160) : v]));
}
export class AdminReadModel {
  private db?: DatabaseSync;
  constructor(readonly config: Config, readonly clock = Date.now) {}
  private connect() {
    if (!this.db && existsSync(resolve(this.config.root, this.config.storage.file))) {
      this.db = new DatabaseSync(resolve(this.config.root, this.config.storage.file), { readOnly: true });
      this.db.exec('PRAGMA query_only=ON; PRAGMA busy_timeout=1000;');
    }
    return this.db;
  }
  private tables = new Set<string>();
  private schemaVersion = -1;
  has(table: string) {
    const db=this.connect(); if(!db)return false;
    const version=Number(db.prepare('PRAGMA schema_version').get()!.schema_version);
    if(version!==this.schemaVersion){this.tables=new Set(db.prepare("SELECT name FROM sqlite_master WHERE type='table'").all().map(r=>String(r.name)));this.schemaVersion=version;}
    return this.tables.has(table);
  }
  all(sql: string, ...args: SQLInputValue[]): Row[] { return this.connect()?.prepare(sql).all(...args) ?? []; }
  one(sql: string, ...args: SQLInputValue[]): Row | undefined { return this.connect()?.prepare(sql).get(...args); }
  close() { this.db?.close(); this.db = undefined; }
  overview() {
    const now = this.clock(), metadata = this.has('metadata');
    const status = metadata ? parse(this.one("SELECT value FROM metadata WHERE key='runtime_status'")?.value) : {};
    const lease = this.has('consumer_lock') ? this.one('SELECT expires FROM consumer_lock WHERE id=1') : undefined;
    const updated = Number.isFinite(status.updated) ? status.updated : null;
    const traced = this.has('trace_inbox') ? Number(this.one('SELECT count(*) n FROM trace_inbox')?.n ?? 0) : 0;
    const total = this.has('inbox') ? Number(this.one('SELECT count(*) n FROM inbox')?.n ?? 0) : 0;
    const counts = (table: 'inbox'|'outbox') => this.has(table) ? Object.fromEntries(this.all(`SELECT state,count(*) n FROM ${table} GROUP BY state`).map(r => [r.state, r.n])) : {};
    const budget = budgetStatus(this.config, (sql, ...args) => {
      const table = sql.includes('metadata') ? 'metadata' : sql.includes('budget_stops') ? 'budget_stops' : 'budget_requests';
      return this.has(table) ? this.one(sql, ...args) : sql.includes('sum(cost_nanos)') ? { spent: 0, held: 0, requests: 0, uncertain: 0 } : undefined;
    }, now);
    const cp = this.has('source_checkpoints') ? this.one('SELECT cursor,baseline,paused FROM source_checkpoints WHERE id=1') : undefined;
    const since = metadata ? Number(this.one("SELECT value FROM metadata WHERE key='trace_since'")?.value ?? 0) || null : null;
    return { now, runtime: { state: code(status.state) ?? 'unknown', updated,
      stale: !updated || now - updated > 30000 || !lease || lease.expires <= now,
      diagnostics: Array.isArray(status.diagnostics) ? status.diagnostics.map(code).filter(Boolean) : [] },
      checkpoint: { cursor: cp?.cursor ?? 0, baseline: cp ? !!cp.baseline : null, paused: code(cp?.paused) },
      counts: { inbox: counts('inbox'), outbox: counts('outbox'), traced, legacy: Math.max(0, total - traced) },
      budget: { ...budget, reason: code(budget.reason), pricingVersion: safeText(budget.pricingVersion, 120) || null },
      trace: { enabled: !!since, since, note: since ? '仅记录启用后的链路；历史缺失阶段不推测。' : '尚无链路埋点；需下次人工启动新版bot后记录。' } };
  }
  private select() {
    const trace = this.has('trace_inbox');
    const outputWhere = `o.id IN (SELECT t.outbox_id FROM trace_outputs t WHERE t.inbox_id=i.id OR t.run_id IN (SELECT s.run_id FROM trace_sources s WHERE s.inbox_id=i.id))`;
    const status = trace ? `CASE WHEN NOT EXISTS(SELECT 1 FROM trace_inbox t WHERE t.id=i.id) THEN 'legacy_unknown' ELSE coalesce(
      (SELECT o.state FROM outbox o WHERE ${outputWhere} ORDER BY CASE o.state
        WHEN 'needs_review' THEN 1 WHEN 'unknown' THEN 2 WHEN 'failed' THEN 3 WHEN 'sending' THEN 4 WHEN 'queued' THEN 5 WHEN 'prepared' THEN 6 WHEN 'local_accepted' THEN 7 WHEN 'message_recorded' THEN 8 WHEN 'cancelled' THEN 9 ELSE 10 END LIMIT 1),
      CASE WHEN i.state IN ('pending','observed') THEN (SELECT e.state FROM trace_events e WHERE e.inbox_id=i.id AND e.phase='participation' ORDER BY e.id DESC LIMIT 1) END,
      CASE i.state WHEN 'pending' THEN 'received' WHEN 'dispatching' THEN 'processing' WHEN 'control_running' THEN 'processing' WHEN 'observed' THEN 'silent' ELSE i.state END) END` : `'legacy_unknown'`;
    return `SELECT i.*,${status} display_status,${trace ? `(SELECT json_extract(e.details,'$.reason') FROM trace_events e WHERE e.inbox_id=i.id AND e.phase='participation' ORDER BY e.id DESC LIMIT 1)` : 'NULL'} trace_reason,${trace ? `EXISTS(SELECT 1 FROM trace_inbox t WHERE t.id=i.id)` : '0'} traced,
      ${trace ? `(SELECT count(*) FROM trace_sources s WHERE s.inbox_id=i.id)` : '0'} run_count,
      ${trace ? `(SELECT count(*) FROM trace_outputs o WHERE o.inbox_id=i.id OR o.run_id IN (SELECT s.run_id FROM trace_sources s WHERE s.inbox_id=i.id))` : '0'} outbox_count,
      ${trace ? `(SELECT max(e.at) FROM trace_events e WHERE e.inbox_id=i.id OR e.run_id IN (SELECT s.run_id FROM trace_sources s WHERE s.inbox_id=i.id) OR e.outbox_id IN (SELECT o.outbox_id FROM trace_outputs o WHERE o.inbox_id=i.id OR o.run_id IN (SELECT s.run_id FROM trace_sources s WHERE s.inbox_id=i.id)))` : 'NULL'} updated_at
      FROM inbox i`;
  }
  private relatedOutputs(id: string) {
    return this.has('trace_outputs') ? this.all(`SELECT o.*,t.run_id FROM outbox o JOIN trace_outputs t ON t.outbox_id=o.id
      WHERE t.inbox_id=? OR t.run_id IN (SELECT run_id FROM trace_sources WHERE inbox_id=?) ORDER BY o.created,o.rowid,o.part`, id,id) : [];
  }
  private message(row: Row) {
    const m = parse(row.payload), traced = !!row.traced;
    const status = row.display_status;
    const reason = code(row.trace_reason) ?? code(row.reason);
    return { id: row.id, messageId: safeText(m.messageId,160) || null, sequence: row.sequence,
      conversationId: safeText(row.conversation,200) || null, senderId: safeText(row.sender,200) || null,
      scope: m.scope === 'group' ? 'group' : m.scope === 'direct' ? 'direct' : 'unknown',
      kind: code(m.kind) ?? 'unsupported', text: safeText(m.text), receivedAt: row.created,
      messageAt: Number.isFinite(m.timestampMs) ? m.timestampMs : null, status, reason,
      traceAvailable: traced, updatedAt: row.updated_at ?? row.created, runCount: row.run_count, outboxCount: row.outbox_count };
  }
  messages(query: { q: string; status: string; limit: number; offset: number; after: number }) {
    if (!this.has('inbox')) return { items: [], total: 0, ...query, cursor: 0 };
    // Page/filter in SQLite before materializing bodies; no per-row polling queries.
    const where = ` WHERE (?='' OR instr(lower(i.payload),lower(?))>0 OR instr(lower(i.id),lower(?))>0 OR instr(lower(coalesce(i.conversation,'')),lower(?))>0 OR instr(lower(coalesce(i.sender,'')),lower(?))>0)`;
    const params:SQLInputValue[]=[query.q,query.q,query.q,query.q,query.q];
    const delta=query.after&&this.has('trace_events')?` AND EXISTS(SELECT 1 FROM trace_events e WHERE e.id>? AND
      (e.inbox_id=i.id OR e.run_id IN (SELECT run_id FROM trace_sources WHERE inbox_id=i.id) OR e.outbox_id IN
      (SELECT outbox_id FROM trace_outputs WHERE inbox_id=i.id OR run_id IN (SELECT run_id FROM trace_sources WHERE inbox_id=i.id))))`:'';
    if(delta)params.push(query.after);
    const source=`(${this.select()+where+delta})`,filter=query.status?' WHERE display_status=?':'';
    if(query.status)params.push(query.status);
    const total=Number(this.one(`SELECT count(*) n FROM ${source}${filter}`,...params)!.n);
    const rows=this.all(`SELECT * FROM ${source}${filter} ORDER BY sequence DESC LIMIT ? OFFSET ?`,...params,query.limit,query.offset);
    return { items: rows.map(r=>this.message(r)), total, limit: query.limit, offset: query.offset,
      cursor: this.has('trace_events') ? this.one('SELECT coalesce(max(id),0) n FROM trace_events')!.n : 0 };
  }
  detail(id: string) {
    if (!this.has('inbox')) return undefined;
    const row = this.one(this.select() + ' WHERE i.id=?', id); if (!row) return undefined;
    const message = this.message(row), traceAvailable = message.traceAvailable;
    if (!traceAvailable) return { message, runs: [], outbox: [], timeline: [], traceAvailable,
      note: '此历史消息没有接收时链路记录，不能凭时间相邻推测模型或出站归属。' };
    const outputs = this.relatedOutputs(id);
    const timeline = this.all(`SELECT * FROM trace_events WHERE inbox_id=? OR run_id IN (SELECT run_id FROM trace_sources WHERE inbox_id=?) OR outbox_id IN
      (SELECT outbox_id FROM trace_outputs WHERE inbox_id=? OR run_id IN (SELECT run_id FROM trace_sources WHERE inbox_id=?)) ORDER BY id`, id,id,id,id)
      .map(e => ({ id:e.id, at:e.at, phase:e.phase, state:e.state, inboxId:e.inbox_id, runId:e.run_id, outboxId:e.outbox_id, details:safeDetails(parse(e.details)) }));
    const runs = this.all('SELECT r.* FROM runs r JOIN trace_sources s ON s.run_id=r.id WHERE s.inbox_id=? ORDER BY r.created,r.rowid', id).map(r => {
      const input = parse(r.input), result = parse(r.result), events = timeline.filter(e => e.runId === r.id);
      const usage = new Map<string, Row>(), tools = new Map<string, Row>();
      for (const e of events) {
        const d = e.details as Row;
        if (e.phase === 'request' && e.state === 'usage' && d.requestId) usage.set(d.requestId, { requestId:d.requestId, at:e.at,
          inputTokens:d.inputTokens,outputTokens:d.outputTokens,cacheReadTokens:d.cacheReadTokens,cacheWriteTokens:d.cacheWriteTokens });
        if (e.phase === 'tool' && d.callId) {
          const previous = tools.get(d.callId);
          tools.set(d.callId, { callId:d.callId,name:d.name,state:e.state,startedAt:previous?.startedAt ?? e.at,
            endedAt:e.state === 'started' ? null : e.at,code:code(d.code) });
        }
      }
      return { id:r.id,executionId:safeText(input.executionId,160),purpose:r.purpose,provider:safeText(input.provider,100),model:safeText(input.model,160),
        state:r.state,startedAt:r.created,endedAt:events.findLast(e => e.phase === 'model' && e.state !== 'dispatching')?.at ?? null,
        sourceIds:this.all('SELECT inbox_id FROM trace_sources WHERE run_id=?',r.id).map(s=>s.inbox_id),
        finalTexts:r.purpose === 'reply' && Array.isArray(result.replies) ? result.replies.flatMap((reply:Row)=> Array.isArray(reply.messages) ? reply.messages.map((s:unknown)=>safeText(s)) : [safeText(reply.text)]) : [],
        usage:[...usage.values()],tools:[...tools.values()] };
    });
    return { message,runs,outbox:outputs.map(o => ({id:o.id,runId:o.run_id,replyId:o.reply,part:o.part,kind:o.kind,
      text:o.kind==='text'?safeText(parse(o.body).text):'',state:o.state,submitted:!!o.submitted,createdAt:o.created,
      updatedAt:timeline.findLast(e=>e.outboxId===o.id)?.at??o.created,error:code(parse(o.result).error??parse(o.result).code),deliveryVerified:false})),
      timeline,traceAvailable,note:'发送状态来自持久Outbox/桥接确认，不等于实际收件；工具仅显示名称与执行状态，不展示参数、结果或思维链。' };
  }
}
