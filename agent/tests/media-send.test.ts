import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync, readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { join } from 'node:path';
import { tmpdir } from 'node:os';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import type { HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import { Sandbox } from '../src/runtime/sandbox.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { BridgeClient, BridgeError, type SendKind } from '../src/bridge/client.js';
import { pngFixture } from './media-helpers.js';
import { AttachmentId } from '@deepseek-ai/dsh-attachment';

async function fixture(enabled = true) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-media-send-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  mkdirSync(join(root, 'data/stickers'), { recursive: true });
  writeFileSync(join(root, 'data/stickers/开心.png'), pngFixture());
  const c = { ...config({ egress: { sendArtifacts: enabled }, media: { maxImagesPerReply: 1 } }), root };
  const store = new Store(c, ':memory:', () => now);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const bridge = new FakeBridge(), kinds: SendKind[] = [];
  const original = bridge.send.bind(bridge), health = await bridge.health();
  bridge.health = async () => ({ ...health, config: { ...health.config, send: { ...health.config.send, media_roots: [join(root, 'data/sandbox')] } } });
  Object.assign(bridge, { send: async (body: string, kind: SendKind) => { kinds.push(kind); return original(body); },
    emojiFavorites: async (offset: number, limit: number) => ({ offset, limit, total: 1, items: [{ emoji_id: 'a'.repeat(32), caption: 'hello' }] }),
    emojiPreview: async () => pngFixture() });
  const host = Object.assign(new FakeHost(), { imageAttachment: async () => ({ attachmentId: AttachmentId('a'.repeat(64)), bytes: pngFixture().length, mediaType: 'image/png' as const, width: 2, height: 2 }) });
  const engine = new Engine(c, store, bridge, host, () => {});
  await engine.tick();
  const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
  const input: HostInput = { session, inputId: 'send-run', executionId: 'send-exec', purpose: 'reply', system: '', context: '', provider: 'mock', model: 'test' };
  const tools = channelTools(engine, input, new AbortController().signal);
  const run = (name: string, args: unknown) => tools.find(t => t.name === name)!.execute(args, {} as ToolRunContext);
  return { root, store, engine, bridge, kinds, session, tools, run, sandbox: new Sandbox(root, session.key),
    close: async () => { await engine.close(); assert.ok(root.startsWith(join(tmpdir(), 'wechat-media-send-'))); rmSync(root, { recursive: true, force: true }); } };
}

test('native image/video sends freeze bytes, fix destination, deduplicate and record history through outbox', async () => {
  const f = await fixture();
  try {
    const png = pngFixture(), mp4 = Buffer.from('0000ftypisom');
    f.sandbox.writeBytes('photo.png', png); f.sandbox.writeBytes('clip.mp4', mp4);
    await f.run('send_image', { path: 'photo.png' });
    await f.run('send_image', { path: 'photo.png' });
    // One resource may be queued in two formats; confirmation must keep the other reference pinned.
    await f.run('send_file', { path: 'photo.png' });
    await f.run('send_video', { path: 'clip.mp4' });
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 3);
    const image = f.store.one("SELECT * FROM outbox WHERE kind='image'")!;
    const body = JSON.parse(image.body);
    assert.equal(body.recipient, 'group-a@chatroom');
    f.sandbox.writeBytes('photo.png', Buffer.from('changed'));
    assert.deepEqual(readFileSync(body.path), png);
    await assert.rejects(f.run('send_video', { path: 'photo.png' }), /video_format_unsupported/);
    await assert.rejects(f.run('send_image', { path: '../photo.png' }), /denied/);
    await assert.rejects(f.run('send_image', { path: 'photo.png', recipient: 'contact-b' }));
    await assert.rejects(f.run('send_image', { path: 'clip.mp4' }), /image_format_unsupported/);
    await f.engine.outbox.tick();
    assert.deepEqual(f.kinds, ['image', 'file', 'video']);
    assert.deepEqual(f.store.timeline(f.session.key).map(r => r.message.kind), ['image', 'file', 'video']);
    assert.equal(f.store.one('SELECT sum(refs) n FROM artifacts')!.n, 0);
  } finally { await f.close(); }
});

test('bot directory catalog, visual preview and image send replace account favorites', async () => {
  const f = await fixture();
  try {
    Object.assign(f.bridge, { emojiFavorites: async () => { throw Error('favorites_must_not_be_used'); },
      emojiPreview: async () => { throw Error('favorites_must_not_be_used'); } });
    const catalog = await f.run('list_emojis', { offset: 0, limit: 10, query: '开心' }) as any;
    const emoji_id = catalog.items[0].emoji_id;
    assert.equal(emoji_id.length, 64);
    assert.equal(catalog.items[0].caption, '开心');
    assert.equal((await f.run('preview_emoji', { emoji_id }) as any).attachment.mediaType, 'image/png');
    await assert.rejects(f.run('preview_emoji', { emoji_id }), /image_read_limit/);
    await assert.rejects(f.run('send_emoji', { emoji_id: '../bad' }));
    await f.run('send_emoji', { emoji_id }); await f.run('send_emoji', { emoji_id });
    const row = f.store.one('SELECT * FROM outbox')!;
    assert.equal(row.kind, 'image');
    const body = JSON.parse(row.body);
    assert.equal(body.recipient, 'group-a@chatroom'); assert.ok(body.path.endsWith('.png')); assert.equal(body.emoji_id, undefined);
    assert.deepEqual(readFileSync(body.path), pngFixture());
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 1);
    await f.engine.outbox.tick(); assert.deepEqual(f.kinds, ['image']);
    assert.equal(f.store.timeline(f.session.key)[0]!.message.kind, 'image');
  } finally { await f.close(); }
});

