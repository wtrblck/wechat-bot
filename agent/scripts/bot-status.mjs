// Read-only status. Never acquires the consumer lease, sends messages or calls a model.
import { existsSync, readFileSync } from 'node:fs';
import { DatabaseSync } from 'node:sqlite';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parse } from 'yaml';

const root = fileURLToPath(new URL('..', import.meta.url));
export function readAgentStatus(file, now = Date.now()) {
  if (!existsSync(file)) return { running: false, ready: false, state: 'stopped', pid: null };
  const db = new DatabaseSync(file, { readOnly: true });
  try {
    const table = name => !!db.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name=?").get(name);
    const lease = table('consumer_lock') ? db.prepare('SELECT * FROM consumer_lock WHERE id=1').get() : undefined;
    const raw = table('metadata') ? db.prepare("SELECT value FROM metadata WHERE key='runtime_status'").get() : undefined;
    const status = raw ? JSON.parse(raw.value) : undefined;
    let alive = false;
    if (Number.isSafeInteger(status?.pid) && status.pid > 0) {
      try { process.kill(status.pid, 0); alive = true; } catch (e) { alive = e.code === 'EPERM'; }
    }
    const leaseFresh = !!lease && lease.expires > now;
    // A fresh lease is authoritative even before the new instance publishes its first status.
    const running = leaseFresh;
    const ready = running && alive && status.owner === lease.owner && status.state === 'running' && Math.abs(now - status.updated) < 15000;
    const owned = status?.owner === lease?.owner;
    return { running, ready, state: running ? owned ? alive ? status.state : 'lease_wait' : 'starting' : 'stopped', pid: running && owned ? status.pid : null,
      lastUpdate: status?.updated ?? null, diagnostics: status?.diagnostics ?? [] };
  } finally { db.close(); }
}
export async function inspect() {
  const config = parse(readFileSync(resolve(root, 'config/agent.local.yaml'), 'utf8'));
  const agent = readAgentStatus(resolve(root, config.storage?.file ?? 'data/agent.sqlite'));
  let bridge = { reachable: false, ready: false, state: 'stopped', sendReady: false, receiveReady: false };
  try {
    const session = JSON.parse(readFileSync(resolve(root, config.bridge.sessionFile), 'utf8'));
    const url = new URL(session.url);
    if (url.protocol !== 'http:' || url.hostname !== '127.0.0.1' || !url.port || url.username || url.password ||
        url.pathname !== '/' || url.search || url.hash || typeof session.token !== 'string' || /\s/.test(session.token) || !session.token) throw Error('invalid_session');
    const response = await fetch(url.origin + '/health', { headers: { Authorization: `Bearer ${session.token}` },
      redirect: 'error', signal: AbortSignal.timeout(1800) });
    if (response.ok) {
      const health = await response.json();
      bridge = { reachable: true, ready: health.ready === true && health.send_ready === true && health.receive_ready === true,
        state: health.state, sendReady: health.send_ready === true, receiveReady: health.receive_ready === true };
    }
  } catch { /* Missing/stale discovery and refused connections are normal while stopped. No token in output. */ }
  return { bridge, agent };
}
if (process.argv[1] && resolve(process.argv[1]) === fileURLToPath(import.meta.url)) {
  try { console.log(JSON.stringify(await inspect())); }
  catch { console.log(JSON.stringify({ error: 'status_unavailable' })); process.exitCode = 1; }
}
