import { spawn, execFile } from 'node:child_process';
import { readFileSync, lstatSync, existsSync, unlinkSync } from 'node:fs';
import { resolve } from 'node:path';
import { randomUUID } from 'node:crypto';
import type { Config } from '../config.js';
import { Sandbox } from '../runtime/sandbox.js';
import { platformUrl, videoDownload, type VideoPlatform } from './video-network.js';
import { bilibiliVideo } from './bilibili.js';
import { douyinVideo } from './douyin.js';

let active = 0;
export type VideoWorker = (config: Config, args: Record<string, unknown>, signal: AbortSignal) => Promise<any>;
export const videoWorker: VideoWorker = async (config, args, parent) => {
  if (active >= 2) throw Error('video_worker_busy');
  active++;
  try {
    const signal = AbortSignal.any([parent, AbortSignal.timeout(config.video.timeoutSeconds * 1000)]);
    signal.throwIfAborted();
    return await new Promise((resolveResult, reject) => {
      const pythonArgs = config.video.python === 'py' ? ['-3.14'] : [];
      const child = spawn(config.video.python, [...pythonArgs, resolve(config.root, 'scripts/video-worker.py')],
        { cwd: config.root, windowsHide: true, stdio: ['pipe', 'pipe', 'pipe'], env: { ...process.env, PYTHONIOENCODING: 'utf-8' } });
      const chunks: Buffer[] = []; let length = 0;
      let stopping: Error | undefined;
      const stop = () => {
        if (stopping) return;
        stopping = signal.reason ?? Error('video_worker_output_limit');
        if (process.platform === 'win32' && child.pid) execFile('taskkill', ['/PID', String(child.pid), '/T', '/F'], { windowsHide: true }, () => {});
        else child.kill('SIGKILL');
        // Wait for close before releasing the worker slot or deleting files locked by FFmpeg.
      };
      signal.addEventListener('abort', stop, { once: true });
      child.stdout.on('data', (chunk: Buffer) => { length += chunk.length; if (length > 6 * 1024 * 1024) stop(); else chunks.push(chunk); });
      child.stderr.on('data', () => {}); // Extractor diagnostics may contain signed URLs. Never log them.
      child.on('error', error => { signal.removeEventListener('abort', stop); reject(error); });
      child.on('close', code => {
        signal.removeEventListener('abort', stop);
        if (stopping) { reject(stopping); return; }
        try { const result = JSON.parse(Buffer.concat(chunks).toString('utf8'));
          if (code || result.error) reject(Error(result.error ?? 'video_worker_failed')); else resolveResult(result);
        } catch { reject(Error('video_worker_failed')); }
      });
      child.stdin.on('error', () => {}); child.stdin.end(JSON.stringify(args));
      if (signal.aborted) stop();
    });
  } finally { active--; }
};

