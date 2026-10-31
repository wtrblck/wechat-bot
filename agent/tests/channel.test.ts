import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, writeFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { Store } from '../src/storage/database.js';
import { normalize } from '../src/ingress/normalizer.js';
import { chunkText } from '../src/egress/chunker.js';
import { Outbox } from '../src/egress/outbox.js';
import { Engine } from '../src/engine.js';
import { PromptRegistry } from '../src/prompts/registry.js';
import { Memory } from '../src/memory/memory.js';
import { Interactions } from '../src/interactions/registry.js';
import { BridgeClient } from '../src/bridge/client.js';
import { parseDecision } from '../src/participation/decision.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

function fixture(c = config()) {
  let time = now;
  const store = new Store(c, ':memory:', () => time);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const bridge = new FakeBridge(); bridge.config = c;
  const host = new FakeHost();
  const engine = new Engine(c, store, bridge, host, () => {});
  return { store, bridge, host, engine, advance: (ms: number) => time += ms };
}

test('native database bridge Chinese text reaches reply execution', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'contact-a', '/ai 你好', {
    schema: 'wechat-db-1', message_type: '文本', local_type: 1,
  })] };
  await f.engine.tick();
  assert.equal(f.host.calls.length, 1);
  assert.equal(f.host.calls[0]!.purpose, 'reply');
  const runtime = JSON.parse(f.store.one("SELECT value FROM metadata WHERE key='runtime_status'")!.value);
  assert.equal(runtime.pid, process.pid); assert.equal(runtime.owner, f.store.owner); assert.equal(runtime.state, 'running');
  await f.engine.close();
});

