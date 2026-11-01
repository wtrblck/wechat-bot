import type { Store } from './database.js';
import type { HostInput, Session, WorkObservation } from '../contracts.js';
import { hash } from '../contracts.js';

/** Durable working evidence, separate from messages actually delivered to WeChat. */
export class Work {
  constructor(readonly store: Store) {
    store.db.exec(`CREATE TABLE IF NOT EXISTS work_results(id TEXT PRIMARY KEY,run_id TEXT NOT NULL,route TEXT NOT NULL,
      session_id TEXT NOT NULL,generation INTEGER NOT NULL,name TEXT NOT NULL,state TEXT NOT NULL,
      arguments TEXT NOT NULL,result TEXT,created INTEGER NOT NULL);
      CREATE INDEX IF NOT EXISTS work_route ON work_results(route,created);
      CREATE TABLE IF NOT EXISTS reply_reviews(reply TEXT PRIMARY KEY,watermark INTEGER NOT NULL,state TEXT NOT NULL,
        reviewed_at INTEGER NOT NULL DEFAULT 0,attempts INTEGER NOT NULL DEFAULT 0);
      CREATE TABLE IF NOT EXISTS delivery_batches(reply TEXT PRIMARY KEY,committed INTEGER NOT NULL);`);
    for (const [name, type] of [['reviewed_at', 'INTEGER NOT NULL DEFAULT 0'], ['attempts', 'INTEGER NOT NULL DEFAULT 0']])
      if (!store.all('PRAGMA table_info(reply_reviews)').some(r => r.name === name)) store.db.exec(`ALTER TABLE reply_reviews ADD COLUMN ${name} ${type}`);
  }
  record(input: HostInput, event: WorkObservation) {
    if (input.purpose !== 'reply' || event.name === 'read_work_result') return;
    const id = hash([input.executionId, event.callId]);
    const previous = this.store.one('SELECT state FROM work_results WHERE id=?', id);
    if (previous && previous.state !== 'started' && previous.state !== 'unknown') return;
    const args = JSON.stringify(event.arguments ?? null);
    const result = event.result === undefined ? null : JSON.stringify(event.result);
    // Keep a bounded durable store; oversized evidence is explicit, never a fake successful result.
    const oversized = result !== null && Buffer.byteLength(result) > 2 * 1024 * 1024;
    this.store.exec(`INSERT INTO work_results VALUES(?,?,?,?,?,?,?,?,?,?) ON CONFLICT(id) DO UPDATE SET
      state=excluded.state,result=excluded.result`, id, input.inputId, input.session.key, input.session.id,
      input.session.generation, event.name, oversized ? 'result_too_large' : event.state,
      Buffer.byteLength(args) <= 65536 ? args : JSON.stringify({ omitted: 'arguments_too_large' }),
      oversized ? JSON.stringify({ unavailable: 'result_too_large', bytes: Buffer.byteLength(result!) }) : result, this.store.clock());
  }
  read(session: Session, id: string, offset = 0, limit = 4096) {
    const current = this.store.one('SELECT id,generation FROM session_map WHERE key=?', session.key);
    if (!current || current.id !== session.id || current.generation !== session.generation) throw Error('work_result_denied');
    const row = this.store.one('SELECT * FROM work_results WHERE id=? AND route=? AND session_id=? AND generation=?',
      id, session.key, session.id, session.generation);
    if (!row || row.created < this.store.clock() - this.store.config.storage.retentionDays * 86400000) throw Error('work_result_denied');
    const text = row.result ?? '';
    return { id, name: row.name, state: row.state, text: text.slice(offset, offset + limit),
      nextOffset: offset + limit < text.length ? offset + limit : null, evidenceOnly: true };
  }
  context(session: Session, budget: number) {
    const items: unknown[] = [];
    const runs = this.store.all("SELECT * FROM runs WHERE route=? AND purpose='reply' ORDER BY created DESC,rowid DESC LIMIT 8", session.key);
    for (const run of runs) {
      const input = JSON.parse(run.input) as Partial<HostInput>;
      if (input.session?.id !== session.id || input.session.generation !== session.generation) continue;
      const tools = this.store.all('SELECT * FROM work_results WHERE run_id=? ORDER BY created,rowid LIMIT 24', run.id)
        .map(r => ({ id: r.id, name: r.name, state: r.state, arguments: r.arguments.slice(0, 512), preview: r.result?.slice(0, 1600) }));
      const output = this.store.all('SELECT o.id,o.reply,o.state,o.submitted,o.body,o.kind FROM outbox o JOIN trace_outputs t ON t.outbox_id=o.id WHERE t.run_id=? ORDER BY o.created,o.rowid,o.part', run.id)
        .map(r => ({ id: r.id, state: r.state, submitted: !!r.submitted, kind: r.kind,
          text: r.kind === 'text' ? JSON.parse(r.body).text : undefined }));
      const result = run.result ? JSON.parse(run.result) : undefined;
      const item = { runId: run.id, sourceIds: JSON.parse(run.source_ids), state: run.state,
        draft: result?.replies?.map((r: { text: string }) => r.text).join('\n').slice(0, 4000), tools, output };
      if (Buffer.byteLength(JSON.stringify([...items, item])) > budget) {
        const compact = { runId: run.id, state: run.state, tools: tools.map(({ preview, arguments: _args, ...t }) => t),
          output: output.map(({ text, ...o }) => o), omitted: 'work_context_budget' };
        if (Buffer.byteLength(JSON.stringify([...items, compact])) <= budget) items.push(compact);
        break;
      }
      items.push(item);
    }
    return items.reverse();
  }
  /** Participation sees delivery facts and a small draft, never tool payloads or read instructions. */
  decisionContext(session: Session) {
    const items: unknown[] = [];
    for (const run of this.store.all("SELECT * FROM runs WHERE route=? AND purpose='reply' ORDER BY created DESC,rowid DESC LIMIT 3", session.key)) {
      const input = JSON.parse(run.input) as HostInput;
      if (input.session?.id !== session.id || input.session.generation !== session.generation) continue;
      const output = this.store.all('SELECT o.state,o.submitted,o.kind FROM outbox o JOIN trace_outputs t ON t.outbox_id=o.id WHERE t.run_id=? ORDER BY o.created,o.part LIMIT 12', run.id)
        .map(r => ({ state: r.state, submitted: !!r.submitted, kind: r.kind }));
      const tools = this.store.all('SELECT name,state FROM work_results WHERE run_id=? ORDER BY created DESC,rowid DESC LIMIT 6', run.id)
        .map(r => ({ name: r.name, state: r.state }));
      const result = run.result ? JSON.parse(run.result) : undefined;
      const draft = !output.some(o => o.submitted) ? result?.replies?.map((r: { text: string }) => r.text).join('\n') : undefined;
      items.push({ state: run.state, tools, output, ...(draft ? { draft: [...draft].slice(0, 160).join(''), draftTruncated: [...draft].length > 160 } : {}) });
    }
    return items.reverse();
  }
  sweep() {
    const cutoff = this.store.clock() - this.store.config.storage.retentionDays * 86400000;
    this.store.exec('DELETE FROM work_results WHERE created<?', cutoff);
    // At most 32 MiB of serialized evidence per conversation, oldest first.
    for (const { route } of this.store.all('SELECT DISTINCT route FROM work_results')) {
      let bytes = 0;
      for (const row of this.store.all('SELECT id,length(CAST(arguments AS BLOB))+coalesce(length(CAST(result AS BLOB)),0) bytes FROM work_results WHERE route=? ORDER BY created DESC,rowid DESC', route)) {
        bytes += row.bytes;
        if (bytes > 32 * 1024 * 1024) this.store.exec('DELETE FROM work_results WHERE id=?', row.id);
      }
    }
    this.store.exec("DELETE FROM reply_reviews WHERE reply NOT IN (SELECT reply FROM outbox WHERE state='prepared')");
  }
}
