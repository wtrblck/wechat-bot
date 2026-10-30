"""Short-lived localhost receive experiment for messages allowed by the observation policy.

The default scope is the file transfer helper plus the wxbot- marker; both the
native capture filter and this event store apply it, and a different target or an
empty prefix must be configured on purpose.
"""
import argparse
import hmac
import json
import os
import secrets
import threading
from collections import deque
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import parse_qs, urlsplit
from urllib.request import Request, urlopen

from event_model import normalize, self_ids_from_environment
from policy import DEDUP_CAPACITY, JSON_BODY_BYTES, ObservePolicy
from profile import ROOT, make_config
from probe import Journal, run_probe

# Current native capture schema; the older name is still accepted so recorded
# evidence can be replayed through the same store.
SYNC_SCHEMAS = ('wechat-sync-ring-1', 'wechat-db-1', 'experimental-sync-0x70')


class EventStore:
    """Bounded event buffer with an explicit, bounded dedup window.

    ``sequence`` and the dedup keys can be persisted across restarts; the events
    themselves are deliberately not durable yet, so a client resuming with an old
    cursor is told ``truncated`` instead of silently missing messages.
    """

    def __init__(self, capacity=128, observe=None, dedup_capacity=DEDUP_CAPACITY,
                 self_ids=(), state_path=None, source_name='wechat-sync', journal=None):
        self.lock = threading.Lock()
        self.messages = deque(maxlen=capacity)
        self.journal = journal
        self.observe = observe or ObservePolicy.from_environment()
        self.dedup_capacity = dedup_capacity
        self.dedup_order = deque()
        self.seen = set()
        self.sequence = 0
        self.state = 'starting'
        self.self_ids = frozenset(self_ids)
        self.source_name = source_name
        self.state_path = Path(state_path) if state_path else None
        self.journal_path = Path(journal.path) if journal is not None else None
        self.persisted = False
        self.counters = dict(received=0, published=0, duplicate=0, filtered_prefix=0,
                             filtered_target=0, filtered_schema=0, invalid_id=0, evicted=0)
        self._load_state()
        if self.journal is not None:
            # Events appended after the last state save must not be renumbered.
            self.sequence = max(self.sequence, self.journal.max_seq())

    def _load_state(self):
        if self.state_path is None or not self.state_path.is_file():
            return
        try:
            data = json.loads(self.state_path.read_text(encoding='utf-8'))
            sequence = data.get('sequence', 0)
            if not isinstance(sequence, int) or sequence < 0:
                raise ValueError('invalid sequence')
            self.sequence = sequence
            keys = data.get('dedup', [])
            if not isinstance(keys, list):
                raise ValueError('invalid dedup list')
            for key in keys[-self.dedup_capacity:]:
                if isinstance(key, list) and key:
                    self._remember(tuple(str(part) for part in key))
            self.persisted = True
        except (OSError, ValueError, TypeError):
            self.sequence = 0
            self.persisted = False

    def save(self):
        """Persist the cursor and dedup window atomically; events stay in memory."""
        if self.state_path is None:
            return False
        with self.lock:
            data = dict(sequence=self.sequence,
                        dedup=[list(key) for key in self.dedup_order])
        self.state_path.parent.mkdir(parents=True, exist_ok=True)
        temporary = self.state_path.with_suffix(self.state_path.suffix + '.tmp')
        temporary.write_text(json.dumps(data, ensure_ascii=False), encoding='utf-8')
        temporary.replace(self.state_path)
        return True

    def _remember(self, key):
        self.seen.add(key)
        self.dedup_order.append(key)
        while len(self.dedup_order) > self.dedup_capacity:
            self.seen.discard(self.dedup_order.popleft())

    def ingest(self, event):
        with self.lock:
            kind = event.get('event')
            if kind == 'started':
                self.state = 'observing'
            elif kind in ('run_error', 'script_error', 'host_timeout'):
                self.state = 'failed'
            elif kind == 'session_detached' and not event.get('expected'):
                self.state = 'failed'
            elif kind == 'run_finished':
                self.state = 'stopped' if event.get('outcome') == 'completed' else 'failed'
            if kind != 'test_message':
                return
            self.counters['received'] += 1
            if event.get('schema') not in SYNC_SCHEMAS:
                self.counters['filtered_schema'] += 1
                return
            content = event.get('content')
            if not self.observe.content_allowed(content):
                self.counters['filtered_prefix'] += 1
                return
            if not self.observe.conversation_allowed(event.get('sender'), event.get('recipient')):
                self.counters['filtered_target'] += 1
                return
            message_id = str(event.get('message_id', ''))
            if not message_id or message_id == '0':
                self.counters['invalid_id'] += 1
                return
            key = (message_id, event.get('sender'), event.get('recipient'))
            if key in self.seen:
                self.counters['duplicate'] += 1
                return
            self._remember(key)
            if len(self.messages) == self.messages.maxlen:
                self.counters['evicted'] += 1
            self.sequence += 1
            self.counters['published'] += 1
            published = dict(event, sequence=self.sequence,
                             source=event.get('source', 'wechat-sync'),
                             **normalize(event, self.self_ids))
            self.messages.append(published)
            if self.journal is not None:
                self.journal.append(self.sequence, published)
            return True

    def update_media(self, message_id, media):
        with self.lock:
            for event in self.messages:
                if event['message_id'] == message_id:
                    event['media'] = media
            if self.journal is not None:
                self.journal.update_media(message_id, media)

    def health(self):
        with self.lock:
            return dict(state=self.state, send_ready=False,
                        receive_scope=self.observe.describe(),
                        received=self.sequence, source=self.source_name,
                        counters=dict(self.counters),
                        dedup_window=self.dedup_capacity, capacity=self.messages.maxlen,
                        self_ids_configured=bool(self.self_ids),
                        state_file=str(self.state_path) if self.state_path else None,
                        durable_events=self.journal is not None,
                        event_journal=str(self.journal_path) if self.journal_path else None,
                        event_journal_min=self.journal.min_seq() if self.journal is not None else None,
                        event_journal_max=self.journal.max_seq() if self.journal is not None else None,
                        state_restored=self.persisted)

    def read(self, after):
        with self.lock:
            oldest = self.messages[0]['sequence'] if self.messages else self.sequence + 1
            if after >= oldest - 1 or self.journal is None:
                return dict(events=[e for e in self.messages if e['sequence'] > after],
                            cursor=self.sequence, truncated=after < oldest - 1,
                            counters=dict(self.counters))
        # The cursor predates the in-memory buffer; serve the durable tail if it
        # still covers the gap, otherwise report truncation instead of skipping.
        minimum, maximum = self.journal.min_seq(), self.journal.max_seq()
        events = self.journal.read(after, 500)
        return dict(events=events, cursor=max(self.sequence, maximum),
                    truncated=after + 1 < minimum, counters=dict(self.counters))