export class VideoService {
  readonly sandbox: Sandbox;
  constructor(readonly config: Config, scope: string, readonly worker: VideoWorker = videoWorker,
    readonly download = videoDownload) { this.sandbox = new Sandbox(config.root, scope); }
  private source(path: string) {
    const source = this.sandbox.path(path), info = lstatSync(source);
    if (!info.size || info.size > this.config.video.maxInputMiB * 1024 * 1024) throw Error('video_size_limit');
    return source;
  }
  async probe(path: string, signal: AbortSignal) {
    return { path, ...await this.worker(this.config, { action: 'probe', path: this.source(path), maxDuration: this.config.video.maxDurationSeconds }, signal) };
  }
  async board(path: string, from: number, to: number | undefined, signal: AbortSignal, detail = false) {
    const source = this.source(path);
    const result = await this.worker(this.config, { action: 'board', path: source, from, ...(to !== undefined ? { to } : {}),
      maxDuration: this.config.video.maxDurationSeconds, frames: this.config.video.frames, detail }, signal);
    const { image, ...manifest } = result;
    return { manifest: { path, ...manifest }, bytes: Buffer.from(image, 'base64') };
  }
  async transcript(path: string, from: number, to: number | undefined, signal: AbortSignal) {
    return this.worker(this.config, { action: 'transcribe', path: this.source(path), from,
      ...(to !== undefined ? { to } : {}), maxDuration: this.config.video.maxDurationSeconds,
      ...this.config.video.asr, localModel: resolve(this.config.root, this.config.video.asr.localModel), embedded: true }, signal);
  }
  async acquire(value: string, platform: VideoPlatform | 'direct', signal: AbortSignal) {
    const max = this.config.video.maxInputMiB * 1024 * 1024;
    const bounded = AbortSignal.any([signal, AbortSignal.timeout(this.config.video.timeoutSeconds * 1000)]);
    let info: any = { title: '', author: '', description: '' }, streams: { url: string; headers?: Record<string, string>; audioOnly?: boolean }[];
    let url = value;
    if (platform === 'direct') streams = [{ url }];
    else {
      if (!this.config.video[platform]) throw Error('video_platform_disabled');
      url = platformUrl(value, platform);
      // Resolve short links through the same public-only downloader before invoking a specific extractor.
      if (['b23.tv', 'v.douyin.com'].includes(new URL(url).hostname)) {
        const page = await this.download(url, 2 * 1024 * 1024, bounded);
        url = platformUrl(page.url, platform);
        if (['b23.tv', 'v.douyin.com'].includes(new URL(url).hostname)) throw Error('video_short_link_unresolved');
      }
      const cookies = resolve(this.config.root, platform === 'bilibili' ? this.config.video.bilibiliCookies : this.config.video.douyinCookies);
      {
        try { info = await (platform === 'bilibili' ? bilibiliVideo : douyinVideo)(this.config, url, bounded, this.download); }
        catch (nativeError) {
          bounded.throwIfAborted();
          try { info = await this.worker(this.config, { action: 'extract', platform, url,
            ...(existsSync(cookies) ? { cookies } : {}), maxDuration: this.config.video.maxDurationSeconds }, bounded); }
          catch (extractError) {
            bounded.throwIfAborted();
            const safe = (e: unknown) => e instanceof Error && /^[a-zA-Z_]+$/.test(e.message) ? e.message : 'network_or_platform_error';
            throw Error(platform + '_fetch_failed:' + safe(nativeError) + ':' + safe(extractError));
          }
        }
      }
      streams = info.streams;
    }
    if (!Array.isArray(streams) || !streams.length || streams.length > 2) throw Error('video_stream_missing');
    let used = 0; const temporary: string[] = [];
    try {
      const paths = [];
      for (const stream of streams) {
        const response = await this.download(stream.url, max - used, bounded, stream.headers);
        used += response.bytes.length;
        const name = 'video-work/' + randomUUID() + '.bin';
        this.sandbox.writeBytes(name, response.bytes, max); temporary.push(name); paths.push(name);
      }
      let output = paths[0]!;
      if (paths.length === 2) {
        const video = streams[0]!.audioOnly ? paths[1]! : paths[0]!;
        const audio = streams[0]!.audioOnly ? paths[0]! : paths[1]!;
        output = 'video-work/' + randomUUID() + '.mp4'; temporary.push(output);
        await this.worker(this.config, { action: 'merge', video: this.sandbox.path(video), audio: this.sandbox.path(audio),
          output: this.sandbox.path(output, true), maxBytes: max }, bounded);
        if (lstatSync(this.sandbox.path(output)).size >= max) throw Error('video_merge_size_limit');
      }
      const metadata = await this.probe(output, bounded);
      let captions: Record<string, unknown> | undefined;
      const languages = Object.entries(info.subtitles ?? {}).sort(([a], [b]) => Number(!/^zh|^ai-zh/.test(a)) - Number(!/^zh|^ai-zh/.test(b)));
      const [language, tracks] = languages[0] ?? [];
      const track = Array.isArray(tracks) ? tracks.find((t: any) => ['json', 'srt', 'vtt', 'json3', 'bcc'].includes(t.ext)) : undefined;
      if (track?.url) {
        try {
          const page = await this.download(track.url, 1024 * 1024, bounded);
          const raw = page.bytes.toString('utf8');
          let text = raw;
          if (['json', 'json3', 'bcc'].includes(track.ext)) {
            const data = JSON.parse(raw);
            text = Array.isArray(data.body) ? data.body.slice(0, 500).map((s: any) => `[${s.from}-${s.to}] ${s.content}`).join('\n') : '';
          }
          if (text) captions = { language, text: text.slice(0, 16000), truncated: text.length > 16000, source: 'platform_subtitles' };
        } catch { bounded.throwIfAborted(); /* Caption failure does not discard a valid video. */ }
      }
      return { bytes: readFileSync(this.sandbox.path(output)), metadata: { ...metadata, path: undefined },
        source: platform === 'direct' ? new URL(url).origin + new URL(url).pathname : url,
        title: info.title, author: info.author, description: info.description, captions,
        note: '已获取文件和平台资料，尚未理解画面；继续调用video_storyboard，台词用video_transcript。' };
    } finally { for (const name of temporary) { try { unlinkSync(this.sandbox.path(name)); } catch {} } }
  }
}
