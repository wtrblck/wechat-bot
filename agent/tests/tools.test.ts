import { test } from 'node:test';
import assert from 'node:assert/strict';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

test('channel question tool waits for the bound sender and emits only numbered prompts', async () => {
  const c = config(); const store = new Store(c, ':memory:', () => now);
  const engine = new Engine(c, store, new FakeBridge(), new FakeHost(), () => {});
  const session = store.session(normalize(event(1), c)!); const controller = new AbortController();
  const input: HostInput = { session, inputId: 'question-run', executionId: 'execution', purpose: 'reply', system: '', context: '',
    provider: 'mock', model: 'test', initiatorId: 'member-a' };
  const tools = channelTools(engine, input, controller.signal);
  assert.ok(!tools.some(t => /shell|http|read_file/.test(t.name)));
  const ask = tools.find(t => t.name === 'ask_user')!;
  const pending = ask.execute({ question: '输出详细版还是简短版？' }, {} as ToolRunContext);
  try {
    const row = store.one('SELECT * FROM interactions')!;
    assert.ok(JSON.parse(store.one('SELECT body FROM outbox')!.body).text.includes('/bot answer ' + row.id));
    assert.equal(engine.interactions.settle(session, 'member-b', row.id, '详细版', 'question'), false);
    assert.equal(engine.interactions.settle(session, 'member-a', row.id, '详细版', 'question'), true);
    assert.deepEqual(await pending, { status: 'answered', answer: '详细版' });
    assert.ok(!tools.some(t => t.name === 'recall_sources'));
    const recall = tools.find(t => t.name === 'memory_read')!;
    await assert.rejects(recall.execute({ ids: ['f'.repeat(64)] }, {} as ToolRunContext), /not_listed/);
  } finally { controller.abort(); await engine.close(); }
});
test('group control permission cannot be gained by asking for another persona', async () => {
  const c = config(); const store = new Store(c, ':memory:', () => now); store.ingest({ events: [], cursor: 0, truncated: false });
  const bridge = new FakeBridge(); const host = new FakeHost(); const engine = new Engine(c, store, bridge, host, () => {});
  bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '/bot new', { sender: 'member-a' })] };
  await engine.tick(); await engine.drain();
  assert.equal(store.one('SELECT generation FROM session_map')!.generation, 1);
  assert.equal(host.calls.length, 0);
  assert.match(JSON.parse(store.one('SELECT body FROM outbox')!.body).text, /管理员/);
  await engine.close();
});
