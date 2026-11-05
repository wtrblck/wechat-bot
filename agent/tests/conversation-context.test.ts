import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput, HostResult } from '../src/contracts.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';

function fixture() {
  const root = mkdtempSync(join(tmpdir(), 'wechat-continuous-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  let clock = now;
  const c = { ...config(), root }, store = new Store(c, join(root, 'state.sqlite'), () => clock);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const bridge = new FakeBridge(); bridge.config = c;
  const host = new FakeHost(), engine = new Engine(c, store, bridge, host, () => {});
  const send = async (seq: number, text: string, conversation = 'group-a@chatroom') => {
    clock += 3000;
    store.ingest({ cursor: seq, events: [event(seq, conversation, text, { timestamp: clock / 1000 })], truncated: false });
    await engine.pump(); await engine.drain();
  };
  return { root, c, store, engine, host, bridge, send, advance: (ms: number) => clock += ms,
    close: async () => { await engine.close(); rmSync(root, { recursive: true, force: true }); } };
}

test('group participation happens inside one persistent session with incremental inputs and frozen initial rules', async () => {
  const f = fixture();
  try {
    await f.send(1, '第一轮独有的问题');
    const first = f.host.calls[0]!;
    f.host.action = 'silent';
    await f.send(2, '第二轮独有的补充');
    const second = f.host.calls[1]!;
    assert.deepEqual(f.host.calls.map(c => c.purpose), ['reply', 'reply']);
    assert.equal(first.executionId, second.executionId);
    assert.equal(first.system, second.system);
    assert.match(first.system, /\[SILENT\]/);
    assert.equal(JSON.parse(second.context).messages.length, 1);
    assert.ok(!second.context.includes('第一轮独有的问题'));
    assert.equal(JSON.parse(second.context).recent, undefined);
    assert.equal(JSON.parse(second.context).previousWork, undefined);
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 1);
    assert.equal(f.store.one("SELECT count(*) n FROM runs WHERE purpose='decision'")!.n, 0);
    // Count/idle never trigger an independent background summary.
    f.advance(3600000); f.store.exec('UPDATE consumer_lock SET expires=?', now + 3700000); await f.engine.tick(); await f.engine.drain();
    assert.equal(f.host.calls.length, 2);
  } finally { await f.close(); }
});

test('near-capacity conversation summarizes in the old session then seeds only the next segment', async () => {
  const f = fixture();
  const execute = f.host.execute.bind(f.host);
  f.host.execute = async (input, signal) => {
    const result = await execute(input, signal);
    if (input.purpose === 'memory') result.replies = [{ id: input.inputId, text: 'member-a计划周六打篮球，地点还没确认，来源group-a@chatroom:1。' }];
    else result.contextUsage = { inputTokens: 13000, windowTokens: 16384 };
    return result;
  };
  try {
    await f.send(1, '周六打篮球，地点还没定');
    await f.send(2, '新问题：几点出发');
    assert.deepEqual(f.host.calls.map(c => c.purpose), ['reply', 'memory', 'reply']);
    const [first, summary, second] = f.host.calls;
    assert.equal(first!.executionId, summary!.executionId);
    assert.notEqual(second!.executionId, first!.executionId);
    assert.equal(first!.system, summary!.system);
    const packet = JSON.parse(second!.context);
    assert.match(packet.handover.memory, /地点还没确认/);
    assert.ok(packet.handover.recent.some((m: any) => m.text.includes('周六打篮球')));
    assert.ok(!packet.handover.recent.some((m: any) => m.text.includes('新问题')));
    assert.equal(packet.messages.length, 1);
    assert.equal(f.store.one('SELECT count(*) n FROM memory_segments')!.n, 1);
    assert.ok(f.engine.memory.reader(second!.session, 'test').search(['打篮球']).matches.length);
    assert.ok(f.store.all('SELECT body FROM outbox').every(r => !JSON.parse(r.body).text.includes('member-a计划')));
  } finally { await f.close(); }
});

test('failed summary retains the old conversation and pending input with bounded backoff', async () => {
  const f = fixture();
  const execute = f.host.execute.bind(f.host);
  f.host.execute = async (input, signal) => {
    if (input.purpose === 'memory') {
      f.host.calls.push(input);
      const failed: HostResult = { status: 'failed', replies: [], failureCode: 'TRANSPORT' };
      f.host.records.set(input.inputId, failed); return failed;
    }
    const result = await execute(input, signal); result.contextUsage = { inputTokens: 13000, windowTokens: 16384 }; return result;
  };
  try {
    await f.send(1, '旧消息');
    await f.send(2, '等待交接的新消息');
    assert.equal(f.store.one('SELECT state FROM inbox WHERE sequence=2')!.state, 'pending');
    assert.equal(f.store.one('SELECT count(*) n FROM memory_segments')!.n, 0);
    assert.equal(f.host.calls[0]!.executionId, f.engine.contexts.get(f.host.calls[0]!.session)!.execution_id);
    await f.engine.pump(); await f.engine.drain(); assert.equal(f.host.calls.length, 2);
    f.advance(61000); await f.engine.pump(); await f.engine.drain();
    assert.equal(f.host.calls.length, 3);
    assert.notEqual(f.host.calls[1]!.inputId, f.host.calls[2]!.inputId);
  } finally { await f.close(); }
});

test('multiline send_text preserves a single bubble and is idempotent within one input', async () => {
  const f = fixture();
  try {
    const session = f.store.session(normalize(event(1), f.c)!);
    const input: HostInput = { session, inputId: 'multiline', executionId: 'session', purpose: 'reply', system: '', context: '{}', provider: 'mock', model: 'test' };
    const tool = channelTools(f.engine, input, new AbortController().signal).find(t => t.name === 'send_text')!;
    const invoke = () => (tool.execute as any)({ text: '第一行\n第二行' }, {});
    await invoke(); await invoke();
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 1);
    assert.equal(JSON.parse(f.store.one('SELECT body FROM outbox')!.body).text, '第一行\n第二行');
  } finally { await f.close(); }
});

