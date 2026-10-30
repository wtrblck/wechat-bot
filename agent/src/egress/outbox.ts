import type { Bridge } from '../bridge/client.js';
import { BridgeError } from '../bridge/client.js';
import type { Store, Row } from '../storage/database.js';

const accepted = new Set(['local_accepted', 'message_recorded', 'server_confirmed']);
const stopped = new Set(['failed', 'cancelled', 'unknown', 'needs_review']);
const states = new Set(['prepared', 'queued', 'sending', ...accepted, ...stopped]);
const graphemes = new Intl.Segmenter(undefined, { granularity: 'grapheme' });
export function messageInterval(text: string): number {
  let length = 0;
  for (const _ of graphemes.segment(text)) if (++length >= 50) break;
  return 500 + length * 10;
}
export class Outbox {
  stopping = false;
  private readonly busy = new Set<string>();
  constructor(readonly store: Store, readonly bridge: Bridge,
    readonly wait: (ms: number) => Promise<void> = ms => new Promise(resolve => setTimeout(resolve, ms)),
    readonly progress: () => void = () => {}) {}
  async tick() {
    if (this.stopping) return;
    const routes = this.store.all("SELECT DISTINCT route FROM outbox WHERE state IN ('prepared','queued','sending','local_accepted','message_recorded')");
    await Promise.allSettled(routes.map(async r => {
      if (this.busy.has(r.route)) return;
      this.busy.add(r.route);
      try { await this.route(r.route); } finally { this.busy.delete(r.route); }
    }));
  }
  private async route(route: string) {
    const rows = this.store.all('SELECT * FROM outbox WHERE route=? ORDER BY created,rowid,part', route);
    for (const scheduled of rows) {
      if (this.stopping) return;
      // Earlier parts may have cancelled this batch since the original snapshot was read.
      const row = this.store.one('SELECT * FROM outbox WHERE id=?', scheduled.id);
      if (!row) continue;
      if (stopped.has(row.state)) {
        this.store.exec("UPDATE outbox SET state='cancelled' WHERE reply=? AND submitted=0 AND state='prepared'", row.reply);
        // An uncertain send blocks this conversation until local reconciliation.
        if (row.state === 'unknown' || row.state === 'needs_review') return;
        continue;
      }
      if (row.state === 'server_confirmed') continue;
      try {
        const existing = await this.bridge.request(row.id);
        if (existing) this.update(row, existing);
        else if (this.stopping) return;
        else if (row.submitted && this.store.config.bridge.requestStoreContinuity !== 'confirmed') {
          this.store.exec("UPDATE outbox SET state='needs_review' WHERE id=?", row.id); return;
        } else {
          // Persist pacing before POST: a lost response or restart must not bypass the interval.
          const key = `outbox_pacing:${route}`;
          const previous = this.store.one('SELECT value FROM metadata WHERE key=?', key);
          const pace = previous ? JSON.parse(previous.value) : undefined;
          if (pace?.reply === row.reply) {
            const remaining = Math.min(1000, pace.nextAt - this.store.clock());
            if (remaining > 0) await this.wait(remaining);
          }
          // Shutdown or cancellation may occur while waiting. Never send the stale snapshot.
          if (this.stopping) return;
          const current = this.store.one('SELECT state,submitted FROM outbox WHERE id=?', row.id);
          if (!current || stopped.has(current.state)) continue;
          const text = row.kind === 'text' ? JSON.parse(row.body).text : '';
          this.store.exec('INSERT OR REPLACE INTO metadata VALUES(?,?)', key,
            JSON.stringify({ reply: row.reply, nextAt: this.store.clock() + messageInterval(text) }));
          // This mark commits BEFORE POST, including the crash-before-POST window.
          this.store.exec('UPDATE outbox SET submitted=1 WHERE id=?', row.id);
          this.update(row, await this.bridge.send(row.body, row.kind));
        }
      } catch (error) {
        if (error instanceof BridgeError && (error.status === 409 || (error.status >= 400 && error.status < 500 && error.status !== 429))) {
          this.store.exec("UPDATE outbox SET state='failed',result=? WHERE id=?", JSON.stringify({ code: error.code }), row.id);
        }
        // A lost response is reconciled by ID on the next tick, never a fresh ID.
        return;
      }
      const latest = this.store.one('SELECT state FROM outbox WHERE id=?', row.id)!;
      this.progress();
      if (!accepted.has(latest.state)) return;
    }
  }
  private update(row: Row, result: Record<string, any>) {
    if (result.request_id !== row.id || !states.has(result.state)) throw new BridgeError('invalid_request_response');
    this.store.transaction(() => {
      this.store.exec('UPDATE outbox SET state=?,result=? WHERE id=?', result.state, JSON.stringify({
        state: result.state, message_id: result.message_id, server_id: result.server_id, delivery_verified: false,
        error: result.error_code ?? result.error,
      }), row.id);
      this.store.recordSent(row, result);
    });
    if (['server_confirmed', 'failed', 'cancelled'].includes(result.state)) this.releaseFile(row);
  }
  private releaseFile(row: Row) {
    if (row.kind !== 'file') return;
    const path = JSON.parse(row.body).path;
    const pending = this.store.one("SELECT count(*) n FROM outbox WHERE kind='file' AND json_extract(body,'$.path')=? AND state NOT IN ('server_confirmed','failed','cancelled')", path)!.n;
    if (!pending) this.store.exec('UPDATE artifacts SET refs=0 WHERE path=?', path);
  }
  async cancel(route: string) {
    const rows = this.store.all("SELECT * FROM outbox WHERE route=? AND state IN ('prepared','queued','sending')", route);
    for (const r of rows) {
      if (!r.submitted) { this.store.exec("UPDATE outbox SET state='cancelled' WHERE id=?", r.id); this.releaseFile(r); }
      else {
        try { await this.bridge.cancel(r.id); const state = await this.bridge.request(r.id); if (state) this.update(r, state); }
        catch { /* Already sending cannot be recalled. Keep tracking it. */ }
      }
    }
  }
}
