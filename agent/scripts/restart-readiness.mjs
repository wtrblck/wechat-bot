// Read-only gate: every dispatching execution must have a durable turn/end,
// and no submitted/pending outbound work may be interrupted by a restart.
import { DatabaseSync } from 'node:sqlite';
import { existsSync, readFileSync, readdirSync } from 'node:fs';
import { resolve, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { parse } from 'yaml';

const root = fileURLToPath(new URL('..', import.meta.url));
const config = parse(readFileSync(resolve(root, 'config/agent.local.yaml'), 'utf8'));
const db = new DatabaseSync(resolve(root, config.storage?.file ?? 'data/agent.sqlite'), { readOnly: true });
try {
  const base = resolve(root, 'data/dsh-home/sessions');
  const dirs = existsSync(base) ? readdirSync(base, { withFileTypes: true }).filter(d => d.isDirectory() && !d.isSymbolicLink()) : [];
  let unsettled = 0, settled = 0;
  for (const run of db.prepare("SELECT input FROM runs WHERE state IN ('dispatching','running')").all()) {
    const input = JSON.parse(run.input);
    if (!/^[a-zA-Z0-9_-]{1,128}$/.test(input.executionId)) { unsettled++; continue; }
    const paths = dirs.map(dir => join(base, dir.name, input.executionId, 'session.v4.jsonl')).filter(existsSync);
    if (paths.length !== 1) { unsettled++; continue; }
    try {
      const events = readFileSync(paths[0], 'utf8').trim().split('\n').map(line => JSON.parse(line));
      if (events.findLast(e => e.type === 'turn/end')) settled++; else unsettled++;
    } catch { unsettled++; }
  }
  const outgoing = db.prepare("SELECT count(*) n FROM outbox WHERE state IN ('prepared','queued','sending','submitted','unknown','needs_review')").get().n;
  console.log(JSON.stringify({ ready: unsettled === 0 && outgoing === 0, unsettled, settled, outgoing }));
} finally { db.close(); }
