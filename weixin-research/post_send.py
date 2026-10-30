"""Post one explicit send request to a running send_api.py experiment.

Reads the session file the service writes, so the token is never copied by hand.
Text is read as UTF-8 (from --text-file or --text); the JSON body is encoded as
UTF-8 so multi-byte content never depends on the console code page.
"""
import argparse
import json
import sys
import uuid
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parent
SESSION = ROOT / 'runs' / 'send-api' / 'send-api-session.json'
KINDS = ('text', 'image', 'file', 'video', 'voice', 'emoji')


def post(payload, kind, session):
    url = '%s/send/%s' % (session['url'], kind)
    request = Request(url, data=json.dumps(payload, ensure_ascii=False).encode('utf-8'),
                      headers={'Authorization': 'Bearer ' + session['token'],
                               'Content-Type': 'application/json'})
    try:
        with urlopen(request, timeout=45) as response:
            return response.status, json.load(response)
    except HTTPError as error:
        with error:
            return error.code, json.load(error)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--kind', choices=KINDS, default='text')
    parser.add_argument('--recipient', required=True,
                        help='Target that the running service policy already allows')
    parser.add_argument('--text', help='Message text given on the command line')
    parser.add_argument('--text-file', type=Path, help='Read message text as UTF-8 from a file')
    parser.add_argument('--path', help='Fixture path for the media kinds')
    parser.add_argument('--emoji-id', help='ID from the authenticated favorite catalog')
    parser.add_argument('--request-id', help='Reuse an existing request id to test idempotency')
    parser.add_argument('--session', type=Path, default=SESSION)
    args = parser.parse_args()
    if args.kind == 'text':
        if bool(args.text) == bool(args.text_file):
            parser.error('text sends need exactly one of --text or --text-file')
        text = args.text_file.read_text(encoding='utf-8') if args.text_file else args.text
        payload = dict(request_id=args.request_id or uuid.uuid4().hex, recipient=args.recipient, text=text)
    elif args.kind == 'emoji':
        if not args.emoji_id:
            parser.error('emoji sends need --emoji-id from /emoji/favorites')
        payload = dict(request_id=args.request_id or uuid.uuid4().hex, recipient=args.recipient, emoji_id=args.emoji_id)
    else:
        if not args.path:
            parser.error('media sends need --path')
        payload = dict(request_id=args.request_id or uuid.uuid4().hex, recipient=args.recipient, path=args.path)
    if not args.session.is_file():
        parser.error('no running send service session at ' + str(args.session))
    session = json.loads(args.session.read_text(encoding='utf-8'))
    status, result = post(payload, args.kind, session)
    print(json.dumps(dict(status=status, **result), ensure_ascii=False))
    return 0 if status == 200 and result.get('accepted') else 1


if __name__ == '__main__':
    sys.exit(main())
