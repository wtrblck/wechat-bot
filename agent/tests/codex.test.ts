import { test } from 'node:test';
import assert from 'node:assert/strict';
import { EventEmitter } from 'node:events';
import { PassThrough } from 'node:stream';
import { spawn, type ChildProcess } from 'node:child_process';
import { mkdtempSync, rmSync, cpSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { config, event, now, agentRoot, FakeBridge, FakeHost } from './helpers.js';
import { normalize } from '../src/ingress/normalizer.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { CodexTasks } from '../src/runtime/codex-tasks.js';
import { codexArguments, codexEnvironment, createCodexRunner, type CodexRunner } from '../src/runtime/codex-process.js';
import { saveConversationAccess } from '../src/access.js';
import { channelTools } from '../src/tools/channel-tools.js';
import type { HostInput } from '../src/contracts.js';

function fixture(runner: CodexRunner = async () => ({ text: 'done' })) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-codex-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const c = { ...config({ codex: { enabled: true } }), root };
  c.storage.file = 'data/agent.sqlite';
  const store = new Store(c, undefined, () => now);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const session = store.session(normalize(event(1), c)!);
  const input: HostInput = { session, inputId: 'codex-run', executionId: 'codex-exec', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' };
  let allowed = true;
  const deliveries: Array<{ session: string; id: string; text: string }> = [];
  const jobs = new CodexTasks(store, () => allowed, (s, id, text) => deliveries.push({ session: s.key, id, text }), runner);
  return { c, root, store, session, input, jobs, deliveries, pause: () => { allowed = false; },
    close: async () => { await jobs.close(); store.close(); rmSync(root, { recursive: true, force: true }); } };
}

test('Codex submits once per input, runs in conversation sandbox, and returns only to its origin once', async () => {
  const calls: unknown[] = [];
  const f = fixture(async (_c, request) => { calls.push(request); return { text: '最终结果 password=HIDDEN', usage: { input_tokens: 10 } }; });
  try {
    const first = f.jobs.submit(f.input, '编写一个函数');
    assert.equal(first.state, 'queued'); assert.equal(f.jobs.submit(f.input, '编写一个函数').id, first.id);
    f.jobs.tick(); await f.jobs.drain(); f.jobs.tick(); f.jobs.tick();
    assert.equal(calls.length, 1); assert.equal(f.deliveries.length, 1);
    assert.equal(f.deliveries[0]!.session, f.session.key);
    assert.ok(f.deliveries[0]!.text.includes('最终结果')); assert.ok(!f.deliveries[0]!.text.includes('HIDDEN'));
    assert.deepEqual(calls[0], { task: '编写一个函数', cwd: join(f.root, 'data', 'sandbox', f.session.key), files: 'sandbox' });
    const other = f.store.session(normalize(event(2, 'contact-b'), f.c)!);
    assert.throws(() => f.jobs.status(other, first.id), /not_found/);
    assert.throws(() => f.jobs.cancel(other, first.id), /not_found/);
    assert.equal(f.jobs.status(f.session, first.id).state, 'completed');
  } finally { await f.close(); }
});

test('Codex host working directory requires any-path access, and permissions are rechecked before launch', async () => {
  let calls = 0;
  const f = fixture(async () => { calls++; return { text: 'done' }; });
  try {
    assert.throws(() => f.jobs.submit(f.input, 'task', f.root), /cwd_denied/);
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: true, files: 'any' });
    const job = f.jobs.submit(f.input, 'task', f.root);
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: true, files: 'sandbox' });
    f.jobs.tick(); await f.jobs.drain();
    assert.equal(calls, 0); assert.equal(f.jobs.status(f.session, job.id).state, 'cancelled');
    assert.equal(f.deliveries.length, 0);
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: false, files: 'sandbox' });
    assert.throws(() => f.jobs.submit(f.input, 'new task'), /not_allowed/);
  } finally { await f.close(); }
});

test('stopping after completion but before notification suppresses the pending result', async () => {
  const f = fixture();
  try {
    const job = f.jobs.submit(f.input, 'task');
    f.jobs.tick(); await f.jobs.drain();
    assert.equal(f.jobs.status(f.session, job.id).state, 'completed');
    f.jobs.cancel(f.session); f.jobs.tick();
    assert.equal(f.deliveries.length, 0);
  } finally { await f.close(); }
});

