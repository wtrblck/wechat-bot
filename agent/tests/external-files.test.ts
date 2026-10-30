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
    close: async () => { controller.abort(); await engine.close(); const r = relative(tmpdir(), root); assert.ok(r && !r.startsWith('..') && !isAbsolute(r)); rmSync(root, { recursive: true, force: true }); } };
}

test('external write binds exact bytes, target and approver; consumes once and records permission chat context', async () => {
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
    assert.ok(f.store.timeline(contact.key).some(r => r.message.text.includes('/bot allow ' + row.id)));
    f.bridge.page = { events: [event(20, 'contact-a', '/bot allow ' + row.id, { sender: 'contact-a' })], cursor: 20, truncated: false };
    await f.engine.tick();
    await pending;
    assert.equal(readFileSync(target, 'utf8'), 'approved original');
    assert.equal(f.store.one('SELECT state FROM interactions WHERE id=?', row.id)!.state, 'consumed');
    assert.equal(f.engine.interactions.settle(contact, 'contact-a', row.id, 'allow', 'approval'), false);
    assert.ok(f.store.timeline(contact.key).some(r => r.message.direction === 'incoming' && r.message.text.includes('/bot allow ' + row.id)));
    const audit = JSON.parse(f.store.one('SELECT value FROM metadata WHERE key=?', 'external_operation:' + row.id)!.value);
    assert.equal(audit.status, 'completed');
  } finally { await f.close(); }
});

test('external reads/listing require approval and return only the specified file or directory', async () => {
  const f = fixture();
  try {
    const target = join(f.root, 'host-file.txt'); writeFileSync(target, 'host contents');
    const pending = f.external.read(target, 'read requested file');
    assert.equal(f.store.one('SELECT count(*) n FROM artifacts')!.n, 0);
    f.approve();
    const result = await pending;
    assert.equal(result.text, 'host contents');
    assert.equal(new Sandbox(f.root, f.session.key).read(result.path), 'host contents');
    const listing = f.external.list(f.root, 'find requested file'); f.approve();
    assert.ok((await listing).files.some(x => x.name === 'host-file.txt'));
    for (const path of ['relative.txt', '\\\\server\\share\\x', 'E:\\x:secret', 'E:\\CON']) await assert.rejects(f.external.read(path, 'invalid'), /external_path_denied/);
  } finally { await f.close(); }
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
