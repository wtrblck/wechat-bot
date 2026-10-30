"""Poll a running receive_api.py session and record every /events response.

The observation window is short, so this runs next to the service and keeps the
raw HTTP evidence: each response that contains events is appended to a JSONL file
with its cursor and counters. No token is printed, only used from the session file.
"""
import argparse
import json
import sys
import time
from datetime import datetime, timezone
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.request import Request, urlopen

ROOT = Path(__file__).resolve().parent


def fetch(session, after=0):
    request = Request('%s/events?after=%d' % (session['url'], after),
                      headers={'Authorization': 'Bearer ' + session['token']})
    with urlopen(request, timeout=3) as response:
        return json.load(response)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--session', type=Path, default=ROOT / 'runs' / 'api' / 'api-session.json')
    parser.add_argument('--seconds', type=int, default=60)
    parser.add_argument('--output', type=Path,
                        default=ROOT / 'runs' / 'api' / ('poll-' + datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '.jsonl'))
    args = parser.parse_args()
    if not 1 <= args.seconds <= 120:
        parser.error('seconds must be 1..120')
    deadline = time.monotonic() + args.seconds
    seen = 0
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open('w', encoding='utf-8') as output:
        while time.monotonic() < deadline:
            if not args.session.is_file():
                output.write(json.dumps(dict(event='session_closed')) + '\n')
                break
            try:
                session = json.loads(args.session.read_text(encoding='utf-8'))
                payload = fetch(session)
            except (HTTPError, URLError, OSError, ValueError) as error:
                output.write(json.dumps(dict(event='poll_error', detail=str(error))) + '\n')
                time.sleep(1)
                continue
            events = payload.get('events', [])
            if len(events) != seen:
                output.write(json.dumps(dict(event='poll', cursor=payload.get('cursor'),
                                             truncated=payload.get('truncated'),
                                             counters=payload.get('counters'),
                                             events=events), ensure_ascii=False) + '\n')
                output.flush()
                seen = len(events)
            time.sleep(1)
    print(json.dumps(dict(output=str(args.output), events=seen)))
    return 0 if seen else 1


if __name__ == '__main__':
    sys.exit(main())
