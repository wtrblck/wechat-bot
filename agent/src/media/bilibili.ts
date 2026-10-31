import { readFileSync, existsSync, lstatSync } from 'node:fs';
import { resolve } from 'node:path';
import type { Config } from '../config.js';
import { platformUrl, videoDownload } from './video-network.js';

/** Native public metadata/playurl API: independent of the HTML-page extractor. */
export async function bilibiliVideo(config: Config, value: string, signal: AbortSignal, download = videoDownload) {
  const canonical = new URL(platformUrl(value, 'bilibili'));
  const id = canonical.pathname.split('/').filter(Boolean).at(-1)!;
  const query = /^BV/.test(id) ? 'bvid=' + id : 'aid=' + id.slice(2);
  const cookiePath = resolve(config.root, config.video.bilibiliCookies);
  const headers: Record<string, string> = { Referer: 'https://www.bilibili.com/', 'User-Agent': 'Mozilla/5.0' };
  if (existsSync(cookiePath)) {
    if (lstatSync(cookiePath).size > 65536) throw Error('video_cookie_file_too_large');
    const cookies = readFileSync(cookiePath, 'utf8').split(/\r?\n/).flatMap(line => {
      const fields = line.replace(/^#HttpOnly_/, '').split('\t');
      if (fields.length !== 7 || !/^(?:\.)?bilibili\.com$/.test(fields[0]!) ||
        Number(fields[4]) && Number(fields[4]) * 1000 < Date.now() || !/^[A-Za-z0-9_]+$/.test(fields[5]!)) return [];
      return [fields[5] + '=' + fields[6]];
    });
    if (cookies.length) headers.Cookie = cookies.join('; ');
  }
  const api = async (path: string) => {
    const page = await download('https://api.bilibili.com/' + path, 2 * 1048576, signal, headers);
    const payload = JSON.parse(page.bytes.toString('utf8'));
    if (payload.code !== 0 || !payload.data) throw Error(payload.code === -101 ? 'video_login_required' : 'bilibili_api_unavailable');
    return payload.data;
  };
  const info = await api('x/web-interface/view?' + query);
  const page = info.pages?.[Number(canonical.searchParams.get('p') ?? '1') - 1];
  if (!page || !Number.isSafeInteger(page.cid) || page.duration > config.video.maxDurationSeconds) throw Error('video_part_or_duration_denied');
  const play = await api('x/player/playurl?' + query + '&cid=' + page.cid + '&qn=32&fnval=4048&fourk=0');
  const mediaHeaders = { Referer: canonical.href, 'User-Agent': 'Mozilla/5.0' };
  let streams: { url: string; headers: Record<string, string>; audioOnly?: boolean }[] = [];
  if (Array.isArray(play.durl) && play.durl.length === 1 && typeof play.durl[0].url === 'string') {
    streams = [{ url: play.durl[0].url, headers: mediaHeaders }];
  } else if (play.dash) {
    const videos = (play.dash.video ?? []).filter((v: any) => typeof (v.baseUrl ?? v.base_url) === 'string' && v.height <= 720)
      .sort((a: any, b: any) => b.height-a.height || a.bandwidth-b.bandwidth);
    const audio = [...(play.dash.audio ?? [])].sort((a: any, b: any) => a.bandwidth-b.bandwidth)[0];
    const video = videos[0];
    if (video) streams.push({ url: video.baseUrl ?? video.base_url, headers: mediaHeaders });
    if (audio) streams.push({ url: audio.baseUrl ?? audio.base_url, headers: mediaHeaders, audioOnly: true });
  }
  if (!streams.length || streams[0]?.audioOnly) throw Error('bilibili_video_stream_missing');
  return { id: String(info.bvid ?? id), title: String(info.title ?? '').slice(0, 300),
    author: String(info.owner?.name ?? '').slice(0, 200), description: String(info.desc ?? '').slice(0, 1500),
    duration: Number(page.duration), streams };
}
