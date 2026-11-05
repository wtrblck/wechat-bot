// Clears the bot's working conversation state. Prompts, configuration and accounting are immutable here.
import { DatabaseSync } from 'node:sqlite';
import { readFileSync, writeFileSync, mkdirSync, readdirSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createHash, randomUUID } from 'node:crypto';
import assert from 'node:assert/strict';
import { inspect } from './bot-status.mjs';
import { loadConfig } from '../dist/src/config.js';

if (!process.argv.includes('--apply')) throw Error('explicit_apply_required');
const root = fileURLToPath(new URL('..', import.meta.url));
const status = await inspect();
if (status.agent.running || status.bridge.reachable) throw Error('stop_bot_and_bridge_before_reset');
const config = loadConfig(resolve(root, 'config/agent.local.yaml'));
const db = new DatabaseSync(resolve(root, config.storage.file));
const hash = value => createHash('sha256').update(value).digest('hex');
const table = name => !!db.prepare("SELECT 1 FROM sqlite_master WHERE type='table' AND name=?").get(name);
const rows = name => table(name) ? db.prepare('SELECT * FROM "' + name + '" ORDER BY rowid').all() : [];
const promptFiles = directory => readdirSync(directory, { withFileTypes: true }).flatMap(entry => {
  const path = resolve(directory, entry.name);
  if (entry.isSymbolicLink()) throw Error('prompt_link_requires_review');
  return entry.isDirectory() ? promptFiles(path) : [[path, hash(readFileSync(path))]];
});
const protectedFiles = [...promptFiles(resolve(root, 'prompts')),
  [resolve(root, 'config/agent.local.yaml'), hash(readFileSync(resolve(root, 'config/agent.local.yaml')))]];
const protectedTables = ['self_profiles', 'self_profile_receipts', 'prompt_snapshots', 'budget_requests', 'budget_stops'];
const fingerprints = Object.fromEntries(protectedTables.map(name => [name, hash(JSON.stringify(rows(name)))]));
const cleared = ['inbox', 'runs', 'participation_decisions', 'outbox', 'interactions', 'memory_units', 'memory_checkpoints',
  'chat_history', 'memory_segments', 'summary_checkpoints', 'social_notes', 'social_tones', 'social_care', 'social_followups',
  'context_audit', 'artifacts', 'message_media', 'trace_inbox', 'trace_sources', 'trace_outputs', 'trace_events',
  'delivery_batches', 'work_results', 'reply_reviews', 'decision_retries', 'input_retries', 'codex_tasks',
  'conversation_contexts', 'context_receipts', 'context_delivery_receipts', 'gaps'];
const counts = Object.fromEntries(cleared.filter(table).map(name => [name, db.prepare('SELECT count(*) n FROM "' + name + '"').get().n]));
try {
  db.exec('PRAGMA busy_timeout=5000; PRAGMA secure_delete=ON; BEGIN IMMEDIATE');
  const lease = db.prepare('SELECT * FROM consumer_lock WHERE expires>?').get(Date.now());
  if (lease) throw Error('consumer_became_active');
  for (const name of cleared.filter(table)) db.exec('DELETE FROM "' + name + '"');
  // Preserve route-specific model/persona preferences, but revoke all old logical task identities.
  for (const row of db.prepare('SELECT key FROM session_map').all())
    db.prepare('UPDATE session_map SET id=?,generation=generation+1,last_reply=0,quiet=0 WHERE key=?').run(randomUUID(), row.key);
  db.exec('UPDATE source_checkpoints SET baseline=1,paused=NULL; DELETE FROM consumer_lock');
  db.exec(`DELETE FROM metadata WHERE key NOT IN ('source','history_v2','self_profile_version','continuous_conversation_v1')
    AND key NOT LIKE 'budget_%' AND key NOT LIKE 'care_off:%'`);
  const resetAt = Date.now();
  db.prepare("INSERT OR REPLACE INTO metadata VALUES('context_reset_at',?)").run(String(resetAt));
  db.prepare("INSERT OR REPLACE INTO metadata VALUES('history_v2','1')").run();
  for (const [name, fingerprint] of Object.entries(fingerprints)) assert.equal(hash(JSON.stringify(rows(name))), fingerprint, name + '_changed');
  for (const [path, fingerprint] of protectedFiles) assert.equal(hash(readFileSync(path)), fingerprint, 'prompt_or_config_changed');
  db.exec('COMMIT');
  for (const name of cleared.filter(table)) assert.equal(db.prepare('SELECT count(*) n FROM "' + name + '"').get().n, 0, name);
  const checkpoint = db.prepare('PRAGMA wal_checkpoint(TRUNCATE)').all();
  const report = { clearedAt: new Date(resetAt).toISOString(), clearedCounts: counts,
    promptFilesUnchanged: true, promptAndProfileTablesUnchanged: true, budgetUnchanged: true,
    protectedTableHashes: fingerprints, oldBacklogBlockedBefore: resetAt, checkpoint,
    fileCleanupTargets: [resolve(root, 'data/memory'), resolve(root, 'data/dsh-home/sessions')] };
  const folder = resolve(root, 'data/validation'); mkdirSync(folder, { recursive: true });
  writeFileSync(resolve(folder, 'chat-state-reset.json'), JSON.stringify(report, null, 2) + '\n');
  console.log(JSON.stringify(report, null, 2));
} catch (error) { try { db.exec('ROLLBACK'); } catch {} throw error; }
finally { db.close(); }
