import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync, readFileSync, writeFileSync, existsSync } from 'node:fs';
import { join, relative, isAbsolute } from 'node:path';
import { tmpdir } from 'node:os';
import { createHash } from 'node:crypto';
import { createServer } from 'node:http';
import { Store } from '../src/storage/database.js';
import { Resources } from '../src/media/resources.js';
import { Engine } from '../src/engine.js';
import { Memory } from '../src/memory/memory.js';
import { BridgeClient } from '../src/bridge/client.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { normalize } from '../src/ingress/normalizer.js';
import { decodeText } from '../src/media/file-types.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';
import { pngFixture } from './media-helpers.js';
import type { HostInput } from '../src/contracts.js';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { AttachmentId } from '@deepseek-ai/dsh-attachment';

const sha = (b: Uint8Array) => createHash('sha256').update(b).digest('hex');
function fixture(bytes: Buffer, name: string, mime = 'application/octet-stream') {
  const root = mkdtempSync(join(tmpdir(), 'wechat-media-v2-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const c = { ...config({ media: { enabled: true } }), root }, store = new Store(c, ':memory:', () => now);
  store.ingest({ events: [], cursor: 0, truncated: false });
  let reads = 0;
  const bridge = Object.assign(new FakeBridge(), { config: c,
    mediaMetadata: async () => ({ state: 'ready', name, variants: { content: { size: bytes.length, sha256: sha(bytes), mime } } }),
    mediaContent: async () => { reads++; return bytes; } });
  const resources = new Resources(store, bridge);
  const message = normalize(event(1, 'group-a@chatroom', '[file]', { message_type: 'file', media: { id: 'media-1' } }), c)!;
  const session = store.session(message);
  return { root, c, store, bridge, resources, message, session, reads: () => reads,
    close: async () => { await resources.close(); store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); } };
}

test('image files are sniffed from bytes and copied into scoped sandbox with real extensions; descriptors survive followups', async () => {
  const bytes = pngFixture(), f = fixture(bytes, '../../picture.bin');
  try {
    f.store.ingest({ cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '[file]', { message_type: 'file', media: { id: 'media-1' } })] });
    const result = await f.resources.describe(f.message, new AbortController().signal);
    assert.equal(result.format, 'image'); assert.equal(result.mime, 'image/png');
    assert.match(String(result.path), /^media\/[a-f0-9]{64}\.png$/);
    const path = join(f.root, 'data/sandbox', f.session.key, String(result.path));
    assert.deepEqual(readFileSync(path), bytes);
    assert.equal(result.extractedText, undefined); assert.ok(!isAbsolute(String(result.path)));
    assert.equal((new Memory(f.store).source(f.message).attachment as any).path, result.path);
    await f.resources.describe(f.message, new AbortController().signal); assert.equal(f.reads(), 1);
    const foreign = f.store.session({ ...f.message, conversationId: 'group-b@chatroom' });
    assert.throws(() => f.resources.attachmentAt(foreign.key, String(result.path)), /denied/);
    writeFileSync(path, 'tampered'); assert.throws(() => f.resources.attachmentAt(f.session.key, String(result.path)), /changed/);
  } finally { await f.close(); }
});

test('text files remain byte-identical and use paged read_text_file rather than inline extraction', async () => {
  const bytes = Buffer.from('\ufeff中文日志\n' + '长内容'.repeat(10000)), f = fixture(bytes, 'chat.log');
  try {
    const descriptor = await f.resources.describe(f.message, new AbortController().signal);
    assert.equal(descriptor.format, 'text'); assert.equal(descriptor.readTool, 'read_text_file');
    assert.deepEqual(f.resources.read(f.session.key, String(descriptor.resourceId)), bytes);
    const first = f.resources.readText(f.session.key, String(descriptor.path), 0, 20);
    assert.equal(first.text.length, 20); assert.equal(first.nextOffset, 20); assert.equal(first.truncated, true);
    assert.equal(first.encoding, 'utf-8'); assert.ok(first.text.startsWith('中文日志'));
    assert.equal(f.resources.readText(f.session.key, String(descriptor.path), 20, 20).offset, 20);
    assert.equal(decodeText(Buffer.concat([Buffer.from([255,254]), Buffer.from('中文', 'utf16le')])).text, '中文');
    assert.equal(decodeText(Buffer.from([0xd6,0xd0,0xce,0xc4])).text, '中文');
    assert.throws(() => decodeText(Buffer.from([0,1,2,3])), /binary/);
  } finally { await f.close(); }
});

