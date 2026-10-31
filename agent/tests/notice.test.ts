import { test } from 'node:test';
import assert from 'node:assert/strict';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { PromptRegistry } from '../src/prompts/registry.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost } from './helpers.js';

function fixture(conversation = 'contact-a') {
  const c = config(), store = new Store(c, ':memory:', () => now), bridge = new FakeBridge();
  store.ingest({ cursor: 0, events: [], truncated: false });
  const engine = new Engine(c, store, bridge, new FakeHost(), () => {});
  const session = store.session(normalize(event(1, conversation), c)!);
  const controller = new AbortController();
  const input: HostInput = { inputId: 'notice-run', executionId: 'notice-execution', purpose: 'reply', session,
    provider: 'mock', model: 'test', system: '', context: '{}' };
  const get = (i = input) => channelTools(engine, i, controller.signal).find(t => t.name === 'announce_work')!;
  const call = (text: string) => get().execute({ text }, {} as ToolRunContext);
  return { c, store, bridge, engine, session, controller, input, get, call };
}

test('notice is sent before work completes, deduplicated per run, and independent of final reply', async () => {
  for (const conversation of ['contact-a', 'group-a@chatroom']) {
    const f = fixture(conversation);
    try {
      const first: any = await f.call('我先看看视频，整理好再告诉你。');
      assert.equal(first.status, 'server_confirmed'); assert.equal(first.deliveryVerified, false);
      assert.equal(f.bridge.posts.length, 1);
      assert.equal(JSON.parse(f.bridge.posts[0]!).recipient, conversation);
      await f.call('更换预告不应重复发送');
      assert.equal(f.bridge.posts.length, 1);
      assert.equal(f.engine.outbox.committed('work-notice:' + f.input.inputId), true);
      f.store.prepareReply(f.session, 'final-answer', '最终答案', { runId: f.input.inputId });
      assert.equal(f.engine.outbox.committed('final-answer'), false);
      f.engine.outbox.cancelPreparedReply('final-answer', 'participation_superseded');
      assert.equal(f.store.one("SELECT state FROM outbox WHERE reply='final-answer'")!.state, 'cancelled');
      await f.get({ ...f.input, inputId: 'second-run' }).execute({ text: '我再核对一下。' }, {} as ToolRunContext);
      assert.equal(f.bridge.posts.length, 2);
    } finally { await f.engine.close(); }
  }
});

test('notice lost response uses original request and never duplicates', async () => {
  const f = fixture();
  try {
    f.bridge.lostResponse = true;
    const result: any = await f.call('我先查一下来源。');
    assert.equal(result.submitted, true); assert.equal(f.bridge.posts.length, 1);
    await f.call('再试一次'); await f.engine.outbox.tick();
    assert.equal(f.bridge.posts.length, 1);
    assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'server_confirmed');
  } finally { await f.engine.close(); }
});

test('notice cannot flush an older unreviewed draft or uncertain send', async () => {
  const f = fixture();
  try {
    f.store.prepareReply(f.session, 'old-draft', '尚未复审');
    const result: any = await f.call('我先整理一下。');
    assert.equal(result.status, 'prepared'); assert.equal(f.bridge.posts.length, 0);
    await f.engine.outbox.cancel(f.session.key);
    assert.equal(f.store.one("SELECT state FROM outbox WHERE reply LIKE 'work-notice:%'")!.state, 'cancelled');
  } finally { await f.engine.close(); }
});

test('notice validates text and respects stage, abort, quiet, reset, baseline, gap and stop', async () => {
  for (const reason of ['text', 'abort', 'quiet', 'reset', 'baseline', 'gap', 'stop', 'budget']) {
    const f = fixture();
    try {
      if (reason === 'text') {
        for (const text of ['', ' '.repeat(5), 'a\nb', 'a'.repeat(81), 'a\u0000b']) await assert.rejects(f.call(text));
      } else {
        if (reason === 'abort') f.controller.abort();
        if (reason === 'quiet') f.store.exec('UPDATE session_map SET quiet=1');
        if (reason === 'reset') f.store.exec('UPDATE session_map SET generation=generation+1');
        if (reason === 'baseline') f.store.exec('UPDATE source_checkpoints SET baseline=1');
        if (reason === 'gap') f.store.exec("UPDATE source_checkpoints SET paused='event_gap'");
        if (reason === 'stop') f.engine.outbox.stopping = true;
        if (reason === 'budget') { f.c.budget.enabled = true; f.engine.budget.stop('test_budget_stop'); }
        await assert.rejects(f.call('我先查一下。'));
      }
      assert.equal(f.bridge.posts.length, 0);
      for (const purpose of ['decision', 'memory'] as const) assert.equal(f.get({ ...f.input, purpose }), undefined);
      assert.equal(f.get({ ...f.input, proactive: true }), undefined);
    } finally { await f.engine.close(); }
  }
});

test('runtime mechanisms remain in custom and tool-disabled snapshots with stage-specific instructions', async () => {
  const f = fixture();
  try {
    f.c.prompts.toolBehavior = null;
    const registry = new PromptRegistry(f.c);
    const reply = registry.snapshot(f.session, 'reply', f.store);
    assert.ok(reply.sections.some(s => s.type === 'mechanisms' && s.source === 'runtime'));
    for (const word of ['announce_work', 'previousWork', 'read_work_result', 'generation', 'server_confirmed', '/bot stop', '预算']) assert.ok(reply.system.includes(word));
    assert.ok(Buffer.byteLength(reply.system) < 32000);
    const decision = registry.snapshot(f.session, 'decision');
    assert.ok(decision.system.includes('预告不代表问题已回答'));
    assert.ok(!decision.system.includes('先调用它发一句短预告'));
    const memory = registry.snapshot(f.session, 'memory');
    assert.ok(memory.system.includes('无工具/发送权限')); assert.ok(!memory.system.includes('announce_work'));
  } finally { await f.engine.close(); }
});
