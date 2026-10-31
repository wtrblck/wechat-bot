import { test } from 'node:test';
import assert from 'node:assert/strict';
import { existsSync, readFileSync, rmSync, readdirSync } from 'node:fs';
import { join } from 'node:path';
import { randomUUID, createHash } from 'node:crypto';
import { platformUrl, videoDownload } from '../src/media/video-network.js';
import { VideoService, videoWorker } from '../src/media/video.js';
import { bilibiliVideo } from '../src/media/bilibili.js';
import { douyinVideo } from '../src/media/douyin.js';
import { Resources } from '../src/media/resources.js';
import { Store } from '../src/storage/database.js';
import { Sandbox } from '../src/runtime/sandbox.js';
import { normalize } from '../src/ingress/normalizer.js';
import { channelTools } from '../src/tools/channel-tools.js';
import { Engine } from '../src/engine.js';
import { config, agentRoot, event, now, FakeBridge, FakeHost } from './helpers.js';
import type { ToolRunContext } from '@deepseek-ai/dsh-tools';
import type { HostInput } from '../src/contracts.js';
import { AttachmentId } from '@deepseek-ai/dsh-attachment';

const fixture = readFileSync(join(agentRoot, '../weixin-research/fixtures/wxbot-video.mp4'));
const available = existsSync(join(agentRoot, 'tools/video-python/imageio_ffmpeg'));
const signal = () => AbortSignal.timeout(30000);
const c = () => config({ account: { key: 'video-' + randomUUID(), selfId: 'self', bridgeEpoch: 'test-source' }, media: { enabled: true }, video: { frames: 6 } });

test('platform URL normalization permits only single B站/抖音 videos and removes tracking', () => {
  assert.equal(platformUrl('BV1d8pU6xEZX', 'bilibili'), 'https://www.bilibili.com/video/BV1d8pU6xEZX');
  assert.equal(platformUrl('https://www.bilibili.com/video/BV1d8pU6xEZX?p=2&token=secret', 'bilibili'), 'https://www.bilibili.com/video/BV1d8pU6xEZX?p=2');
  assert.equal(platformUrl('https://www.douyin.com/?modal_id=6961737553342991651&tracking=secret', 'douyin'), 'https://www.douyin.com/video/6961737553342991651');
  assert.equal(platformUrl('https://www.iesdouyin.com/share/video/6961737553342991651/', 'douyin'), 'https://www.douyin.com/video/6961737553342991651');
  for (const value of ['http://www.douyin.com/video/6961737553342991651', 'https://douyin.com.evil.org/video/6961737553342991651',
    'https://www.douyin.com/user/123', 'file:///etc/passwd', 'https://127.0.0.1/video/123']) assert.throws(() => platformUrl(value, 'douyin'));
});

test('video downloader refuses mixed/private DNS and cancels a stalled DNS before HTTP', async () => {
  await assert.rejects(videoDownload('https://example.com/video.mp4', 1000, signal(), {}, async () => [
    { address: '93.184.216.34', family: 4 }, { address: '127.0.0.1', family: 4 }]), /private_address/);
  await assert.rejects(videoDownload('https://example.com/video.mp4', 1000, AbortSignal.timeout(5), {}, () => new Promise(() => {})), /timeout/i);
  await assert.rejects(videoDownload('file:///etc/passwd', 1000, signal()));
});

test('native Bilibili acquisition selects the requested P and bounded DASH streams without exposing credentials', async () => {
  const calls: string[] = [];
  const download = async (url: string) => {
    calls.push(url);
    return { url, mime: 'application/json', bytes: Buffer.from(JSON.stringify({ code: 0, data: calls.length === 1 ? {
      bvid: 'BV1d8pU6xEZX', title: 'test', pages: [{ cid: 10, duration: 1 }, { cid: 20, duration: 2 }], owner: { name: 'author' },
    } : { dash: { video: [{ baseUrl: 'https://cdn.example.com/1080', height: 1080, bandwidth: 200 },
      { baseUrl: 'https://cdn.example.com/480', height: 480, bandwidth: 100 }], audio: [{ baseUrl: 'https://cdn.example.com/audio', bandwidth: 20 }] } } })) };
  };
  const result = await bilibiliVideo(c(), 'https://www.bilibili.com/video/BV1d8pU6xEZX?p=2', signal(), download);
  assert.ok(calls[1]!.includes('cid=20')); assert.equal(result.duration, 2);
  assert.equal(result.streams[0]!.url, 'https://cdn.example.com/480'); assert.equal(result.streams[1]!.audioOnly, true);
  assert.equal(result.streams[0]!.headers.Cookie, undefined);
});

