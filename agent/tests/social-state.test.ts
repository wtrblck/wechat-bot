import { test } from 'node:test';
import assert from 'node:assert/strict';
import { cpSync, mkdtempSync, rmSync } from 'node:fs';
import { join } from 'node:path';
import { tmpdir } from 'node:os';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { SocialState } from '../src/memory/social-state.js';
import { normalize } from '../src/ingress/normalizer.js';
import { parseDecision } from '../src/participation/decision.js';
import { channelTools } from '../src/tools/channel-tools.js';
import type { HostInput } from '../src/contracts.js';
import { config, event, FakeBridge, FakeHost, agentRoot } from './helpers.js';

function fixture(proactive = false, persistent = false) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-social-state-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  let time = Date.parse('2026-10-30T14:00:00+08:00');
  const c = { ...config({ memory: { enabled: true, lowTrafficSeconds: 86400 },
    social: { proactive: { enabled: proactive, contacts: proactive ? ['contact-a'] : [] } } }), root };
  const file = persistent ? join(root, 'state.sqlite') : ':memory:';
  const store = new Store(c, file, () => time);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const raw = event(1, 'contact-a', '我今天一点有面试', { timestamp: (time - 2 * 3600000) / 1000 });
  store.ingest({ events: [raw], cursor: 1, truncated: false });
  store.exec("UPDATE inbox SET state='observed'");
  const source = normalize(raw, c)!, session = store.session(source);
  const bridge = new FakeBridge(); bridge.config = c; bridge.page = { events: [], cursor: 1, truncated: false };
  const host = new FakeHost(), engine = new Engine(c, store, bridge, host, () => {}), social = new SocialState(store);
  const note = { kind: 'open_loop' as const, key: '面试进展', quote: source.text, sourceMessageId: source.messageId, followUpAt: time - 60000 };
  engine.memory.social.record(session, [note], [source]);
  return { root, c, file, store, source, session, bridge, host, engine, social, note,
    time: () => time, advance: (ms: number) => time += ms,
    cleanup: async () => { await engine.close(); rmSync(root, { recursive: true, force: true }); } };
}

test('short-term tone is tied to speaker and topic, fades without repeat renewal, and restores neutral', async () => {
  const f = fixture();
  try {
    const m = { ...f.source, timestampMs: f.time() };
    f.social.tone(f.session, m, '面试', 'serious');
    assert.equal(f.social.tones(f.session, [m.senderId], '面试')[0]!.strength, 1);
    assert.deepEqual(f.social.tones(f.session, ['someone-else'], '面试'), []);
    assert.deepEqual(f.social.tones(f.session, [m.senderId], '篮球'), []);
    f.advance(15 * 60000);
    f.social.tone(f.session, m, '面试', 'serious');
    assert.equal(f.social.tones(f.session, [m.senderId], '面试')[0]!.strength, 0.5);
    f.social.tone(f.session, { ...m, sequence: 2, messageId: 'next', timestampMs: f.time() }, '面试', 'neutral');
    assert.deepEqual(f.social.tones(f.session, [m.senderId], '面试'), []);
    f.social.tone(f.session, { ...m, sequence: 3, messageId: 'third', timestampMs: f.time() }, '面试', 'light');
    f.advance(31 * 60000);
    assert.deepEqual(f.social.tones(f.session, [m.senderId], '面试'), []);
    assert.throws(() => f.social.tone(f.session, { ...m, conversationId: 'contact-b' }, '面试', 'quiet'), /source_denied/);
  } finally { await f.cleanup(); }
});

test('group tone evidence must belong to the selected real incoming speaker', () => {
  const c = config(), m = normalize(event(1, 'group-a@chatroom'), c)!;
  const decision = { action: 'reply', reason: '接话', sourceMessageIds: [m.messageId], topicId: '面试', replyToSenderId: m.senderId,
    tone: { state: 'serious', sourceMessageId: m.messageId } };
  assert.equal(parseDecision(JSON.stringify(decision), [m]).tone!.state, 'serious');
  assert.throws(() => parseDecision(JSON.stringify({ ...decision, tone: { ...decision.tone, sourceMessageId: 'invented' } }), [m]), /tone_source_denied/);
  assert.throws(() => parseDecision(JSON.stringify(decision), [{ ...m, direction: 'outgoing' }]), /tone_source_denied/);
});

test('natural care only consumes its cooldown when an actual reply is queued; updated same topic stays cooled', async () => {
  const f = fixture();
  try {
    f.social.planCare(f.session, 'cancelled-run', f.source.messageId);
    assert.equal(f.social.lastCare(f.session.key, f.source.messageId), 0);
    f.store.prepareReply(f.session, 'care-reply', '面试咋样');
    f.social.bindCare('cancelled-run', 'care-reply');
    assert.equal(f.social.lastCare(f.session.key, f.source.messageId), f.time());
    assert.equal(f.engine.memory.social.context(f.session, [f.source.senderId])[0]!.canFollowUp, false);
    const next = { ...f.source, sequence: 2, messageId: 'contact-a:2', timestampMs: f.time(), text: '面试还没消息' };
    f.engine.memory.social.record(f.session, [{ ...f.note, quote: next.text, sourceMessageId: next.messageId }], [next]);
    assert.equal(f.engine.memory.social.context(f.session, [next.senderId])[0]!.canFollowUp, false);
    f.store.exec("UPDATE outbox SET state='cancelled'");
    assert.equal(f.social.lastCare(f.session.key, next.messageId), 0);
  } finally { await f.cleanup(); }
});

