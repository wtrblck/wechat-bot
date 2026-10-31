"""One explicitly authorized bridge GIF trial; never retries an unknown send.

Without --execute, only inspect the previously used frozen source file.
The only supported target is the user's authorized test contact.
"""
import argparse
import hashlib
import io
import json
import re
import time
from pathlib import Path
from urllib.parse import quote, urlsplit
from urllib.request import Request, urlopen
from PIL import Image

ROOT = Path(__file__).resolve().parent
RECIPIENT = 'wxid_u3yyhe3yrwh122'
SOURCE = ROOT.parent / ('agent/data/sandbox/d009e792720d08a4a2b503ebac6652bf972dff23a03a853f8fbd3f9d4730cfab/'
    'outgoing/47279dcbee946a09dfb6db0c863659f0e63aa64decc54c0dc8108b42fd498e80/sticker.gif')
EXPECTED = '2309d05d9d26a6d80907220753cc73bce5844080382a8bf564107c40b6176d30'


def inspect(data):
    with Image.open(io.BytesIO(data)) as image:
        frames, duration, loop = image.n_frames, 0, image.info.get('loop')
        for frame in range(frames):
            image.seek(frame)
            image.load()
            duration += image.info.get('duration', 0)
    return dict(sha256=hashlib.sha256(data).hexdigest(), size=len(data), frames=frames,
                duration_ms=duration, loop=loop)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--execute', action='store_true')
    parser.add_argument('--request-id', default='gifrepair_20261031_library_01')
    parser.add_argument('--sample', choices=('library', 'failed-small', 'failed-large', 'failed-186', 'cold-186', 'cold-fresh'), default='library')
    args = parser.parse_args()
    if not re.fullmatch(r'[a-zA-Z0-9_-]{1,64}', args.request_id):
        raise ValueError('invalid diagnostic request ID')
    samples = {'library': (SOURCE, EXPECTED),
        'failed-small': (SOURCE.parents[1] / '966d9b8f1b1b062b4e437f9626675f8f9917917f572564104aa6b45908a46769/sticker.gif',
                         '1ff2ea88825a5b2c4424511a8d47e96123801598959d8d3f570a86687d0041c2'),
        'failed-large': (SOURCE.parents[1] / '2955399c89b2a103936e34cdaaaa7fd7582d1a093f2f2092dd984869fd5174ba/sticker.gif',
                         '1cd9a10b0db8fda12668bda309738c3525e277c9fcb8f4baaf2b8b90f778fbd9'),
        'failed-186': (SOURCE.parents[1] / '39d4dd49bfad41a5617e7ecae4f6bd4a5a49bdbbfa2b5b15a68bb92f4baabc2d/sticker.gif',
                         '166bb7ec280e82223860e2bc7c904fd234d39a0f4b0c62e4a6449174689edb59'),
        'cold-186': (ROOT / 'fixtures/cold-186.gif',
                         'ef03fc5fc6608f1dabfec43ccbbc1109db43e92043a2eee0d031e138382a238d'),
        'cold-fresh': (ROOT / 'fixtures/cold-186-fresh.gif',
                         'a14f144c6d3c0e8092613d5a23256e1d8f8a783e840b733fc8a0d9713d1ad68e')}
    source, expected = samples[args.sample]
    result = dict(source=inspect(source.read_bytes()), sent=False)
    if result['source']['sha256'] != expected:
        raise ValueError('frozen source changed')
    if args.execute:
        session = json.loads((ROOT / 'runs/bridge/session.json').read_text(encoding='utf-8'))
        url = urlsplit(session['url'])
        if url.scheme != 'http' or url.hostname != '127.0.0.1' or not url.port or url.username or url.password or url.path not in ('', '/') or url.query or url.fragment:
            raise ValueError('invalid local session')
        base = 'http://127.0.0.1:%d' % url.port

        def call(path, body=None, binary=False):
            request = Request(base + path, data=None if body is None else json.dumps(body).encode(),
                headers={'Authorization': 'Bearer ' + session['token'], 'Content-Type': 'application/json'})
            with urlopen(request, timeout=30) as response:
                data = response.read()
            return data if binary else json.loads(data)

        health = call('/health')
        if not health['send_ready'] or not health['receive_ready']:
            raise ValueError('bridge is not ready')
        cursor = call('/events?after=0').get('cursor', 0)
        body = dict(request_id=args.request_id, recipient=RECIPIENT, path=str(source), wait=True)
        response = call('/send/image', body)  # one POST, no retry or fallback
        result.update(sent=True, request=response)
        deadline = time.monotonic() + 30
        while response['state'] not in ('server_confirmed', 'failed', 'unknown', 'cancelled') and time.monotonic() < deadline:
            time.sleep(.5)
            response = call('/request/' + quote(args.request_id, safe=''))
            result['request'] = response
        events = call('/events?after=%d' % cursor).get('events', [])
        event = next((e for e in events if e.get('message_id') == response.get('message_id')), None)
        if event:
            result['event'] = {k: event.get(k) for k in ('message_id', 'local_type', 'server_id', 'direction', 'message_type')}
            media_id = (event.get('media') or {}).get('id')
            if media_id:
                for _ in range(12):
                    metadata = call('/media/' + quote(media_id, safe=''))
                    result['media'] = metadata
                    if metadata.get('state') == 'ready':
                        data = call('/media/' + quote(media_id, safe='') + '/content', binary=True)
                        result['retrieved'] = inspect(data)
                        break
                    if metadata.get('state') == 'failed':
                        break
                    time.sleep(.5)
        result['receiver_playback'] = 'pending_user_confirmation_for_this_new_trial'
        destination = ROOT / ('runs/gif-repair/bridge-trial.json' if args.sample == 'library' else 'runs/gif-upload-fix/trial-' + args.sample + '.json')
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_text(json.dumps(result, indent=2, ensure_ascii=False), encoding='utf-8')
        # Preserve each trial separately; a later explicit request must not
        # overwrite the evidence for a previous failure using the same sample.
        destination.with_name(args.request_id + '.json').write_text(
            json.dumps(result, indent=2, ensure_ascii=False), encoding='utf-8')
    print(json.dumps(result, ensure_ascii=True))


if __name__ == '__main__':
    main()