class ReceiveServer:
    def __init__(self, store, token, port=17867, on_post=None, body_bytes=JSON_BODY_BYTES, media_store=None, on_get=None):
        self.store = store
        self.token = token
        self.body_bytes = body_bytes
        owner = self

        class Handler(BaseHTTPRequestHandler):
            def log_message(self, format, *args):
                pass

            def reply(self, code, payload):
                data = json.dumps(payload, ensure_ascii=False).encode('utf-8')
                self.send_response(code)
                self.send_header('Content-Type', 'application/json; charset=utf-8')
                self.send_header('Content-Length', str(len(data)))
                self.send_header('Cache-Control', 'no-store')
                self.send_header('X-Content-Type-Options', 'nosniff')
                self.end_headers()
                self.wfile.write(data)

            def allowed(self):
                if self.headers.get('Host') != '127.0.0.1:%d' % owner.port:
                    self.reply(403, dict(error='invalid_host'))
                    return False
                supplied = self.headers.get('Authorization', '')
                if not hmac.compare_digest(supplied, 'Bearer ' + owner.token):
                    self.reply(401, dict(error='unauthorized'))
                    return False
                return True

            def reply_binary(self, data, mime):
                self.send_response(200)
                self.send_header('Content-Type', mime)
                self.send_header('Content-Length', str(len(data)))
                self.send_header('Content-Disposition', 'attachment')
                self.send_header('Cache-Control', 'no-store')
                self.send_header('X-Content-Type-Options', 'nosniff')
                self.end_headers()
                self.wfile.write(data)

            def do_GET(self):
                if not self.allowed():
                    return
                route = urlsplit(self.path)
                if route.path == '/health':
                    self.reply(200, store.health())
                elif route.path == '/events':
                    try:
                        values = parse_qs(route.query)
                        after = int(values.get('after', ['0'])[0])
                        if after < 0:
                            raise ValueError()
                    except ValueError:
                        self.reply(400, dict(error='invalid_cursor'))
                        return
                    self.reply(200, store.read(after))
                elif route.path.startswith('/media/') and media_store is not None:
                    parts = route.path.split('/')
                    if len(parts) not in (3, 4) or (len(parts) == 4 and parts[3] != 'content'):
                        self.reply(404, dict(error='not_found'))
                        return
                    media_id = parts[2]
                    if len(parts) == 3:
                        metadata = media_store.metadata(media_id)
                        self.reply(200 if metadata else 404, metadata or dict(error='media_not_found'))
                        return
                    variant = parse_qs(route.query).get('variant', ['content'])[0]
                    code, payload = media_store.content(media_id, variant)
                    if code != 200:
                        self.reply(code, payload)
                        return
                    self.reply_binary(*payload)
                elif on_get is not None:
                    code, payload = on_get(route.path, parse_qs(route.query))
                    if code == 200 and isinstance(payload, tuple):
                        self.reply_binary(*payload)
                    else:
                        self.reply(code, payload)
                else:
                    self.reply(404, dict(error='not_found'))

            def do_POST(self):
                if not self.allowed():
                    return
                if on_post is None:
                    self.reply(501, dict(error='send_not_implemented', send_ready=False))
                    return
                try:
                    length = int(self.headers.get('Content-Length', '0'))
                    if not 0 < length <= owner.body_bytes or self.headers.get('Transfer-Encoding'):
                        raise ValueError('invalid_body_length')
                    if self.headers.get_content_type() != 'application/json':
                        raise ValueError('json_required')
                    self.connection.settimeout(5)
                    raw = self.rfile.read(length)
                    if len(raw) != length:
                        raise ValueError('incomplete_body')
                    payload = json.loads(raw)
                    if not isinstance(payload, dict):
                        raise ValueError('object_required')
                except (ValueError, OSError) as error:
                    self.reply(400, dict(error=str(error)))
                    return
                code, result = on_post(urlsplit(self.path).path, payload)
                self.reply(code, result)

        self.server = ThreadingHTTPServer(('127.0.0.1', port), Handler)
        self.server.daemon_threads = True
        self.port = self.server.server_port
        self.thread = threading.Thread(target=self.server.serve_forever, daemon=True)

    def start(self):
        self.thread.start()

    def close(self):
        self.server.shutdown()
        self.server.server_close()
        self.thread.join(timeout=3)


