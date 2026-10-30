import { test } from 'node:test';
import assert from 'node:assert/strict';
import { parseDecision } from '../src/participation/decision.js';
import { normalize } from '../src/ingress/normalizer.js';
import { Engine } from '../src/engine.js';
import { Store } from '../src/storage/database.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

test('real emoji participation shorthand resolves to complete IDs in the current window only', () => {
  const c = config(), window = [1288,1289,1290].map(n => normalize(event(n, 'group-a@chatroom', '[emoji]', { message_type: 'emoji' }), c)!);
  const value = { action: 'reply', reason: '接表情', sourceMessageIds: ['1288','1289','1290'], topicId: '当前话题', replyToSenderId: 'member-a' };
  assert.deepEqual(parseDecision(JSON.stringify(value), window).sourceMessageIds, window.map(m => m.messageId));
  for (const ids of [['9999'], ['group-b@chatroom:1290'], ['request:1290']])
    assert.throws(() => parseDecision(JSON.stringify({ ...value, sourceMessageIds: ids }), window), /outside_conversation/);
  assert.throws(() => parseDecision(JSON.stringify({ ...value, sourceMessageIds: ['1290'] }),
    [window[2]!, { ...window[2]!, messageId: 'another:1290' }]), /outside_conversation/);
});

test('participation hides attachment paths and repairs a fake XML tool output once before continuing', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  class XmlHost extends FakeHost {
    decisionCalls = 0;
    override async execute(...args: Parameters<FakeHost['execute']>) {
      const result = await super.execute(...args);
      if (args[0].purpose === 'decision' && ++this.decisionCalls === 1)
        result.replies[0]!.text = '<tool_use name="read_image" input="{}" />';
      return result;
    }
  }
  const host = new XmlHost(), engine = new Engine(c, store, bridge, host, () => {});
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    const message = normalize(event(1, 'group-a@chatroom', '[emoji]', { message_type: 'emoji' }), c)!;
    const session = store.session(message);
    store.exec('INSERT INTO message_media VALUES(?,?,?,?,?)', session.key, message.messageId, null, JSON.stringify({
      kind: 'emoji', state: 'ready', format: 'image', path: 'media/private.png', readTool: 'read_image', note: '先读取工具' }), now);
    bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '[emoji]', { message_type: 'emoji' })] };
    await engine.tick(); await engine.drain();
    const decisions = host.calls.filter(c => c.purpose === 'decision');
    assert.equal(decisions.length, 2);
    assert.ok(decisions.every(c => !c.context.includes('media/private.png') && !c.context.includes('readTool')));
    assert.equal(host.calls.filter(c => c.purpose === 'reply').length, 1);
    assert.equal(store.one('SELECT state FROM inbox')!.state, 'completed');
  } finally { await engine.close(); }
});

test('repeated invalid participation output stops after one format repair', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  class InvalidHost extends FakeHost {
    override async execute(...args: Parameters<FakeHost['execute']>) {
      const result = await super.execute(...args);
      if (args[0].purpose === 'decision') result.replies[0]!.text = '<tool_use />';
      return result;
    }
  }
  const host = new InvalidHost(), engine = new Engine(c, store, bridge, host, () => {});
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom')] };
    await engine.tick(); await engine.drain();
    assert.equal(host.calls.filter(c => c.purpose === 'decision').length, 2);
    assert.equal(host.calls.filter(c => c.purpose === 'reply').length, 0);
    assert.equal(store.one('SELECT count(*) n FROM outbox')!.n, 0);
  } finally { await engine.close(); }
});

test('emoji participation with local IDs proceeds to reply generation instead of failing validation', async () => {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  class ShortIdHost extends FakeHost {
    override async execute(...args: Parameters<FakeHost['execute']>) {
      const result = await super.execute(...args);
      if (args[0].purpose === 'decision') {
        const decision = JSON.parse(result.replies[0]!.text);
        decision.sourceMessageIds = decision.sourceMessageIds.map((s: string) => s.split(':').at(-1));
        result.replies[0]!.text = JSON.stringify(decision);
      }
      return result;
    }
  }
  const host = new ShortIdHost(), engine = new Engine(c, store, bridge, host, () => {});
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    bridge.page = { cursor: 1290, truncated: false, events: [event(1290, 'group-a@chatroom', '[emoji]', { message_type: 'emoji', media: { id: 'emoji' } })] };
    await engine.tick(); await engine.drain();
    assert.equal(host.calls.filter(c => c.purpose === 'reply').length, 1);
    assert.equal(store.one('SELECT state FROM inbox')!.state, 'completed');
    const decision = store.one('SELECT result FROM participation_decisions')!;
    assert.deepEqual(JSON.parse(decision.result).sourceMessageIds, ['group-a@chatroom:1290']);
  } finally { await engine.close(); }
});