test('native Douyin parser accepts verified detail/share data, rejects mismatched IDs and never executes scripts', async () => {
  const id = '6961737553342991651', url = 'https://www.douyin.com/video/' + id;
  const item = { aweme_id: id, desc: 'test', author: { nickname: 'author' }, video: { duration: 2000,
    play_addr: { url_list: ['https://cdn.example.com/video.mp4'] } } };
  let calls = 0;
  const api = await douyinVideo(c(), url, signal(), async link => ({ url: link, mime: 'application/json',
    bytes: Buffer.from(JSON.stringify({ status_code: 0, aweme_detail: item })) }));
  assert.equal(api.duration, 2); assert.equal(api.streams[0]!.url, 'https://cdn.example.com/video.mp4');
  const shared = await douyinVideo(c(), url, signal(), async link => ({ url: link, mime: 'text/html',
    bytes: Buffer.from(++calls === 1 ? '{}' : '<script>window._ROUTER_DATA = ' + JSON.stringify({ loaderData: { video: { item_list: [item] } } }) + '</script>') }));
  assert.equal(shared.author, 'author'); assert.equal(calls, 2);
  await assert.rejects(douyinVideo(c(), url, signal(), async link => ({ url: link, mime: 'text/html',
    bytes: Buffer.from('<script>window._ROUTER_DATA = fetch("file:///secret")</script>') })), /platform_restricted/);
  await assert.rejects(douyinVideo(c(), url, signal(), async link => ({ url: link, mime: 'application/json',
    bytes: Buffer.from(JSON.stringify({ status_code: 0, aweme_detail: { ...item, aweme_id: '123' } })) })), /platform_restricted/);
});

test('WeChat native videos and file videos become hashed scoped resources; tampering, expiry and foreign sessions are rejected', async () => {
  const cfg = c(), store = new Store(cfg, ':memory:', () => now);
  const bridge = Object.assign(new FakeBridge(), { mediaMetadata: async () => ({ state: 'ready', name: 'movie.mp4',
    variants: { content: { size: fixture.length, mime: 'video/mp4', sha256: createHash('sha256').update(fixture).digest('hex') } } }), mediaContent: async () => fixture });
  const resources = new Resources(store, bridge);
  const message = normalize(event(1, 'contact-a', '[video]', { message_type: 'video', media: { id: 'test-video' } }), cfg)!;
  const session = store.session(message), sandbox = new Sandbox(cfg.root, session.key);
  try {
    for (const kind of ['video', 'file'] as const) {
      const descriptor = await resources.describe({ ...message, kind, messageId: kind }, signal());
      assert.equal(descriptor.format, 'video'); assert.equal(descriptor.readTool, 'video_storyboard');
      assert.deepEqual(resources.read(session.key, String(descriptor.resourceId)), fixture);
    }
    const saved = resources.video(session, fixture);
    assert.throws(() => resources.read('foreign', saved.resourceId), /denied/);
    store.exec('UPDATE artifacts SET expires=? WHERE id=?', now-1, saved.resourceId);
    assert.throws(() => resources.read(session.key, saved.resourceId), /expired/);
    cfg.video.maxInputMiB = 0; assert.throws(() => resources.video(session, fixture), /size/);
  } finally { await resources.close(); store.close(); rmSync(sandbox.root, { recursive: true, force: true }); }
});

test('real decoder produces time-addressed images and validates windows, containers and input duration', { skip: !available }, async () => {
  const cfg = c(), service = new VideoService(cfg, 'video-test-' + randomUUID());
  service.sandbox.writeBytes('movie.mp4', fixture); service.sandbox.write('playlist.mp4', '#EXTM3U\nfile:///private');
  try {
    const probe = await service.probe('movie.mp4', signal()); assert.equal(probe.duration, 1); assert.equal(probe.audio, false);
    const board = await service.board('movie.mp4', .1, .8, signal());
    assert.equal(board.manifest.cells.length, 6); assert.equal(board.bytes[0], 0xff);
    assert.ok(board.manifest.cells.every((cell: any) => cell.seconds >= .1 && cell.seconds < .8));
    assert.equal((await service.transcript('movie.mp4', 0, undefined, signal())).state, 'no_audio');
    await assert.rejects(service.board('movie.mp4', 5, 10, signal()), /window_invalid/);
    await assert.rejects(service.probe('playlist.mp4', signal()), /container/);
    await assert.rejects(service.probe('../escape.mp4', signal()), /path_denied/);
    cfg.video.maxDurationSeconds = .5; await assert.rejects(service.probe('movie.mp4', signal()), /duration_limit/);
  } finally { rmSync(service.sandbox.root, { recursive: true, force: true }); }
});