class FeedJournal(Journal):
    def __init__(self, directory, store):
        super().__init__(directory)
        self.store = store

    def emit(self, event):
        super().emit(event)
        self.store.ingest(event)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, required=True)
    parser.add_argument('--seconds', type=int, default=60)
    parser.add_argument('--port', type=int, default=17867)
    parser.add_argument('--expect', help='Verify that this exact test text arrives through HTTP')
    parser.add_argument('--state-file', type=Path,
                        help='Persist the event cursor and dedup window across restarts')
    args = parser.parse_args()
    if args.pid <= 0 or not 0 <= args.port <= 65535:
        parser.error('Invalid PID or port')
    observe = ObservePolicy.from_environment()
    self_ids = self_ids_from_environment()
    config = make_config('sync_process_candidate', args.seconds)
    config.update(callback_backend='native', capture_test=True, capture_kind='receive',
                  capture_filter=observe.describe())
    store = EventStore(observe=observe, self_ids=self_ids, state_path=args.state_file)
    token = os.environ.get('WECHAT_BOT_TOKEN') or secrets.token_urlsafe(32)
    bridge = ReceiveServer(store, token, args.port)
    directory = ROOT / 'runs' / 'api'
    directory.mkdir(parents=True, exist_ok=True)
    session_file = directory / 'api-session.json'
    session_file.write_text(json.dumps(dict(url='http://127.0.0.1:%d' % bridge.port,
                                             token=token, seconds=args.seconds,
                                             observe=observe.describe(),
                                             state_file=str(args.state_file) if args.state_file else None),
                                        ensure_ascii=False), encoding='utf-8')
    journal = None
    bridge.start()
    print(json.dumps(dict(api_session=str(session_file), url='http://127.0.0.1:%d' % bridge.port,
                          observe=observe.describe()), ensure_ascii=False), flush=True)
    stop_check = threading.Event()
    check_result = {}

    def check_http():
        try:
            url = 'http://127.0.0.1:%d' % bridge.port
            headers = dict(Authorization='Bearer ' + token)
            while not stop_check.is_set():
                with urlopen(Request(url + '/events?after=0', headers=headers), timeout=3) as response:
                    payload = json.load(response)
                matches = [e for e in payload['events'] if e.get('content') == args.expect]
                if matches:
                    check_result.update(passed=True, via='HTTP GET /events', message=matches[0])
                    print(json.dumps(dict(event='http_smoke_passed', content=args.expect)), flush=True)
                    return
                stop_check.wait(0.5)
            check_result.update(passed=False, error='Expected text did not arrive through HTTP')
        except Exception as error:
            check_result.update(passed=False, error=str(error))

    checker = threading.Thread(target=check_http, daemon=True) if args.expect else None
    if checker:
        checker.start()
    result_code = 1
    try:
        journal = FeedJournal(directory, store)
        result_code = run_probe(args.pid, config, journal)
    finally:
        stop_check.set()
        if checker:
            checker.join(timeout=4)
        store.save()
        (directory / 'last-api-result.json').write_text(
            json.dumps(dict(health=store.health(), result=store.read(0),
                            http_check=check_result,
                            journal=str(journal.path) if journal else None), ensure_ascii=False, indent=2), encoding='utf-8')
        bridge.close()
        session_file.unlink(missing_ok=True)
    return result_code if not args.expect or check_result.get('passed') else 1


if __name__ == '__main__':
    raise SystemExit(main())
