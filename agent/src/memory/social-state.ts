import { z } from 'zod';
import { hash, type Message, type Session } from '../contracts.js';
import type { Store } from '../storage/database.js';

export const toneSchema = z.enum(['light', 'serious', 'quiet', 'neutral']);
export class SocialState {
  constructor(readonly store: Store) {}
  tone(session: Session, m: Message, topic: string, state: z.infer<typeof toneSchema>) {
    if (!this.store.config.social.enabled) return;
    toneSchema.parse(state);
    if (!topic.trim() || topic.length > 128 || m.direction !== 'incoming' || m.accountKey !== this.store.config.account.key ||
      m.bridgeEpoch !== this.store.config.account.bridgeEpoch || m.scope !== session.scope || m.conversationId !== session.conversation)
      throw Error('tone_source_denied');
    const occurred = Math.min(m.timestampMs, this.store.clock()), expires = occurred + this.store.config.social.toneMinutes * 60000;
    this.store.exec(`INSERT INTO social_tones VALUES(?,?,?,?,?,?,?,?) ON CONFLICT(route,subject,topic) DO UPDATE SET
      state=excluded.state,source_id=excluded.source_id,sequence=excluded.sequence,occurred=excluded.occurred,expires=excluded.expires
      WHERE excluded.sequence>social_tones.sequence`, session.key, m.senderId, topic, state, m.messageId, m.sequence, occurred, expires);
    this.store.exec(`DELETE FROM social_tones WHERE route=? AND rowid NOT IN
      (SELECT rowid FROM social_tones WHERE route=? ORDER BY sequence DESC LIMIT 64)`, session.key, session.key);
  }
  tones(session: Session, subjects: string[], topic?: string) {
    if (!this.store.config.social.enabled) return [];
    return this.store.all('SELECT * FROM social_tones WHERE route=? AND expires>? ORDER BY sequence DESC LIMIT 64', session.key, this.store.clock())
      .filter(r => subjects.includes(r.subject) && (!topic || r.topic === topic) && r.state !== 'neutral').slice(0, 4)
      .map(r => ({ subjectId: r.subject, topic: r.topic, state: r.state, sourceMessageId: r.source_id,
        strength: Math.max(0, Math.min(1, (r.expires - this.store.clock()) / (r.expires - r.occurred))), expiresAt: r.expires, evidenceOnly: true }));
  }
  lastCare(route: string, sourceId: string) {
    return Number(this.store.one(`SELECT max(c.created) t FROM social_care c JOIN outbox o ON o.reply=c.reply_id AND o.route=c.route
      JOIN social_notes old ON old.route=c.route AND old.source_id=c.source_id AND old.kind='open_loop'
      JOIN social_notes current ON current.route=old.route AND current.subject=old.subject AND current.slot=old.slot AND current.kind=old.kind
      WHERE c.route=? AND current.source_id=? AND o.state NOT IN ('cancelled','failed')`, route, sourceId)?.t ?? 0);
  }
  planCare(session: Session, runId: string, sourceId: string) {
    if (!this.store.config.social.enabled || !this.store.config.memory.enabled) throw Error('social_disabled');
    const row = this.store.one("SELECT * FROM social_notes WHERE route=? AND source_id=? AND kind='open_loop' AND expires>?", session.key, sourceId, this.store.clock());
    if (!row || row.status === 'closed' || this.store.one("SELECT id FROM social_notes WHERE route=? AND subject=? AND kind='open_loop' AND slot=? AND sequence>?",
      session.key, row.subject, row.slot, row.sequence)) throw Error('care_source_denied');
    if (this.lastCare(session.key, sourceId) && this.store.clock() - this.lastCare(session.key, sourceId) < this.store.config.social.careCooldownHours * 3600000)
      throw Error('care_cooldown');
    this.store.exec('INSERT OR IGNORE INTO social_care VALUES(?,?,?,NULL,?)', runId, session.key, sourceId, this.store.clock());
  }
  bindCare(runId: string, replyId: string) {
    this.store.exec('UPDATE social_care SET reply_id=? WHERE run_id=? AND reply_id IS NULL', replyId, runId);
  }
  quiet() {
    const p = this.store.config.social.proactive;
    const hour = Number(new Intl.DateTimeFormat('en-GB', { timeZone: 'Asia/Shanghai', hour: '2-digit', hourCycle: 'h23' }).format(this.store.clock()));
    return p.quietStartHour === p.quietEndHour || (p.quietStartHour < p.quietEndHour ?
      hour >= p.quietStartHour && hour < p.quietEndHour : hour >= p.quietStartHour || hour < p.quietEndHour);
  }
  schedule(session: Session, m: Message, key: string, quote: string, due?: number, closed = false) {
    this.store.exec("UPDATE social_followups SET state='superseded' WHERE route=? AND subject=? AND slot=? AND sequence<? AND state IN ('pending','claimed')",
      session.key, m.senderId, key, m.sequence);
    const p = this.store.config.social.proactive;
    if (!this.store.config.social.enabled || !p.enabled || !this.store.config.memory.enabled || session.scope !== 'direct' ||
      !p.contacts.includes(session.conversation) || closed || !due || due <= m.timestampMs || due > m.timestampMs + 7 * 86400000 ||
      this.store.one('SELECT id FROM social_followups WHERE route=? AND subject=? AND slot=? AND sequence>?', session.key, m.senderId, key, m.sequence)) return;
    this.store.exec("INSERT OR IGNORE INTO social_followups VALUES(?,?,?,?,?,?,?,?,'pending',NULL)",
      hash([session.key, m.messageId, key]), session.key, m.senderId, key, m.messageId, quote, due, m.sequence);
  }
  eligible(session: Session, job: Record<string, any>) {
    const p = this.store.config.social.proactive, now = this.store.clock();
    const cp = this.store.checkpoint();
    if (!this.store.config.social.enabled || !this.store.config.memory.enabled || !p.enabled || !p.contacts.includes(session.conversation) ||
      !this.store.config.access.direct.allow.includes(session.conversation) || session.scope !== 'direct' || this.quiet() || cp.paused || cp.baseline ||
      job.route !== session.key || job.state !== 'pending' || job.due > now || now - job.due > 86400000 ||
      this.store.one('SELECT quiet FROM session_map WHERE key=?', session.key)?.quiet) return false;
    if (this.store.one('SELECT value FROM metadata WHERE key=?', 'care_off:' + session.key)?.value === '1' ||
      this.store.one("SELECT id FROM social_notes WHERE route=? AND subject=? AND kind='open_loop' AND slot=? AND sequence>?",
        session.key, job.subject, job.slot, job.sequence)) return false;
    if (this.store.one("SELECT id FROM inbox WHERE route=? AND state IN ('pending','dispatching','needs_review') LIMIT 1", session.key) ||
      this.store.one("SELECT id FROM outbox WHERE route=? AND state IN ('prepared','queued','unknown','needs_review') LIMIT 1", session.key)) return false;
    const last = this.store.one('SELECT max(occurred) t FROM chat_history WHERE route=?', session.key)?.t;
    if (!last || now - last < p.minIdleMinutes * 60000) return false;
    if (now - this.lastCare(session.key, job.source_id) < this.store.config.social.careCooldownHours * 3600000) return false;
    const date = new Intl.DateTimeFormat('sv-SE', { timeZone: 'Asia/Shanghai', year: 'numeric', month: '2-digit', day: '2-digit' }).format(now);
    const start = Date.parse(date + 'T00:00:00+08:00');
    return this.store.one('SELECT count(*) n FROM social_followups WHERE route=? AND attempted>=?', session.key, start)!.n < p.maxPerContactPerDay;
  }
}
