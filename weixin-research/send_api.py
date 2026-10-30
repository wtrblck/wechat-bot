"""Bounded localhost sender experiment; targets come from the send policy."""
import argparse
import hashlib
import json
import re
import secrets
import threading
import uuid
from pathlib import Path
from urllib.request import Request, urlopen

import policy
from active_send import config_for
from policy import JSON_BODY_BYTES, PolicyError, SendPolicy
from profile import ROOT
from probe import Journal, run_probe
from receive_api import ReceiveServer

KINDS = ('text', 'image', 'file', 'video', 'voice', 'emoji')


class SendBridge:
    def __init__(self, pid, token, port=17868, *, executor=run_probe, builder=config_for, limit=4,
                 send_policy=None, send_seconds=15, emoji_catalog=None):
        self.pid, self.executor, self.builder, self.limit = pid, executor, builder, limit
        self.send_seconds = send_seconds
        self.policy = send_policy or SendPolicy.from_environment()
        self.emoji_catalog = emoji_catalog
        self.lock = threading.Lock()
        self.results = {}
        self.accepting = True
        self.bridge = ReceiveServer(self, token, port, self.post, on_get=self.get)
        # Closing the service waits for native-call cleanup before Python exits.
        self.bridge.server.daemon_threads = False
        self.port = self.bridge.port

    def start(self):
        self.bridge.start()

    def close(self):
        self.accepting = False
        self.bridge.close()

    def health(self):
        return dict(state='ready' if self.accepting else 'stopping', send_ready=self.accepting,
                    recipients=list(self.policy.recipients),
                    limits=dict(self.policy.describe(), json_body_bytes=JSON_BODY_BYTES),
                    kinds=[kind for kind in KINDS if kind != 'emoji' or self.emoji_catalog is not None], completed=len(self.results), limit=self.limit,
                    delivery_verified=False)

    def read(self, after):
        return dict(events=[], cursor=0, truncated=False)

    def get(self, route, query):
        if route != '/emoji/favorites' and not route.startswith('/emoji/favorites/'):
            return 404, dict(error='not_found')
        if self.emoji_catalog is None:
            return 503, dict(error='emoji_catalog_disabled')
        try:
            if route == '/emoji/favorites':
                if set(query) - {'offset','limit'} or any(len(values) != 1 for values in query.values()):
                    raise ValueError('invalid_emoji_page')
                return 200, self.emoji_catalog.list(int(query.get('offset',['0'])[0]),int(query.get('limit',['100'])[0]))
            parts = route.split('/')
            if len(parts) != 5 or parts[4] != 'content' or query:
                return 404, dict(error='not_found')
            data,mime,_,_ = self.emoji_catalog.preview(parts[3])
            return 200, (data,mime)
        except ValueError as error:
            reason = str(error) if re.fullmatch('[a-z_]+',str(error)) else 'invalid_emoji_request'
            return 400, dict(error=reason)
        except LookupError:
            return 502, dict(error='emoji_preview_unavailable')
        except Exception:
            return 503, dict(error='emoji_catalog_unavailable')

    def post(self, route, payload):
        kind = route.removeprefix('/send/')
        if route != '/send/' + kind or kind not in KINDS:
            return 404, dict(error='not_found')
        request_id = payload.get('request_id')
        if not isinstance(request_id, str) or not re.fullmatch(policy.REQUEST_ID_PATTERN, request_id):
            return 400, dict(error='valid_request_id_required')
        recipient = payload.get('recipient')
        if not isinstance(recipient, str):
            return 400, dict(error='valid_recipient_required')
        field = 'text' if kind == 'text' else 'emoji_id' if kind == 'emoji' else 'path'
        allowed = {'request_id', 'recipient', field}
        if set(payload) != allowed:
            return 400, dict(error='unexpected_or_missing_fields')
        if kind == 'emoji' and self.emoji_catalog is None:
            return 503, dict(error='emoji_catalog_disabled')
        # The boundary checks the policy itself; the builder repeats it before any
        # native call so a target can never be widened by skipping a layer.
        try:
            self.policy.encode_recipient(recipient)
            if kind == 'text':
                self.policy.encode_text(payload.get('text'))
        except PolicyError as error:
            return (403 if error.code == 'recipient_not_allowed' else 400), dict(error=error.code, detail=str(error))
        fingerprint = hashlib.sha256(json.dumps([route, payload], sort_keys=True).encode()).hexdigest()
        if not self.lock.acquire(blocking=False):
            return 409, dict(error='sender_busy')
        try:
            if request_id in self.results:
                previous, code, result = self.results[request_id]
                return (code, dict(result, cached=True)) if previous == fingerprint else (409, dict(error='request_id_conflict'))
            if not self.accepting:
                return 503, dict(error='sender_stopping')
            if len(self.results) >= self.limit:
                return 429, dict(error='experiment_limit_reached')
            try:
                extra = dict(emoji_id=payload.get('emoji_id'), emoji_catalog=self.emoji_catalog) if kind == 'emoji' else {}
                config = self.builder(kind, text=payload.get('text'), path=payload.get('path'),
                                      recipient=recipient, seconds=self.send_seconds, policy=self.policy, **extra)
            except PolicyError as error:
                return (403 if error.code == 'recipient_not_allowed' else 400), dict(error=error.code, detail=str(error))
            except (ValueError, TypeError, OSError) as error:
                return 400, dict(error=str(error))
            journal = Journal(ROOT / 'runs' / 'send-api')
            try:
                exit_code = self.executor(self.pid, config, journal)
                native = next((e for e in journal.events if e['event'] == 'active_send_result'), {})
                accepted = native.get('accepted', False)
                result = dict(request_id=request_id, kind=kind, recipient=recipient, accepted=accepted,
                              delivery_verified=False, run_completed=exit_code == 0, cached=False,
                              local_status=native.get('local_status', []), detail=native.get('detail'),
                              native_error=native.get('native_error'),
                              text_bytes=native.get('text_bytes'), recipient_bytes=native.get('recipient_bytes'),
                              duration_ms=native.get('duration_ms'),
                              emoji_id=payload.get('emoji_id') if kind == 'emoji' else None,
                              journal=str(journal.path))
                code = 200 if accepted and exit_code == 0 else 502
            except Exception as error:
                journal.close('failed')
                code, result = 502, dict(request_id=request_id, kind=kind, recipient=recipient,
                                         accepted=False, delivery_verified=False, error=type(error).__name__)
            self.results[request_id] = fingerprint, code, result
            return code, result
        finally:
            self.lock.release()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int)
    parser.add_argument('--serve', action='store_true', help='Explicitly enable HTTP sends')
    parser.add_argument('--seconds', type=int, default=60)
    parser.add_argument('--send-seconds', type=int, default=15,
                        help='Per-send probe lifetime; lower values speed up batched tests')
    parser.add_argument('--port', type=int, default=17868)
    parser.add_argument('--emoji', action='store_true', help='Enable the current account favorite emoji catalog and sends')
    parser.add_argument('--db-dir', help='WeChat data root for the favorite catalog')
    parser.add_argument('--account', help='Account directory for the favorite catalog')
    parser.add_argument('--smoke', action='append', default=[], help='Explicit real HTTP test: kind=fixture_path')
    parser.add_argument('--smoke-recipient', default='filehelper',
                        help='Recipient for --smoke; must also be allowed by the policy')
    args = parser.parse_args()
    if not 1 <= args.seconds <= 60 or not 0 <= args.port <= 65535:
        parser.error('Invalid lifetime or port')
    if not 2 <= args.send_seconds <= 15:
        parser.error('--send-seconds must be between 2 and 15')
    if not args.serve:
        send_policy = SendPolicy.from_environment()
        print(json.dumps(dict(started=False, routes=['/send/' + kind for kind in KINDS],
                              recipients=list(send_policy.recipients), limits=send_policy.describe(),
                              scope='explicit recipients only; generated test data only; --serve required')))
        return 0
    if not args.pid or args.pid <= 0:
        parser.error('--serve requires a positive --pid')
    # Pin disk version before opening a listening socket; runtime checks repeat per call.
    config_for('context')
    send_policy = SendPolicy.from_environment()
    emoji_catalog = None
    if args.emoji:
        from emoji_media import create_catalog
        emoji_catalog = create_catalog(args.db_dir,args.account)
    token = secrets.token_urlsafe(32)
    bridge = SendBridge(args.pid, token, args.port, send_policy=send_policy,
                        send_seconds=args.send_seconds, emoji_catalog=emoji_catalog)
    directory = ROOT / 'runs' / 'send-api'
    directory.mkdir(parents=True, exist_ok=True)
    session_file = directory / 'send-api-session.json'
    url = 'http://127.0.0.1:%d' % bridge.port
    session_file.write_text(json.dumps(dict(url=url, token=token, seconds=args.seconds,
                                            recipients=list(send_policy.recipients))), encoding='utf-8')
    bridge.start()
    print(json.dumps(dict(session_file=str(session_file), url=url, recipients=list(send_policy.recipients))), flush=True)
    results = []
    deadline = threading.Timer(args.seconds, bridge.close)
    deadline.start()
    try:
        if args.smoke:
            for spec in args.smoke:
                kind, separator, value = spec.partition('=')
                if not separator or kind not in KINDS:
                    raise ValueError('Smoke requires kind=value')
                payload = dict(request_id=uuid.uuid4().hex, recipient=args.smoke_recipient)
                payload['text' if kind == 'text' else 'emoji_id' if kind == 'emoji' else 'path'] = value
                request = Request(url + '/send/' + kind, data=json.dumps(payload).encode(),
                                  headers={'Authorization':'Bearer ' + token, 'Content-Type':'application/json'})
                with urlopen(request, timeout=45) as response:
                    result = json.load(response)
                results.append(result)
                print(json.dumps(dict(event='http_send_smoke', **result)), flush=True)
        else:
            deadline.join()
    finally:
        deadline.cancel()
        if bridge.accepting:
            bridge.close()
        deadline.join()
        session_file.unlink(missing_ok=True)
        (directory / 'last-send-api-result.json').write_text(json.dumps(dict(http_results=results,
             requests=[result for _, _, result in bridge.results.values()]), indent=2), encoding='utf-8')
    return 0 if all(result['accepted'] and result['run_completed'] for result in results) else 1


if __name__ == '__main__':
    raise SystemExit(main())
