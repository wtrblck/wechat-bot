import { test } from 'node:test';
import assert from 'node:assert/strict';
import { decodeReply } from '../src/egress/reply-format.js';
import { Store } from '../src/storage/database.js';
import { Outbox, messageInterval } from '../src/egress/outbox.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

test('multi-message decoding rejects empty/invalid envelopes without leaking protocol text, plain output remains compatible', () => {
  assert.deepEqual(decodeReply('普通回复'), { text: '普通回复' });
  assert.deepEqual(decodeReply('```json\n{"messages":["第一条","第二条"]}\n```'), { text: '第一条\n\n第二条', messages: ['第一条', '第二条'] });
  for (const text of ['{"messages":[]}', '{"messages":[" "]}', '{"messages":[1]}', '{"messages":',
    JSON.stringify({ messages: Array(31).fill('多余') }), '{"messages":["正文"],"extra":"不可公开"}']) assert.equal(decodeReply(text), undefined);
});

test('real-model plain line breaks become distinct bubbles, while explicit multiline content and code keep their boundaries', () => {
  const real = '孩子们，复活了，刚才被鞭子抽得有点 out\nwhat can i say，牢大这东西，抽不没的';
  assert.deepEqual(decodeReply(real)?.messages, real.split('\n'));
  assert.deepEqual(decodeReply('第一条\r\n\r\n第二条')?.messages, ['第一条', '第二条']);
  assert.deepEqual(decodeReply(JSON.stringify({ messages: ['一条内\n换行'] }))?.messages, ['一条内\n换行']);
  for (const text of ['```js\nconst x = 1;\nconsole.log(x);\n```', '1. 第一项\n2. 第二项', '- 一\n- 二', '> 引文\n> 第二行'])
    assert.deepEqual(decodeReply(text), { text });
});

test('30-message boundaries survive decoding and sending; pacing follows length and persists across restart', async () => {
  const messages = ['短', '长'.repeat(25), '👨‍👩‍👧‍👦'.repeat(50), ...Array(27).fill('继续')];
  assert.deepEqual(decodeReply(JSON.stringify({ messages }))?.messages, messages);
  assert.deepEqual(decodeReply(messages.join('\n'))?.messages, messages);
  assert.equal(messageInterval(''), 500);
  assert.equal(messageInterval('👨‍👩‍👧‍👦'), 510);
  assert.equal(messageInterval('长'.repeat(100)), 1000);
  let clock = now;
  const c = config(), store = new Store(c, ':memory:', () => clock), bridge = new FakeBridge();
  const waits: number[] = [];
  const wait = async (ms: number) => { waits.push(ms); clock += ms; };
  const session = store.session(normalize(event(1), c)!);
  try {
    store.prepareMessages(session, 'thirty', messages);
    bridge.lostResponse = true;
    await new Outbox(store, bridge, wait).tick();
    await new Outbox(store, bridge, wait).tick();
    assert.deepEqual(bridge.posts.map(p => JSON.parse(p).text), messages);
    assert.equal(waits.length, 29);
    assert.deepEqual(waits.slice(0, 3), [510, 750, 1000]);
    assert.equal(store.one("SELECT count(*) n FROM outbox WHERE state='server_confirmed'")!.n, 30);
  } finally { store.close(); }
});

test('cancelling during the inter-message pause prevents remaining submissions', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  const session = store.session(normalize(event(1), c)!);
  const outbox = new Outbox(store, bridge, async () => { await outbox.cancel(session.key); });
  try {
    store.prepareMessages(session, 'cancel-during-pause', ['一', '二', '三']);
    await outbox.tick();
    assert.equal(bridge.posts.length, 1);
    assert.equal(store.one("SELECT count(*) n FROM outbox WHERE state='cancelled'")!.n, 2);
  } finally { store.close(); }
});

test('one reply can send several ordered messages; lost responses and replay never duplicate the batch', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge(), outbox = new Outbox(store, bridge);
  const session = store.session(normalize(event(1), c)!);
  try {
    store.prepareMessages(session, 'batch-1', ['先说一句', '再补充一句']);
    store.prepareMessages(session, 'batch-1', ['先说一句', '再补充一句']);
    assert.equal(store.one('SELECT count(*) n FROM outbox')!.n, 2);
    assert.equal(store.one('SELECT count(DISTINCT reply) n FROM outbox')!.n, 1);
    bridge.lostResponse = true; await outbox.tick(); await outbox.tick();
    assert.deepEqual(bridge.posts.map(s => JSON.parse(s).text), ['先说一句', '再补充一句']);
    assert.equal(store.one("SELECT count(*) n FROM outbox WHERE state='server_confirmed'")!.n, 2);
    assert.equal(store.timeline(session.key).length, 2);
  } finally { store.close(); }
});

test('a failed first message cancels the rest of its reply; uncertain sends do not release followups', async () => {
  for (const state of ['failed', 'unknown']) {
    const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge(), outbox = new Outbox(store, bridge);
    const session = store.session(normalize(event(1), c)!);
    try {
      store.prepareMessages(session, 'batch-2', ['第一条', '第二条']); bridge.nextState = state;
      await outbox.tick(); await outbox.tick();
      assert.equal(bridge.posts.length, 1);
      if (state === 'failed') assert.equal(store.one("SELECT state FROM outbox WHERE part=1")!.state, 'cancelled');
    } finally { store.close(); }
  }
});

test('engine preserves intended boundaries and enqueues a multi-message reply atomically within the existing part allowance', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  class MultiHost extends FakeHost {
    override async execute(...args: Parameters<FakeHost['execute']>) {
      const result = await super.execute(...args);
      if (args[0].purpose === 'reply') Object.assign(result.replies[0]!, { text: '一\n\n二', messages: ['一', '二'] });
      return result;
    }
  }
  const host = new MultiHost(), engine = new Engine(c, store, bridge, host, () => {});
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    bridge.page = { events: [event(1)], cursor: 1, truncated: false };
    await engine.tick(); await engine.drain(); await engine.outbox.tick();
    assert.equal(host.calls[0]!.replyFormat, 'messages-v1');
    assert.deepEqual(bridge.posts.map(p => JSON.parse(p).text), ['一', '二']);
    const session = store.session(normalize(event(1), c)!);
    assert.throws(() => store.prepareMessages(session, 'oversize-batch', Array(31).fill('过多')), /reply_requires_artifact/);
    assert.equal(store.one("SELECT count(*) n FROM outbox WHERE reply='oversize-batch'")!.n, 0);
  } finally { await engine.close(); }
});