test('summary publication retry reuses durable output instead of paying for a new summary', async () => {
  const f = fixture(), execute = f.host.execute.bind(f.host);
  f.host.execute = async (input, signal) => {
    const result = await execute(input, signal);
    if (input.purpose === 'memory') result.replies = [{ id: input.inputId, text: '来源group-a@chatroom:1：周六篮球地点待定。' }];
    else result.contextUsage = { inputTokens: 13000, windowTokens: 16384 };
    return result;
  };
  const rollover = f.engine.contexts.rollover.bind(f.engine.contexts);
  let failed = false;
  f.engine.contexts.rollover = (...args) => { if (!failed) { failed = true; throw Error('temporary_disk_failure'); } return rollover(...args); };
  try {
    await f.send(1, '周六篮球地点待定'); await f.send(2, '交接后继续聊');
    assert.equal(f.store.one('SELECT state FROM inbox WHERE sequence=2')!.state, 'pending');
    f.advance(61000); await f.engine.pump(); await f.engine.drain();
    assert.equal(f.host.calls.filter(c => c.purpose === 'memory').length, 1);
    assert.equal(f.host.calls.filter(c => c.purpose === 'reply').length, 2);
    assert.equal(f.store.one('SELECT count(*) n FROM memory_segments')!.n, 1);
  } finally { await f.close(); }
});

test('upgrade cancels the retired pipeline without discarding uncertain submitted sends', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-conversation-upgrade-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const c = { ...config(), root }, store = new Store(c, ':memory:', () => now), host = new FakeHost();
  store.ingest({ events: [], cursor: 0, truncated: false });
  store.ingest({ events: [event(1)], cursor: 1, truncated: false });
  const session = store.session(normalize(event(1), c)!);
  const source = store.one('SELECT id FROM inbox')!.id;
  store.startRun({ session, inputId: 'old-run', executionId: 'old-execution', purpose: 'reply',
    context: '{}', system: '', provider: 'mock', model: 'test' }, [source]);
  store.prepareMessages(session, 'old-draft', ['旧机制未发送草稿'], { runId: 'old-run' });
  store.prepareMessages(session, 'uncertain', ['不确定是否已经发送'], { runId: 'old-run' });
  store.exec("UPDATE outbox SET state='unknown',submitted=1 WHERE reply='uncertain'");
  const engine = new Engine(c, store, new FakeBridge(), host, () => {});
  try {
    assert.equal(store.one("SELECT state FROM runs WHERE id='old-run'")!.state, 'cancelled');
    assert.equal(store.one("SELECT state FROM outbox WHERE reply='old-draft'")!.state, 'cancelled');
    assert.equal(store.one("SELECT state FROM outbox WHERE reply='uncertain'")!.state, 'unknown');
    assert.equal(store.one('SELECT state FROM inbox')!.state, 'cancelled');
    await engine.recover(); assert.equal(host.calls.length, 0);
  } finally { await engine.close(); rmSync(root, { recursive: true, force: true }); }
});
