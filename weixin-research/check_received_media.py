"""Verify media through the authenticated HTTP API; archive evidence under runs/.

No attach, no UI, no sends. By default only actual incoming events are checked.
"""
import argparse
import hashlib
import io
import json
import subprocess
import sys
import wave
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen
from urllib.parse import urlsplit

from media_receive import MAX_FILE
from profile import ROOT


def verify_video(path):
    sys.path.insert(0, str(ROOT / 'deps'))
    import imageio_ffmpeg
    result = subprocess.run([imageio_ffmpeg.get_ffmpeg_exe(), '-hide_banner', '-loglevel', 'error',
        '-nostdin', '-xerror', '-err_detect', 'explode', '-threads', '1', '-i', str(path),
        '-threads', '1', '-f', 'null', '-'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
        timeout=30, creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
    if result.returncode:
        raise ValueError('Video cannot be fully decoded')


def check(session_file, output, after=0, include_outgoing=False):
    session = json.loads(Path(session_file).read_text(encoding='utf-8'))
    base = session['url']
    if urlsplit(base).hostname != '127.0.0.1' or urlsplit(base).scheme != 'http':
        raise ValueError('Session must point to a local receive server')
    output = Path(output).resolve()
    if (ROOT / 'runs').resolve() not in output.parents:
        raise ValueError('Evidence must be inside runs/')
    output.mkdir(parents=True, exist_ok=True)

    def get(path):
        if not path.startswith('/') or path.startswith('//'):
            raise ValueError('Invalid API path')
        return urlopen(Request(base + path, headers={'Authorization': 'Bearer ' + session['token']}), timeout=15)

    with get('/events?after=%d' % after) as response:
        events = json.load(response)
    evidence = []
    for event in events['events']:
        media = event.get('media')
        if not media or (not include_outgoing and event.get('direction') != 'incoming'):
            continue
        with get(media['url']) as response:
            metadata = json.load(response)
        checks = []
        for variant, descriptor in metadata['variants'].items():
            with get(descriptor['url']) as response:
                data = response.read(MAX_FILE + 1)
            if len(data) > MAX_FILE:
                raise ValueError('HTTP content exceeds limit')
            digest = hashlib.sha256(data).hexdigest()
            if digest != descriptor['sha256'] or len(data) != descriptor['size']:
                raise ValueError('HTTP content differs from metadata')
            mime = descriptor['mime']
            suffix = {'image/png': '.png', 'image/jpeg': '.jpg', 'image/gif': '.gif',
                      'image/webp': '.webp', 'audio/wav': '.wav', 'audio/silk': '.silk',
                      'video/mp4': '.mp4'}.get(mime, '.bin')
            path = output / (digest + suffix)
            path.write_bytes(data)
            result = dict(variant=variant, size=len(data), sha256=digest, http_hash_verified=True,
                          artifact=str(path.relative_to(ROOT)))
            expected_md5 = (metadata.get('original_md5') if variant == 'original' and metadata['kind'] == 'video'
                            else metadata.get('expected_md5'))
            if variant in ('content', 'original') and expected_md5 and metadata['kind'] != 'voice':
                if descriptor.get('transcoded_from'):
                    result.update(transcoded_from=descriptor['transcoded_from'],
                                  xml_md5_applicable=False, source_size=descriptor['source_size'])
                else:
                    if hashlib.md5(data).hexdigest() != expected_md5:
                        raise ValueError('HTTP content differs from declared MD5')
                    result['xml_md5_verified'] = True
            if mime.startswith('image/'):
                from PIL import Image, ImageSequence
                with Image.open(io.BytesIO(data)) as image:
                    result['dimensions'] = list(image.size)
                    frames = getattr(image, 'n_frames', 1)
                    duration = 0
                    for frame in ImageSequence.Iterator(image):
                        frame.load()
                        duration += frame.info.get('duration', 0)
                    result.update(frames=frames, animated=frames > 1, duration_ms=duration)
                    if metadata['kind'] == 'emoji' and frames != descriptor.get('frames'):
                        raise ValueError('Animation frame count differs from metadata')
                    result['image_decoded'] = True
            elif mime == 'audio/wav':
                with wave.open(io.BytesIO(data)) as audio:
                    result['duration_ms'] = audio.getnframes() * 1000 // audio.getframerate()
                    result['sample_rate'] = audio.getframerate()
                    result['channels'] = audio.getnchannels()
                    if result['duration_ms'] != metadata.get('duration_ms'):
                        raise ValueError('WAV duration differs from decoder result')
            elif mime == 'video/mp4':
                verify_video(path)
                result['full_decode_verified'] = True
                import cv2
                capture = cv2.VideoCapture(str(path))
                try:
                    decoded, frame = capture.read()
                    if not decoded:
                        raise ValueError('Video frame cannot be decoded')
                    result['first_frame_decoded'] = True
                    result['dimensions'] = [frame.shape[1], frame.shape[0]]
                    fps = capture.get(cv2.CAP_PROP_FPS)
                    frames = capture.get(cv2.CAP_PROP_FRAME_COUNT)
                    result['duration_ms'] = round(frames * 1000 / fps) if fps > 0 else None
                finally:
                    capture.release()
            checks.append(result)
        if metadata['state'] != 'ready':
            try:
                with get(metadata['url'] + '/content') as response:
                    result = response.status
            except HTTPError as error:
                result = error.code
                error.close()
            if result != 409:
                raise ValueError('Pending content must return HTTP 409')
        evidence.append(dict(event=event, media=metadata, http_checks=checks))
        print(json.dumps(dict(kind=metadata['kind'], direction=event['direction'],
                              group=event['conversation_id'].endswith('@chatroom'),
                              state=metadata['state'], reason=metadata.get('reason'),
                              variants=[item['variant'] for item in checks]), ensure_ascii=False))
    report = output / 'evidence.json'
    report.write_text(json.dumps(dict(cursor=events['cursor'], truncated=events['truncated'], records=evidence),
                                 ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(dict(records=len(evidence), report=str(report)), ensure_ascii=False))
    return evidence


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--session', type=Path, default=ROOT / 'runs/db-receive/db-session.json')
    parser.add_argument('--output', type=Path, default=ROOT / 'runs/p4/received')
    parser.add_argument('--after', type=int, default=0)
    parser.add_argument('--include-outgoing', action='store_true')
    args = parser.parse_args()
    check(args.session, args.output, args.after, args.include_outgoing)


if __name__ == '__main__':
    main()
