import { test } from 'node:test';
import assert from 'node:assert/strict';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { Memory } from '../src/memory/memory.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput, HostResult } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

function fixture() {
  let time = now;
  const c = config(), store = new Store(c, ':memory:', () => time), bridge = new FakeBridge(), host = new FakeHost();
  store.ingest({ cursor: 0, events: [], truncated: false });
  const engine = new Engine(c, store, bridge, host, () => {});
  return { c, store, bridge, host, engine, advance: (ms: number) => time += ms };
}



test('accepted group answers cool for two seconds rather than thirty; notices do not consume reply slots', async () => {
  const f = fixture();
  try {
    assert.equal(f.c.participation.cooldownSeconds, 2);
    assert.equal(f.c.participation.maxRepliesPerMinute, 8);
    f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '在吗')] };
    await f.engine.tick(); await f.engine.drain(); await f.engine.tick();
    f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '接着说这个细节')] };
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.host.calls.filter(i => i.purpose === 'reply').length, 1);
    const trace = f.store.one("SELECT details FROM trace_events WHERE state='waiting' ORDER BY id DESC LIMIT 1")!;
    assert.equal(JSON.parse(trace.details).reason, 'cooldown');
    assert.equal(JSON.parse(trace.details).nextEligibleAt, now + 2000);
    f.advance(2001); await f.engine.tick(); await f.engine.drain();
    assert.equal(f.host.calls.filter(i => i.purpose === 'reply').length, 2);
  } finally { await f.engine.close(); }
});
