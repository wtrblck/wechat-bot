import { readFile } from 'node:fs/promises';
import { resolve } from 'node:path';
import type { Config } from '../config.js';
import type { EventPage } from '../contracts.js';

export class BridgeError extends Error {
  constructor(readonly code: string, readonly status = 0) { super(code); }
}
export type SendKind = 'text' | 'file' | 'image' | 'video' | 'emoji';
export interface Bridge {
  health(): Promise<Record<string, any>>;
  events(after: number): Promise<EventPage>;
  request(id: string): Promise<Record<string, any> | undefined>;
  send(body: string, kind?: SendKind): Promise<Record<string, any>>;
  emojiFavorites?(offset: number, limit: number, signal: AbortSignal): Promise<Record<string, any>>;
  emojiPreview?(id: string, signal: AbortSignal): Promise<Buffer>;
  cancel(id: string): Promise<void>;
  mediaMetadata?(id: string, signal?: AbortSignal): Promise<Record<string, any>>;
  mediaContent?(id: string, maxBytes: number, signal: AbortSignal): Promise<Buffer>;
}
export class BridgeClient implements Bridge {
  private session?: { url: string; token: string };
  constructor(readonly config: Config, readonly fetcher = fetch) {}
  async discover() {
    const raw = JSON.parse(await readFile(resolve(this.config.root, this.config.bridge.sessionFile), 'utf8'));
    const u = new URL(raw.url);
    if (u.protocol !== 'http:' || u.hostname !== '127.0.0.1' || u.username || u.password || u.pathname !== '/' || u.search || u.hash || !u.port ||
        typeof raw.token !== 'string' || !raw.token || /\s/.test(raw.token)) throw new BridgeError('invalid_bridge_session');
    this.session = { url: u.origin, token: raw.token };
  }
  async call(path: string, body?: string, retryAuth = true, signal?: AbortSignal): Promise<any> {
    if (!this.session) await this.discover();
    const s = this.session!;
    let response: Response;
    try {
      response = await this.fetcher(s.url + path, { method: body ? 'POST' : 'GET', body,
        headers: { Authorization: `Bearer ${s.token}`, ...(body ? { 'Content-Type': 'application/json' } : {}) },
        redirect: 'error', signal: signal ? AbortSignal.any([signal, AbortSignal.timeout(this.config.bridge.timeoutMs)]) : AbortSignal.timeout(this.config.bridge.timeoutMs) });
    } catch { throw new BridgeError('bridge_network'); }
    if (response.status === 401 && retryAuth) { await this.discover(); return this.call(path, body, false, signal); }
    const bytes = await boundedBody(response, 8 * 1024 * 1024);
    let value;
    try { value = JSON.parse(bytes.toString('utf8')); } catch { throw new BridgeError('invalid_bridge_json', response.status); }
    if (!response.ok) throw new BridgeError(typeof value.error === 'string' ? value.error : 'bridge_http', response.status);
    return value;
  }
  async health() { return this.call('/health'); }
  async events(after: number): Promise<EventPage> {
    const page = await this.call(`/events?after=${after}`);
    if (!Array.isArray(page.events) || !Number.isSafeInteger(page.cursor) || typeof page.truncated !== 'boolean' ||
        page.events.some((e: unknown) => !e || typeof e !== 'object' || Array.isArray(e))) throw new BridgeError('invalid_events_page');
    return page;
  }
  async request(id: string) {
    try { return await this.call(`/request/${encodeURIComponent(id)}`); }
    catch (error) { if (error instanceof BridgeError && error.status === 404) return undefined; throw error; }
  }
  async send(body: string, kind: SendKind = 'text') { return this.call('/send/' + kind, body); }
  async emojiFavorites(offset: number, limit: number, signal: AbortSignal) {
    return this.call(`/emoji/favorites?offset=${offset}&limit=${limit}`, undefined, true, signal);
  }
  async emojiPreview(id: string, signal: AbortSignal) {
    if (!/^[a-f0-9]{32}$/.test(id)) throw new BridgeError('invalid_emoji_id');
    return this.content('/emoji/favorites/' + id + '/content', 8 * 1024 * 1024, signal);
  }
  async cancel(id: string) { await this.call(`/request/${encodeURIComponent(id)}/cancel`, '{}'); }
  async mediaMetadata(id: string, signal?: AbortSignal) { return this.call('/media/' + encodeURIComponent(id), undefined, true, signal); }
  async mediaContent(id: string, maxBytes: number, signal: AbortSignal) {
    return this.content('/media/' + encodeURIComponent(id) + '/content?variant=content', maxBytes, signal);
  }
  private async content(path: string, maxBytes: number, signal: AbortSignal, retryAuth = true): Promise<Buffer> {
    if (!this.session) await this.discover();
    const s = this.session!;
    const response = await this.fetcher(s.url + path, {
      headers: { Authorization: `Bearer ${s.token}` }, redirect: 'error', signal: AbortSignal.any([signal, AbortSignal.timeout(this.config.bridge.timeoutMs)]),
    });
    if (response.status === 401 && retryAuth) { await response.body?.cancel(); await this.discover(); return this.content(path, maxBytes, signal, false); }
    if (!response.ok) throw new BridgeError('media_unavailable', response.status);
    return boundedBody(response, maxBytes);
  }
}
export async function boundedBody(response: Response, max: number): Promise<Buffer> {
  const reader = response.body?.getReader();
  if (!reader) return Buffer.alloc(0);
  const chunks: Uint8Array[] = []; let total = 0;
  try {
    for (;;) {
      const next = await reader.read(); if (next.done) break;
      total += next.value.byteLength;
      if (total > max) throw new BridgeError('response_too_large');
      chunks.push(next.value);
    }
  } finally { await reader.cancel().catch(() => {}); }
  return Buffer.concat(chunks);
}
export function policyDiagnostics(c: Config, health: Record<string, any>): string[] {
  const p = health.config;
  if (!p?.observe || !p?.send || !Array.isArray(p.conversations)) return ['bridge_policy_unavailable'];
  const errors: string[] = [];
  for (const target of [...c.access.direct.allow, ...c.access.group.allow]) {
    if (!p.conversations.includes(target)) errors.push('conversation_not_polled');
    if (!p.observe.targets?.includes(target) && !p.observe.targets?.includes('*')) errors.push('conversation_not_observed');
    if (!p.send.recipients?.includes(target)) errors.push('recipient_not_allowed');
  }
  if (c.access.group.allow.length && p.observe.prefix !== '') errors.push('autonomous_group_requires_empty_observe_prefix');
  if (c.egress.chunkBytes > p.send.text_bytes) errors.push('bridge_text_limit');
  return [...new Set(errors)];
}
