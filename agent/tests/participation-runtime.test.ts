import { test } from 'node:test';
import assert from 'node:assert/strict';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { decisionContext, estimateDecisionTokens } from '../src/participation/context.js';
import { parseDecision } from '../src/participation/decision.js';
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

test('200 long Chinese messages use an independent conservative decision budget with full IDs and safe attachments', async () => {
  const f = fixture();
  try {
    const events = Array.from({ length: 200 }, (_, i) => event(i + 1, 'group-a@chatroom', '长中文聊天内容'.repeat(35) + i));
    f.store.ingest({ cursor: 200, events, truncated: false }); f.store.exec("UPDATE inbox SET state='observed'");
    const session = f.store.session(normalize(events[199]!, f.c)!);
    f.store.ingest({ cursor: 201, events: [event(201, 'group-a@chatroom', '最新问题：请比较两种方法。' + '补充'.repeat(10000))], truncated: false });
    f.bridge.page = { cursor: 201, events: [], truncated: false };
    const old = new Memory(f.store).recent(session, f.c.runtime.chatContextBytes - 4096);
    const oldContext = JSON.stringify({ nowMs: now, recent: old.recent, previousWork: [], evidenceOnly: true, tones: [],
      socialState: { recentBotMessages: 0, lastReplyAt: 0 }, contextStats: { available: old.availableMessages, included: old.includedMessages, truncated: old.truncated } });
    await f.engine.tick(); await f.engine.drain();
    const call = f.host.calls.find(c => c.purpose === 'decision')!;
    assert.ok(call); assert.ok(estimateDecisionTokens(call.context) <= 2000);
    assert.ok(Buffer.byteLength(call.context) <= f.c.runtime.chatContextBytes);
    const c = JSON.parse(call.context);
    assert.equal(c.recent.at(-1).messageId, 'group-a@chatroom:201');
    assert.equal(c.recent.at(-1).senderId, 'member-a'); assert.ok(c.recent.at(-1).text.startsWith('最新问题'));
    assert.equal(c.recent.at(-1).truncated, true);
    assert.equal(c.contextStats.available, 200); assert.equal(c.contextStats.truncated, true);
    assert.ok(Buffer.byteLength(call.context) < Buffer.byteLength(oldContext));
    console.log('synthetic decision comparison', JSON.stringify({ oldBytes: Buffer.byteLength(oldContext), newBytes: Buffer.byteLength(call.context),
      oldEstimatedTokens: estimateDecisionTokens(oldContext), newEstimatedTokens: estimateDecisionTokens(call.context) }));
    const reply = f.host.calls.find(c => c.purpose === 'reply')!;
    assert.equal(JSON.parse(reply.context).contextStats.available, 200);
    assert.ok(JSON.parse(reply.context).recent.length > c.recent.length);
  } finally { await f.engine.close(); }
});

test('decision builder reserves repair space, preserves candidate and delivery facts, and rejects unseen sources', () => {
  const input = { recent: Array.from({ length: 200 }, (_, i) => ({ messageId: 'group:' + i, senderId: 'sender:' + i,
    speaker: i === 199 ? 'user' : 'assistant', kind: 'image', text: '历史中文'.repeat(80), ageSeconds: 200 - i, gapSeconds: 1, recencyWeight: 1,
    attachment: { kind: 'image', state: 'ready', format: 'png', path: 'SECRET_PATH', note: 'read_image SECRET_PATH' } })),
    tokens: 2000, bytes: 196608, nowMs: now, stage: 'before_send', candidate: '仍然有效的候选回答',
    previousWork: [{ state: 'completed', tools: [{ name: 'web_search', state: 'completed' }],
      draft: '未交付草稿', output: [{ state: 'queued', submitted: true, kind: 'text' }] }], tones: [], lastReplyAt: now - 100,
    incomingIds: new Set(['group:199']) };
  const built = decisionContext(input), parsed = JSON.parse(built.context);
  assert.ok(estimateDecisionTokens(built.context) <= 2000); assert.ok(estimateDecisionTokens(built.repairContext) <= 2000);
  assert.ok(Buffer.byteLength(built.repairContext) <= input.bytes);
  assert.equal(parsed.stage, 'before_send'); assert.equal(parsed.candidateReply, input.candidate);
  assert.equal(parsed.previousWork[0].output[0].submitted, true);
  assert.ok(!built.context.includes('SECRET_PATH')); assert.ok(!built.context.includes('read_image'));
  assert.equal(parsed.recent.at(-1).messageId, 'group:199'); assert.equal(parsed.recent.at(-1).senderId, 'sender:199');
  const visible = input.recent.filter(m => built.visibleIds.has(m.messageId)).map(m => ({ ...m, direction: 'incoming' })) as any;
  const answer = (id: string) => JSON.stringify({ action: 'reply', reason: 'question', sourceMessageIds: [id], topicId: 'topic', replyToSenderId: 'sender:199' });
  assert.throws(() => parseDecision(answer('group:0'), visible), /outside_conversation/);
  assert.equal(parseDecision(answer('group:199'), visible).action, 'reply');
  assert.throws(() => decisionContext({ ...input, tokens: 256, recent: [{ ...input.recent[199]!, messageId: 'x'.repeat(2000) }] }), /budget_exceeded/);
});

test('conversation-specific participation override bounds initial, format-repair and transport-retry packets', async () => {
  const c = config({ conversationOverrides: { groups: { 'group-a@chatroom': { participation: { decisionContextTokens: 600, debounceMs: 0 } } } } });
  let time = now;
  const store = new Store(c, ':memory:', () => time), bridge = new FakeBridge(), host = new FakeHost();
  bridge.config = c; store.ingest({ cursor: 0, events: [], truncated: false });
  const engine = new Engine(c, store, bridge, host, () => {});
  const execute = host.execute.bind(host); let n = 0;
  host.execute = async (input, signal) => {
    if (input.purpose === 'decision' && n++ < 2) {
      host.calls.push(input);
      const result: HostResult = n === 1 ? { status: 'completed', replies: [{ id: 'bad', text: '{bad' }] } : { status: 'failed', replies: [], failureCode: 'TRANSPORT' };
      host.records.set(input.inputId, result); return result;
    }
    return execute(input, signal);
  };
  try {
    bridge.page = { cursor: 1, events: [event(1, 'group-a@chatroom', '新问题' + '补充'.repeat(1000))], truncated: false };
    await engine.tick(); await engine.drain(); time += 1001;
    await engine.tick(); await engine.drain();
    const calls = host.calls.filter(c => c.purpose === 'decision');
    assert.equal(calls.length, 3); assert.ok(calls.some(c => JSON.parse(c.context).formatCorrection));
    for (const call of calls) {
      assert.ok(estimateDecisionTokens(call.context) <= 600);
      assert.equal(JSON.parse(call.context).recent.at(-1).messageId, 'group-a@chatroom:1');
    }
    assert.equal(host.calls.filter(c => c.purpose === 'reply').length, 1);
  } finally { await engine.close(); }
});
