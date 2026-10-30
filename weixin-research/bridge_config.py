"""Configuration for the resident bridge service (P6).

Defaults stay local-only and narrow: loopback binding, explicit recipients, an
explicit conversation list and generated test media only.  A deployment widens
one thing at a time through environment variables or an explicit JSON file.
"""
import json
import os
from pathlib import Path

from policy import MEDIA_BYTES, ObservePolicy, SendPolicy
from profile import ROOT

_TRUE = ('1', 'true', 'yes', 'on')


def _bool(environ, name, default):
    raw = environ.get(name)
    if raw is None or raw == '':
        return default
    return raw.strip().lower() in _TRUE


def _int(environ, name, default):
    raw = environ.get(name)
    if raw is None or raw == '':
        return default
    try:
        return int(raw)
    except ValueError:
        raise ValueError('%s must be an integer' % name) from None


def _find_db_dir(environ):
    """Locate the account root when the operator did not name it explicitly."""
    candidates = [environ.get('WECHAT_DB_DIR')]
    home = Path.home()
    candidates += [r'E:\xwechat_files', str(home / 'Documents' / 'xwechat_files'),
                   str(home / 'xwechat_files'), r'D:\xwechat_files', r'C:\xwechat_files']
    for candidate in candidates:
        if not candidate:
            continue
        path = Path(candidate)
        try:
            if path.is_dir() and any((child / 'db_storage').is_dir() for child in path.iterdir()):
                return str(path)
        except OSError:
            continue
    return None


def _float(environ, name, default):
    raw = environ.get(name)
    if raw is None or raw == '':
        return default
    try:
        return float(raw)
    except ValueError:
        raise ValueError('%s must be a number' % name) from None


