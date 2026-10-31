import { readFileSync, existsSync, lstatSync } from 'node:fs';
import { resolve } from 'node:path';
import type { Config } from '../config.js';
import { platformUrl, videoDownload } from './video-network.js';

/** Read-only detail API and public share-page hydration data; never execute page scripts. */
export async function douyinVideo(config: Config, value: string, signal: AbortSignal, download = videoDownload) {
  const canonical = platformUrl(value, 'douyin'), id = new URL(canonical).pathname.split('/').filter(Boolean).at(-1)!;
  if (!/^\d{10,25}$/.test(id)) throw Error('douyin_video_id_required');
  const headers: Record<string, string> = { Referer: 'https://www.douyin.com/', 'User-Agent': 'Mozilla/5.0' };
  const cookiePath = resolve(config.root, config.video.douyinCookies);
  if (existsSync(cookiePath)) {
    if (lstatSync(cookiePath).size > 65536) throw Error('video_cookie_file_too_large');
    const cookies = readFileSync(cookiePath, 'utf8').split(/\r?\n/).flatMap(line => {
      const fields = line.replace(/^#HttpOnly_/, '').split('\t');
      if (fields.length !== 7 || !/^(?:\.)?(?:www\.)?douyin\.com$/.test(fields[0]!) ||
        Number(fields[4]) && Number(fields[4]) * 1000 < Date.now() || !/^[A-Za-z0-9_]+$/.test(fields[5]!)) return [];
      return [fields[5] + '=' + fields[6]];
    });
    if (cookies.length) headers.Cookie = cookies.join('; ');
  }
  let detail: any;
  try {
    const page = await download('https://www.douyin.com/aweme/v1/web/aweme/detail/?aweme_id=' + id, 2 * 1048576, signal, headers);
    const payload = JSON.parse(page.bytes.toString('utf8'));
    if (payload.status_code === 0 && String(payload.aweme_detail?.aweme_id) === id) detail = payload.aweme_detail;
  } catch { signal.throwIfAborted(); }
  if (!detail) {
    const page = await download('https://www.iesdouyin.com/share/video/' + id + '/', 2 * 1048576, signal,
      { 'User-Agent': headers['User-Agent']!, Referer: canonical }); // Never send douyin.com cookies to the share domain.
    const html = page.bytes.toString('utf8');
    const router = html.match(/(?:window\.)?_ROUTER_DATA\s*=\s*({[\s\S]*?})\s*;?\s*<\/script>/)?.[1];
    const encoded = html.match(/<script[^>]+id=["']RENDER_DATA["'][^>]*>([\s\S]*?)<\/script>/)?.[1];
    let payload: any;
    try { payload = router ? JSON.parse(router) : encoded ? JSON.parse(decodeURIComponent(encoded)) : undefined; } catch {}
    const queue = payload ? [payload] : [];
    for (let n = 0; n < queue.length && n < 20000; n++) {
      const item = queue[n];
      if (!item || typeof item !== 'object') continue;
      if (String(item.aweme_id) === id && item.video) { detail = item; break; }
      for (const child of Object.values(item)) if (child && typeof child === 'object' && queue.length < 20000) queue.push(child);
    }
  }
  if (!detail) throw Error('douyin_login_or_platform_restricted');
  const duration = Number(detail.video?.duration ?? detail.duration ?? 0) / 1000;
  if (!Number.isFinite(duration) || duration <= 0 || duration > config.video.maxDurationSeconds || detail.is_live) throw Error('video_duration_or_live_denied');
  const url = detail.video?.play_addr?.url_list?.find((u: unknown) => typeof u === 'string' && /^https:\/\//.test(u));
  if (!url) throw Error('douyin_video_stream_missing');
  return { id, title: String(detail.desc ?? '').slice(0, 300), description: String(detail.desc ?? '').slice(0, 1500),
    author: String(detail.author?.nickname ?? '').slice(0, 200), duration,
    streams: [{ url, headers: { Referer: canonical, 'User-Agent': 'Mozilla/5.0' } }] };
}
