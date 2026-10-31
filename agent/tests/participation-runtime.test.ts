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

test('transport decision failures wait durably then retry with fresh IDs and one final answer', async () => {
  const f = fixture();
  const execute = f.host.execute.bind(f.host); let failures = 0;
  f.host.execute = async (input, signal) => {
    if (input.purpose === 'decision' && failures++ === 0) {
      f.host.calls.push(input);
      const result: HostResult = { status: 'failed', replies: [], failureCode: 'TRANSPORT' };
      f.host.records.set(input.inputId, result); return result;
    }
    return execute(input, signal);
  };
  try {
    f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '给这个时长打个分')] };
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.store.one('SELECT state FROM inbox')!.state, 'pending');
    assert.equal(f.store.one('SELECT attempt FROM decision_retries')!.attempt, 1);
    await f.engine.tick(); await f.engine.drain(); assert.equal(f.host.calls.length, 1);
    f.advance(1001); await f.engine.tick(); await f.engine.drain();
    const decisions = f.host.calls.filter(i => i.purpose === 'decision');
    assert.equal(decisions.length, 2); assert.notEqual(decisions[0]!.inputId, decisions[1]!.inputId);
    assert.equal(f.host.calls.filter(i => i.purpose === 'reply').length, 1);
    await f.engine.tick(); assert.equal(f.bridge.posts.length, 1);
  } finally { await f.engine.close(); }
});

test('persistent transport failure stops after two retries without replaying reply tools', async () => {
  const f = fixture();
  f.host.execute = async (input: HostInput) => { f.host.calls.push(input); return { status: 'failed', replies: [], failureCode: 'TRANSPORT' }; };
  try {
    f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom')] };
    for (const wait of [0, 1001, 3001, 1001]) {
      f.advance(wait); await f.engine.tick(); await f.engine.drain();
    }
    assert.equal(f.host.calls.length, 3);
    assert.equal(f.store.one('SELECT state FROM inbox')!.state, 'failed');
    assert.equal(f.bridge.posts.length, 0);
  } finally { await f.engine.close(); }
});

test('expired retry input is ignored and non-transport decision failures do not retry', async () => {
  for (const expiry of [false, true]) {
    const f = fixture();
    f.host.execute = async input => { f.host.calls.push(input); return { status: 'failed', replies: [], ...(expiry ? { failureCode: 'TRANSPORT' } : {}) }; };
    try {
      f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom')] };
      await f.engine.tick(); await f.engine.drain();
      if (expiry) {
        for (let i = 0; i < 13; i++) { f.advance(10000); f.store.heartbeat(); }
        await f.engine.tick(); await f.engine.drain();
        assert.equal(f.store.one('SELECT state FROM inbox')!.state, 'ignored');
      } else {
        f.advance(4000); await f.engine.tick(); await f.engine.drain();
        assert.equal(f.store.one('SELECT state FROM inbox')!.state, 'failed');
      }
      assert.equal(f.host.calls.length, 1);
    } finally { await f.engine.close(); }
  }
});

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

test('recent context weights decline with real time and retain long-gap evidence', () => {
  const f = fixture();
  try {
    const old = normalize(event(1, 'group-a@chatroom', '旧话题', { timestamp: now / 1000 - 3600 }), f.c)!;
    const latest = normalize(event(2, 'group-a@chatroom', '新问题'), f.c)!;
    const session = f.store.session(latest);
    f.store.recordHistory(session.key, old); f.store.recordHistory(session.key, latest);
    const context = new Memory(f.store).recent(session, 4096);
    assert.equal(context.recent.length, 2);
    assert.equal(context.recent[0]!.ageSeconds, 3600);
    assert.ok(context.recent[0]!.recencyWeight < context.recent[1]!.recencyWeight);
    assert.equal(context.recent[1]!.gapSeconds, 3600);
    f.advance(300000);
    assert.equal(new Memory(f.store).recent(session, 4096).recent[1]!.recencyWeight, 0.5);
    assert.ok(Buffer.byteLength(JSON.stringify(context.recent)) <= 4096);
  } finally { f.store.close(); }
});