test('direct tone tool rejects foreign/current-window spoofing; proactive runs expose no tools', async () => {
  const f = fixture();
  try {
    const input: HostInput = { inputId: 'tool-run', executionId: 'exec', session: f.session, purpose: 'reply',
      provider: 'mock', model: 'test', system: '', context: JSON.stringify({ currentMessageIds: [f.source.messageId] }) };
    const tools = channelTools(f.engine, input, new AbortController().signal), tone = tools.find(t => t.name === 'set_social_tone')!;
    await assert.rejects(tone.execute({ sourceMessageId: 'contact-b:1', topic: '面试', state: 'serious' }, {} as ToolRunContext), /source_denied/);
    await tone.execute({ sourceMessageId: f.source.messageId, topic: '面试', state: 'serious' }, {} as ToolRunContext);
    assert.equal(f.store.one('SELECT state FROM social_tones')!.state, 'serious');
    assert.deepEqual(channelTools(f.engine, { ...input, proactive: true }, new AbortController().signal), []);
  } finally { await f.cleanup(); }
});

test('scheduled care is disabled by default; only configured direct contacts create jobs', async () => {
  const f = fixture();
  try {
    assert.equal(f.store.one('SELECT count(*) n FROM social_followups')!.n, 0);
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.host.calls.length, 0);
    assert.throws(() => config({ social: { proactive: { enabled: true, contacts: ['stranger'] } } }), /not_allowed/);
  } finally { await f.cleanup(); }
});

test('scheduled care sends once, is marked proactive, and survives restart without replay', async () => {
  const f = fixture(true, true);
  let closed = false;
  try {
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.host.calls.length, 1);
    assert.equal(f.host.calls[0]!.proactive, true);
    assert.equal(f.store.one('SELECT state FROM social_followups')!.state, 'queued');
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.bridge.posts.length, 1);
    await f.engine.close(); closed = true;
    const store = new Store(f.c, f.file, f.time), host = new FakeHost(), engine = new Engine(f.c, store, f.bridge, host, () => {});
    try { await engine.recover(); await engine.tick(); await engine.drain(); assert.equal(host.calls.length, 0); assert.equal(f.bridge.posts.length, 1); }
    finally { await engine.close(); }
  } finally { if (!closed) await f.engine.close(); rmSync(f.root, { recursive: true, force: true }); }
});

test('quiet hours, daily quota, paused gaps and private opt-out block timed care', async () => {
  const f = fixture(true);
  try {
    const job = f.store.one('SELECT * FROM social_followups')!;
    assert.equal(f.social.eligible(f.session, job), true);
    f.c.social.proactive.quietStartHour = 13; f.c.social.proactive.quietEndHour = 15;
    assert.equal(f.social.eligible(f.session, job), false);
    f.c.social.proactive.quietStartHour = 22; f.c.social.proactive.quietEndHour = 9;
    f.store.exec('INSERT INTO metadata VALUES(?,?)', 'care_off:' + f.session.key, '1');
    assert.equal(f.social.eligible(f.session, job), false);
    f.store.exec('DELETE FROM metadata WHERE key=?', 'care_off:' + f.session.key);
    f.store.exec("UPDATE source_checkpoints SET paused='gap'");
    assert.equal(f.social.eligible(f.session, job), false);
    f.store.exec('UPDATE source_checkpoints SET paused=NULL');
    f.store.exec('UPDATE social_followups SET attempted=?', f.time());
    assert.equal(f.social.eligible(f.session, job), false);
  } finally { await f.cleanup(); }
});

test('new incoming messages during generation and disabling before send cancel proactive output', async () => {
  const f = fixture(true);
  try {
    f.host.hook = async input => {
      if (input.proactive) f.store.ingest({ events: [event(2, 'contact-a', '不用问面试了', { timestamp: f.time() / 1000 })], cursor: 2, truncated: false });
    };
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 0);
    assert.equal(f.store.one('SELECT state FROM social_followups')!.state, 'skipped');
  } finally { await f.cleanup(); }
  const g = fixture(true);
  try {
    await g.engine.tick(); await g.engine.drain();
    assert.equal(g.store.one('SELECT state FROM outbox')!.state, 'prepared');
    g.c.social.proactive.enabled = false;
    await g.engine.tick(); await g.engine.drain();
    assert.equal(g.bridge.posts.length, 0);
    assert.equal(g.store.one('SELECT state FROM outbox')!.state, 'cancelled');
  } finally { await g.cleanup(); }
});

test('completed events supersede pending follow-ups; abandoned claims do not resume', async () => {
  const f = fixture(true);
  try {
    const m = { ...f.source, sequence: 2, messageId: 'contact-a:2', text: '面试结束了，不用再问', timestampMs: f.time() };
    f.engine.memory.social.record(f.session, [{ ...f.note, sourceMessageId: m.messageId, quote: m.text, status: 'closed' }], [m]);
    assert.equal(f.store.one('SELECT state FROM social_followups')!.state, 'superseded');
    assert.equal(f.engine.memory.social.context(f.session, [m.senderId])[0]!.canFollowUp, false);
    f.store.exec("UPDATE social_followups SET state='claimed'");
    await f.engine.recover();
    assert.equal(f.store.one('SELECT state FROM social_followups')!.state, 'abandoned');
  } finally { await f.cleanup(); }
});

test('an uncertain model response for tool-free proactive care is discarded without blocking ordinary chat', async () => {
  const f = fixture(true);
  try {
    const execute = f.host.execute.bind(f.host);
    f.host.execute = async (input, signal) => input.proactive ? { status: 'needs_review', replies: [] } : execute(input, signal);
    await f.engine.tick(); await f.engine.drain();
    assert.equal(f.store.one('SELECT state FROM runs')!.state, 'failed');
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 0);
    assert.equal(f.store.one('SELECT state FROM social_followups')!.state, 'skipped');
  } finally { await f.cleanup(); }
});
