import { test } from 'node:test';
import assert from 'node:assert/strict';
import { cpSync, mkdtempSync, rmSync, mkdirSync, writeFileSync, readFileSync, linkSync, symlinkSync } from 'node:fs';
import { join } from 'node:path';
import { tmpdir } from 'node:os';
import { StickerLibrary } from '../src/media/stickers.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { Engine } from '../src/engine.js';
import { Store } from '../src/storage/database.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput } from '../src/contracts.js';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import { config, event, now, agentRoot, FakeBridge, FakeHost } from './helpers.js';
import { pngFixture } from './media-helpers.js';

const gif = Buffer.from('R0lGODlhCAAGAIEAAP8AAAAAAAAAAAAAACH/C05FVFNDQVBFMi4wAwECAAAh+QQICAAAACwAAAAACAAGAAAIDgABCBxIsKDBgwgTDgwIACH5BAgMAAAALAAAAAAIAAYAgQAA/wAAAAAAAAAAAAgOAAEIHEiwoMGDCBMODAgAOw==', 'base64');
function fixture() {
  const root = mkdtempSync(join(tmpdir(), 'wechat-stickers-'));
  mkdirSync(join(root, 'data/stickers/开心'), { recursive: true });
  writeFileSync(join(root, 'data/stickers/开心/大笑.gif'), gif);
  writeFileSync(join(root, 'data/stickers/好耶.png'), pngFixture());
  writeFileSync(join(root, 'data/stickers/不是图片.png'), 'not an image');
  writeFileSync(join(root, 'data/stickers/说明.txt'), 'not an image');
  const c = { ...config({ egress: { sendArtifacts: true } }), root };
  return { root, c, library: new StickerLibrary(c), close: () => rmSync(root, { recursive: true, force: true }) };
}

test('directory stickers search names, paginate, ignore non-images, require listed IDs and pin selected bytes', () => {
  const f = fixture();
  try {
    const page = f.library.list(0, 1, '开心');
    assert.equal(page.items.length, 1); assert.equal(page.items[0]!.mime, 'image/gif');
    assert.equal(page.items[0]!.caption, '开心/大笑');
    assert.throws(() => f.library.read('f'.repeat(64)), /not_listed/);
    const selected = f.library.read(page.items[0]!.emoji_id);
    assert.deepEqual(selected.bytes, gif);
    writeFileSync(join(f.root, 'data/stickers/开心/大笑.gif'), 'changed after preview');
    assert.deepEqual(f.library.read(page.items[0]!.emoji_id).bytes, gif);
    const other = f.library.list(0, 10, '好耶').items[0]!;
    writeFileSync(join(f.root, 'data/stickers/好耶.png'), 'changed before selection');
    assert.throws(() => f.library.read(other.emoji_id), /changed/);
    assert.equal(f.library.list(99, 10).items.length, 0);
  } finally { f.close(); }
});

test('directory library rejects junctions and hardlinks, honors size/scan limits and empty/missing directories', () => {
  const f = fixture();
  try {
    const outside = join(f.root, 'outside'); mkdirSync(outside);
    writeFileSync(join(outside, 'private.png'), pngFixture());
    symlinkSync(outside, join(f.root, 'data/stickers/linked'), 'junction');
    linkSync(join(outside, 'private.png'), join(f.root, 'data/stickers/hardlink.png'));
    assert.equal(f.library.list().total, 2);
    f.c.stickers.directory = 'data/stickers/linked';
    assert.throws(() => f.library.list(), /path_denied/);
    f.c.stickers.directory = 'missing';
    assert.equal(f.library.list().total, 0);
    f.c.stickers.directory = 'data/stickers'; f.c.stickers.maxFiles = 1;
    assert.equal(f.library.list().truncated, true);
    f.c.stickers.enabled = false;
    assert.throws(() => f.library.list(), /disabled/);
  } finally { f.close(); }
});

test('local animated GIF queues a frozen image path, never calls account favorites, and uses the normal outbox', async () => {
  const f = fixture(); cpSync(join(agentRoot, 'prompts'), join(f.root, 'prompts'), { recursive: true });
  const store = new Store(f.c, ':memory:', () => now), bridge = new FakeBridge(), host = new FakeHost();
  const engine = new Engine(f.c, store, bridge, host, () => {});
  const kinds: string[] = [];
  const original = bridge.send.bind(bridge);
  Object.assign(bridge, { send: async (body: string, kind: string) => { kinds.push(kind); return original(body); },
    emojiFavorites: () => { throw Error('favorites_forbidden'); }, emojiPreview: () => { throw Error('favorites_forbidden'); } });
  engine.canSendArtifact = () => true;
  const session = store.session(normalize(event(1), f.c)!);
  const input: HostInput = { inputId: 'gif-run', executionId: 'gif-exec', session, purpose: 'reply', context: '', system: '', provider: 'mock', model: 'test' };
  const tools = channelTools(engine, input, new AbortController().signal);
  const run = (name: string, args: unknown) => tools.find(t => t.name === name)!.execute(args, {} as ToolRunContext);
  try {
    const list = await run('list_emojis', { query: '大笑' }) as any;
    const emoji_id = list.items[0].emoji_id;
    await assert.rejects(run('send_emoji', { emoji_id: 'a'.repeat(32) }));
    await assert.rejects(run('send_emoji', { emoji_id, recipient: 'contact-b' }));
    await run('send_emoji', { emoji_id }); await run('send_emoji', { emoji_id });
    const row = store.one('SELECT * FROM outbox')!, body = JSON.parse(row.body);
    assert.equal(row.kind, 'image'); assert.equal(body.recipient, 'contact-a');
    assert.ok(body.path.endsWith('.gif')); assert.deepEqual(readFileSync(body.path), gif);
    assert.equal(store.one('SELECT count(*) n FROM outbox')!.n, 1);
    writeFileSync(join(f.root, 'data/stickers/开心/大笑.gif'), 'changed');
    assert.deepEqual(readFileSync(body.path), gif);
    await engine.outbox.tick(); assert.deepEqual(kinds, ['image']);
  } finally { await engine.close(); f.close(); }
});