test('native database media labels normalize while cards remain unsupported', () => {
  const c = config();
  for (const [label, kind] of Object.entries({ '图片': 'image', '语音': 'voice', '视频': 'video', '动画表情': 'emoji' })) {
    assert.equal(normalize(event(1, 'contact-a', '', { message_type: label }), c)!.kind, kind);
  }
  assert.equal(normalize(event(1, 'contact-a', '', { message_type: '文件/链接/卡片', media: { kind: 'file', id: 'f' } }), c)!.kind, 'file');
  assert.equal(normalize(event(1, 'contact-a', '', { message_type: '文件/链接/卡片' }), c)!.kind, 'unsupported');
});
test('first startup drains historical events before enabling replies', async () => {
  const f = fixture(); f.store.exec('UPDATE source_checkpoints SET baseline=1');
  f.bridge.page = { cursor: 1, events: [event(1)], truncated: false };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.host.calls.length, 0); assert.equal(f.store.checkpoint().baseline, 1);
  await f.engine.tick(); assert.equal(f.store.checkpoint().baseline, 0);
  await f.engine.close();
});
test('cursor and inbox rollback together when page exceeds storage bound', () => {
  const f = fixture(config({ storage: { maxInboxBytes: 65536 } }));
  assert.throws(() => f.store.ingest({ cursor: 1, truncated: false, events: [event(1, 'contact-a', '大'.repeat(30000))] }), /inbox_capacity/);
  assert.equal(f.store.checkpoint().cursor, 0); assert.equal(f.store.one('SELECT count(*) n FROM inbox')!.n, 0); f.store.close();
});
test('duplicate polls execute once while identical text with distinct IDs executes twice', async () => {
  const f = fixture(); f.bridge.page = { cursor: 1, events: [event(1)], truncated: false };
  await f.engine.tick(); await f.engine.drain(); await f.engine.tick(); await f.engine.drain();
  assert.equal(f.host.calls.length, 1);
  f.bridge.page = { cursor: 2, events: [event(2)], truncated: false };
  await f.engine.tick(); await f.engine.drain(); assert.equal(f.host.calls.length, 2); await f.engine.close();
});
test('self echo, unknown directions, disallowed targets and stale messages never execute', async () => {
  const f = fixture(); f.bridge.page = { cursor: 5, truncated: false, events: [event(1, 'contact-a', '/ai 自己', { sender: 'self' }),
    event(2, 'contact-a', '/ai 回流', { direction: 'outgoing' }), event(3, 'contact-a', '/ai 未知', { direction: 'unknown' }),
    event(4, 'stranger'), event(5, 'contact-a', '/ai 旧消息', { timestamp: now / 1000 - 121 })] };
  await f.engine.tick(); await f.engine.drain(); assert.equal(f.host.calls.length, 0);
  assert.equal(f.store.one("SELECT payload FROM inbox WHERE sequence=4")!.payload.includes('stranger'), false); await f.engine.close();
});
test('gap persists and pauses model work and output', async () => {
  const f = fixture(); f.bridge.page = { cursor: 4, truncated: true, events: [event(4)] };
  await f.engine.tick(); assert.equal(f.engine.state, 'paused_gap'); assert.equal(f.host.calls.length, 0);
  assert.equal(f.store.one('SELECT count(*) n FROM gaps')!.n, 1); await f.engine.close();
});
test('durable bridge pages with a global tip cursor never skip the unreturned tail', () => {
  const f = fixture();
  f.store.ingest({ cursor: 1200, truncated: false, events: [event(1), event(2)] });
  assert.equal(f.store.checkpoint().cursor, 2);
  f.store.ingest({ cursor: 1200, truncated: false, events: [event(3), event(4)] });
  assert.equal(f.store.checkpoint().cursor, 4);
  f.store.close();
});
test('bounded queues retain explicit rejection and leave the control channel available', async () => {
  const f = fixture(config({ runtime: { provider: 'mock', model: 'test', perSessionQueue: 1 } }));
  f.store.ingest({ cursor: 3, truncated: false, events: [event(1), event(2), event(3, 'contact-a', '/bot status')] });
  assert.equal(f.store.one('SELECT reason FROM inbox WHERE sequence=2')!.reason, 'execution_queue_full');
  assert.equal(f.store.one('SELECT state FROM inbox WHERE sequence=3')!.state, 'pending'); await f.engine.close();
});
test('autonomous group batches require no mention or prefix and share one session across members', async () => {
  const f = fixture(); f.bridge.page = { cursor: 2, truncated: false, events: [event(1, 'group-a@chatroom', '这个问题怎么处理？'),
    event(2, 'group-a@chatroom', '我也想了解', { sender: 'member-b' })] };
  await f.engine.tick(); await f.engine.drain();
  assert.deepEqual(f.host.calls.map(c => c.purpose), ['decision', 'reply']);
  assert.equal(f.store.one('SELECT count(*) n FROM session_map')!.n, 1);
  const input = f.host.calls[1]!; assert.match(input.context, /member-a/); assert.match(input.context, /member-b/);
  await f.engine.tick(); await f.engine.drain(); assert.equal(f.host.calls.length, 2); await f.engine.close();
});
test('group silence and natural quiet requests never produce placeholder messages', async () => {
  const f = fixture(); f.host.action = 'silent'; f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '随便聊聊')] };
  await f.engine.tick(); await f.engine.drain(); assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 0);
  f.host.action = 'reply'; f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '先别说话')] };
  await f.engine.tick(); await f.engine.drain(); assert.equal(f.host.calls.length, 1); await f.engine.close();
});
test('new answer during generation suppresses delivery but retains the completed draft after recheck', async () => {
  const f = fixture(); f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  f.host.hook = async input => { if (input.purpose === 'reply') {
    f.store.ingest({ cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '问题已解决', { sender: 'member-b' })] }); f.host.action = 'silent';
  } };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'cancelled');
  const run = f.store.one("SELECT state,result FROM runs WHERE purpose='reply'")!;
  assert.equal(run.state, 'completed'); assert.ok(JSON.parse(run.result).replies.length);
  assert.equal(f.host.calls.length, 3); await f.engine.close();
});

