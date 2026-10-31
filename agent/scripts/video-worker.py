"""Bounded local decoder and read-only platform extractor. JSON stdin/stdout only.

No model commands, browser cookie harvesting, playlist downloads or remote FFmpeg inputs.
"""
import base64
import hashlib
import http.client
import io
import importlib.util
import ipaddress
import json
import math
import os
from pathlib import Path
import re
import socket
import ssl
import subprocess
import sys
import tempfile
import urllib.request

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'tools' / 'video-python'))


def ffmpeg():
    import imageio_ffmpeg
    return imageio_ffmpeg.get_ffmpeg_exe()


def run(args, timeout=25):
    result = subprocess.run([ffmpeg(), '-hide_banner', '-nostdin', '-threads', '1',
                             '-max_alloc', '67108864', *args], capture_output=True,
                            timeout=timeout, creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
    if len(result.stdout) > 32 * 1024 * 1024:
        raise ValueError('decoder_output_limit')
    return result


def container(path):
    with open(path, 'rb') as source:
        head = source.read(32)
    if head[4:8] == b'ftyp':
        return 'mov'
    if head[:4] == bytes.fromhex('1a45dfa3'):
        return 'matroska'
    if head[:4] == b'RIFF' and head[8:12] == b'AVI ':
        return 'avi'
    if head[:3] == b'FLV':
        return 'flv'
    if head[:4] == b'OggS':
        return 'ogg'
    if head[:3] in (b'GIF',):
        return 'gif'
    if head[:1] == b'G':
        return 'mpegts'
    if head[:4] in (b'\x00\x00\x01\xba', b'\x00\x00\x01\xb3'):
        return 'mpeg'
    raise ValueError('unsupported_video_container')


def source_args(path):
    # An explicit demuxer prevents text playlists from reading arbitrary local files.
    return ['-protocol_whitelist', 'file,pipe', '-f', container(path), '-i', path]


def probe(path, maximum):
    result = run([*source_args(path), '-f', 'null', '-t', '0', '-'], 15)
    text = result.stderr.decode('utf-8', 'replace')
    duration = re.search(r'Duration: (\d+):(\d+):(\d+(?:\.\d+)?)', text)
    video = re.search(r'Stream[^\n]*Video: ([^\n]+)', text)
    if not duration or not video or result.returncode:
        raise ValueError('video_probe_failed')
    seconds = int(duration[1]) * 3600 + int(duration[2]) * 60 + float(duration[3])
    if not 0 < seconds <= maximum:
        raise ValueError('video_duration_limit')
    resolution = re.search(r'\b(\d{2,6})x(\d{2,6})\b', video[1])
    if not resolution or int(resolution[1]) * int(resolution[2]) > 16777216:
        raise ValueError('video_resolution_limit')
    return {'duration': seconds, 'width': int(resolution[1]), 'height': int(resolution[2]),
            'audio': bool(re.search(r'Stream[^\n]*Audio:', text)),
            'embeddedSubtitles': bool(re.search(r'Stream[^\n]*Subtitle:', text))}


def frame(path, at, width=384, height=216):
    # Input-side seek, forced demuxer and local-only protocols, bounded 384x216 raster.
    result = run(['-ss', str(at), *source_args(path), '-map', '0:v:0', '-frames:v', '1',
                  '-vf', f'scale={width}:{height}:force_original_aspect_ratio=decrease,pad={width}:{height}:(ow-iw)/2:(oh-ih)/2',
                  '-f', 'image2pipe', '-vcodec', 'png', '-'])
    if result.returncode or not result.stdout:
        raise ValueError('video_frame_failed')
    from PIL import Image
    return Image.open(io.BytesIO(result.stdout)).convert('RGB')


def board(v):
    from PIL import Image, ImageDraw
    p = probe(v['path'], v['maxDuration'])
    start, end = float(v.get('from', 0)), min(float(v.get('to', p['duration'])), p['duration'])
    if not 0 <= start < end:
        raise ValueError('video_window_invalid')
    count = v['frames']
    # Interior points avoid end-of-file seeking errors; every cell has an exact timestamp.
    times = [start + (end - start) * (i + .15) / count for i in range(count)]
    sampling = 'uniform'
    # Short windows additionally identify scene transitions. Dense zoom remains available.
    if end - start <= 180:
        scene = run(['-ss', str(start), *source_args(v['path']), '-t', str(end-start),
                     '-an', '-vf', "scale=160:-2,select='gt(scene,0.32)',showinfo", '-vsync', 'vfr',
                     '-frames:v', '24', '-f', 'null', '-'], 20)
        changes = [start + float(t) for t in re.findall(r'pts_time:([\d.]+)', scene.stderr.decode('utf-8', 'replace'))]
        changes = [t + .08 for t in changes if start <= t < end - .15]
        if changes:
            # Keep uniform coverage alongside scene cuts rather than dropping the entire middle.
            keep = times[::2]
            times = sorted(keep + changes[::max(1, math.ceil(len(changes)/(count-len(keep))))][:count-len(keep)])
            sampling = 'uniform+scene'
    width, height = (640, 360) if v.get('detail') else (384, 216)
    sheet = Image.new('RGB', (width*3, math.ceil(len(times) / 3) * (height+26)), '#171a21')
    draw = ImageDraw.Draw(sheet)
    cells = []
    for index, at in enumerate(times):
        x, y = (index % 3) * width, (index // 3) * (height+26)
        sheet.paste(frame(v['path'], at, width, height), (x, y))
        draw.text((x+6, y+height+5), f'{index+1:02d}   {at:.2f}s', fill='white')
        cells.append({'index': index+1, 'seconds': round(at, 3)})
    data = io.BytesIO()
    sheet.save(data, format='JPEG', quality=85)
    return {**p, 'from': start, 'to': end, 'sampling': sampling, 'cells': cells,
            'image': base64.b64encode(data.getvalue()).decode(),
            'note': '抽帧仅覆盖列出的时刻；动作细节用更短时间窗口复查，未提供语音转写。'}


def guard_network():
    """yt-dlp metadata only; validate and pin DNS answers, including every redirect.

    Proxies are disabled; fake-IP DNS is independently resolved over TLS.
    """
    original = socket.getaddrinfo

    class DNSConnection(http.client.HTTPSConnection):
        def connect(self):
            raw = socket.create_connection(('223.5.5.5', 443), timeout=10)
            self.sock = ssl.create_default_context().wrap_socket(raw, server_hostname='dns.alidns.com')

    def checked(host, port, *args, **kwargs):
        records = original(host, port, *args, **kwargs)
        addresses = [ipaddress.ip_address(r[4][0].split('%')[0]) for r in records]
        if addresses and all(a.version == 4 and a in ipaddress.ip_network('198.18.0.0/15') for a in addresses):
            if not re.fullmatch(r'[A-Za-z0-9.-]+', host):
                raise ValueError('video_dns_denied')
            conn = DNSConnection('dns.alidns.com', timeout=10)
            conn.request('GET', '/resolve?name=' + host + '&type=A', headers={'Host': 'dns.alidns.com'})
            response = conn.getresponse()
            payload = json.loads(response.read(65536))
            conn.close()
            records = []
            for answer in payload.get('Answer', []):
                if answer.get('type') == 1:
                    records.extend(original(answer['data'], port, *args, **kwargs))
            addresses = [ipaddress.ip_address(r[4][0]) for r in records]
        if not addresses or any(not a.is_global for a in addresses):
            raise ValueError('video_private_address_denied')
        return records
    socket.getaddrinfo = checked


class Quiet:
    def debug(self, *_): pass
    def warning(self, *_): pass
    def error(self, *_): pass


def extract(v):
    import yt_dlp
    guard_network()
    opts = {'quiet': True, 'no_warnings': True, 'logger': Quiet(), 'noplaylist': True,
            'playlist_items': '1', 'skip_download': True, 'socket_timeout': 12,
            'retries': 0, 'extractor_retries': 0, 'proxy': '',
            'format': 'bv*[height<=720][protocol=https]+ba[protocol=https]/b[protocol=https]/b[protocol=http]',
            'cachedir': False, 'extractor_args': {'bilibili': {'skip': ['ai_subtitles']}}}
    if v.get('cookies') and Path(v['cookies']).is_file():
        opts['cookiefile'] = v['cookies']
    # Only allow the two explicit extractors. No generic extractor or user-supplied plugins.
    with yt_dlp.YoutubeDL(opts, auto_init=False) as ydl:
        from yt_dlp.extractor.bilibili import BiliBiliIE
        from yt_dlp.extractor.tiktok import DouyinIE
        ydl.add_info_extractor(BiliBiliIE() if v['platform'] == 'bilibili' else DouyinIE())
        info = ydl.extract_info(v['url'], download=False)
        if not info or info.get('_type') in ('playlist', 'multi_video'):
            raise ValueError('video_single_item_required')
        if info.get('is_live') or info.get('duration', 0) > v['maxDuration']:
            raise ValueError('video_duration_or_live_denied')
        selected = info.get('requested_formats') or [info]
        streams = []
        for item in selected:
            if item.get('protocol') not in ('http', 'https') or item.get('fragments') or item.get('has_drm'):
                raise ValueError('video_segmented_or_drm_unsupported')
            # Header names are restricted again by the trusted TS downloader.
            headers = dict(info.get('http_headers') or {}, **(item.get('http_headers') or {}))
            request = ydl._calc_headers(item)
            headers.update(request)
            streams.append({'url': item['url'], 'headers': dict(headers), 'audioOnly': item.get('vcodec') == 'none'})
        return {'id': str(info['id']), 'title': str(info.get('title', ''))[:300],
                'description': str(info.get('description', ''))[:1500], 'author': str(info.get('uploader', ''))[:200],
                'duration': info.get('duration'), 'streams': streams[:2],
                'subtitles': info.get('subtitles', {}), 'automaticCaptions': info.get('automatic_captions', {})}


def transcribe(v):
    p = probe(v['path'], v['maxDuration'])
    start = float(v.get('from', 0))
    end = min(float(v.get('to', p['duration'])), p['duration'], start + v['maxSeconds'])
    if not 0 <= start < end:
        raise ValueError('video_window_invalid')
    if v.get('embedded', False) and p['embeddedSubtitles']:
        data = run(['-ss', str(start), *source_args(v['path']), '-t', str(end-start),
                    '-map', '0:s:0', '-f', 'srt', '-'])
        if data.returncode == 0 and data.stdout:
            return {'state': 'ready', 'source': 'embedded_subtitles', 'from': start, 'to': end,
                    'text': data.stdout.decode('utf-8', 'replace')[:16000], 'timestampsRelativeTo': start}
    if not p['audio']:
        return {'segments': [], 'state': 'no_audio'}
    backend = v.get('backend', 'off')
    if backend == 'off' or backend == 'endpoint' and not v.get('endpoint'):
        return {'state': 'asr_not_configured', 'note': '未配置语音转写服务；仅可理解画面，不能声称听懂台词。'}
    audio = run(['-ss', str(start), *source_args(v['path']), '-t', str(end-start),
                 '-vn', '-ac', '1', '-ar', '16000', '-f', 'wav', '-'])
    if audio.returncode:
        raise ValueError('audio_decode_failed')
    if backend == 'local':
        model_path = v['localModel']
        if not Path(model_path, 'model.bin').is_file():
            return {'state': 'local_asr_model_missing', 'note': '本地转写模型尚未安装，不能声称听懂音轨。'}
        from faster_whisper import WhisperModel
        import numpy as np
        import wave
        model = WhisperModel(model_path, device='cpu', compute_type='int8', cpu_threads=2,
                             num_workers=1, local_files_only=True)
        # Already decoded by our restricted FFmpeg; avoid PyAV opening another input/container.
        with wave.open(io.BytesIO(audio.stdout), 'rb') as wav:
            samples = np.frombuffer(wav.readframes(int((end-start)*16000)+16000), dtype='<i2').astype(np.float32) / 32768.0
        rows, details = model.transcribe(samples, beam_size=1, vad_filter=True,
                                        condition_on_previous_text=False, word_timestamps=False)
        segments = []
        for row in rows:
            if len(segments) >= 300: break
            segments.append({'start': round(start+row.start, 3), 'end': round(start+row.end, 3), 'text': row.text[:2000]})
        return {'state': 'ready', 'source': 'local_whisper', 'language': details.language,
                'from': start, 'to': end, 'segments': segments,
                'text': '\n'.join(s['text'] for s in segments)[:16000],
                'truncated': end < p['duration'], 'note': '本地自动识别可能有误，仅覆盖返回时间窗口。'}
    boundary = 'wxvideo' + hashlib.sha256(audio.stdout[:4096]).hexdigest()[:24]
    parts = []
    for name, value in [('model', v['model']), ('response_format', 'verbose_json')]:
        parts.append(f'--{boundary}\r\nContent-Disposition: form-data; name="{name}"\r\n\r\n{value}\r\n'.encode())
    parts.extend([f'--{boundary}\r\nContent-Disposition: form-data; name="file"; filename="audio.wav"\r\nContent-Type: audio/wav\r\n\r\n'.encode(),
                  audio.stdout, f'\r\n--{boundary}--\r\n'.encode()])
    headers = {'Content-Type': 'multipart/form-data; boundary=' + boundary}
    key = os.environ.get(v['apiKeyEnv'])
    if key:
        headers['Authorization'] = 'Bearer ' + key
    req = urllib.request.Request(v['endpoint'].rstrip('/') + '/audio/transcriptions', data=b''.join(parts), headers=headers)
    class NoRedirect(urllib.request.HTTPRedirectHandler):
        def redirect_request(self, *_): raise ValueError('asr_redirect_denied')
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}), NoRedirect())
    with opener.open(req, timeout=60) as response:
        payload = json.loads(response.read(1024 * 1024))
    segments = [{'start': start+float(s['start']), 'end': start+float(s['end']), 'text': str(s['text'])[:2000]}
                for s in payload.get('segments', [])[:300]]
    return {'state': 'ready', 'source': 'asr', 'from': start, 'to': end,
            'text': str(payload.get('text', ''))[:16000], 'segments': segments,
            'truncated': end < p['duration'], 'note': '自动识别可能有误；仅覆盖返回时间窗口。'}