test('ordinary pictures and picture-typed files use the same image path; binary documents stay unsupported', async () => {
  for (const kind of ['image','file'] as const) {
    const f = fixture(pngFixture(), 'screen.png', 'image/png');
    try { assert.equal((await f.resources.describe({ ...f.message, kind }, new AbortController().signal)).format, 'image'); }
    finally { await f.close(); }
  }
  const f = fixture(Buffer.from('%PDF-1.7 example'), 'report.pdf', 'application/pdf');
  try {
    const value = await f.resources.describe(f.message, new AbortController().signal);
    assert.equal(value.state, 'unsupported'); assert.equal(value.path, undefined);
    assert.equal(f.store.one('SELECT count(*) n FROM artifacts')!.n, 0);
  } finally { await f.close(); }
});

test('real authenticated bridge HTTP bytes are copied; bridge paths and names never become host reads', async () => {
  const bytes = Buffer.from('来自桥接端的正文'), token = 'test-media-token'; let hits = 0;
  const server = createServer((req, res) => {
    if (req.headers.authorization !== 'Bearer ' + token) { res.writeHead(401).end('{}'); return; }
    if (req.url?.endsWith('/content?variant=content')) { hits++; res.writeHead(200).end(bytes); return; }
    res.setHeader('Content-Type', 'application/json'); res.end(JSON.stringify({ state: 'ready', name: '../note.txt',
      path: 'C:/secret-do-not-read', variants: { content: { size: bytes.length, sha256: sha(bytes), mime: 'text/plain' } } }));
  });
  await new Promise<void>(r => server.listen(0, '127.0.0.1', r));
  const f = fixture(bytes, 'unused');
  try {
    const address = server.address() as { port: number }, sessionFile = join(f.root, 'bridge.json');
    writeFileSync(sessionFile, JSON.stringify({ url: `http://127.0.0.1:${address.port}`, token }));
    const client = new BridgeClient({ ...f.c, bridge: { ...f.c.bridge, sessionFile } });
    const resources = new Resources(f.store, client);
    const descriptor = await resources.describe(f.message, new AbortController().signal);
    assert.equal(hits, 1); assert.match(String(descriptor.path), /^media\//);
    assert.equal(resources.readText(f.session.key, String(descriptor.path)).text, '来自桥接端的正文');
    await resources.close();
  } finally { await f.close(); await new Promise<void>(r => server.close(() => r())); }
});

test('later text replies retain prior sandbox attachment paths; pending or expired resources never masquerade as readable', async () => {
  const f = fixture(Buffer.from('先前的文件内容'), 'notes.txt');
  const host = new FakeHost(), engine = new Engine(f.c, f.store, f.bridge, host, () => {});
  try {
    f.store.ingest({ cursor: 1, truncated: false, events: [event(1, 'contact-a', '[file]', { message_type: 'file', media: { id: 'media-1' } })] });
    const m = normalize(event(1, 'contact-a', '[file]', { message_type: 'file', media: { id: 'media-1' } }), f.c)!;
    const descriptor = await engine.resources.describe(m, new AbortController().signal);
    f.store.exec("UPDATE inbox SET state='observed'");
    f.bridge.page = { cursor: 2, truncated: false, events: [event(2, 'contact-a', '/ai 刚才文件写了什么')] };
    await engine.tick(); await engine.drain();
    const input = host.calls.find(i => i.purpose === 'reply')!, context = JSON.parse(input.context);
    assert.equal(context.recent.find((m: any) => m.messageId === 'contact-a:1').attachment.path, descriptor.path);
    assert.ok(!input.context.includes('先前的文件内容'));
    const tools = channelTools(engine, input, new AbortController().signal), read = tools.find(t => t.name === 'read_text_file')!;
    assert.equal((await read.execute({ path: descriptor.path }, {} as ToolRunContext) as any).text, '先前的文件内容');
    await assert.rejects(read.execute({ path: '../secret.txt' }, {} as ToolRunContext), /denied/);
    f.store.exec('UPDATE artifacts SET expires=0');
    assert.equal(f.store.mediaDescriptor(input.session.key, m.messageId)!.state, 'expired');
    await assert.rejects(read.execute({ path: descriptor.path }, {} as ToolRunContext), /expired/);
  } finally { await engine.close(); await f.resources.close(); rmSync(f.root, { recursive: true, force: true }); }
});

test('background preparation and explicit preparation share one copy and respect cache TTL', async () => {
  const f = fixture(pngFixture(), 'screen.png', 'image/png');
  try {
    f.store.ingest({ cursor: 1, truncated: false, events: [event(1, 'group-a@chatroom', '[image]', { message_type: 'image', media: { id: 'media-1' } })] });
    f.resources.prefetch(); const value = await f.resources.describe({ ...f.message, kind: 'image' }, new AbortController().signal);
    assert.equal(f.reads(), 1); assert.equal(value.state, 'ready');
    const path = join(f.root, 'data/sandbox', f.session.key, String(value.path)); assert.ok(existsSync(path));
    f.store.exec('UPDATE artifacts SET expires=0'); f.resources.sweep();
    assert.equal(existsSync(path), false); assert.equal(f.store.mediaDescriptor(f.session.key, f.message.messageId)!.state, 'expired');
  } finally { await f.close(); }
});

test('shutdown cancels pending bridge preparation and never publishes a phantom sandbox path', async () => {
  const f = fixture(pngFixture(), 'pending.png', 'image/png');
  Object.assign(f.bridge, { mediaMetadata: async (_id: string, signal?: AbortSignal) => new Promise((_resolve, reject) => {
    signal!.addEventListener('abort', () => reject(signal!.reason), { once: true });
  }) });
  try {
    const pending = f.resources.describe(f.message, new AbortController().signal);
    await f.resources.close(); const value = await pending;
    assert.equal(value.state, 'unavailable'); assert.equal(value.path, undefined);
    assert.equal(f.store.one('SELECT count(*) n FROM artifacts')!.n, 0);
  } finally { await f.close(); }
});

test('parallel image tool calls cannot exceed the per-reply image allowance', async () => {
  const f = fixture(pngFixture(), 'photo.png', 'image/png'); f.c.media.maxImagesPerReply = 1;
  const host = Object.assign(new FakeHost(), { imageAttachment: async () => {
    await new Promise(r => setTimeout(r, 10));
    return { attachmentId: AttachmentId('a'.repeat(64)), mediaType: 'image/png' as const, bytes: 123, width: 2, height: 2 };
  } });
  const engine = new Engine(f.c, f.store, f.bridge, host, () => {});
  try {
    const descriptor = await engine.resources.describe(f.message, new AbortController().signal);
    const input: HostInput = { inputId: 'image-limit', executionId: 'image-exec', session: f.session,
      purpose: 'reply', system: '', context: '{}', provider: 'mock', model: 'test' };
    const tools = channelTools(engine, input, new AbortController().signal), image = tools.find(t => t.name === 'read_image')!;
    const values = await Promise.allSettled([image.execute({ path: descriptor.path }, {} as ToolRunContext), image.execute({ path: descriptor.path }, {} as ToolRunContext)]);
    assert.equal(values.filter(v => v.status === 'fulfilled').length, 1);
    assert.equal(values.filter(v => v.status === 'rejected').length, 1);
  } finally { await engine.close(); await f.resources.close(); rmSync(f.root, { recursive: true, force: true }); }
});