test('a follow-up during generation can approve the answer using the new message ID', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  f.host.hook = async input => { if (input.purpose === 'reply') {
    f.store.ingest({ cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '我想问具体细节')] });
  } };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'prepared');
  const reply = f.store.one("SELECT state,result FROM runs WHERE purpose='reply'")!;
  assert.equal(reply.state, 'completed'); assert.equal(JSON.parse(reply.result).status, 'completed');
  await f.engine.close();
});
test('two groups and one direct chat never share session IDs, contexts or reply targets', async () => {
  const f = fixture(); f.bridge.page = { cursor: 3, truncated: false, events: [event(1, 'group-a@chatroom', '独有甲问题？'),
    event(2, 'group-b@chatroom', '独有乙问题？'), event(3, 'contact-a', '/ai 独有丙问题')] };
  await f.engine.tick(); await f.engine.drain(); await f.engine.tick(); await f.engine.drain();
  const replies = f.host.calls.filter(c => c.purpose === 'reply'); assert.equal(replies.length, 3);
  assert.equal(new Set(replies.map(c => c.session.id)).size, 3);
  assert.ok(replies.every(c => ['甲', '乙', '丙'].filter(s => c.context.includes(s)).length === 1)); await f.engine.close();
});

test('queued group reply survives a follow-up and changed topic label after semantic review', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  await f.engine.tick(); await f.engine.drain();
  const original = f.store.one('SELECT id FROM outbox')!.id;
  const execute = f.host.execute.bind(f.host);
  f.host.execute = async (input, signal) => {
    const result = await execute(input, signal);
    if (input.purpose === 'decision' && JSON.parse(input.context).stage === 'before_send') {
      const decision = JSON.parse(result.replies[0]!.text);
      decision.topicId = 'same-conversation-with-a-new-label';
      result.replies[0]!.text = JSON.stringify(decision);
    }
    return result;
  };
  f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '再解释一下细节')] };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.store.one('SELECT state FROM outbox WHERE id=?', original)!.state, 'server_confirmed');
  assert.ok(f.bridge.posts.some(body => JSON.parse(body).request_id === original));
  assert.ok(f.host.calls.some(call => call.purpose === 'decision' && JSON.parse(call.context).stage === 'before_send'));
  await f.engine.close();
});

test('queued group reply is cancelled only when semantic review says silent', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  await f.engine.tick(); await f.engine.drain();
  const original = f.store.one('SELECT id FROM outbox')!.id;
  f.host.action = 'silent';
  f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '已经解决，不用回复')] };
  await f.engine.tick(); await f.engine.drain();
  const row = f.store.one('SELECT state,result FROM outbox WHERE id=?', original)!;
  assert.equal(row.state, 'cancelled'); assert.equal(JSON.parse(row.result).reason, 'participation_superseded');
  assert.equal(f.bridge.posts.length, 0);
  await f.engine.close();
});

test('outgoing group echo does not cancel a queued answer or trigger a review', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  await f.engine.tick(); await f.engine.drain();
  const original = f.store.one('SELECT id FROM outbox')!.id;
  f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '上一条回声', { sender: 'self', direction: 'outgoing' })] };
  await f.engine.tick();
  assert.equal(f.store.one('SELECT state FROM outbox WHERE id=?', original)!.state, 'server_confirmed');
  assert.equal(f.host.calls.filter(call => call.purpose === 'decision').length, 1);
  await f.engine.close();
});

