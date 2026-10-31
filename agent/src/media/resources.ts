import { existsSync, readFileSync, unlinkSync, writeFileSync, lstatSync } from 'node:fs';
import { isAbsolute, relative, resolve } from 'node:path';
import { createHash } from 'node:crypto';
import { setTimeout as delay } from 'node:timers/promises';
import type { Bridge } from '../bridge/client.js';
import type { Message, Session } from '../contracts.js';
import { hash } from '../contracts.js';
import type { Store } from '../storage/database.js';
import { Sandbox } from '../runtime/sandbox.js';
import { imageType, videoType, textExtension, decodeText } from './file-types.js';

const digest = (bytes: Uint8Array) => createHash('sha256').update(bytes).digest('hex');
export class Resources {
  private readonly controller = new AbortController();
  private readonly preparing = new Map<string, Promise<Record<string, unknown>>>();
  constructor(readonly store: Store, readonly bridge: Bridge) {}
  video(session: Session, bytes: Buffer) {
    const config = this.store.config, format = videoType(bytes);
    if (!config.video.enabled || !format || !bytes.length || bytes.length > config.video.maxInputMiB * 1048576) throw Error('video_size_or_format_denied');
    this.sweep();
    const id = hash(['video', session.key, digest(bytes)]), name = 'media/' + id + '.' + format.extension;
    const existing = this.store.one('SELECT * FROM artifacts WHERE id=?', id);
    const total = Number(this.store.one('SELECT coalesce(sum(bytes),0) n FROM artifacts')!.n);
    if (total - Number(existing?.bytes ?? 0) + bytes.length > config.media.cacheMiB * 1048576) throw Error('media_cache_capacity');
    const path = new Sandbox(config.root, session.key).writeBytes(name, bytes, config.video.maxInputMiB * 1048576);
    this.store.exec('INSERT OR REPLACE INTO artifacts VALUES(?,?,?,?,?,?,?,?)', id, session.key, path, digest(bytes), format.mime, bytes.length,
      this.store.clock() + config.media.ttlHours * 3600000, existing?.refs ?? 0);
    return { path: name, resourceId: id, format: 'video', readTool: 'video_storyboard', bytes: bytes.length };
  }
  file(session: Session, eventId: string, name: string, bytes: Buffer) {
    if (!bytes.length || bytes.length > 10 * 1024 * 1024) throw Error('artifact_too_large_or_empty');
    const id = hash(['file', session.key, eventId, name, digest(bytes)]);
    const sandbox = new Sandbox(this.store.config.root, session.key);
    const path = sandbox.path('outgoing/' + id + '/' + name, true);
    const existing = this.store.one('SELECT * FROM artifacts WHERE id=?', id);
    if (existing) { this.read(session.key, id); return { id, path: existing.path as string }; }
    sandbox.writeBytes('outgoing/' + id + '/' + name, bytes);
    this.store.exec('INSERT INTO artifacts VALUES(?,?,?,?,?,?,?,0)', id, session.key, path, digest(bytes), 'application/octet-stream', bytes.length,
      this.store.clock() + this.store.config.media.ttlHours * 3600000);
    return { id, path };
  }
  artifact(session: Session, eventId: string, text: string) {
    const id = hash(['artifact', session.key, eventId]);
    const bytes = Buffer.from(text, 'utf8');
    if (bytes.length > 10 * 1024 * 1024) throw Error('artifact_too_large');
    const path = new Sandbox(this.store.config.root, session.key).path('artifacts/' + id + '.txt', true);
    const existing = this.store.one('SELECT * FROM artifacts WHERE id=?', id);
    if (existing) { if (existing.hash !== digest(bytes)) throw Error('artifact_conflict'); return { id, path: existing.path as string }; }
    if (existsSync(path)) { if (digest(readFileSync(path)) !== digest(bytes)) throw Error('artifact_conflict'); }
    else writeFileSync(path, bytes, { flag: 'wx', mode: 0o600 });
    this.store.exec('INSERT INTO artifacts VALUES(?,?,?,?,?,?,?,0)', id, session.key, path, digest(bytes), 'text/plain', bytes.length,
      this.store.clock() + this.store.config.media.ttlHours * 3600000);
    return { id, path };
  }
  read(route: string, id: string) {
    const row = this.store.one('SELECT * FROM artifacts WHERE id=? AND route=?', id, route);
    if (!row || row.expires < this.store.clock() && !row.refs) throw Error('resource_expired_or_denied');
    const path = this.controlledPath(row.path);
    const maximum = String(row.mime).startsWith('video/') ? this.store.config.video.maxInputMiB * 1048576 : 10 * 1048576;
    if (lstatSync(path).size !== row.bytes || row.bytes > maximum) throw Error('resource_changed');
    const bytes = readFileSync(path);
    if (bytes.length !== row.bytes || digest(bytes) !== row.hash) throw Error('resource_changed');
    return bytes;
  }
  controlledPath(path: string) {
    const base = resolve(this.store.config.root, 'data/sandbox');
    const rel = relative(base, path);
    if (!rel || rel.startsWith('..') || isAbsolute(rel)) throw Error('resource_path_denied');
    const [scope, ...parts] = rel.split(/[\\/]/);
    return new Sandbox(this.store.config.root, scope!).path(parts.join('/'));
  }
  private remember(message: Message, value: Record<string, unknown>) {
    const route = hash(['wechat', message.accountKey, message.scope, message.conversationId]);
    const descriptor = { messageId: message.messageId, ...value };
    this.store.exec('INSERT OR REPLACE INTO message_media VALUES(?,?,?,?,?)', route, message.messageId,
      typeof value.resourceId === 'string' ? value.resourceId : null, JSON.stringify(descriptor), this.store.clock());
    return descriptor;
  }
  describe(message: Message, signal: AbortSignal): Promise<Record<string, unknown>> {
    signal.throwIfAborted();
    if (!this.store.config.media.enabled) return Promise.resolve({ kind: message.kind, state: 'disabled', note: '媒体理解未启用，不推测内容。' });
    if (!['image', 'file', 'emoji', ...(this.store.config.video.enabled ? ['video'] : [])].includes(message.kind)) return Promise.resolve({ kind: message.kind, state: 'unsupported',
      note: message.kind === 'voice' ? '未配置 ASR，不能声称已识别语音。' : '此媒体类型未接入理解器。' });
    const route = hash(['wechat', message.accountKey, message.scope, message.conversationId]);
    const cached = this.store.mediaDescriptor(route, message.messageId);
    if (cached?.state === 'ready') {
      try { this.read(route, cached.resourceId); return Promise.resolve(cached); } catch { /* Recopy a changed/expired cache through the trusted bridge. */ }
    }
    const key = route + ':' + message.messageId;
    let job = this.preparing.get(key);
    if (!job) {
      this.remember(message, { kind: message.kind, state: 'pending', note: '附件正在复制到本会话沙箱。' });
      job = this.prepare(message, this.controller.signal)
        .then(value => this.remember(message, { ...value, ...(value.state !== 'ready' && value.state !== 'unsupported' ? { retryAfter: this.store.clock() + 60000 } : {}) }))
        .catch(() => this.remember(message, { kind: message.kind, state: 'unavailable', retryAfter: this.store.clock() + 60000,
          note: '附件准备失败或校验未通过，不能推测内容。' }))
        .finally(() => this.preparing.delete(key));
      this.preparing.set(key, job);
    }
    return new Promise((resolve, reject) => {
      const cancel = () => reject(signal.reason);
      signal.addEventListener('abort', cancel, { once: true });
      job!.then(resolve, reject).finally(() => signal.removeEventListener('abort', cancel));
      if (signal.aborted) cancel();
    });
  }
  prefetch() {
    if (!this.store.config.media.enabled || this.controller.signal.aborted) return;
    const rows = this.store.all(`SELECT payload FROM (SELECT payload,position,row_number() OVER
      (PARTITION BY route ORDER BY position DESC) rank FROM chat_history) WHERE rank<=200 ORDER BY position DESC`);
    for (const row of rows) {
      if (this.preparing.size >= 2) break;
      const message = JSON.parse(row.payload) as Message;
      if (!message.mediaRef || !['image', 'file', 'emoji', ...(this.store.config.video.enabled ? ['video'] : [])].includes(message.kind)) continue;
      const route = hash(['wechat', message.accountKey, message.scope, message.conversationId]);
      const value = this.store.mediaDescriptor(route, message.messageId);
      if (value?.state === 'ready' || value?.state === 'unsupported' || Number(value?.retryAfter ?? 0) > this.store.clock()) continue;
      void this.describe(message, this.controller.signal).catch(() => {});
    }
  }
  async close() { this.controller.abort(); await Promise.allSettled([...this.preparing.values()]); }
  private async prepare(message: Message, signal: AbortSignal): Promise<Record<string, unknown>> {
    signal = AbortSignal.any([signal, AbortSignal.timeout(30000)]);
    if (!this.store.config.media.enabled) return { kind: message.kind, state: 'disabled', note: '媒体理解未启用，不推测内容。' };
    if (!message.mediaRef || !this.bridge.mediaMetadata || !this.bridge.mediaContent) return { kind: message.kind, state: 'unavailable', note: '媒体引用不可用。' };
    const deadline = Date.now() + 30000;
    let meta;
    do {
      signal.throwIfAborted();
      meta = await this.bridge.mediaMetadata(message.mediaRef, signal);
      if (meta.state === 'ready') break;
      if (meta.state !== 'pending') return { kind: message.kind, state: 'unavailable' };
      await delay(500, undefined, { signal });
    } while (Date.now() < deadline);
    if (meta.state !== 'ready') return { kind: message.kind, state: 'pending', note: '媒体尚未就绪，用户可稍后显式重试。' };
    const variant = meta.variants?.content;
    const videoCandidate = this.store.config.video.enabled && (message.kind === 'video' || message.kind === 'file' &&
      (/^video\//.test(variant?.mime ?? '') || /\.(mp4|mov|mkv|webm|avi|flv|ogv|ts|mpg|mpeg)$/i.test(String(meta.name ?? ''))));
    const max = (videoCandidate ? this.store.config.video.maxInputMiB : this.store.config.media.maxInputMiB) * 1024 * 1024;
    if (!variant || !Number.isSafeInteger(variant.size) || variant.size < 0 || variant.size > max || typeof variant.mime !== 'string') throw Error('media_descriptor_invalid');
    const bytes = await this.bridge.mediaContent(message.mediaRef, max, signal);
    if (bytes.length !== variant.size || digest(bytes) !== variant.sha256) throw Error('media_integrity_failed');
    this.sweep();
    const route = hash(['wechat', message.accountKey, message.scope, message.conversationId]);
    const id = hash(['media', route, message.mediaRef]);
    const image = imageType(bytes), video = this.store.config.video.enabled ? videoType(bytes) : undefined;
    const extension = image?.extension ?? video?.extension ?? textExtension(String(meta.name ?? ''), variant.mime);
    if (!extension || !image && !video && message.kind !== 'file') return { kind: message.kind, state: 'unsupported', note: '此文件未接入理解器，不推测内容。' };
    let decoded: ReturnType<typeof decodeText> | undefined;
    if (!image && !video) {
      try { decoded = decodeText(bytes); }
      catch { return { kind: message.kind, state: 'unsupported', note: '文件不是可安全解码的文本，不推测二进制内容。' }; }
    }
    const mime = image?.mime ?? video?.mime ?? 'text/plain', relativePath = 'media/' + id + '.' + extension;
    const existing = this.store.one('SELECT * FROM artifacts WHERE id=?', id);
    const total = this.store.one('SELECT coalesce(sum(bytes),0) n FROM artifacts')!.n;
    if (total - Number(existing?.bytes ?? 0) + bytes.length > this.store.config.media.cacheMiB * 1024 * 1024) throw Error('media_cache_capacity');
    const path = new Sandbox(this.store.config.root, route).writeBytes(relativePath, bytes, max);
    this.store.exec('INSERT OR REPLACE INTO artifacts VALUES(?,?,?,?,?,?,?,0)', id, route, path, digest(bytes), mime, bytes.length,
      this.store.clock() + this.store.config.media.ttlHours * 3600000);
    return { kind: message.kind, format: image ? 'image' : video ? 'video' : 'text', resourceId: id, state: 'ready', path: relativePath,
      name: String(meta.name ?? 'attachment').split(/[\\/]/).at(-1)!.replace(/[\x00-\x1f]/g, '').slice(0, 255), mime, bytes: bytes.length,
      ...(decoded ? { encoding: decoded.encoding, readTool: 'read_text_file' } : { readTool: video ? 'video_storyboard' : 'read_image' }),
      note: 'path相对于当前会话沙箱；先使用对应读取工具，不根据文件名猜测内容。' };
  }
  attachmentAt(route: string, relativePath: string) {
    const sandbox = new Sandbox(this.store.config.root, route);
    let path: string;
    try { path = sandbox.path(relativePath); } catch { throw Error('attachment_path_denied'); }
    const row = this.store.one("SELECT a.*,m.descriptor FROM artifacts a JOIN message_media m ON m.resource_id=a.id WHERE a.route=? AND a.path=? LIMIT 1", route, path);
    if (!row) throw Error('attachment_path_denied');
    const bytes = this.read(route, row.id), descriptor = JSON.parse(row.descriptor);
    return { bytes, descriptor, row };
  }
  readText(route: string, path: string, offset = 0, limit = 12000) {
    const { bytes, descriptor } = this.attachmentAt(route, path);
    if (descriptor.format !== 'text') throw Error('attachment_not_text');
    const decoded = decodeText(bytes), text = decoded.text.slice(offset, offset + limit);
    return { path, text, encoding: decoded.encoding, totalChars: decoded.text.length, offset,
      nextOffset: offset + text.length < decoded.text.length ? offset + text.length : null, truncated: offset + text.length < decoded.text.length,
      evidenceOnly: true };
  }
  sweep() {
    for (const row of this.store.all('SELECT * FROM artifacts WHERE expires<? AND refs=0', this.store.clock())) {
      try { unlinkSync(this.controlledPath(row.path)); } catch { continue; }
      this.store.exec('DELETE FROM artifacts WHERE id=? AND refs=0', row.id);
    }
  }
}