test('Codex queued/running tasks cancel on stop, generation changes, permission downgrade or pauses', async () => {
  for (const mode of ['stop', 'generation', 'disable', 'downgrade', 'pause']) {
    let started = false, killed = false;
    const f = fixture(async (_c, _request, signal) => {
      started = true;
      return await new Promise((resolve, reject) => {
        signal.addEventListener('abort', () => { killed = true; reject(Error('codex_cancelled')); }, { once: true });
      });
    });
    try {
      if (mode === 'downgrade') saveConversationAccess(f.c, { conversation: 'contact-a', enabled: true, files: 'any' });
      const job = f.jobs.submit(f.input, 'task');
      f.jobs.tick(); await Promise.resolve(); assert.equal(started, true);
      if (mode === 'stop') f.jobs.cancel(f.session, job.id);
      if (mode === 'generation') f.store.exec('UPDATE session_map SET generation=generation+1 WHERE key=?', f.session.key);
      if (mode === 'disable') saveConversationAccess(f.c, { conversation: 'contact-a', enabled: false, files: 'sandbox' });
      if (mode === 'downgrade') saveConversationAccess(f.c, { conversation: 'contact-a', enabled: true, files: 'sandbox' });
      if (mode === 'pause') f.pause();
      f.jobs.reconcile(); await f.jobs.drain();
      assert.equal(killed, true); assert.equal(f.store.one('SELECT state FROM codex_tasks WHERE id=?', job.id)!.state, 'cancelled');
      assert.equal(f.deliveries.length, 0);
    } finally { await f.close(); }
  }
});

test('Codex interrupted task is reported after restart without reexecution; failed jobs return a safe error', async () => {
  let calls = 0;
  const f = fixture(async () => { calls++; throw Error('secret raw error'); });
  try {
    const first = f.jobs.submit(f.input, 'task');
    f.store.exec("UPDATE codex_tasks SET state='running' WHERE id=?", first.id);
    const restarted = new CodexTasks(f.store, () => true, (_s, _id, text) => f.deliveries.push({ session: '', id: '', text }), async () => { calls++; return { text: 'unexpected' }; });
    restarted.tick(); await restarted.drain();
    assert.equal(calls, 0); assert.equal(f.deliveries.length, 1); assert.ok(f.deliveries[0]!.text.includes('没有自动重跑'));
    await restarted.close();
    f.jobs.submit({ ...f.input, inputId: 'second' }, 'new task'); f.jobs.tick(); await f.jobs.drain(); f.jobs.tick();
    assert.equal(calls, 1); assert.ok(!f.deliveries.at(-1)!.text.includes('secret raw error'));
  } finally { await f.close(); }
});

test('Codex queue caps concurrency, rejects overflow and closes children before releasing storage', async () => {
  const releases: Array<() => void> = [];
  const f = fixture(async (_c, _r, signal) => new Promise((resolve, reject) => {
    releases.push(() => resolve({ text: 'done' })); signal.addEventListener('abort', () => reject(Error('codex_cancelled')), { once: true });
  }));
  try {
    f.c.codex.maxQueued = 1;
    f.jobs.submit(f.input, 'one'); f.jobs.submit({ ...f.input, inputId: 'two' }, 'two');
    assert.throws(() => f.jobs.submit({ ...f.input, inputId: 'three' }, 'three'), /queue_full/);
    f.jobs.tick(); await Promise.resolve(); assert.equal(releases.length, 1);
    releases[0]!(); await f.jobs.drain(); f.jobs.tick(); await Promise.resolve(); assert.equal(releases.length, 2);
    await f.jobs.close(); assert.equal(f.store.one("SELECT count(*) n FROM codex_tasks WHERE state='running'")!.n, 0);
  } finally { await f.close(); }
});