test('unavailable queued review preserves the answer and does not create a permanent group review block', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '如何做？')] };
  await f.engine.tick(); await f.engine.drain();
  const original = f.store.one('SELECT id FROM outbox')!.id;
  f.host.hook = async input => { if (input.purpose === 'decision') throw Error('offline'); };
  f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '补充细节')] };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.store.one('SELECT state FROM outbox WHERE id=?', original)!.state, 'prepared');
  assert.equal(f.bridge.posts.length, 0);
  assert.equal(f.store.one("SELECT count(*) n FROM runs WHERE purpose='decision' AND state='needs_review'")!.n, 0);
  await f.engine.close();
});
test('wait during generation retains a draft and the next input revises it without duplicate delivery', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '请分析两种方案')] };
  let injected = false;
  f.host.hook = async input => {
    if (input.purpose === 'reply' && !injected) {
      injected = true;
      f.store.ingest({ cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '只看第二种')] });
      f.host.action = 'wait';
    }
  };
  await f.engine.tick(); await f.engine.drain();
  const old = f.store.one('SELECT * FROM outbox')!;
  assert.equal(old.state, 'prepared');
  assert.equal(f.store.one('SELECT state FROM reply_reviews')!.state, 'wait');
  f.bridge.page = { cursor: 2, events: [], truncated: false };
  f.host.action = 'reply'; f.store.exec('UPDATE session_map SET last_reply=0'); f.advance(1000);
  await f.engine.tick(); await f.engine.drain();
  const replies = f.host.calls.filter(c => c.purpose === 'reply');
  assert.equal(replies.length, 2);
  assert.ok(JSON.parse(replies[1]!.context).previousWork.some((w: any) => w.draft));
  assert.equal(f.store.one('SELECT state FROM outbox WHERE id=?', old.id)!.state, 'cancelled');
  assert.equal(f.bridge.posts.length, 0);
  await f.engine.tick();
  assert.equal(f.bridge.posts.length, 1);
  await f.engine.close();
});

test('messages arriving during final review retain rather than cancel completed work', async () => {
  const f = fixture();
  f.bridge.page = { cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '查一下这个问题')] };
  f.host.hook = async input => {
    if (input.purpose === 'reply') f.store.ingest({ cursor: 2, truncated: false, events: [event(2, 'group-a@chatroom', '补充一条')] });
    if (input.purpose === 'decision' && JSON.parse(input.context).stage === 'before_send')
      f.store.ingest({ cursor: 3, truncated: false, events: [event(3, 'group-a@chatroom', '再补充一条')] });
  };
  await f.engine.tick(); await f.engine.drain();
  assert.equal(f.store.one("SELECT state FROM runs WHERE purpose='reply'")!.state, 'completed');
  assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'prepared');
  assert.equal(f.store.one('SELECT state FROM reply_reviews')!.state, 'wait');
  await f.engine.close();
});

