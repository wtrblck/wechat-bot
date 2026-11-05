import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync, writeFileSync, readFileSync, existsSync, symlinkSync } from 'node:fs';
import { join, relative, isAbsolute } from 'node:path';
import { tmpdir } from 'node:os';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import type { HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import { Sandbox } from '../src/runtime/sandbox.js';
import { ExternalFiles } from '../src/runtime/external-files.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { setTimeout as delay } from 'node:timers/promises';

function fixture() {
  const root = mkdtempSync(join(tmpdir(), 'wechat-external-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  let clock = now;
  const c = { ...config({ externalAccess: { enabled: true, approver: 'contact-a', timeoutSeconds: 10 }, egress: { sendArtifacts: true } }), root };
  const store = new Store(c, ':memory:', () => clock);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const bridge = Object.assign(new FakeBridge(), { config: c });
  const engine = new Engine(c, store, bridge, new FakeHost(), () => {});
  const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
  const input: HostInput = { session, inputId: 'external-run', executionId: 'execution', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' };
  const controller = new AbortController();
  const external = new ExternalFiles(engine, input, controller.signal);
  const approve = (answer = 'allow') => {
    const row = store.one("SELECT * FROM interactions WHERE state='pending' ORDER BY rowid DESC LIMIT 1")!;
    const contact = store.one('SELECT * FROM session_map WHERE key=?', row.route)! as typeof session;
    assert.ok(engine.interactions.settle(contact, 'contact-a', row.id, answer, 'approval'));
    return row;
  };
  return { root, store, engine, bridge, session, input, controller, external, approve,
    advance: () => { clock += 11000; },
    advanceBy: (ms: number) => { clock += ms; },
    close: async () => { controller.abort(); await engine.close(); const r = relative(tmpdir(), root); assert.ok(r && !r.startsWith('..') && !isAbsolute(r)); rmSync(root, { recursive: true, force: true }); } };
}

test('external task approval binds origin and approver, needs no command ID, and snapshots write bytes', async () => {
  const f = fixture();
  try {
    const sandbox = new Sandbox(f.root, f.session.key);
    sandbox.write('result.txt', 'approved original');
    const target = join(f.root, 'host-output.txt');
    const pending = f.external.write(target, 'result.txt', 'save requested result');
    const row = f.store.one('SELECT * FROM interactions')!;
    const contact = f.store.one('SELECT * FROM session_map WHERE key=?', row.route)! as typeof f.session;
    assert.notEqual(contact.key, f.session.key);
    assert.equal(existsSync(target), false);
    assert.equal(f.engine.interactions.settle(f.session, 'contact-a', row.id, 'allow', 'approval'), false);
    assert.equal(f.engine.interactions.settle(contact, 'member-a', row.id, 'allow', 'approval'), false);
    sandbox.write('result.txt', 'changed while waiting');
    await f.engine.outbox.tick();
    assert.ok(f.store.timeline(contact.key).some(r => r.message.text.includes('/bot allow') && !r.message.text.includes(row.id)));
    f.bridge.page = { events: [event(20, 'contact-a', '/bot allow', { sender: 'contact-a' })], cursor: 20, truncated: false };
    await f.engine.tick();
    await pending;
    assert.equal(readFileSync(target, 'utf8'), 'approved original');
    assert.equal(f.store.one('SELECT state FROM interactions WHERE id=?', row.id)!.state, 'consumed');
    assert.equal(f.engine.interactions.settle(contact, 'contact-a', row.id, 'allow', 'approval'), false);
    assert.ok(f.store.timeline(contact.key).some(r => r.message.direction === 'incoming' && r.message.text === '/bot allow'));
    const audit = JSON.parse(f.store.one('SELECT value FROM metadata WHERE key=?', 'external_operation:' + row.id)!.value);
    assert.equal(audit.status, 'completed');
  } finally { await f.close(); }
});

test('one approval covers this task reads, listings and writes without authorizing a new task', async () => {
  const f = fixture();
  try {
    const target = join(f.root, 'host-file.txt'); writeFileSync(target, 'host contents');
    const pending = f.external.read(target, 'read requested file');
    assert.equal(f.store.one('SELECT count(*) n FROM artifacts')!.n, 0);
    f.approve();
    const result = await pending;
    assert.equal(result.text, 'host contents');
    assert.equal(new Sandbox(f.root, f.session.key).read(result.path), 'host contents');
    const listing = f.external.list(f.root, 'find requested file');
    assert.ok((await listing).files.some(x => x.name === 'host-file.txt'));
    new Sandbox(f.root, f.session.key).write('output.txt', 'task output');
    await f.external.write(join(f.root, 'task-output.txt'), 'output.txt', 'save result');
    assert.equal(readFileSync(join(f.root, 'task-output.txt'), 'utf8'), 'task output');
    const repeated = await new ExternalFiles(f.engine, f.input, f.controller.signal).read(target, 'same active task');
    assert.equal(repeated.text, 'host contents');
    assert.notEqual(repeated.path, result.path);
    assert.equal(f.store.one('SELECT count(*) n FROM interactions')!.n, 1);
    assert.equal(f.store.one("SELECT count(*) n FROM outbox WHERE reply LIKE 'command:external-approval:%'")!.n, 1);
    const next = new ExternalFiles(f.engine, { ...f.input, inputId: 'next-task' }, f.controller.signal).read(target, 'new task');
    assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='pending'")!.n, 1);
    f.approve(); await next;
    for (const path of ['relative.txt', '\\\\server\\share\\x', 'E:\\x:secret', 'E:\\CON']) await assert.rejects(f.external.read(path, 'invalid'), /external_path_denied/);
  } finally { await f.close(); }
});

test('number-free approvals apply only to the submitted prompt; concurrent tasks are presented one at a time', async () => {
  const f = fixture();
  try {
    const first = f.external.list(f.root, 'first task');
    const contact = f.store.one("SELECT * FROM session_map WHERE conversation='contact-a'")! as typeof f.session;
    assert.equal(f.engine.interactions.settleCurrentApproval(contact, 'contact-a', 'allow'), false);
    const other = new ExternalFiles(f.engine, { ...f.input, inputId: 'parallel-task' }, f.controller.signal);
    const second = other.list(f.root, 'second task');
    assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='queued'")!.n, 1);
    await f.engine.outbox.tick();
    assert.equal(f.engine.interactions.settleCurrentApproval(f.session, 'contact-a', 'allow'), false);
    assert.equal(f.engine.interactions.settleCurrentApproval(contact, 'member-a', 'allow'), false);
    assert.equal(f.engine.interactions.settleCurrentApproval(contact, 'contact-a', 'allow'), true);
    assert.equal(f.engine.interactions.settleCurrentApproval(contact, 'contact-a', 'allow'), false);
    await first;
    for (let i = 0; i < 100 && !f.store.one("SELECT id FROM interactions WHERE state='pending'"); i++) await delay(10);
    assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='pending'")!.n, 1);
    await f.engine.outbox.tick();
    assert.equal(f.engine.interactions.settleCurrentApproval(contact, 'contact-a', 'allow'), true);
    await second;
    assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='consumed'")!.n, 2);
  } finally { await f.close(); }
});

test('task grant cannot survive task completion, approver reset, or startup recovery', async () => {
  for (const mode of ['finished', 'reset', 'restart']) {
    const f = fixture();
    try {
      f.store.startRun(f.input, []);
      const first = f.external.list(f.root, 'task'); f.approve(); await first;
      if (mode === 'finished') f.store.completeRun(f.input.inputId, 'completed', { replies: [] });
      if (mode === 'reset') f.store.exec("UPDATE session_map SET generation=generation+1 WHERE conversation='contact-a'");
      if (mode === 'restart') f.engine.interactions.invalidate();
      await assert.rejects(f.external.list(f.root, 'reuse'), /external_task_finished|external_task_grant_revoked/);
    } finally { await f.close(); }
  }
});

test('approval waiting does not consume the execution timeout or discard an admitted file task after source age expires', async () => {
  for (const conversation of ['contact-b', 'group-a@chatroom']) {
    const f = fixture();
    try {
      f.engine.config.runtime.turnTimeoutSeconds = .06;
      let didWork = false;
      f.engine.host.execute = async (input, signal) => {
        if (input.purpose !== 'reply') return { status: 'completed', replies: [{ id: input.executionId, text: JSON.stringify({ action: 'reply', reason: 'unanswered_question', sourceMessageIds: [event(1, conversation).message_id], topicId: 'task', replyToSenderId: 'member-a' }) }] };
        const operation = new ExternalFiles(f.engine, input, signal).list(f.root, 'inspect files');
        await f.engine.outbox.tick();
        await delay(120);
        assert.equal(signal.aborted, false);
        f.advanceBy(125000);
        f.store.exec('UPDATE consumer_lock SET expires=? WHERE owner=?', f.store.clock() + 30000, f.store.owner);
        // Human confirmation is still inside its own configured window for this test.
        f.store.exec("UPDATE interactions SET expires=? WHERE state='pending'", f.store.clock() + 10000);
        f.approve(); await operation;
        didWork = true;
        return { status: 'completed', replies: [{ id: input.executionId + ':result', text: 'file task finished' }] };
      };
      f.store.ingest({ events: [event(1, conversation)], cursor: 1, truncated: false });
      await f.engine.pump(); await f.engine.drain();
      assert.equal(didWork, true);
      assert.equal(f.store.one("SELECT state FROM runs WHERE purpose='reply'")!.state, 'completed');
      assert.ok(f.store.one("SELECT id FROM outbox WHERE json_extract(body,'$.text')='file task finished'"));
      f.bridge.page = { events: [], cursor: 1, truncated: false };
      await f.engine.tick();
      assert.ok(f.bridge.posts.some(body => JSON.parse(body).text === 'file task finished'));
    } finally { await f.close(); }
  }
});

test('denial, expiry, cancellation and origin reset perform no external write', async () => {
  for (const mode of ['deny', 'expire', 'cancel', 'reset', 'approver-reset']) {
    const f = fixture();
    try {
      new Sandbox(f.root, f.session.key).write('result.txt', 'never write');
      const target = join(f.root, 'denied.txt');
      const pending = f.external.write(target, 'result.txt', 'test permission');
      const rejection = assert.rejects(pending);
      if (mode === 'deny') f.approve('deny');
      if (mode === 'expire') f.advance();
      if (mode === 'cancel') f.controller.abort();
      if (mode === 'reset') { f.store.exec('UPDATE session_map SET generation=generation+1 WHERE key=?', f.session.key); f.approve(); }
      if (mode === 'approver-reset') { const approval = f.approve(); f.store.exec('UPDATE session_map SET generation=generation+1 WHERE key=?', approval.route); }
      await rejection;
      assert.equal(existsSync(target), false);
      assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='pending'")!.n, 0);
    } finally { await f.close(); }
  }
});

test('actual execution timeout is reported as turn_timeout rather than source expiry', async () => {
  const f = fixture();
  try {
    f.engine.config.runtime.turnTimeoutSeconds = .02;
    f.engine.host.execute = async input => {
      await delay(80);
      return { status: 'completed', replies: [{ id: input.executionId, text: 'too late' }] };
    };
    f.store.ingest({ events: [event(1, 'contact-b')], cursor: 1, truncated: false });
    await f.engine.pump(); await f.engine.drain();
    const result = JSON.parse(f.store.one("SELECT result FROM runs WHERE purpose='reply'")!.result);
    assert.equal(result.status, 'cancelled');
    assert.equal(result.cancellationReason, 'turn_timeout');
    assert.equal(f.store.one("SELECT count(*) n FROM outbox WHERE json_extract(body,'$.text')='too late'")!.n, 0);
  } finally { await f.close(); }
});

test('approved external paths still reject directory junctions', async () => {
  const f = fixture();
  try {
    const link = join(f.root, 'junction'); symlinkSync(join(f.root, 'prompts'), link, 'junction');
    const pending = f.external.list(link, 'list path'); f.approve();
    await assert.rejects(pending, /external_link_denied/);
  } finally { await f.close(); }
});

test('send_file freezes arbitrary sandbox files, keeps filename, scopes destination and deduplicates retry', async () => {
  const f = fixture();
  try {
    const sandbox = new Sandbox(f.root, f.session.key);
    sandbox.writeBytes('report.bin', Buffer.from([0, 255, 1, 3]));
    f.bridge.health = async () => ({ state: 'ready', send_ready: true, receive_ready: true, config: {
      conversations: [...f.store.config.access.direct.allow, ...f.store.config.access.group.allow],
      observe: { targets: ['*'], prefix: '' }, send: { recipients: [...f.store.config.access.direct.allow, ...f.store.config.access.group.allow], text_bytes: 4096, media_roots: [join(f.root, 'data/sandbox')] },
    } });
    await f.engine.tick();
    const tool = channelTools(f.engine, f.input, f.controller.signal).find(t => t.name === 'send_file')!;
    await tool.execute({ path: 'report.bin' }, {} as ToolRunContext);
    await tool.execute({ path: 'report.bin' }, {} as ToolRunContext);
    sandbox.writeBytes('report.bin', Buffer.from([9]));
    const row = f.store.one("SELECT * FROM outbox WHERE kind='file'")!;
    const body = JSON.parse(row.body);
    assert.equal(body.recipient, 'group-a@chatroom');
    assert.ok(body.path.endsWith('report.bin'));
    assert.deepEqual([...readFileSync(body.path)], [0, 255, 1, 3]);
    assert.equal(f.store.one("SELECT count(*) n FROM outbox WHERE kind='file'")!.n, 1);
    await assert.rejects(tool.execute({ path: join(f.root, 'host.txt') }, {} as ToolRunContext), /sandbox_path_denied/);
    await assert.rejects(tool.execute({ path: 'report.bin', recipient: 'contact-b' }, {} as ToolRunContext));
    await f.engine.outbox.tick();
    assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'server_confirmed');
  } finally { await f.close(); }
});

test('enabled external access requires a configured allowed private approver', () => {
  assert.throws(() => config({ externalAccess: { enabled: true } }), /external_approver_not_allowed/);
  assert.throws(() => config({ externalAccess: { enabled: true, approver: 'stranger' } }), /external_approver_not_allowed/);
});