class BridgeConfig:
    def __init__(self, **values):
        self.port = int(values.get('port', 17870))
        self.host = '127.0.0.1'
        self.pid = values.get('pid')
        self.seconds = values.get('seconds')
        self.db_dir = values.get('db_dir')
        self.account = values.get('account')
        self.image_keys = values.get('image_keys')
        self.observe = values.get('observe') or ObservePolicy.from_environment()
        self.send = values.get('send') or SendPolicy.from_environment()
        conversations = values.get('conversations') or ()
        self.conversations = tuple(dict.fromkeys(str(item) for item in conversations if item))
        self.media = bool(values.get('media', True))
        self.download = bool(values.get('download', False))
        self.emoji = bool(values.get('emoji', False))
        self.history = bool(values.get('history', False))
        self.poll_seconds = float(values.get('poll_seconds', 1.0))
        self.media_refresh_seconds = float(values.get('media_refresh_seconds', 0.5))
        self.supervise_seconds = float(values.get('supervise_seconds', 3.0))
        self.send_timeout_ms = int(values.get('send_timeout_ms', 20000))
        self.send_wait_seconds = float(values.get('send_wait_seconds', 25.0))
        self.queue_capacity = int(values.get('queue_capacity', 64))
        self.event_capacity = int(values.get('event_capacity', 1024))
        self.event_log = bool(values.get('event_log', True))
        self.state_dir = Path(values.get('state_dir') or (ROOT / 'runs' / 'bridge'))
        self.token = values.get('token')
        self.token_file = Path(values.get('token_file') or (self.state_dir / 'token'))
        self.log_file = Path(values.get('log_file') or (self.state_dir / 'bridge.jsonl'))
        self.request_db = Path(values.get('request_db') or (self.state_dir / 'requests.db'))
        self.event_db = Path(values.get('event_db') or (self.state_dir / 'events.db'))
        self.media_cache = Path(values.get('media_cache') or (ROOT / 'runs' / 'media-cache'))
        self.retention_days = float(values.get('retention_days', 7.0))
        self._validate()

    def _validate(self):
        if not 0 <= self.port <= 65535:
            raise ValueError('port must be 0..65535')
        if self.pid is not None and (not isinstance(self.pid, int) or self.pid <= 0):
            raise ValueError('pid must be a positive integer')
        if self.seconds is not None and not 1 <= int(self.seconds) <= 86400:
            raise ValueError('seconds must be 1..86400')
        if not 0.5 <= self.poll_seconds <= 30:
            raise ValueError('poll_seconds must be 0.5..30')
        if not 0.2 <= self.media_refresh_seconds <= 30:
            raise ValueError('media_refresh_seconds must be 0.2..30')
        if not 1 <= self.supervise_seconds <= 60:
            raise ValueError('supervise_seconds must be 1..60')
        if not 1000 <= self.send_timeout_ms <= 120000:
            raise ValueError('send_timeout_ms must be 1000..120000')
        if not 1 <= self.send_wait_seconds <= 300:
            raise ValueError('send_wait_seconds must be 1..300')
        if not 1 <= self.queue_capacity <= 4096:
            raise ValueError('queue_capacity must be 1..4096')
        if not 16 <= self.event_capacity <= 100000:
            raise ValueError('event_capacity must be 16..100000')
        if not 0 <= self.retention_days <= 365:
            raise ValueError('retention_days must be 0..365')
        if not self.conversations:
            if self.observe.wildcard:
                raise ValueError('wildcard observation requires WECHAT_BOT_CONVERSATIONS with explicit ids')
            self.conversations = tuple(target for target in self.observe.targets)

    @classmethod
    def from_environment(cls, environ=None, path=None):
        environ = os.environ if environ is None else environ
        values = {}
        if path:
            raw = json.loads(Path(path).read_text(encoding='utf-8'))
            if not isinstance(raw, dict):
                raise ValueError('config file must contain a JSON object')
            allowed = {'port', 'pid', 'seconds', 'db_dir', 'account', 'image_keys',
                       'conversations', 'media', 'download', 'emoji', 'history', 'poll_seconds',
                       'media_refresh_seconds', 'supervise_seconds', 'send_timeout_ms',
                       'send_wait_seconds', 'queue_capacity', 'event_capacity', 'event_log',
                       'state_dir', 'log_file', 'request_db', 'event_db', 'media_cache',
                       'retention_days'}
            unknown = set(raw) - allowed
            if unknown:
                raise ValueError('unsupported config keys: ' + ','.join(sorted(unknown)))
            values.update(raw)
        conversations = environ.get('WECHAT_BOT_CONVERSATIONS', '')
        if conversations:
            values['conversations'] = tuple(item.strip() for item in conversations.split(',') if item.strip())
        if 'WECHAT_BOT_PORT' in environ:
            values['port'] = _int(environ, 'WECHAT_BOT_PORT', 17870)
        if 'WECHAT_BOT_PID' in environ:
            values['pid'] = _int(environ, 'WECHAT_BOT_PID', 0) or None
        if 'WECHAT_BOT_SECONDS' in environ:
            values['seconds'] = _int(environ, 'WECHAT_BOT_SECONDS', 0) or None
        if 'WECHAT_BOT_MEDIA' in environ:
            values['media'] = _bool(environ, 'WECHAT_BOT_MEDIA', True)
        if 'WECHAT_BOT_DOWNLOAD' in environ:
            values['download'] = _bool(environ, 'WECHAT_BOT_DOWNLOAD', False)
        if 'WECHAT_BOT_EMOJI' in environ:
            values['emoji'] = _bool(environ, 'WECHAT_BOT_EMOJI', False)
        if 'WECHAT_BOT_HISTORY' in environ:
            values['history'] = _bool(environ, 'WECHAT_BOT_HISTORY', False)
        if 'WECHAT_BOT_POLL_SECONDS' in environ:
            values['poll_seconds'] = _float(environ, 'WECHAT_BOT_POLL_SECONDS', 1.0)
        if 'WECHAT_BOT_QUEUE' in environ:
            values['queue_capacity'] = _int(environ, 'WECHAT_BOT_QUEUE', 64)
        if 'WECHAT_BOT_SEND_TIMEOUT_MS' in environ:
            values['send_timeout_ms'] = _int(environ, 'WECHAT_BOT_SEND_TIMEOUT_MS', 20000)
        if 'WECHAT_BOT_EVENT_CAPACITY' in environ:
            values['event_capacity'] = _int(environ, 'WECHAT_BOT_EVENT_CAPACITY', 1024)
        if 'WECHAT_BOT_EVENT_LOG' in environ:
            values['event_log'] = _bool(environ, 'WECHAT_BOT_EVENT_LOG', True)
        if 'WECHAT_BOT_TOKEN' in environ:
            values['token'] = environ['WECHAT_BOT_TOKEN']
        if 'WECHAT_BOT_STATE_DIR' in environ:
            values['state_dir'] = environ['WECHAT_BOT_STATE_DIR']
        values.setdefault('db_dir', environ.get('WECHAT_DB_DIR') or _find_db_dir(environ))
        values.setdefault('account', environ.get('WECHAT_DB_ACCOUNT') or None)
        values.setdefault('image_keys', environ.get('WECHAT_BOT_IMAGE_KEYS') or None)
        values['observe'] = ObservePolicy.from_environment(environ)
        values['send'] = SendPolicy.from_environment(environ)
        return cls(**values)

    def public(self):
        return dict(port=self.port, host=self.host, pid=self.pid,
                    conversations=list(self.conversations), media=self.media,
                    download=self.download, emoji=self.emoji, history=self.history,
                    poll_seconds=self.poll_seconds,
                    queue_capacity=self.queue_capacity,
                    send_timeout_ms=self.send_timeout_ms,
                    send_wait_seconds=self.send_wait_seconds,
                    event_capacity=self.event_capacity, event_log=self.event_log,
                    observe=self.observe.describe(), send=self.send.describe(),
                    retention_days=self.retention_days)
