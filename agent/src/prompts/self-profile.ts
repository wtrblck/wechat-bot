import type { Store } from '../storage/database.js';
import type { HostInput } from '../contracts.js';
import type { PromptRegistry } from './registry.js';
import { randomUUID } from 'node:crypto';

export interface SelfProfileValue { version: string; persona: string | null; responseStyle: string | null }
export function installSelfProfile(store: Store) {
  store.db.exec(`CREATE TABLE IF NOT EXISTS self_profiles(version TEXT PRIMARY KEY,parent TEXT NOT NULL,
    persona TEXT,response_style TEXT,reason TEXT NOT NULL,route TEXT NOT NULL,run_id TEXT NOT NULL,created INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS self_profile_receipts(run_id TEXT PRIMARY KEY,version TEXT NOT NULL);
    INSERT OR IGNORE INTO metadata VALUES('self_profile_version','base');`);
}
export function activeSelfProfile(store: Store): SelfProfileValue {
  const version = store.one("SELECT value FROM metadata WHERE key='self_profile_version'")?.value ?? 'base';
  if (version === 'base') return { version, persona: null, responseStyle: null };
  const row = store.one('SELECT * FROM self_profiles WHERE version=?', version);
  if (!row) throw Error('self_profile_version_missing');
  return { version, persona: row.persona, responseStyle: row.response_style };
}
export class SelfProfile {
  constructor(readonly store: Store, readonly registry: PromptRegistry) { installSelfProfile(store); }
  read(input: HostInput) {
    const active = activeSelfProfile(this.store);
    const snapshot = this.registry.snapshot(input.session, 'reply', this.store);
    return { ...active, scope: 'global', effectivePersona: snapshot.sections.find(s => s.type === 'persona')?.text ?? '',
      effectiveStyle: snapshot.sections.find(s => s.type === 'responseStyle')?.text ?? '',
      history: this.store.all('SELECT version,parent,reason,created FROM self_profiles ORDER BY created DESC,rowid DESC LIMIT 10') };
  }
  change(input: HostInput, expected: string, reason: string, patch: Partial<Pick<SelfProfileValue, 'persona' | 'responseStyle'>>, rollback?: string) {
    return this.store.transaction(() => {
      const receipt = this.store.one('SELECT version FROM self_profile_receipts WHERE run_id=?', input.inputId);
      if (receipt) return { status: 'already_applied', version: receipt.version, activeVersion: activeSelfProfile(this.store).version, scope: 'global' };
      const active = activeSelfProfile(this.store);
      if (active.version !== expected) return { status: 'version_conflict', version: active.version, scope: 'global' };
      let value = { ...active, ...patch };
      if (rollback) {
        if (rollback === 'base') value = { version: 'base', persona: null, responseStyle: null };
        else {
          const old = this.store.one('SELECT * FROM self_profiles WHERE version=?', rollback);
          if (!old) throw Error('self_profile_version_unavailable');
          value = { version: old.version, persona: old.persona, responseStyle: old.response_style };
        }
      }
      for (const text of [value.persona, value.responseStyle]) if (text !== null &&
        (!text.trim() || Buffer.byteLength(text) > 16000 || /[\x00-\x08\x0b-\x1f\x7f]/.test(text))) throw Error('invalid_self_profile');
      const version = randomUUID();
      this.store.exec('INSERT INTO self_profiles VALUES(?,?,?,?,?,?,?,?)', version, active.version,
        value.persona, value.responseStyle, reason, input.session.key, input.inputId, this.store.clock());
      this.store.exec("UPDATE metadata SET value=? WHERE key='self_profile_version'", version);
      // Validate every known/configured route and persona before publishing this global version.
      const sessions = this.store.all('SELECT * FROM session_map').map(s => ({ ...input.session, ...s }));
      for (const scope of ['direct', 'group'] as const) {
        const overrides = scope === 'group' ? this.store.config.conversationOverrides.groups : this.store.config.conversationOverrides.contacts;
        for (const conversation of ['', ...Object.keys(overrides)])
          for (const persona of [null, ...Object.keys(this.store.config.promptProfiles)])
            sessions.push({ ...input.session, scope, conversation, persona });
      }
      for (const session of sessions) this.registry.validateSelfProfile(session, this.store);
      this.store.exec('INSERT INTO self_profile_receipts VALUES(?,?)', input.inputId, version);
      this.store.exec('DELETE FROM self_profiles WHERE version NOT IN (SELECT version FROM self_profiles ORDER BY created DESC,rowid DESC LIMIT 50)');
      return { status: 'updated', version, scope: 'global', effective: 'next_turn' };
    });
  }
}
