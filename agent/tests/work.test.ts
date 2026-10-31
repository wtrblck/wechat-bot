import { test } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { mkdtempSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { Store } from '../src/storage/database.js';
import { Work } from '../src/storage/work.js';
import { Engine } from '../src/engine.js';
import { Outbox } from '../src/egress/outbox.js';
import { normalize } from '../src/ingress/normalizer.js';
import { type HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

function fixture(file = ':memory:') {
  const c = config();
  const store = new Store(c, file, () => now);
  const session = store.session(normalize(event(1), c)!);
  const work = new Work(store);
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), session, purpose: 'reply', system: '', context: '{}', provider: 'mock', model: 'test' };
  store.startRun(input, []);
  return { c, store, session, work, input };
}

test('tool evidence survives failed replies, pagination and cold restart, isolated by session generation', () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-work-')), file = join(root, 'store.sqlite');
  const f = fixture(file);
  try {
    f.work.record(f.input, { callId: 'lookup', name: 'video_transcript', arguments: { path: 'video.mp4' }, state: 'started' });
    f.work.record(f.input, { callId: 'lookup', name: 'video_transcript', state: 'completed', result: { text: '已经转写的台词'.repeat(2000), path: 'transcript.json' } });
    f.store.completeRun(f.input.inputId, 'cancelled', { status: 'cancelled', replies: [] });
    const id = f.store.one('SELECT id FROM work_results')!.id;
    assert.equal(f.work.read(f.session, id, 0, 20).text.length, 20);
    assert.equal(f.work.read(f.session, id, 0, 20).nextOffset, 20);
    assert.ok(Buffer.byteLength(JSON.stringify(f.work.context(f.session, 4096))) <= 4096);
    f.store.close();
    const store = new Store(f.c, file, () => now), work = new Work(store);
    try {
      assert.equal(work.read(f.session, id).state, 'completed');
      assert.ok(work.context(f.session, 8192).length);
      assert.throws(() => work.read({ ...f.session, key: 'another-group' }, id), /denied/);
      store.exec('UPDATE session_map SET generation=generation+1');
      assert.throws(() => work.read(f.session, id), /denied/);
      assert.deepEqual(work.context({ ...f.session, generation: 2 }, 8192), []);
    } finally { store.close(); }
  } finally { try { f.store.close(); } catch {} rmSync(root, { recursive: true, force: true }); }
});

test('ordinary review cannot truncate a committed batch, including lost first POST response', async () => {
  const f = fixture(), bridge = new FakeBridge(), outbox = new Outbox(f.store, bridge, async () => {});
  try {
    f.store.prepareMessages(f.session, 'batch', ['第一条', '第二条', '第三条']);
    bridge.lostResponse = true;
    await outbox.tick();
    assert.equal(bridge.posts.length, 1);
    assert.equal(outbox.committed('batch'), true);
    outbox.cancelPreparedReply('batch', 'participation_superseded');
    assert.equal(f.store.one("SELECT count(*) n FROM outbox WHERE state='cancelled'")!.n, 0);
    await outbox.tick();
    assert.equal(bridge.posts.length, 3);
    assert.equal(new Set(bridge.posts.map(p => JSON.parse(p).request_id)).size, 3);
  } finally { f.store.close(); }
});

test('explicit stop still cancels remaining unsubmitted messages after batch commit', async () => {
  const f = fixture(), bridge = new FakeBridge(), outbox = new Outbox(f.store, bridge, async () => {});
  try {
    f.store.prepareMessages(f.session, 'batch', ['一', '二']); bridge.nextState = 'queued';
    await outbox.tick(); await outbox.cancel(f.session.key);
    assert.equal(f.store.one("SELECT count(*) n FROM outbox WHERE state='cancelled'")!.n, 2);
  } finally { f.store.close(); }
});

test('next reply sees prior tool evidence, undelivered draft and actual output states', async () => {
  const f = fixture(), bridge = new FakeBridge(), host = new FakeHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  try {
    f.work.record(f.input, { callId: 'search', name: 'web_search', state: 'completed', result: { found: '可复用结论', url: 'https://example.com' } });
    f.store.completeRun(f.input.inputId, 'completed', { status: 'completed', replies: [{ id: 'old', text: '未交付的旧草稿' }] });
    f.store.ingest({ cursor: 0, events: [], truncated: false });
    bridge.page = { cursor: 2, events: [event(2, 'contact-a', '/ai 只解释第二种方法')], truncated: false };
    await engine.tick(); await engine.drain();
    const input = host.calls.find(c => c.purpose === 'reply')!;
    const previous = JSON.parse(input.context).previousWork;
    assert.ok(JSON.stringify(previous).includes('可复用结论'));
    assert.ok(JSON.stringify(previous).includes('未交付的旧草稿'));
    assert.equal(previous[0].output.length, 0);
    assert.ok(Buffer.byteLength(input.context) <= f.c.runtime.chatContextBytes);
  } finally { await engine.close(); }
});
