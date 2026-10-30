import { DatabaseSync, type SQLInputValue } from 'node:sqlite';
import { mkdirSync } from 'node:fs';
import { dirname, resolve, basename } from 'node:path';
import { randomUUID } from 'node:crypto';
import { conversationConfig, type Config } from '../config.js';
import { hash, requestId, routeKey, type EventPage, type HostInput, type Message, type Session } from '../contracts.js';
import { ignoreReason, normalize } from '../ingress/normalizer.js';
import { chunkText } from '../egress/chunker.js';

export type Row = Record<string, any>;
export class Store {
  readonly db: DatabaseSync;
  readonly owner = randomUUID();
  constructor(readonly config: Config, file = resolve(config.root, config.storage.file), readonly clock = Date.now) {
    if (file !== ':memory:') mkdirSync(dirname(file), { recursive: true });
    this.db = new DatabaseSync(file);
    this.db.exec(`PRAGMA journal_mode=WAL; PRAGMA synchronous=FULL; PRAGMA foreign_keys=ON; PRAGMA busy_timeout=5000;
      CREATE TABLE IF NOT EXISTS metadata(key TEXT PRIMARY KEY,value TEXT NOT NULL);
      CREATE TABLE IF NOT EXISTS consumer_lock(id INTEGER PRIMARY KEY,owner TEXT NOT NULL,expires INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS source_checkpoints(id INTEGER PRIMARY KEY,cursor INTEGER NOT NULL DEFAULT 0,baseline INTEGER NOT NULL DEFAULT 1,paused TEXT);
      INSERT OR IGNORE INTO source_checkpoints(id) VALUES(1);
      CREATE TABLE IF NOT EXISTS gaps(id INTEGER PRIMARY KEY,after_seq INTEGER,cursor INTEGER,created INTEGER);
      CREATE TABLE IF NOT EXISTS inbox(id TEXT PRIMARY KEY,sequence INTEGER UNIQUE NOT NULL,route TEXT,conversation TEXT,sender TEXT,
        payload TEXT NOT NULL,bytes INTEGER NOT NULL,state TEXT NOT NULL,reason TEXT,created INTEGER NOT NULL);
      CREATE INDEX IF NOT EXISTS inbox_route ON inbox(route,sequence);
      CREATE TABLE IF NOT EXISTS session_map(key TEXT PRIMARY KEY,id TEXT NOT NULL,generation INTEGER NOT NULL,conversation TEXT NOT NULL,
        scope TEXT NOT NULL,model TEXT NOT NULL,persona TEXT,last_reply INTEGER NOT NULL DEFAULT 0,quiet INTEGER NOT NULL DEFAULT 0);
      CREATE TABLE IF NOT EXISTS runs(id TEXT PRIMARY KEY,route TEXT NOT NULL,input TEXT NOT NULL,source_ids TEXT NOT NULL,
        state TEXT NOT NULL,purpose TEXT NOT NULL,created INTEGER NOT NULL,result TEXT);
      CREATE TABLE IF NOT EXISTS participation_decisions(id TEXT PRIMARY KEY,route TEXT NOT NULL,watermark INTEGER NOT NULL,
        state TEXT NOT NULL,attempts INTEGER NOT NULL DEFAULT 0,result TEXT,created INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS prompt_snapshots(id TEXT PRIMARY KEY,route TEXT NOT NULL,version TEXT NOT NULL,payload TEXT NOT NULL,created INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS outbox(id TEXT PRIMARY KEY,reply TEXT NOT NULL,route TEXT NOT NULL,part INTEGER NOT NULL,
        body TEXT NOT NULL,hash TEXT NOT NULL,state TEXT NOT NULL,submitted INTEGER NOT NULL DEFAULT 0,result TEXT,created INTEGER NOT NULL,
        kind TEXT NOT NULL DEFAULT 'text',UNIQUE(reply,part));
      CREATE INDEX IF NOT EXISTS outbox_route ON outbox(route,created,part);
      CREATE TABLE IF NOT EXISTS interactions(id TEXT PRIMARY KEY,route TEXT NOT NULL,generation INTEGER NOT NULL,sender TEXT NOT NULL,
        kind TEXT NOT NULL,payload TEXT NOT NULL,parameter_hash TEXT NOT NULL,expires INTEGER NOT NULL,state TEXT NOT NULL,answer TEXT);
      CREATE TABLE IF NOT EXISTS memory_units(id TEXT PRIMARY KEY,route TEXT NOT NULL,kind TEXT NOT NULL,subject TEXT NOT NULL,
        content TEXT NOT NULL,sources TEXT NOT NULL,occurred INTEGER NOT NULL,status TEXT NOT NULL,version TEXT NOT NULL,created INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS memory_checkpoints(route TEXT PRIMARY KEY,sequence INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS chat_history(position INTEGER PRIMARY KEY AUTOINCREMENT,route TEXT NOT NULL,
        message_id TEXT NOT NULL,payload TEXT NOT NULL,occurred INTEGER NOT NULL,request_id TEXT,
        UNIQUE(route,message_id));
      CREATE INDEX IF NOT EXISTS history_route ON chat_history(route,position);
      CREATE UNIQUE INDEX IF NOT EXISTS history_request ON chat_history(request_id) WHERE request_id IS NOT NULL;
      CREATE TABLE IF NOT EXISTS memory_segments(id TEXT PRIMARY KEY,route TEXT NOT NULL,start_position INTEGER NOT NULL,
        end_position INTEGER NOT NULL,start_time INTEGER NOT NULL,end_time INTEGER NOT NULL,title TEXT NOT NULL,
        tags TEXT NOT NULL,summary TEXT NOT NULL,path TEXT NOT NULL,created INTEGER NOT NULL);
      CREATE INDEX IF NOT EXISTS segments_route ON memory_segments(route,end_position DESC);
      CREATE TABLE IF NOT EXISTS summary_checkpoints(route TEXT PRIMARY KEY,position INTEGER NOT NULL,completed INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS context_audit(input_id TEXT PRIMARY KEY,route TEXT NOT NULL,details TEXT NOT NULL,created INTEGER NOT NULL);
      CREATE TABLE IF NOT EXISTS artifacts(id TEXT PRIMARY KEY,route TEXT NOT NULL,path TEXT NOT NULL,hash TEXT NOT NULL,
        mime TEXT NOT NULL,bytes INTEGER NOT NULL,expires INTEGER NOT NULL,refs INTEGER NOT NULL DEFAULT 0);
      CREATE TABLE IF NOT EXISTS message_media(route TEXT NOT NULL,message_id TEXT NOT NULL,resource_id TEXT,
        descriptor TEXT NOT NULL,updated INTEGER NOT NULL,PRIMARY KEY(route,message_id));
      PRAGMA user_version=1;`);
    if (!this.all('PRAGMA table_info(outbox)').some(r => r.name === 'kind')) this.db.exec("ALTER TABLE outbox ADD COLUMN kind TEXT NOT NULL DEFAULT 'text'");
    const identity = JSON.stringify([config.account.key, config.account.selfId, config.account.bridgeEpoch]);
    const previous = this.one('SELECT value FROM metadata WHERE key=?', 'source');
    if (previous && previous.value !== identity) { this.db.close(); throw Error('account_or_epoch_changed_use_new_database'); }
    this.exec('INSERT OR IGNORE INTO metadata VALUES(?,?)', 'source', identity);
    try { this.transaction(() => {
      const lock = this.one('SELECT * FROM consumer_lock WHERE id=1');
      if (lock && lock.expires > this.clock()) throw Error('consumer_already_running');
      this.exec('INSERT OR REPLACE INTO consumer_lock VALUES(1,?,?)', this.owner, this.clock() + 30000);
    }); } catch (error) { this.db.close(); throw error; }
    // Additive migration: retain legacy units/runs, rebuild raw history once without executing any messages.
    if (!this.one("SELECT value FROM metadata WHERE key='history_v2'")) this.transaction(() => {
      for (const row of this.all('SELECT route,payload FROM inbox WHERE route IS NOT NULL ORDER BY sequence')) {
        const m = JSON.parse(row.payload) as Message;
        if (m.kind !== 'unsupported') this.recordHistory(row.route, m);
      }
      for (const row of this.all("SELECT * FROM outbox WHERE kind='text' AND state IN ('local_accepted','message_recorded','server_confirmed') ORDER BY created"))
        this.recordSent(row, JSON.parse(row.result ?? '{}'));
      this.exec("INSERT INTO metadata VALUES('history_v2','1')");
    });
  }
  exec(sql: string, ...args: SQLInputValue[]) { return this.db.prepare(sql).run(...args); }
  one(sql: string, ...args: SQLInputValue[]): Row | undefined { return this.db.prepare(sql).get(...args); }
  all(sql: string, ...args: SQLInputValue[]): Row[] { return this.db.prepare(sql).all(...args); }
  transaction<T>(fn: () => T): T {
    this.db.exec('BEGIN IMMEDIATE');
    try { const result = fn(); this.db.exec('COMMIT'); return result; }
    catch (error) { this.db.exec('ROLLBACK'); throw error; }
  }
  heartbeat() {
    const result = this.exec('UPDATE consumer_lock SET expires=? WHERE id=1 AND owner=? AND expires>?', this.clock() + 30000, this.owner, this.clock());
    if (!result.changes) throw Error('consumer_lease_lost');
  }
  checkpoint() { return this.one('SELECT * FROM source_checkpoints WHERE id=1')!; }
  ingest(page: EventPage) {
    return this.transaction(() => {
      const cp = this.checkpoint();
      if (page.cursor < cp.cursor) {
        this.exec('UPDATE source_checkpoints SET paused=? WHERE id=1', 'cursor_regressed'); return;
      }
      if (page.truncated) {
        this.exec('INSERT INTO gaps(after_seq,cursor,created) VALUES(?,?,?)', cp.cursor, page.cursor, this.clock());
        this.exec('UPDATE source_checkpoints SET paused=? WHERE id=1', 'event_gap');
      }
      let sequence = cp.cursor;
      for (const raw of page.events) {
        const seq = raw.sequence;
        if (!Number.isSafeInteger(seq) || Number(seq) <= sequence || Number(seq) > page.cursor) throw Error('invalid_event_order');
        sequence = Number(seq);
        const m = normalize(raw, this.config);
        let reason = m ? ignoreReason(m, this.config, this.clock()) : 'invalid_structure';
        if (!reason && cp.baseline) reason = 'baseline';
        const authorized = m && (m.scope === 'group' ? this.config.access.group.allow : this.config.access.direct.allow).includes(m.conversationId);
        if (!reason && m?.scope === 'direct' && !m.text.startsWith('/bot ')) {
          const trigger = conversationConfig(this.config, 'direct', m.conversationId)?.directTrigger ?? this.config.access.direct.trigger;
          if (trigger === 'all' || m.text.startsWith(this.config.access.prefix)) {
            const route = routeKey(m.accountKey, m.scope, m.conversationId);
            const local = this.one("SELECT count(*) n FROM inbox WHERE route=? AND state IN ('pending','dispatching')", route)!.n;
            const global = this.one("SELECT count(*) n FROM inbox WHERE state IN ('pending','dispatching')")!.n;
            if (local >= this.config.runtime.perSessionQueue || global >= this.config.runtime.globalQueue) reason = 'execution_queue_full';
          }
        }
        const payload = JSON.stringify(authorized ? m : { sequence: seq, reason });
        const messageId = m?.messageId ?? `invalid:${seq}`;
        const key = hash([this.config.account.key, this.config.account.bridgeEpoch, messageId]);
        this.exec(`INSERT OR IGNORE INTO inbox VALUES(?,?,?,?,?,?,?,?,?,?)`, key, seq as number,
          authorized ? routeKey(m.accountKey, m.scope, m.conversationId) : null, authorized ? m.conversationId : null,
          authorized ? m.senderId : null, payload, Buffer.byteLength(payload), reason ? 'ignored' : 'pending', reason, this.clock());
        if (authorized && m.kind !== 'unsupported') this.recordHistory(routeKey(m.accountKey, m.scope, m.conversationId), m);
      }
      const size = this.one('SELECT count(*) n,coalesce(sum(bytes),0) bytes FROM inbox')!;
      if (size.n > this.config.storage.maxInbox || size.bytes > this.config.storage.maxInboxBytes) throw Error('inbox_capacity');
      // Bridge durable-tail reads return at most 500 events but advertise the
      // global tip as cursor. Commit only the actual page, not that tip.
      if (!page.events.length && page.cursor > cp.cursor) {
        this.exec('UPDATE source_checkpoints SET paused=? WHERE id=1', 'empty_page_ahead'); return;
      }
      this.exec('UPDATE source_checkpoints SET cursor=?,baseline=? WHERE id=1', sequence, cp.baseline && page.events.length ? 1 : 0);
    });
  }
  acceptBaseline() {
    this.exec('UPDATE source_checkpoints SET baseline=1,paused=NULL WHERE id=1');
    this.exec("UPDATE inbox SET state='ignored',reason='new_baseline' WHERE state IN ('pending','observed')");
  }
  session(message: Message): Session {
    const key = routeKey(message.accountKey, message.scope, message.conversationId);
    this.exec('INSERT OR IGNORE INTO session_map(key,id,generation,conversation,scope,model) VALUES(?,?,1,?,?,?)',
      key, randomUUID(), message.conversationId, message.scope, 'default');
    return this.one('SELECT * FROM session_map WHERE key=?', key) as Session;
  }
  messages(route: string, limit = 30): Message[] {
    return this.all("SELECT payload FROM inbox WHERE route=? AND reason IS NULL ORDER BY sequence DESC LIMIT ?", route, limit)
      .reverse().map(r => JSON.parse(r.payload));
  }
  recordHistory(route: string, m: Message, requestId: string | null = null) {
    this.exec('INSERT OR IGNORE INTO chat_history(route,message_id,payload,occurred,request_id) VALUES(?,?,?,?,?)',
      route, m.messageId, JSON.stringify(m), m.timestampMs, requestId);
  }
  recordSent(row: Row, result: Record<string, any>) {
    if (!['text', 'file'].includes(row.kind) || !['local_accepted', 'message_recorded', 'server_confirmed'].includes(result.state ?? row.state)) return;
    const body = JSON.parse(row.body);
    const text = row.kind === 'file' && typeof body.path === 'string' ? '[文件] ' + basename(body.path) : body.text;
    if (typeof text !== 'string' || !text) return;
    const id = typeof result.message_id === 'string' && result.message_id ? result.message_id : 'request:' + row.id;
    const old = this.one('SELECT * FROM chat_history WHERE request_id=?', row.id);
    const canonical = this.one('SELECT * FROM chat_history WHERE route=? AND message_id=?', row.route, id);
    if (old) {
      if (canonical && canonical.position !== old.position) {
        // Preserve the original position so already-completed summary watermarks remain stable.
        this.exec('DELETE FROM chat_history WHERE position=?', canonical.position);
      }
      const message = JSON.parse(old.payload); message.messageId = id;
      this.exec('UPDATE chat_history SET message_id=?,payload=? WHERE position=?', id, JSON.stringify(message), old.position);
      return;
    }
    if (canonical) { this.exec('UPDATE chat_history SET request_id=? WHERE position=?', row.id, canonical.position); return; }
    const conversation = body.recipient;
    this.recordHistory(row.route, { accountKey: this.config.account.key, bridgeEpoch: this.config.account.bridgeEpoch,
      sequence: 0, messageId: id, conversationId: conversation, senderId: this.config.account.selfId,
      scope: conversation.endsWith('@chatroom') ? 'group' : 'direct', direction: 'outgoing', kind: row.kind,
      text, timestampMs: row.created }, row.id);
  }
  timeline(route: string, limit: number = this.config.runtime.recentMessages) {
    return this.all('SELECT position,payload FROM chat_history WHERE route=? ORDER BY position DESC LIMIT ?', route, limit)
      .reverse().map(r => ({ position: Number(r.position), message: JSON.parse(r.payload) as Message }));
  }
  mediaDescriptor(route: string, messageId: string) {
    const row = this.one('SELECT m.descriptor,m.resource_id,a.expires FROM message_media m LEFT JOIN artifacts a ON a.id=m.resource_id WHERE m.route=? AND m.message_id=?', route, messageId);
    if (!row) return undefined;
    const descriptor = JSON.parse(row.descriptor);
    if (row.resource_id && (!row.expires || row.expires < this.clock()))
      return { messageId, kind: descriptor.kind, state: 'expired', note: '沙箱附件已过期，可请求重新准备。' };
    return descriptor as Record<string, any>;
  }
  prepareReply(session: Session, eventId: string, text: string): void {
    this.prepareMessages(session, eventId, [text]);
  }
  prepareMessages(session: Session, eventId: string, texts: string[]): void {
    if (!texts.length || texts.some(t => typeof t !== 'string' || !t.trim())) throw Error('invalid_reply_messages');
    const chunks = texts.flatMap(text => chunkText(text, this.config.egress.chunkBytes, this.config.egress.maxInlineParts));
    if (chunks.length > this.config.egress.maxInlineParts) throw Error('reply_requires_artifact');
    this.transaction(() => chunks.forEach((part, i) => {
      const id = requestId(this.config.account.key, session, eventId, i);
      const body = JSON.stringify({ request_id: id, recipient: session.conversation, text: part, wait: false });
      const existing = this.one('SELECT hash FROM outbox WHERE id=?', id);
      if (existing && existing.hash !== hash(body)) throw Error('request_id_conflict');
      this.exec('INSERT OR IGNORE INTO outbox(id,reply,route,part,body,hash,state,created) VALUES(?,?,?,?,?,?,?,?)',
        id, eventId, session.key, i, body, hash(body), 'prepared', this.clock());
    }));
  }
  startRun(input: HostInput, ids: string[]) {
    this.transaction(() => {
      this.exec('INSERT INTO runs VALUES(?,?,?,?,?,?,?,NULL)', input.inputId, input.session.key, JSON.stringify(input), JSON.stringify(ids), 'dispatching', input.purpose, this.clock());
      for (const id of ids) this.exec("UPDATE inbox SET state='dispatching' WHERE id=?", id);
    });
  }
  prepareFile(session: Session, eventId: string, path: string) {
    const id = requestId(this.config.account.key, session, eventId, 0);
    const body = JSON.stringify({ request_id: id, recipient: session.conversation, path, wait: false });
    const existing = this.one('SELECT hash FROM outbox WHERE id=?', id);
    if (existing && existing.hash !== hash(body)) throw Error('request_id_conflict');
    this.exec("INSERT OR IGNORE INTO outbox(id,reply,route,part,body,hash,state,created,kind) VALUES(?,?,?,0,?,?,'prepared',?,'file')", id, eventId, session.key, body, hash(body), this.clock());
  }
  completeRun(id: string, state: string, result: unknown) {
    this.transaction(() => {
      const run = this.one('SELECT * FROM runs WHERE id=?', id)!;
      this.exec('UPDATE runs SET state=?,result=? WHERE id=?', state, JSON.stringify(result), id);
      if (run.purpose === 'reply') for (const source of JSON.parse(run.source_ids)) this.exec('UPDATE inbox SET state=? WHERE id=?', state, source);
    });
  }
  sweep() {
    const cutoff = this.clock() - this.config.storage.retentionDays * 86400000;
    this.transaction(() => {
      // Active/uncertain inputs and output identities survive the retention sweep.
      this.exec("DELETE FROM inbox WHERE created<? AND state IN ('ignored','completed','cancelled','observed','failed')", cutoff);
      this.exec("DELETE FROM memory_units WHERE created<?", cutoff);
      // Never discard raw messages that still await a successful summary.
      this.exec(`DELETE FROM chat_history WHERE occurred<? AND position<=coalesce(
        (SELECT position FROM summary_checkpoints WHERE route=chat_history.route),0)`, cutoff);
      this.exec('DELETE FROM context_audit WHERE created<?', cutoff);
      this.exec("UPDATE runs SET input='{}',source_ids='[]',result=NULL WHERE created<? AND state IN ('completed','failed','cancelled')", cutoff);
      this.exec("UPDATE outbox SET body='{}',result=NULL WHERE created<? AND state IN ('server_confirmed','failed','cancelled')", cutoff);
      this.exec("DELETE FROM participation_decisions WHERE created<? AND state<>'pending'", cutoff);
      this.exec("DELETE FROM prompt_snapshots WHERE created<? AND id NOT IN (SELECT id FROM runs WHERE state IN ('dispatching','needs_review'))", cutoff);
      this.exec("UPDATE interactions SET state='expired' WHERE expires<? AND state='pending'", this.clock());
      this.exec("DELETE FROM interactions WHERE expires<? AND state<>'pending'", cutoff);
    });
  }
  close() {
    this.exec('DELETE FROM consumer_lock WHERE owner=?', this.owner);
    this.db.close();
  }
}
