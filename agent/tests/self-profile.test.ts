import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput } from '../src/contracts.js';
import { activeSelfProfile } from '../src/prompts/self-profile.js';
import { config, event, now, agentRoot, FakeBridge, FakeHost } from './helpers.js';

function fixture(file = ':memory:') {
  const c = config(), store = new Store(c, file, () => now), engine = new Engine(c, store, new FakeBridge(), new FakeHost(), () => {});
  store.ingest({ cursor: 0, events: [], truncated: false });
  const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
  const input: HostInput = { inputId: 'profile-run', executionId: 'profile-exec', session, purpose: 'reply', provider: 'mock', model: 'test', system: '', context: '{}' };
  const controller = new AbortController();
  const call = (name: string, args: unknown, i = input) => channelTools(engine, i, controller.signal).find(t => t.name === name)!.execute(args, {} as ToolRunContext) as Promise<any>;
  return { c, store, engine, session, input, controller, call };
}

test('global persona/style hot load on every route while old snapshots and fixed constraints remain intact', async () => {
  const f = fixture();
  try {
    const old = f.engine.prompts.snapshot(f.session, 'reply', f.store);
    assert.equal((await f.call('read_self_profile', {})).version, 'base');
    const result = await f.call('update_self_profile', { expectedVersion: 'base', persona: '你叫小海豚，沉稳幽默。', responseStyle: '表达温和清楚，避免口头禅。', reason: '调整角色和语气' });
    assert.equal(result.status, 'updated');
    for (const conversation of ['group-b@chatroom', 'contact-a']) {
      const s = f.store.session(normalize(event(2, conversation), f.c)!);
      const next = f.engine.prompts.snapshot(s, 'reply', f.store);
      assert.ok(next.system.includes('你叫小海豚'));
      assert.ok(next.system.includes('表达温和清楚'));
      assert.ok(next.system.includes('messages格式'));
      assert.ok(next.sections.find(s => s.type === 'mechanisms'));
      assert.ok(!old.system.includes('你叫小海豚'));
      assert.ok(!f.engine.prompts.snapshot(s, 'decision', f.store).system.includes('你叫小海豚'));
      assert.ok(!f.engine.prompts.snapshot(s, 'memory', f.store).system.includes('你叫小海豚'));
    }
    const repeated = await f.call('update_self_profile', { expectedVersion: 'base', persona: '不应生效', reason: '重复' });
    assert.equal(repeated.status, 'already_applied');
    assert.equal(f.store.one('SELECT count(*) n FROM self_profiles')!.n, 1);
    const conflict = await f.call('update_self_profile', { expectedVersion: 'base', responseStyle: '冲突', reason: '旧版本' }, { ...f.input, inputId: 'run-2' });
    assert.equal(conflict.status, 'version_conflict');
    const next = await f.call('update_self_profile', { expectedVersion: result.version, responseStyle: '简短明确', reason: '只改风格' }, { ...f.input, inputId: 'run-3' });
    assert.equal(activeSelfProfile(f.store).persona, '你叫小海豚，沉稳幽默。');
    const rolled = await f.call('rollback_self_profile', { expectedVersion: next.version, targetVersion: result.version, reason: '恢复' }, { ...f.input, inputId: 'run-4' });
    assert.equal(activeSelfProfile(f.store).responseStyle, '表达温和清楚，避免口头禅。');
    await f.call('rollback_self_profile', { expectedVersion: rolled.version, targetVersion: 'base', reason: '撤销全局覆盖' }, { ...f.input, inputId: 'run-5' });
    const restored = f.engine.prompts.snapshot(f.session, 'reply', f.store);
    for (const type of ['persona', 'responseStyle', 'mechanisms'])
      assert.equal(restored.sections.find(s => s.type === type)?.text, old.sections.find(s => s.type === type)?.text);
  } finally { await f.engine.close(); }
});

