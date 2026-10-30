import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { pathToFileURL } from 'node:url';
import { tmpdir } from 'node:os';
import { Store } from '../src/storage/database.js';
import { config, agentRoot } from './helpers.js';

test('startup status is read-only, blocks duplicate leases, and requires fresh matching owner/process readiness', async () => {
  const { readAgentStatus } = await import(pathToFileURL(join(agentRoot, 'scripts/bot-status.mjs')).href);
  const root = mkdtempSync(join(tmpdir(), 'wechat-startup-')), file = join(root, 'status.sqlite'), now = Date.now();
  assert.equal(readAgentStatus(file, now).running, false);
  const store = new Store(config(), file, () => now);
  try {
    assert.equal(readAgentStatus(file, now).running, true);
    assert.equal(readAgentStatus(file, now).ready, false);
    const publish = (fields: Record<string, unknown> = {}) => store.exec('INSERT OR REPLACE INTO metadata VALUES(?,?)', 'runtime_status',
      JSON.stringify({ owner: store.owner, pid: process.pid, updated: now, state: 'running', diagnostics: [], ...fields }));
    publish(); assert.equal(readAgentStatus(file, now).ready, true);
    publish({ owner: 'another-instance' }); assert.equal(readAgentStatus(file, now).ready, false);
    publish({ updated: now - 15001 }); assert.equal(readAgentStatus(file, now).ready, false);
    publish({ state: 'budget_exhausted' }); assert.equal(readAgentStatus(file, now).state, 'budget_exhausted');
    assert.equal(readAgentStatus(file, now).ready, false);
    publish(); assert.equal(readAgentStatus(file, now + 31000).running, false);
    assert.equal(store.one('SELECT owner FROM consumer_lock')!.owner, store.owner);
  } finally { store.close(); rmSync(root, { recursive: true, force: true }); }
});