test('Codex CLI forces ChatGPT and stdin, isolates sandbox tasks, and uses full access only for any-path grants', async () => {
  const f = fixture();
  const original = process.env.CODEX_API_KEY; process.env.CODEX_API_KEY = 'MUST_NOT_INHERIT';
  try {
    assert.equal(codexEnvironment(f.c).CODEX_API_KEY, undefined);
    const args = codexArguments(f.c, { task: 'not argv', cwd: f.root, files: 'sandbox' });
    assert.ok(args.includes('forced_login_method="chatgpt"')); assert.ok(args.includes('--ignore-user-config'));
    assert.ok(args.some(value => value.includes('\":root\"=\"deny\"')));
    assert.ok(!args.some(value => value.includes('dangerously'))); assert.ok(!args.includes('not argv'));
    const full = codexArguments(f.c, { task: 'task', cwd: f.root, files: 'any' });
    assert.ok(full.includes('--dangerously-bypass-approvals-and-sandbox'));
    assert.ok(!full.some(value => value.includes('permissions.wechat-bot') || value.includes('windows.sandbox')));
    assert.ok(full.includes('forced_login_method="chatgpt"'));
    let seenTask = '';
    const runner = createCodexRunner(((executable: string, argv: string[], options: any) => {
      assert.equal(options.shell, false); assert.equal(options.windowsHide, true);
      const child = new EventEmitter() as any;
      child.stdin = new PassThrough(); child.stdout = new PassThrough(); child.stderr = new PassThrough();
      child.stdin.on('data', (chunk: Buffer) => { seenTask += chunk.toString('utf8'); });
      child.stdin.on('finish', () => {
        const output = Buffer.from([
          JSON.stringify({ type: 'item.completed', item: { type: 'reasoning', text: 'PRIVATE REASONING' } }),
          JSON.stringify({ type: 'item.completed', item: { type: 'command_execution', command: 'PRIVATE COMMAND' } }),
          JSON.stringify({ type: 'item.completed', item: { type: 'agent_message', text: '中间消息' } }),
          JSON.stringify({ type: 'item.completed', item: { type: 'agent_message', text: '最终中文结果' } }),
          JSON.stringify({ type: 'turn.completed', usage: { input_tokens: 12 } }),
        ].join('\n'));
        for (const byte of output) child.stdout.write(Buffer.from([byte]));
        child.stderr.write('PRIVATE TOKEN'); child.emit('close', 0);
      });
      return child as ChildProcess;
    }) as typeof spawn);
    const result = await runner(f.c, { task: 'task $(hostile) `literal`', cwd: f.root, files: 'sandbox' }, new AbortController().signal);
    assert.equal(seenTask, 'task $(hostile) `literal`'); assert.equal(result.text, '最终中文结果');
    assert.deepEqual(result.usage, { input_tokens: 12 }); assert.ok(!JSON.stringify(result).includes('PRIVATE'));
  } finally { if (original === undefined) delete process.env.CODEX_API_KEY; else process.env.CODEX_API_KEY = original; await f.close(); }
});

test('direct Codex command bypasses the chat model and automatically queues the final result', async () => {
  const f = fixture();
  await f.jobs.close();
  const bridge = Object.assign(new FakeBridge(), { config: f.c }), host = new FakeHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  Object.assign(engine.codex, { runner: async () => ({ text: '命令执行结果' }) });
  try {
    bridge.page = { events: [event(1, 'contact-a', '/bot codex 创建一个示例')], cursor: 1, truncated: false };
    await engine.tick(); await engine.codex.drain(); await engine.tick();
    assert.equal(host.calls.length, 0);
    assert.equal(f.store.one('SELECT count(*) n FROM codex_tasks')!.n, 1);
    assert.ok(bridge.posts.some(body => JSON.parse(body).text.includes('命令执行结果')));
    assert.ok(channelTools(engine, f.input, new AbortController().signal).some(tool => tool.name === 'codex_submit'));
    assert.equal(channelTools(engine, { ...f.input, proactive: true }, new AbortController().signal).length, 0);
  } finally { await engine.close(); rmSync(f.root, { recursive: true, force: true }); }
});

test('Codex runner rejects incomplete/malformed output and waits for child close after timeout or abort', async () => {
  const f = fixture();
  try {
    for (const mode of ['incomplete', 'malformed', 'timeout', 'abort']) {
      let killed = false, closed = false;
      const controller = new AbortController();
      const runner = createCodexRunner((() => {
        const child = new EventEmitter() as any;
        child.stdin = new PassThrough(); child.stdout = new PassThrough(); child.stderr = new PassThrough();
        const close = () => { closed = true; child.emit('close', 1); };
        child.kill = () => { killed = true; queueMicrotask(close); return true; };
        child.stdin.on('finish', () => {
          if (mode === 'incomplete') { child.stdout.write(JSON.stringify({ type: 'item.completed', item: { type: 'agent_message', text: 'not completed' } }) + '\n'); queueMicrotask(close); }
          if (mode === 'malformed') child.stdout.write('null\n');
          if (mode === 'abort') controller.abort();
        });
        return child;
      }) as typeof spawn);
      f.c.codex.timeoutSeconds = .01;
      await assert.rejects(runner(f.c, { task: 'task', cwd: f.root, files: 'sandbox' }, controller.signal),
        new RegExp(mode === 'incomplete' ? 'codex_task_failed' : mode === 'malformed' ? 'codex_invalid_output' : mode === 'timeout' ? 'codex_timeout' : 'codex_cancelled'));
      assert.equal(closed, true);
      if (mode !== 'incomplete') assert.equal(killed, true);
    }
  } finally { await f.close(); }
});
