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
  invalidate(route?: string) {
    if (route) this.store.exec("UPDATE interactions SET state='invalidated' WHERE (route=? OR json_extract(payload,'$.originRoute')=?) AND state='pending'", route, route);
    else this.store.exec("UPDATE interactions SET state='invalidated' WHERE state='pending'");
  }
}
