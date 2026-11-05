import { randomUUID } from 'node:crypto';
import type { HostInput, HostResult, Session } from '../contracts.js';
import { hash } from '../contracts.js';
import type { Store } from '../storage/database.js';
import { Memory } from '../memory/memory.js';

export interface ConversationContext {
  route: string; generation: number; execution_id: string; system: string; provider: string; model: string;
  carry: string; turns: number; bytes: number; input_tokens: number; window_tokens: number; summary_input: string | null;
  summary_attempts: number; summary_next_at: number;
}

/** Durable DSH identity and frozen instructions; no timers, sliding windows or per-batch decision sessions. */
export class ConversationContexts {
  constructor(readonly store: Store, readonly memory: Memory) {
    store.db.exec(`CREATE TABLE IF NOT EXISTS conversation_contexts(route TEXT PRIMARY KEY,generation INTEGER NOT NULL,
      execution_id TEXT NOT NULL UNIQUE,system TEXT NOT NULL,provider TEXT NOT NULL,model TEXT NOT NULL,carry TEXT NOT NULL,
      turns INTEGER NOT NULL DEFAULT 0,bytes INTEGER NOT NULL DEFAULT 0,input_tokens INTEGER NOT NULL DEFAULT 0,
      window_tokens INTEGER NOT NULL DEFAULT 0,summary_input TEXT,summary_attempts INTEGER NOT NULL DEFAULT 0,summary_next_at INTEGER NOT NULL DEFAULT 0);
      CREATE TABLE IF NOT EXISTS context_receipts(input_id TEXT PRIMARY KEY,execution_id TEXT NOT NULL);
      CREATE TABLE IF NOT EXISTS context_delivery_receipts(execution_id TEXT NOT NULL,outbox_id TEXT NOT NULL,state TEXT NOT NULL,
        PRIMARY KEY(execution_id,outbox_id));`);
    if (!store.one("SELECT value FROM metadata WHERE key='continuous_conversation_v1'")) store.transaction(() => {
      // Retain historical evidence, but never resume the retired JSON/decision pipeline after this upgrade.
      store.exec(`UPDATE outbox SET state='cancelled' WHERE submitted=0 AND state='prepared' AND id IN
        (SELECT t.outbox_id FROM trace_outputs t JOIN runs r ON r.id=t.run_id WHERE r.purpose='reply')`);
      for (const run of store.all(`SELECT id,purpose,source_ids FROM runs WHERE state IN ('dispatching','needs_review') AND
        purpose IN ('reply','decision','memory')`)) {
        store.exec("UPDATE work_results SET state='unknown' WHERE run_id=? AND state='started'", run.id);
        store.exec("UPDATE runs SET state='cancelled',result=? WHERE id=?",
          JSON.stringify({ status: 'cancelled', replies: [], reason: 'continuous_conversation_upgrade' }), run.id);
        if (run.purpose === 'reply') for (const source of JSON.parse(run.source_ids))
          store.exec("UPDATE inbox SET state='cancelled' WHERE id=?", source);
      }
      store.exec("INSERT INTO metadata VALUES('continuous_conversation_v1','1')");
    });
  }
  get(session: Session): ConversationContext | undefined {
    const row = this.store.one('SELECT * FROM conversation_contexts WHERE route=? AND generation=?', session.key, session.generation);
    return row as ConversationContext | undefined;
  }
  open(session: Session, system: string, provider: string, model: string, beforePosition: number): ConversationContext {
    const saved = this.get(session);
    if (saved) return saved;
    const latest = this.store.one('SELECT summary FROM memory_segments WHERE route=? ORDER BY end_position DESC LIMIT 1', session.key);
    const recent = this.recent(session, beforePosition);
    const carry = latest || recent.length ? JSON.stringify({ memory: latest?.summary ?? '', recent, evidenceOnly: true }) : '';
    return this.replace(session, system, provider, model, carry);
  }
  private recent(session: Session, through: number) {
    const rows = this.store.all('SELECT payload FROM chat_history WHERE route=? AND position<=? ORDER BY position DESC LIMIT ?',
      session.key, through, this.store.config.sessions.recentMessages).reverse();
    const selected: unknown[] = []; let bytes = 0;
    for (const row of rows.reverse()) {
      const item = this.memory.source(JSON.parse(row.payload)), size = Buffer.byteLength(JSON.stringify(item));
      if (bytes + size > 24576) break;
      selected.unshift(item); bytes += size;
    }
    return selected;
  }
  private replace(session: Session, system: string, provider: string, model: string, carry: string) {
    this.store.exec(`INSERT OR REPLACE INTO conversation_contexts(route,generation,execution_id,system,provider,model,carry)
      VALUES(?,?,?,?,?,?,?)`, session.key, session.generation, randomUUID(), system, provider, model, carry);
    return this.get(session)!;
  }
  needsRollover(state: ConversationContext, incomingBytes: number) {
    if (!state.turns) return false;
    if (state.summary_input) return true; // Resume a claimed summary before admitting more chat.
    const c = this.store.config.sessions;
    const capacity = state.window_tokens || c.fallbackContextTokens;
    const used = state.input_tokens || state.bytes + Buffer.byteLength(state.system) + 8192;
    return used + incomingBytes + c.reserveTokens >= capacity * c.rolloverRatio;
  }
  claimSummary(state: ConversationContext) {
    const previous = state.summary_input ? this.store.one('SELECT state FROM runs WHERE id=?', state.summary_input) : undefined;
    if (previous && ['failed', 'cancelled'].includes(previous.state) && state.summary_attempts >= this.store.config.sessions.summaryMaxAttempts)
      throw Error('context_summary_paused');
    const reuse = state.summary_input && (!previous || !['failed', 'cancelled'].includes(previous.state));
    const id = reuse ? state.summary_input! : randomUUID();
    this.store.exec('UPDATE conversation_contexts SET summary_input=?,summary_attempts=summary_attempts+? WHERE execution_id=?',
      id, reuse ? 0 : 1, state.execution_id);
    return id;
  }
  readyAt(session: Session) {
    const state = this.get(session);
    if (!state) return 0;
    const run = state.summary_input ? this.store.one('SELECT state FROM runs WHERE id=?', state.summary_input) : undefined;
    if (run && ['failed', 'cancelled'].includes(run.state) && state.summary_attempts >= this.store.config.sessions.summaryMaxAttempts) return Infinity;
    return state.summary_next_at;
  }
  record(input: HostInput, result: HostResult) {
    if (!this.store.one('SELECT execution_id FROM conversation_contexts WHERE execution_id=?', input.executionId)) return;
    this.store.transaction(() => {
      if (this.store.one('SELECT input_id FROM context_receipts WHERE input_id=?', input.inputId)) return;
      const bytes = Buffer.byteLength(input.context) + Buffer.byteLength(JSON.stringify(result.replies));
      this.store.exec(`UPDATE conversation_contexts SET turns=turns+1,bytes=bytes+?,
        input_tokens=coalesce(?,input_tokens),window_tokens=coalesce(?,window_tokens) WHERE execution_id=?`,
        bytes, result.contextUsage ? result.contextUsage.inputTokens + (result.contextUsage.outputTokens ?? 0) : null,
        result.contextUsage?.windowTokens ?? null, input.executionId);
      this.store.exec('INSERT INTO context_receipts VALUES(?,?)', input.inputId, input.executionId);
      for (const delivery of JSON.parse(input.context).deliveryUpdates ?? [])
        this.store.exec('INSERT OR REPLACE INTO context_delivery_receipts VALUES(?,?,?)', input.executionId, delivery.requestId, delivery.state);
    });
  }
  deliveryUpdates(state: ConversationContext) {
    return this.store.all(`SELECT o.id,o.reply,o.state,o.kind,o.body FROM outbox o LEFT JOIN context_delivery_receipts r
      ON r.execution_id=? AND r.outbox_id=o.id WHERE o.route=? AND o.created>? AND (r.state IS NULL OR r.state<>o.state)
      ORDER BY o.created DESC,o.rowid DESC LIMIT 24`, state.execution_id, state.route, this.store.clock() - 86400000)
      .reverse().map(row => ({ requestId: row.id, replyId: row.reply, state: row.state, kind: row.kind,
        ...(row.kind === 'text' ? { text: [...String(JSON.parse(row.body).text ?? '')].slice(0, 400).join('') } : {}) }));
  }
  rollover(session: Session, state: ConversationContext, text: string, system: string, provider: string, model: string, through: number) {
    const summary = text.trim();
    if (!summary || summary === '[SILENT]' || [...summary].length > this.store.config.sessions.maxSummaryChars) throw Error('context_summary_invalid');
    const range = this.store.one('SELECT min(position) start,min(occurred) first,max(occurred) last FROM chat_history WHERE route=? AND position<=?', session.key, through)!;
    const id = hash(['context-memory-v1', state.execution_id]);
    const now = this.store.clock(), start = Number(range.start ?? through);
    const tags = { topics: ['会话交接'], entities: [], states: ['持续会话'], aliases: [] };
    const document = { format: 'wechat-context-memory-v1', id, scope: session.key, startPosition: start, endPosition: through,
      startTime: Number(range.first ?? now), endTime: Number(range.last ?? now), title: '持续会话记忆', summary, tags };
    const path = this.memory.files.write(session.key, now, id, document);
    // The memory index, coverage and new execution become visible together. A crash reuses the claimed model output.
    return this.store.transaction(() => {
      this.store.exec('INSERT OR IGNORE INTO memory_segments VALUES(?,?,?,?,?,?,?,?,?,?,?)', id, session.key, start, through,
        document.startTime, document.endTime, document.title, JSON.stringify(tags), summary, path, now);
      this.store.exec('INSERT OR REPLACE INTO summary_checkpoints VALUES(?,?,?)', session.key, through, now);
      return this.replace(session, system, provider, model,
        JSON.stringify({ memory: summary, recent: this.recent(session, through), evidenceOnly: true }));
    });
  }
}
