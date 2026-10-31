import { randomUUID } from 'node:crypto';
import { mkdirSync, readFileSync, writeFileSync, renameSync, unlinkSync, statSync } from 'node:fs';
import { resolve } from 'node:path';

/** A per-process stop capability. Stale requests cannot stop a replacement. */
export function installServiceStop(root: string, stop: () => void, intervalMs = 500) {
  const folder = resolve(root, 'data/service-control');
  mkdirSync(folder, { recursive: true });
  const descriptor = resolve(folder, 'bot.json'), request = resolve(folder, 'bot.stop.json');
  const identity = { pid: process.pid, token: randomUUID() };
  writeFileSync(descriptor + '.tmp', JSON.stringify(identity), { mode: 0o600 });
  renameSync(descriptor + '.tmp', descriptor);
  let requested = false;
  const timer = setInterval(() => {
    if (requested) return;
    try {
      if (statSync(request).size > 256) return;
      const raw = readFileSync(request, 'utf8');
      if (raw.length > 256) return;
      const value = JSON.parse(raw);
      if (value.pid !== identity.pid || value.token !== identity.token) return;
      requested = true;
      unlinkSync(request);
      stop();
    } catch { /* Missing, partial or stale control files never stop a service. */ }
  }, intervalMs);
  timer.unref();
  const cleanup = () => {
    try {
      if (JSON.parse(readFileSync(descriptor, 'utf8')).token === identity.token) unlinkSync(descriptor);
    } catch { /* Another instance's descriptor is never removed. */ }
  };
  process.once('exit', cleanup);
  return { close() { clearInterval(timer); }, cleanup() { clearInterval(timer); process.off('exit', cleanup); cleanup(); } };
}