test('self profile rejects arbitrary sections, invalid/oversized changes and guards session controls', async () => {
  const f = fixture();
  try {
    for (const patch of [{ system: 'bad' }, { path: '../prompts/base.md' }, { replyDecision: 'bad' }, { format: 'bad' }, {}, { persona: '' }, { persona: '中'.repeat(6000) }, { persona: 'a\u0000b' }, { persona: '字'.repeat(5000), responseStyle: '风'.repeat(5000) }]) {
      await assert.rejects(f.call('update_self_profile', { expectedVersion: 'base', reason: '测试拒绝', ...patch }));
      assert.equal(activeSelfProfile(f.store).version, 'base');
      assert.equal(f.store.one('SELECT count(*) n FROM self_profiles')!.n, 0);
    }
    f.store.exec('UPDATE session_map SET generation=generation+1');
    await assert.rejects(f.call('update_self_profile', { expectedVersion: 'base', persona: '失效', reason: '旧轮次' }), /generation/);
    for (const purpose of ['decision', 'memory'] as const) assert.equal(channelTools(f.engine, { ...f.input, purpose }, f.controller.signal).length, 0);
    assert.equal(channelTools(f.engine, { ...f.input, proactive: true }, f.controller.signal).length, 0);
  } finally { await f.engine.close(); }
});

test('self profile guards stop, quiet, gap, baseline, budget and aborted executions', async () => {
  for (const reason of ['stop', 'quiet', 'gap', 'baseline', 'budget', 'abort']) {
    const f = fixture();
    try {
      if (reason === 'stop') f.engine.outbox.stopping = true;
      if (reason === 'quiet') f.store.exec('UPDATE session_map SET quiet=1');
      if (reason === 'gap') f.store.exec("UPDATE source_checkpoints SET paused='gap'");
      if (reason === 'baseline') f.store.exec('UPDATE source_checkpoints SET baseline=1');
      if (reason === 'budget') { f.c.budget.enabled = true; f.engine.budget.stop('test_budget_stop'); }
      if (reason === 'abort') f.controller.abort();
      await assert.rejects(f.call('update_self_profile', { expectedVersion: 'base', persona: '不可保存', reason: '保护测试' }));
      assert.equal(activeSelfProfile(f.store).version, 'base');
    } finally { await f.engine.close(); }
  }
});

test('self profile history is bounded and explicit persona=null can be globally overridden', async () => {
  const f = fixture();
  try {
    f.c.prompts.persona = null;
    let version = 'base';
    for (let i = 0; i < 52; i++) {
      const result = await f.call('update_self_profile', { expectedVersion: version, persona: '沉稳的角色' + i,
        responseStyle: '简洁清楚', reason: '版本' + i }, { ...f.input, inputId: 'version-run-' + i });
      version = result.version;
    }
    assert.equal(f.store.one('SELECT count(*) n FROM self_profiles')!.n, 50);
    assert.equal(activeSelfProfile(f.store).version, version);
    assert.ok(f.engine.prompts.snapshot(f.session, 'reply', f.store).system.includes('沉稳的角色51'));
  } finally { await f.engine.close(); }
});

test('global profile survives restart and treats template markers literally', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-self-profile-')), file = join(root, 'agent.sqlite');
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const f = fixture(file);
  try {
    await f.call('update_self_profile', { expectedVersion: 'base', persona: '称呼是{{not_a_variable}}，友好。', reason: '字面文本' });
    const version = activeSelfProfile(f.store).version;
    await f.engine.close();
    const store = new Store(f.c, file, () => now), engine = new Engine(f.c, store, new FakeBridge(), new FakeHost(), () => {});
    try {
      assert.equal(activeSelfProfile(store).version, version);
      assert.ok(engine.prompts.snapshot(f.session, 'reply', store).system.includes('{{not_a_variable}}'));
    } finally { await engine.close(); }
  } finally { try { await f.engine.close(); } catch {} rmSync(root, { recursive: true, force: true }); }
});
