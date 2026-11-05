import { randomBytes } from 'node:crypto';
import { hash, type Session } from '../contracts.js';
import type { Store } from '../storage/database.js';

export class Interactions {
  constructor(readonly store: Store) {}
  create(session: Session, sender: string, kind: 'question' | 'approval', payload: unknown) {
    const id = randomBytes(5).toString('hex').toUpperCase();
    this.store.exec('INSERT INTO interactions VALUES(?,?,?,?,?,?,?,?,?,NULL)', id, session.key, session.generation, sender, kind,
      JSON.stringify(payload), hash(payload), this.store.clock() + this.store.config.interactions.timeoutSeconds * 1000, 'pending');
    return id;
  }
  settle(session: Session, sender: string, id: string, answer: string, kind: 'question' | 'approval') {
    return this.store.transaction(() => {
      const row = this.store.one("SELECT * FROM interactions WHERE id=? AND route=? AND generation=? AND sender=? AND kind=? AND state='pending' AND expires>?",
        id, session.key, session.generation, sender, kind, this.store.clock());
      if (!row) return false;
      this.store.exec("UPDATE interactions SET state=?,answer=? WHERE id=? AND state='pending'", answer === 'deny' ? 'denied' : 'answered', answer, id);
      return true;
    });
  }
  settleCurrentApproval(session: Session, sender: string, answer: 'allow' | 'deny') {
    // Only the single active, submitted prompt can be answered without an ID.
    // Queued requests cannot steal an answer intended for the displayed task.
    const rows = this.store.all(`SELECT i.id FROM interactions i WHERE i.route=? AND i.generation=? AND i.sender=?
      AND i.kind='approval' AND i.state='pending' AND i.expires>?
      AND EXISTS(SELECT 1 FROM outbox o WHERE o.reply='command:external-approval:'||i.id AND o.submitted=1
        AND o.state IN ('local_accepted','message_recorded','server_confirmed'))`, session.key, session.generation, sender, this.store.clock());
    return rows.length === 1 && this.settle(session, sender, rows[0]!.id, answer, 'approval');
  }
  invalidate(route?: string) {
    const live = "(state IN ('pending','queued','answered') OR state='consumed' AND json_extract(payload,'$.scope')='task')";
    if (route) this.store.exec(`UPDATE interactions SET state='invalidated' WHERE (route=? OR json_extract(payload,'$.originRoute')=?) AND ${live}`, route, route);
    else this.store.exec(`UPDATE interactions SET state='invalidated' WHERE ${live}`);
  }
}