def main(v):
    action = v['action']
    if action == 'health':
        import yt_dlp.version
        from PIL import __version__
        return {'ffmpeg': Path(ffmpeg()).is_file(), 'ytDlp': yt_dlp.version.__version__, 'pillow': __version__,
                'localAsr': importlib.util.find_spec('faster_whisper') is not None}
    if action == 'extract': return extract(v)
    if action == 'probe': return probe(v['path'], v['maxDuration'])
    if action == 'board': return board(v)
    if action == 'transcribe': return transcribe(v)
    if action == 'merge':
        args = source_args(v['video']) + source_args(v['audio']) + ['-map', '0:v:0', '-map', '1:a:0',
                '-c', 'copy', '-fs', str(v['maxBytes']), '-f', 'mp4', '-y', v['output']]
        if run(args, 30).returncode: raise ValueError('video_merge_failed')
        return {'merged': True}
    raise ValueError('video_action_denied')


if __name__ == '__main__':
    try:
        value = json.loads(sys.argv[1]) if len(sys.argv) > 1 else json.load(sys.stdin)
        print(json.dumps(main(value), ensure_ascii=True))
    except Exception as error:
        # Never leak signed URLs, cookies, bearer keys or extractor traceback to the model/logs.
        code = str(error) if isinstance(error, ValueError) and re.fullmatch(r'[a-z_]+', str(error)) else 'video_' + type(error).__name__
        print(json.dumps({'error': code, 'note': '获取失败可能需要有效登录Cookie、视频已失效或平台限制；不绕过风控。'}))
        sys.exit(1)