test('lost native send response reconciles without duplicate POST and cancellation unpins unsent media', async () => {
  const f = await fixture();
  try {
    f.sandbox.writeBytes('photo.png', pngFixture());
    await f.run('send_image', { path: 'photo.png' });
    f.bridge.lostResponse = true;
    await f.engine.outbox.tick(); await f.engine.outbox.tick();
    assert.deepEqual(f.kinds, ['image']);
    assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'server_confirmed');
    await f.run('send_file', { path: 'photo.png' });
    assert.equal(f.store.one('SELECT refs FROM artifacts')!.refs, 1);
    await f.engine.outbox.cancel(f.session.key);
    assert.equal(f.store.one("SELECT state FROM outbox WHERE kind='file'")!.state, 'cancelled');
    assert.equal(f.store.one('SELECT refs FROM artifacts')!.refs, 0);
  } finally { await f.close(); }
});

test('media send tools honor delivery switch and bridge root policy; rejected sends release resource', async () => {
  const off = await fixture(false);
  try { assert.ok(!off.tools.some(t => ['send_image', 'send_video', 'send_emoji', 'list_emojis', 'preview_emoji'].includes(t.name))); }
  finally { await off.close(); }
  const f = await fixture();
  try {
    f.sandbox.writeBytes('photo.png', pngFixture());
    f.engine.canSendArtifact = () => false;
    assert.equal((await f.run('send_image', { path: 'photo.png' }) as any).status, 'bridge_media_root_not_allowed');
    assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 0);
    f.engine.canSendArtifact = () => true;
    await f.run('send_image', { path: 'photo.png' });
    f.bridge.send = async () => { throw new BridgeError('image_format_not_allowed', 400); };
    await f.engine.outbox.tick();
    assert.equal(f.store.one('SELECT state FROM outbox')!.state, 'failed');
    assert.equal(f.store.one('SELECT refs FROM artifacts')!.refs, 0);
  } finally { await f.close(); }
});

test('GIF native failures and unknown results do not resend or fall back and keep normal artifact ownership', async () => {
  const gif = Buffer.from('R0lGODlhCAAGAIEAAP8AAAAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwECAAAh+QQICAAAACwAAAAACAAGAAAIDgABCBxIsKDBgwgTDgwIACH5BAgMAAAALAAAAAAIAAYAgQAA/wAAAAAAAAAAAAgOAAEIHEiwoMGDCBMODAgAOw==', 'base64');
  for (const state of ['failed', 'unknown']) {
    const f = await fixture();
    try {
      f.sandbox.writeBytes('animation.gif', gif);
      await f.run('send_image', { path: 'animation.gif' });
      await f.run('send_image', { path: 'animation.gif' });
      const kinds: SendKind[] = [];
      f.bridge.send = async (body: string, kind: SendKind = 'text') => {
        kinds.push(kind);
        const request = JSON.parse(body);
        assert.equal(request.recipient, 'group-a@chatroom');
        assert.deepEqual(readFileSync(request.path), gif);
        return { request_id: request.request_id, state, error_code: 'native_send_failed', delivery_verified: false };
      };
      await f.engine.outbox.tick(); await f.engine.outbox.tick();
      assert.deepEqual(kinds, ['image']); // stable /send/image contract; bridge selects native emoji
      assert.equal(f.store.one('SELECT count(*) n FROM outbox')!.n, 1);
      const row = f.store.one('SELECT state,result FROM outbox')!;
      assert.equal(row.state, state);
      assert.equal(JSON.parse(row.result).error, 'native_send_failed');
      assert.equal(f.store.one('SELECT refs FROM artifacts')!.refs, state === 'failed' ? 0 : 1);
    } finally { await f.close(); }
  }
});

test('bridge client routes native sends and authenticated catalog/preview requests including token refresh', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-media-http-'));
  try {
    const sessionFile = join(root, 'bridge.json');
    writeFileSync(sessionFile, JSON.stringify({ url: 'http://127.0.0.1:12345', token: 'old' }));
    const calls: string[] = []; let refresh = true;
    const client = new BridgeClient({ ...config(), root, bridge: { ...config().bridge, sessionFile } }, async (url, init) => {
      const path = new URL(String(url)).pathname; calls.push(path);
      assert.match((init!.headers as any).Authorization, /^Bearer (old|new)$/);
      if (path.endsWith('/content')) {
        if (refresh) { refresh = false; writeFileSync(sessionFile, JSON.stringify({ url: 'http://127.0.0.1:12345', token: 'new' })); return new Response('{}', { status: 401 }); }
        assert.equal((init!.headers as any).Authorization, 'Bearer new'); return new Response(new Uint8Array(pngFixture()));
      }
      return new Response(JSON.stringify({ items: [] }));
    });
    for (const kind of ['image', 'video', 'emoji'] as const) await client.send('{}', kind);
    await client.emojiFavorites(0, 20, new AbortController().signal);
    assert.deepEqual(await client.emojiPreview('a'.repeat(32), new AbortController().signal), pngFixture());
    assert.deepEqual(calls.slice(0, 4), ['/send/image', '/send/video', '/send/emoji', '/emoji/favorites']);
    assert.equal(calls.length, 6);
    await assert.rejects(client.emojiPreview('../bad', new AbortController().signal), /invalid_emoji_id/);
  } finally { assert.ok(root.startsWith(join(tmpdir(), 'wechat-media-http-'))); rmSync(root, { recursive: true, force: true }); }
});