test('generic public video acquisition probes real bytes, strips signed queries and cleans temporary inputs after success/failure', { skip: !available }, async () => {
  const cfg = c(), service = new VideoService(cfg, 'video-download-test-' + randomUUID(), videoWorker,
    async url => ({ url, mime: 'video/mp4', bytes: fixture }));
  try {
    const result = await service.acquire('https://example.com/clip.mp4?signature=secret', 'direct', signal());
    assert.deepEqual(result.bytes, fixture); assert.equal(result.metadata.duration, 1);
    assert.equal(result.source, 'https://example.com/clip.mp4');
    assert.deepEqual(readdirSync(join(service.sandbox.root, 'video-work')), []);
    const bad = new VideoService(cfg, service.sandbox.scope, videoWorker, async url => ({ url, mime: 'text/html', bytes: Buffer.from('<html>login</html>') }));
    await assert.rejects(bad.acquire('https://example.com/clip.mp4', 'direct', signal()), /container/);
    assert.deepEqual(readdirSync(join(service.sandbox.root, 'video-work')), []);
  } finally { rmSync(service.sandbox.root, { recursive: true, force: true }); }
});

test('cancelling a video worker waits for subprocess exit and leaves slots reusable', { skip: !available }, async () => {
  const cfg = c();
  const controller = new AbortController();
  const pending = videoWorker(cfg, { action: 'health' }, controller.signal);
  const checked = assert.rejects(pending, /video_test_cancelled/);
  setTimeout(() => controller.abort(Error('video_test_cancelled')), 25);
  await checked;
  const result = await videoWorker(cfg, { action: 'health' }, signal());
  assert.equal(result.ffmpeg, true);
});

test('video tools enforce image quota, session generation, expiry, zoom window and proactive/disabled boundaries', { skip: !available }, async () => {
  const cfg = c(), store = new Store(cfg, ':memory:', () => now);
  const host = Object.assign(new FakeHost(), { imageAttachment: async () => ({ attachmentId: AttachmentId('test-image'), bytes: 1000, width: 1152, height: 484, mediaType: 'image/jpeg' as const }) });
  const engine = new Engine(cfg, store, new FakeBridge(), host, () => {});
  const session = store.session(normalize(event(1), cfg)!);
  const input: HostInput = { inputId: randomUUID(), executionId: randomUUID(), session, purpose: 'reply', context: '{}', system: '', provider: 'mock', model: 'test' };
  const sandbox = new Sandbox(cfg.root, session.key), saved = engine.resources.video(session, fixture);
  const tools = channelTools(engine, input, signal());
  const run = (name: string, args: unknown) => tools.find(t => t.name === name)!.execute(args, {} as ToolRunContext);
  try {
    await assert.rejects(run('video_zoom', { path: saved.path }), /window_required/);
    await assert.rejects(run('video_probe', { path: saved.path, command: 'bad' }));
    cfg.media.maxImagesPerReply = 1;
    const result: any = await run('video_storyboard', { path: saved.path });
    assert.equal(result.manifest.cells.length, 6);
    const rendered: any = tools.find(t => t.name === 'video_storyboard')!.output.render({}, result);
    assert.equal(rendered[1].type, 'image');
    await assert.rejects(run('video_storyboard', { path: saved.path }), /image_read_limit/);
    assert.deepEqual(channelTools(engine, { ...input, proactive: true }, signal()), []);
    cfg.video.enabled = false; assert.ok(!channelTools(engine, input, signal()).some(t => t.name.startsWith('video_') || t.name.startsWith('fetch_bilibili')));
    cfg.video.enabled = true;
    store.exec('UPDATE session_map SET generation=generation+1 WHERE key=?', session.key);
    await assert.rejects(run('video_probe', { path: saved.path }), /generation_changed/);
  } finally { await engine.close(); rmSync(sandbox.root, { recursive: true, force: true }); }
});
