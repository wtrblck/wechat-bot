import { request as https } from 'node:https';
import { request as http } from 'node:http';
import { publicAddress, resolvePublicHostname, webUrl, type Resolve } from '../tools/web.js';

export type BinaryPage = { bytes: Buffer; url: string; mime: string };
/** Each redirect is DNS-checked and pinned. No proxy, decompression, file URLs or private sockets. */
export async function videoDownload(value: string, max: number, signal: AbortSignal,
  headers: Record<string, string> = {}, resolve: Resolve = resolvePublicHostname): Promise<BinaryPage> {
  let url = webUrl(value);
  const originalHost = url.hostname;
  for (let hop = 0; hop <= 4; hop++) {
    signal.throwIfAborted();
    const records = await new Promise<{ address: string; family: number }[]>((done, reject) => {
      const abort = () => reject(signal.reason); signal.addEventListener('abort', abort, { once: true });
      if (signal.aborted) abort();
      resolve(url.hostname.replace(/^\[|\]$/g, ''), signal).then(done, reject).finally(() => signal.removeEventListener('abort', abort));
    });
    signal.throwIfAborted();
    if (!records.length || records.some(r => !publicAddress(r.address))) throw Error('video_private_address_denied');
    const safeHeaders: Record<string, string> = { 'User-Agent': 'Mozilla/5.0', 'Accept-Encoding': 'identity' };
    for (const [name, val] of Object.entries(headers)) {
      if (/^(user-agent|referer|accept|cookie)$/i.test(name) && typeof val === 'string' && val.length <= 32768 && !/[\r\n\x00]/.test(val) &&
        (name.toLowerCase() !== 'cookie' || url.hostname === originalHost && url.protocol === 'https:')) safeHeaders[name] = val;
    }
    const result = await new Promise<{ location?: string; bytes: Buffer; mime: string }>((resolve, reject) => {
      const pinned = records[0]!;
      const req = (url.protocol === 'https:' ? https : http)(url, { method: 'GET', signal, agent: false,
        family: pinned.family, lookup: (_host, _options, done) => done(null, pinned.address, pinned.family), headers: safeHeaders }, res => {
        if (res.statusCode && res.statusCode >= 300 && res.statusCode < 400 && res.headers.location) {
          res.destroy(); resolve({ location: res.headers.location, bytes: Buffer.alloc(0), mime: '' }); return;
        }
        if (res.statusCode !== 200 || Number(res.headers['content-length'] ?? 0) > max ||
          res.headers['content-encoding'] && res.headers['content-encoding'] !== 'identity') {
          res.destroy(); reject(Error('video_http_unavailable_or_too_large')); return;
        }
        const chunks: Buffer[] = []; let length = 0;
        res.on('data', (chunk: Buffer) => { length += chunk.length;
          if (length > max) res.destroy(Error('video_size_limit')); else chunks.push(chunk); });
        res.on('error', reject);
        res.on('end', () => resolve({ bytes: Buffer.concat(chunks), mime: String(res.headers['content-type'] ?? '').split(';')[0]! }));
        res.on('aborted', () => reject(Error('video_download_incomplete')));
      });
      req.on('error', reject); req.end();
    });
    if (result.location) { url = webUrl(new URL(result.location, url).href); continue; }
    return { bytes: result.bytes, url: url.href, mime: result.mime };
  }
  throw Error('video_redirect_limit');
}

export type VideoPlatform = 'bilibili' | 'douyin';
export function platformUrl(value: string, platform: VideoPlatform): string {
  // A BV id is also accepted. Share messages should supply just their URL.
  if (platform === 'bilibili' && /^BV[a-zA-Z0-9]{10}$/.test(value)) value = 'https://www.bilibili.com/video/' + value;
  const url = webUrl(value);
  if (url.protocol !== 'https:') throw Error('platform_https_required');
  if (platform === 'bilibili' && ['b23.tv', 'www.bilibili.com', 'bilibili.com', 'm.bilibili.com'].includes(url.hostname) &&
    (url.hostname === 'b23.tv' && /^\/[a-zA-Z0-9]+\/?$/.test(url.pathname) || /^\/video\/(?:BV[a-zA-Z0-9]{10}|av\d+)\/?$/.test(url.pathname))) {
    const page = url.searchParams.get('p'); url.search = '';
    if (page && /^\d{1,3}$/.test(page)) url.searchParams.set('p', page);
    return url.href;
  }
  if (platform === 'douyin' && ['www.douyin.com', 'douyin.com', 'v.douyin.com', 'www.iesdouyin.com'].includes(url.hostname)) {
    const modal = url.searchParams.get('modal_id') ?? url.searchParams.get('vid');
    if (modal && /^\d{10,25}$/.test(modal)) return 'https://www.douyin.com/video/' + modal;
    if (/^\/(?:video|share\/video)\/\d{10,25}\/?$/.test(url.pathname)) {
      return 'https://www.douyin.com/video/' + url.pathname.split('/').filter(Boolean).at(-1)!;
    }
    if (url.hostname === 'v.douyin.com' && /^\/[a-zA-Z0-9_-]+\/?$/.test(url.pathname)) {
      url.search = ''; return url.href;
    }
  }
  throw Error('platform_video_url_denied');
}
