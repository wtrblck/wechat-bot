import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync, writeFileSync, readFileSync, cpSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { config, event, now, agentRoot, FakeBridge, FakeHost } from './helpers.js';
import { conversationAccess, conversationEnabled, saveConversationAccess } from '../src/access.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import { Sandbox } from '../src/runtime/sandbox.js';
import { ExternalFiles } from '../src/runtime/external-files.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { createAdminServer } from '../src/admin/server.js';
import type { HostInput } from '../src/contracts.js';

function fixture(extra: Record<string, unknown> = {}) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-access-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const c = { ...config(extra), root };
  c.storage.file = 'data/agent.sqlite';
  const store = new Store(c, undefined, () => now);
  const bridge = new FakeBridge(), host = new FakeHost(), engine = new Engine(c, store, bridge, host, () => {});
  store.ingest({ events: [], cursor: 0, truncated: false });
  const session = store.session(normalize(event(1), c)!);
  const input: HostInput = { session, inputId: 'access-run', executionId: 'access-execution', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' };
  return { c, root, store, engine, bridge, host, input,
    close: async () => { await engine.close(); rmSync(root, { recursive: true, force: true }); } };
}

test('contact and group policies persist, isolate scopes, and corrupt policy fails closed', async () => {
  const f = fixture();
  try {
    assert.deepEqual(conversationAccess(f.c, 'contact-a'), { enabled: true, files: 'sandbox' });
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: false, files: 'any' });
    assert.equal(conversationEnabled({ ...f.c }, 'contact-a'), false);
    assert.equal(conversationEnabled(f.c, 'group-a@chatroom'), true);
    saveConversationAccess(f.c, { conversation: 'group-a@chatroom', enabled: true, files: 'any' });
    assert.equal(conversationAccess(f.c, 'group-a@chatroom').files, 'any');
    assert.equal(conversationAccess(f.c, 'contact-b').files, 'sandbox');
    writeFileSync(join(f.root, f.c.storage.file) + '.access.json', 'invalid');
    assert.equal(conversationEnabled(f.c, 'contact-b'), false);
  } finally { await f.close(); }
});

test('disabled conversations reject new input, pending input and prepared delivery', async () => {
  const f = fixture();
  try {
    f.store.ingest({ events: [event(1)], cursor: 1, truncated: false });
    f.store.prepareReply(f.input.session, 'draft', 'must not send');
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: false, files: 'sandbox' });
    f.store.ingest({ events: [event(2)], cursor: 2, truncated: false });
    await f.engine.pump(); await f.engine.drain(); await f.engine.outbox.tick();
    assert.equal(f.host.calls.length, 0); assert.equal(f.bridge.posts.length, 0);
    assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'cancelled');
    assert.equal(f.store.one('SELECT state FROM inbox WHERE sequence=2')!.state, 'ignored');
  } finally { await f.close(); }
});

test('disabling during model execution prevents its completed answer from being delivered', async () => {
  const f = fixture();
  try {
    f.host.hook = async () => { saveConversationAccess(f.c, { conversation: 'contact-a', enabled: false, files: 'sandbox' }); };
    f.store.ingest({ events: [event(1)], cursor: 1, truncated: false });
    await f.engine.pump(); await f.engine.drain(); await f.engine.outbox.tick();
    assert.equal(f.host.calls.length, 1);
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 0);
    assert.equal(f.bridge.posts.length, 0);
  } finally { await f.close(); }
});

test('switching legacy approval to sandbox cancels a pending host write without changing the target', async () => {
  const f = fixture({ externalAccess: { enabled: true, approver: 'contact-b', timeoutSeconds: 10 } });
  try {
    const target = join(f.root, 'target.txt'); writeFileSync(target, 'original');
    new Sandbox(f.root, f.input.session.key).write('result.txt', 'replacement');
    const external = new ExternalFiles(f.engine, f.input, new AbortController().signal);
    const pending = external.write(target, 'result.txt', 'save');
    assert.equal(f.store.one("SELECT count(*) n FROM interactions WHERE state='pending'")!.n, 1);
    saveConversationAccess(f.c, { conversation: 'contact-a', enabled: true, files: 'sandbox' });
    await assert.rejects(pending, /external_access_denied/);
    assert.equal(readFileSync(target, 'utf8'), 'original');
    assert.equal(f.store.one('SELECT state FROM interactions')!.state, 'invalidated');
  } finally { await f.close(); }
});

