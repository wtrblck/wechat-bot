import { z } from 'zod';
import { hash, type Message, type Session } from '../contracts.js';
import type { Store } from '../storage/database.js';
import { SocialState } from './social-state.js';

export const socialSchema = z.strictObject({
  kind: z.enum(['preference', 'correction', 'open_loop']),
  key: z.string().trim().min(1).max(40),
  sourceMessageId: z.string().min(1).max(256),
  quote: z.string().trim().min(2).max(240),
  followUpAt: z.number().int().positive().optional(), status: z.enum(['open', 'closed']).optional(),
});

/** Attributed quotations, never executable instructions or cross-conversation profiles. */
export class SocialMemory {
  constructor(readonly store: Store) {}
  record(session: Session, values: z.infer<typeof socialSchema>[], sources: Message[]) {
    if (!this.store.config.memory.enabled || !this.store.config.social.enabled) return;
    for (const value of values) {
      const v = socialSchema.parse(value);
      const m = sources.find(m => m.messageId === v.sourceMessageId);
      // The speaker comes from the actual incoming event, never a model-provided identity.
      if (!m || m.direction !== 'incoming' || m.scope !== session.scope || m.conversationId !== session.conversation ||
          m.accountKey !== this.store.config.account.key || m.bridgeEpoch !== this.store.config.account.bridgeEpoch || !m.text.includes(v.quote)) continue;
      const occurred = Math.min(m.timestampMs, this.store.clock());
      const expires = occurred + (v.kind === 'open_loop' ? 7 : 30) * 86400000;
      this.store.exec('INSERT OR IGNORE INTO social_notes(id,route,subject,kind,slot,quote,source_id,occurred,sequence,expires,status) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
        hash([session.key, m.messageId, v.kind, v.key, v.quote]), session.key, m.senderId, v.kind, v.key,
        v.quote, m.messageId, occurred, m.sequence, expires, v.status ?? 'open');
      if (v.kind === 'open_loop') new SocialState(this.store).schedule(session, m, v.key, v.quote, v.followUpAt, v.status === 'closed');
    }
    this.store.exec('DELETE FROM social_notes WHERE route=? AND expires<=?', session.key, this.store.clock());
    // Bounded correction history. Deterministic source order prevents delayed summaries undoing newer corrections.
    this.store.exec(`DELETE FROM social_notes WHERE route=? AND id NOT IN
      (SELECT id FROM social_notes WHERE route=? ORDER BY occurred DESC,sequence DESC,id DESC LIMIT 512)`, session.key, session.key);
  }
  context(session: Session, senderIds: string[], maxBytes = 4096) {
    if (!this.store.config.memory.enabled || !this.store.config.social.enabled || !senderIds.length) return [];
    const ids = [...new Set(senderIds)].slice(-8);
    const rows = this.store.all(`SELECT * FROM (SELECT *,row_number() OVER
      (PARTITION BY subject,kind,slot ORDER BY occurred DESC,sequence DESC,id DESC) rank
      FROM social_notes WHERE route=?) WHERE rank=1 AND expires>? AND subject IN (${ids.map(() => '?').join(',')})
      ORDER BY CASE kind WHEN 'correction' THEN 0 WHEN 'preference' THEN 1 ELSE 2 END,occurred DESC LIMIT 12`,
      session.key, this.store.clock(), ...ids);
    const result: Record<string, unknown>[] = []; let bytes = 2;
    for (const r of rows) {
      const lastCareAt = new SocialState(this.store).lastCare(session.key, r.source_id);
      const item = { subjectId: r.subject, kind: r.kind, key: r.slot, quote: r.quote,
        status: r.status, lastCareAt, canFollowUp: r.status !== 'closed' && (!lastCareAt || this.store.clock() - lastCareAt >= this.store.config.social.careCooldownHours * 3600000),
        sourceMessageId: r.source_id, occurredAt: r.occurred, expiresAt: r.expires, evidenceOnly: true };
      const size = Buffer.byteLength(JSON.stringify(item)) + 1;
      if (bytes + size > maxBytes) continue;
      result.push(item); bytes += size;
    }
    return result;
  }
}