test('UTF-8 chunks preserve complete graphemes and stable request IDs', () => {
  const text = '中文👨‍👩‍👧‍👦e\u0301🇨🇳\n'.repeat(200);
  const chunks = chunkText(text, 3800, 20);
  assert.ok(chunks.every(c => Buffer.byteLength(c) <= 3800));
  assert.equal(chunks.map(c => c.replace(/^\(\d+\/\d+\) /, '')).join(''), text.trim());
  assert.throws(() => chunkText('bad\0text'), /invalid_text/);
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!);
  f.store.prepareReply(s, 'durable-1', '一'); f.store.prepareReply(s, 'durable-1', '一');
  const row = f.store.one('SELECT * FROM outbox')!; assert.equal(row.id.length, 63);
  assert.throws(() => f.store.prepareReply(s, 'durable-1', '二'), /request_id_conflict/); f.store.close();
});
test('lost POST response reconciles by original ID without another POST', async () => {
  const f = fixture(); const session = f.store.session(normalize(event(1), f.store.config)!);
  f.store.prepareReply(session, 'out-1', '答复'); f.bridge.lostResponse = true;
  await f.engine.outbox.tick(); await f.engine.outbox.tick(); assert.equal(f.bridge.posts.length, 1);
  assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'server_confirmed'); await f.engine.close();
});
test('unknown send blocks remaining chunks and never resends', async () => {
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!);
  f.store.prepareReply(s, 'out-2', '长'.repeat(2000)); f.bridge.nextState = 'unknown';
  await f.engine.outbox.tick(); await f.engine.outbox.tick(); assert.equal(f.bridge.posts.length, 1);
  assert.equal(f.store.all("SELECT * FROM outbox WHERE state='cancelled'").length, 1); await f.engine.close();
});
test('missing prior request after restart needs review when store continuity is not confirmed', async () => {
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!);
  f.store.prepareReply(s, 'out-3', '答复'); f.store.exec('UPDATE outbox SET submitted=1');
  await f.engine.outbox.tick(); assert.equal(f.bridge.posts.length, 0); assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'needs_review'); await f.engine.close();
});
test('crash after host admission recovers committed direct output without reexecuting model', async () => {
  const f = fixture(); const m = normalize(event(1), f.store.config)!; f.store.ingest({ cursor: 1, truncated: false, events: [event(1)] });
  const s = f.store.session(m); const input = { session: s, inputId: 'recover', executionId: 'execution', purpose: 'reply' as const, system: '', context: '', provider: 'mock', model: 'test' };
  f.store.startRun(input, [f.store.one('SELECT id FROM inbox')!.id]);
  f.host.records.set('recover', { status: 'completed', replies: [{ id: 'execution:1', text: '恢复的回复' }] });
  await f.engine.recover(); await f.engine.recover(); assert.equal(f.host.calls.length, 0); assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 1); await f.engine.close();
});
test('orphaned execution becomes needs_review and is not retried', async () => {
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!);
  f.store.startRun({ session: s, inputId: 'orphan', executionId: 'lost', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' }, []);
  await f.engine.recover(); assert.equal(f.store.one('SELECT state FROM runs')!.state, 'needs_review'); assert.equal(f.host.calls.length, 0); await f.engine.close();
});

test('expired unprojected group review stops blocking fresh group participation without replay', async () => {
  const f = fixture();
  const old = event(1, 'group-a@chatroom', 'old group question');
  f.store.ingest({ cursor: 1, truncated: false, events: [old] });
  const session = f.store.session(normalize(old, f.store.config)!);
  const source = f.store.one('SELECT id FROM inbox')!.id;
  f.store.startRun({ session, inputId: 'old-group', executionId: 'old-execution', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' }, [source]);
  f.store.completeRun('old-group', 'needs_review', { status: 'needs_review', replies: [] });
  f.advance((f.store.config.ingress.maxMessageAgeSeconds + 1) * 1000);
  const fresh = event(2, 'group-a@chatroom', 'new group question', { timestamp: (now + (f.store.config.ingress.maxMessageAgeSeconds + 1) * 1000) / 1000 });
  f.store.ingest({ cursor: 2, truncated: false, events: [fresh] });
  f.advance(10000);
  await f.engine.pump(); await f.engine.drain();
  assert.equal(f.store.one("SELECT state FROM runs WHERE id='old-group'")!.state, 'cancelled');
  assert.equal(f.store.one('SELECT state FROM inbox WHERE id=?', source)!.state, 'cancelled');
  assert.ok(f.host.calls.some(call => call.purpose === 'decision'));
  assert.ok(f.host.calls.every(call => call.inputId !== 'old-group'));
  assert.equal(f.bridge.posts.length, 0);
  await f.engine.close();
});

test('fresh group review and uncertain group delivery remain blocked', async () => {
  for (const uncertain of [false, true]) {
    const f = fixture();
    const message = event(1, 'group-a@chatroom', 'group question');
    f.store.ingest({ cursor: 1, truncated: false, events: [message] });
    const session = f.store.session(normalize(message, f.store.config)!);
    const source = f.store.one('SELECT id FROM inbox')!.id;
    f.store.startRun({ session, inputId: 'review', executionId: 'execution', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' }, [source]);
    f.store.completeRun('review', 'needs_review', { status: 'needs_review', replies: [] });
    if (uncertain) {
      f.store.prepareReply(session, 'unknown-reply', 'uncertain');
      f.store.exec("UPDATE outbox SET state='unknown',submitted=1");
      f.advance((f.store.config.ingress.maxMessageAgeSeconds + 1) * 1000);
    }
    await f.engine.pump();
    assert.equal(f.store.one("SELECT state FROM runs WHERE id='review'")!.state, 'needs_review');
    assert.equal(f.host.calls.length, 0); assert.equal(f.bridge.posts.length, 0);
    await f.engine.close();
  }
});
test('strict configuration rejects unknown keys, identity placeholders and cross session sharing', () => {
  assert.throws(() => config({ unexpected: true })); assert.throws(() => config({ sessions: { isolation: 'conversation', crossSessionMemory: true } }));
  assert.throws(() => config({ account: { key: 'a', selfId: 'REPLACE_LOCALLY', bridgeEpoch: 'b' } }));
});
test('prompt inheritance validates cycles and variables without changing permissions', () => {
  assert.throws(() => new PromptRegistry(config({ promptProfiles: { a: { extends: 'b' }, b: { extends: 'a' } } })), /cycle/);
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!);
  const reply = new PromptRegistry(f.store.config).snapshot(s, 'reply');
  const memory = new PromptRegistry(f.store.config).snapshot(s, 'memory');
  assert.ok(reply.sections.some(s => s.type === 'persona')); assert.ok(!memory.sections.some(s => s.type === 'persona')); f.store.close();
});
test('summary coverage only advances for a valid contiguous conversation batch', () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-summary-'));
  const c = { ...config(), root }, store = new Store(c, ':memory:', () => now);
  try {
    store.ingest({ events: [], cursor: 0, truncated: false });
    store.ingest({ cursor: 2, truncated: false, events: [event(1), event(2)] });
    const s = store.session(normalize(event(1), c)!), memory = new Memory(store), batch = memory.pending(s);
    const summary = JSON.stringify({ title: '中文偏好', summary: '成员讨论中文交流的偏好。',
      tags: { topics: ['语言偏好'], entities: [], states: ['讨论'], aliases: [] } });
    assert.throws(() => memory.commitSummary(s, batch.slice(1), summary, 'v2'), /noncontiguous/);
    assert.throws(() => memory.commitSummary({ ...s, key: 'f'.repeat(64) }, batch, summary, 'v2'), /foreign/);
    assert.equal(store.one('SELECT count(*) n FROM summary_checkpoints')!.n, 0);
    memory.commitSummary(s, batch, summary, 'v2');
    assert.equal(memory.pending(s).length, 0);
    assert.equal(store.one('SELECT count(*) n FROM memory_segments')!.n, 1);
  } finally { store.close(); rmSync(root, { recursive: true, force: true }); }
});
test('interaction answer binds sender, scope, generation, expiry and single settlement', () => {
  const f = fixture(); const s = f.store.session(normalize(event(1), f.store.config)!); const registry = new Interactions(f.store);
  const id = registry.create(s, 'member-a', 'approval', { tool: 'test', parameter: 1 });
  assert.equal(registry.settle(s, 'member-b', id, 'allow', 'approval'), false);
  assert.equal(registry.settle({ ...s, generation: 2 }, 'member-a', id, 'allow', 'approval'), false);
  assert.equal(registry.settle(s, 'member-a', id, 'allow', 'approval'), true);
  assert.equal(registry.settle(s, 'member-a', id, 'allow', 'approval'), false); f.store.close();
});
test('model decisions cannot inject arbitrary recipients or sources', () => {
  const m = normalize(event(1, 'group-a@chatroom'), config())!;
  assert.throws(() => parseDecision(JSON.stringify({ action: 'reply', reason: 'test', sourceMessageIds: ['outside'], topicId: 'x', replyToSenderId: m.senderId }), [m]));
});
test('bridge discovery rejects remote hosts, URL credentials and redirects', async () => {
  const dir = mkdtempSync(join(tmpdir(), 'wechat-client-'));
  try { const path = join(dir, 'session.json'); writeFileSync(path, JSON.stringify({ url: 'http://example.com:1234', token: 'secret' }));
    const c = config({ bridge: { sessionFile: path } });
    await assert.rejects(new BridgeClient(c).discover(), /invalid_bridge_session/);
  } finally { rmSync(dir, { recursive: true, force: true }); }
});
test('single consumer lock refuses second instance and identity changes', () => {
  const dir = mkdtempSync(join(tmpdir(), 'wechat-lock-')); const path = join(dir, 'agent.sqlite');
  try { const first = new Store(config(), path, () => now);
    assert.throws(() => new Store(config(), path, () => now), /consumer_already_running/); first.close();
    assert.throws(() => new Store(config({ account: { key: 'other', selfId: 'self', bridgeEpoch: 'source-2' } }), path, () => now), /account_or_epoch_changed/);
  } finally { rmSync(dir, { recursive: true, force: true }); }
});