test('any-path grant permits host reads/writes without approval, sandbox/revocation blocks retained tools', async () => {
  const f = fixture();
  try {
    const target = join(f.root, 'host.txt'); writeFileSync(target, 'host text');
    const external = new ExternalFiles(f.engine, f.input, new AbortController().signal);
    await assert.rejects(external.read(target, 'read'), /external_access_denied/);
    for (const conversation of ['contact-a', 'group-a@chatroom']) {
      const session = f.store.session(normalize(event(2, conversation), f.c)!);
      const input = { ...f.input, session };
      saveConversationAccess(f.c, { conversation, enabled: true, files: 'any' });
      const files = new ExternalFiles(f.engine, input, new AbortController().signal);
      assert.equal((await files.read(target, 'read')).text, 'host text');
      const sandbox = new Sandbox(f.root, session.key); sandbox.write('result.txt', conversation);
      await files.write(target, 'result.txt', 'save');
      assert.equal(readFileSync(target, 'utf8'), conversation);
      assert.ok((await files.list(f.root, 'list')).files.some(file => file.name === 'host.txt'));
      assert.equal(f.store.one('SELECT count(*) n FROM interactions')!.n, 0);
      const retained = channelTools(f.engine, input, new AbortController().signal).find(tool => tool.name === 'external_read')!;
      saveConversationAccess(f.c, { conversation, enabled: true, files: 'sandbox' });
      await assert.rejects(Promise.resolve().then(() => retained.execute({ path: target, reason: 'read' }, {} as never)), /external_access_denied/);
      assert.ok(!channelTools(f.engine, input, new AbortController().signal).some(tool => tool.name === 'external_read'));
      writeFileSync(target, 'host text');
    }
  } finally { await f.close(); }
});

test('admin permission writes require same origin, capability and strict body; fresh config reads saved settings', async () => {
  const f = fixture();
  const { server } = createAdminServer(f.c, { staticRoot: join(agentRoot, 'admin-ui') });
  await new Promise<void>(resolve => server.listen(0, '127.0.0.1', resolve));
  const base = `http://127.0.0.1:${(server.address() as {port:number}).port}`;
  try {
    const data = await (await fetch(base + '/api/access')).json() as any;
    assert.ok(data.items.some((item: any) => item.conversation === 'contact-a'));
    const headers = { origin: base, 'Content-Type': 'application/json', 'X-Service-Token': data.token };
    const post = (body: unknown, h = headers) => fetch(base + '/api/access', { method: 'POST', headers: h, body: JSON.stringify(body) });
    const value = { conversation: 'contact-a', enabled: false, files: 'sandbox' };
    assert.equal((await post(value, { ...headers, origin: 'https://evil.example' })).status, 403);
    assert.equal((await post(value, { ...headers, 'X-Service-Token': '0'.repeat(64) })).status, 403);
    assert.equal((await post({ ...value, enabled: 'false' })).status, 400);
    assert.equal((await post({ ...value, files: 'unknown' })).status, 400);
    assert.equal((await post({ ...value, command: 'anything' })).status, 400);
    assert.equal((await post(value)).status, 200);
    assert.equal(conversationEnabled({ ...f.c }, 'contact-a'), false);
    assert.equal((await post({ conversation: 'new-group@chatroom', enabled: false, files: 'sandbox' })).status, 200);
    const updated = await (await fetch(base + '/api/access')).json() as any;
    assert.ok(updated.items.some((item: any) => item.conversation === 'new-group@chatroom' && !item.enabled));
  } finally {
    await new Promise<void>(resolve => { server.close(() => resolve()); server.closeAllConnections(); });
    await f.close();
  }
});
