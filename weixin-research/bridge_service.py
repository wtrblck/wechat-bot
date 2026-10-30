"""Resident localhost bridge: one process, one token, one send queue (P5/P6).

Receives hook-free from the local WeChat databases, sends through one long-lived
Frida session, keeps a durable request store and reports explicit states.  The
only manual step a bot needs is polling ``/events`` and posting ``/send/*``.

    py -3.14 weixin-research/bridge_service.py --pid 1234 --download

Temporary ``--seconds`` exists for tests; the default lifetime is unbounded.
"""
import argparse
import hashlib
import json
import logging
import logging.handlers
import os
import queue
import re
import secrets
import signal
import threading
import time
from pathlib import Path

from active_send import config_for, pinned_image
from bridge_config import BridgeConfig
from event_log import EventLog
from policy import PolicyError, REQUEST_ID_PATTERN
from profile import DLL, SHA256, VERSION
from process_discovery import find_main_pid, process_alive
from receive_api import EventStore, ReceiveServer
from request_store import (CANCELLED, FAILED, LOCAL_ACCEPTED, MESSAGE_RECORDED,
                           PREPARED, QUEUED, SENDING, SERVER_CONFIRMED, TERMINAL,
                           UNKNOWN, RequestConflict, RequestStore)
from send_worker import SendWorker, payload_from_config
from worker_session import WorkerUnavailable

# Imported lazily inside the runtime so unit tests can inject fakes without the
# native dependencies.  The public API keeps the same names.

STATE_STARTING = 'starting'
STATE_READY = 'ready'
STATE_DEGRADED = 'degraded'
STATE_BLOCKED = 'blocked'
STATE_STOPPING = 'stopping'


def _error_status(code):
    if code in ('recipient_not_allowed',):
        return 403
    if code in ('media_too_large', 'json_body_bytes'):
        return 413
    if code in ('image_format_unsupported', 'image_format_not_allowed',
                'video_format_unsupported', 'audio_format_unsupported',
                'audio_sample_rate_unsupported', 'audio_duration_out_of_range'):
        return 415
    if code in ('queue_full', 'sender_busy'):
        return 429
    if code in ('worker_unavailable', 'send_worker_unavailable'):
        return 503
    if code in ('native_send_failed',):
        return 502
    return 400


class BridgeRuntime:
    """One account connection: DB source, event store, workers and threads."""

    def __init__(self, config, pid, *, log=None, requests=None):
        self.config = config
        self.pid = pid
        self.log = log or (lambda event: None)
        self.requests = requests
        self.stop = threading.Event()
        self.db_lock = threading.RLock()
        self.stuck = False
        self.closed = False
        self.created = time.monotonic()
        self.last_poll = 0.0
        self.last_poll_error = None
        self.poll_errors = 0
        self.last_tracker_error = None
        from wechat_db import DatabaseSource
        self.source = DatabaseSource(config.db_dir, config.account,
                                     state_path=config.state_dir / 'watermarks.json')
        self.self_ids = frozenset({self.source.self_wxid} | set(
            item.strip() for item in os.environ.get('WECHAT_BOT_SELF', '').split(',') if item.strip()))
        journal = EventLog(config.event_db) if config.event_log else None
        self.store = EventStore(capacity=config.event_capacity, observe=config.observe,
                                self_ids=self.self_ids,
                                state_path=config.state_dir / 'events-state.json',
                                source_name='wechat-db', journal=journal)
        if not config.history:
            # A fresh bridge starts at the current tail instead of replaying chat
            # history.  Existing watermarks are kept, so a restart catches up.
            for conversation in config.conversations:
                if conversation not in self.source.watermarks:
                    try:
                        self.source.watermarks[conversation] = self.source.latest_sort_seq(conversation)
                    except Exception:
                        self.source.watermarks[conversation] = 0
            self.source.save_state()
        self.store.ingest(dict(event='started'))
        self.media_store = None
        self.download_queue = None
        self.download_worker = None
        if config.media:
            try:
                from media_receive import LocalMediaBackend, MediaStore
                backend = LocalMediaBackend(self.source.db, config.image_keys,
                                            download_emoji=config.download and config.emoji,
                                            lock=self.db_lock)
                self.media_store = MediaStore(backend,
                                              config.media_cache / secrets.token_hex(8))
            except Exception as error:
                self.log(dict(event='media_unavailable', error=type(error).__name__))
                self.media_store = None
        if config.download and self.media_store is not None:
            try:
                from media_download import DownloadQueue, NativeDownloadWorker
                self.download_worker = NativeDownloadWorker(pid, config.observe,
                                                            on_event=self.log)
                self.download_queue = DownloadQueue(self.download_worker, config.observe)
            except Exception as error:
                self.log(dict(event='download_unavailable', error=type(error).__name__))
                self.download_worker = None
                self.download_queue = None
        self.send_worker = SendWorker(pid, config.send, on_event=self.log)
        from message_tracker import MessageTracker
        self.tracker = MessageTracker(self.source, self.query, on_transition=self.log)
        self._media_state = {}
        self.threads = []
        self._start_thread(self._receive_loop, 'bridge-receive')
        if self.media_store is not None:
            self._start_thread(self._media_loop, 'bridge-media')
        self._start_thread(self._tracker_loop, 'bridge-tracker')

    def _start_thread(self, target, name):
        thread = threading.Thread(target=target, name=name, daemon=True)
        thread.start()
        self.threads.append(thread)

    def query(self, conversation, since, limit):
        with self.db_lock:
            return self.source.messages_since(conversation, since, limit)

    def latest_seq(self, conversation):
        with self.db_lock:
            return self.source.latest_sort_seq(conversation)

    def _receive_loop(self):
        while not self.stop.is_set():
            try:
                for conversation in self.config.conversations:
                    with self.db_lock:
                        events = self.source.poll(conversation)
                    for event in events:
                        published = self.store.ingest(event)
                        if published and self.media_store is not None and event.get('media'):
                            media = self.media_store.register(event)
                            self.store.update_media(event['message_id'], media)
                with self.db_lock:
                    self.source.save_state()
                self.last_poll = time.monotonic()
                self.last_poll_error = None
            except Exception as error:
                self.poll_errors += 1
                self.last_poll_error = type(error).__name__
                self.last_poll = time.monotonic()
                self.log(dict(event='receive_error', error=self.last_poll_error))
            self.stop.wait(self.config.poll_seconds)

    def _media_loop(self):
        while not self.stop.is_set():
            try:
                self.media_store.refresh()
                if self.download_queue is not None:
                    self.media_store.synchronize_downloads(self.download_queue)
                changed = False
                for message_id, media in self.media_store.snapshot():
                    marker = json.dumps(media, sort_keys=True, ensure_ascii=False)
                    if self._media_state.get(message_id) != marker:
                        self.store.update_media(message_id, media)
                        self._media_state[message_id] = marker
                        changed = True
                if changed:
                    self.log(dict(event='media_updated', items=len(self._media_state)))
            except Exception as error:
                self.log(dict(event='media_error', error=type(error).__name__))
            self.stop.wait(self.config.media_refresh_seconds)

    def _tracker_loop(self):
        while not self.stop.is_set():
            try:
                if self.requests is not None:
                    self.tracker.poll(self.requests)
                self.last_tracker_error = None
            except Exception as error:
                self.last_tracker_error = '%s: %s' % (type(error).__name__, str(error)[:200])
                self.log(dict(event='tracker_error', detail=self.last_tracker_error))
            self.stop.wait(1.0)

    @property
    def send_alive(self):
        if not self.send_worker.alive or self.send_worker.poisoned:
            return False
        if self.download_worker is not None:
            if not self.download_worker.alive or self.download_worker.poisoned:
                return False
        return True

    def health(self):
        receive = self.store.health()
        age = time.monotonic() - self.last_poll if self.last_poll else None
        media = self.media_store.stats() if self.media_store is not None else None
        return dict(pid=self.pid, alive=process_alive(self.pid), uptime_s=round(time.monotonic() - self.created, 1),
                    last_poll_age_s=None if age is None else round(age, 2),
                    poll_errors=self.poll_errors, last_poll_error=self.last_poll_error,
                    last_tracker_error=self.last_tracker_error,
                    send_worker=self.send_worker.health(),
                    download_worker=self.download_worker.health() if self.download_worker else None,
                    tracker=self.tracker.health(), media=media, receive=receive,
                    stuck=self.stuck)

    def close(self):
        if self.closed:
            return True
        self.stop.set()
        for thread in self.threads:
            thread.join(timeout=30 if thread.name == 'bridge-media' else 10)
        lingering = [thread.name for thread in self.threads if thread.is_alive()]
        if lingering:
            self.log(dict(event='threads_lingering', names=lingering))
        if self.download_queue is not None:
            try:
                self.download_queue.close()
            except Exception:
                pass
        clean = True
        if self.download_worker is not None:
            clean = self.download_worker.close() and clean
        clean = self.send_worker.close() and clean
        if not clean:
            self.stuck = True
        self.store.ingest(dict(event='run_finished', outcome='completed' if clean else 'failed'))
        try:
            self.store.save()
        except Exception:
            pass
        if self.store.journal is not None:
            try:
                self.store.journal.trim(self.config.retention_days)
                self.store.journal.close()
            except Exception:
                pass
        with self.db_lock:
            try:
                self.source.save_state()
            except Exception:
                pass
        if self.media_store is not None and not any(name == 'bridge-media' for name in lingering):
            try:
                self.media_store.close()
            except Exception:
                pass
        self.closed = True
        return clean


class BridgeView:
    def __init__(self, service):
        self.service = service

    def read(self, after):
        runtime = self.service.runtime
        if runtime is None:
            return dict(events=[], cursor=0, truncated=False, counters={})
        return runtime.store.read(after)

    def health(self):
        return self.service.health()


class MediaView:
    def __init__(self, service):
        self.service = service

    def _store(self):
        runtime = self.service.runtime
        return runtime.media_store if runtime is not None else None

    def metadata(self, media_id):
        store = self._store()
        return store.metadata(media_id) if store is not None else None

    def content(self, media_id, variant='content'):
        store = self._store()
        if store is None:
            return 404, dict(error='media_not_found')
        return store.content(media_id, variant)


class BridgeService:
    def __init__(self, config, token, *, runtime_factory=None, send_wait=None):
        self.config = config
        self.token = token
        self.runtime = None
        self.runtime_factory = runtime_factory
        self.state = STATE_STARTING
        self.last_error = None
        self.blocked = False
        self.recovered = []
        self.started = time.monotonic()
        self.stop = threading.Event()
        self.lock = threading.RLock()
        self.requests = RequestStore(config.request_db)
        try:
            self.recovered = self.requests.recover()
        except Exception:
            self.recovered = []
        config.log_file.parent.mkdir(parents=True, exist_ok=True)
        self.logger = logging.getLogger('wechat_bridge.%d' % id(self))
        self.logger.setLevel(logging.INFO)
        self.logger.propagate = False
        handler = logging.handlers.RotatingFileHandler(
            config.log_file, maxBytes=10 * 1024 * 1024, backupCount=5, encoding='utf-8')
        handler.setFormatter(logging.Formatter('%(asctime)s %(message)s'))
        self.logger.addHandler(handler)
        self.queue = queue.Queue(maxsize=config.queue_capacity)
        self.in_flight = None
        self.sender = threading.Thread(target=self._send_loop, name='bridge-sender', daemon=True)
        self.supervisor = threading.Thread(target=self._supervise, name='bridge-supervisor', daemon=True)
        self.view = BridgeView(self)
        self.media_view = MediaView(self)
        self.emoji_catalog = None
        if config.emoji:
            try:
                from emoji_media import create_catalog
                self.emoji_catalog = create_catalog(config.db_dir, config.account)
            except Exception as error:
                self.last_error = 'emoji_catalog_unavailable'
                self.emoji_catalog = None
        self.server = ReceiveServer(self.view, token, config.port, on_post=self.post,
                                    media_store=self.media_view, on_get=self.get)
        self.server.server.daemon_threads = False
        self.port = self.server.port
        self.send_wait = config.send_wait_seconds if send_wait is None else send_wait
        self.http_started = False

    # ------------------------------------------------------------------ startup
    def start(self):
        self.server.start()
        self.http_started = True
        self.sender.start()
        self.supervisor.start()
        return self.port

    def _runtime_kwargs(self):
        return dict(log=self._log)

    def _log(self, event):
        item = dict(event, at=time.time())
        try:
            self.logger.info(json.dumps(item, ensure_ascii=False))
        except Exception:
            pass
        with self.lock:
            self._events = getattr(self, '_events', [])
            self._events.append(item)
            del self._events[:-200]

    def _resolve_pid(self):
        if self.config.pid:
            try:
                from probe import process_path
                if process_alive(self.config.pid) and \
                        process_path(self.config.pid).name.lower() == 'weixin.exe':
                    return self.config.pid
            except Exception:
                pass
            self._log(dict(event='configured_pid_stale', pid=self.config.pid))
        return find_main_pid(DLL)

    def _build_runtime(self):
        if self.runtime_factory is not None:
            return self.runtime_factory(self.config)
        pid = self._resolve_pid()
        return BridgeRuntime(self.config, pid, requests=self.requests, **self._runtime_kwargs())

    def _supervise(self):
        failures = 0
        while not self.stop.is_set():
            try:
                runtime = self.runtime
                if self.blocked:
                    self.state = STATE_BLOCKED
                    if not self.last_error:
                        self.last_error = 'native_callback_running'
                    self.stop.wait(self.config.supervise_seconds)
                    continue
                if runtime is None:
                    try:
                        runtime = self._build_runtime()
                        with self.lock:
                            self.runtime = runtime
                        self.state = STATE_READY
                        self.last_error = None
                        failures = 0
                    except Exception as error:
                        failures += 1
                        text = str(error)
                        self.state = STATE_DEGRADED
                        self.last_error = '%s: %s' % (type(error).__name__, text[:300])
                        if 'SHA256' in text or 'ABI profile' in text or 'Pinned DLL' in text:
                            self.blocked = True
                            self.state = STATE_BLOCKED
                            self.last_error = 'unsupported_version: ' + text[:200]
                        self._log(dict(event='runtime_unavailable', error=type(error).__name__,
                                       detail=text[:300]))
                elif runtime.stuck:
                    self.blocked = True
                    self.state = STATE_BLOCKED
                    self.last_error = 'native_callback_running'
                else:
                    health = runtime.health()
                    if not health['alive'] or not runtime.send_alive:
                        self.state = STATE_DEGRADED
                        self.last_error = 'weixin_or_worker_unavailable'
                        self._replace_runtime('weixin_or_worker_unavailable')
                    elif health['last_poll_age_s'] is None or health['last_poll_age_s'] > max(30, self.config.poll_seconds * 20):
                        self.state = STATE_DEGRADED
                        self.last_error = 'receive_stalled'
                    else:
                        self.state = STATE_READY
                        self.last_error = None
                self._maintenance()
            except Exception as error:
                self.state = STATE_DEGRADED
                self.last_error = type(error).__name__
                self._log(dict(event='supervisor_error', error=type(error).__name__))
            self.stop.wait(self.config.supervise_seconds)

    def _replace_runtime(self, reason):
        with self.lock:
            old = self.runtime
            if old is None:
                return
            for request_id in list(old.tracker.jobs):
                request = self.requests.get(request_id)
                if request and request['state'] in (LOCAL_ACCEPTED, MESSAGE_RECORDED):
                    try:
                        self.requests.update(request_id, UNKNOWN, reason='reconnect_lost_tracking')
                    except (KeyError, ValueError):
                        pass
            self.runtime = None
            clean = old.close()
            self._log(dict(event='runtime_replaced', reason=reason, clean=clean))
            if not clean:
                self.blocked = True
                self.state = STATE_BLOCKED
                self.last_error = 'old_runtime_stuck'

    def _maintenance(self):
        if self.config.event_log:
            try:
                runtime = self.runtime
                if runtime is not None and runtime.store.journal is not None:
                    runtime.store.journal.trim(self.config.retention_days)
            except Exception:
                pass
        try:
            from media_input import cleanup_staging
            cleanup_staging(ttl=3600)
        except Exception:
            pass
        try:
            if self.config.retention_days > 0:
                self.requests.purge(time.time() - self.config.retention_days * 86400)
        except Exception:
            pass

    # ------------------------------------------------------------------- health
    def health(self):
        runtime = self.runtime
        runtime_health = runtime.health() if runtime is not None else None
        receive = runtime_health.pop('receive') if runtime_health else dict(state='unavailable', counters={})
        media = runtime_health.get('media') if runtime_health else None
        queue_depth = self.queue.qsize()
        counts = self.requests.counts()
        return dict(state=self.state, ready=self.state == STATE_READY,
                    send_ready=bool(self.state == STATE_READY and runtime is not None and runtime.send_alive),
                    receive_ready=bool(runtime_health and runtime_health.get('last_poll_age_s') is not None and
                                       runtime_health['last_poll_age_s'] < max(30, self.config.poll_seconds * 20)),
                    delivery_verified=False, pid=runtime.pid if runtime else None,
                    profile=dict(version=VERSION, dll=str(DLL), sha256=SHA256),
                    runtime=runtime_health, receive=receive,
                    media=media, queue=dict(depth=queue_depth, capacity=self.config.queue_capacity,
                                            in_flight=self.in_flight),
                    requests=dict(counts=counts, recovered=len(self.recovered)),
                    supervisor=dict(last_error=self.last_error,
                                    events=list(getattr(self, '_events', [])[-20:])),
                    config=self.config.public(), uptime_s=round(time.monotonic() - self.started, 1))

    # --------------------------------------------------------------------- send
    def _status_code(self, request):
        state = request['state']
        if state in (LOCAL_ACCEPTED, MESSAGE_RECORDED, SERVER_CONFIRMED):
            return 200
        if state == FAILED:
            return _error_status(request.get('error_code'))
        if state == CANCELLED:
            return 409
        if state == UNKNOWN:
            return 200
        return 202

    def _public(self, request, cached=False):
        result = dict(request)
        result['delivery_verified'] = False
        result['cached'] = bool(cached)
        if request['state'] in (FAILED, CANCELLED, UNKNOWN):
            result['error'] = request.get('error_code') or request.get('reason') or request['state']
        return result

    def _fingerprint(self, kind, payload):
        fields = {key: payload.get(key) for key in ('recipient', 'text', 'path', 'emoji_id')
                  if key in payload}
        return hashlib.sha256(json.dumps([kind, fields], sort_keys=True).encode('utf-8')).hexdigest()

    def post(self, route, payload):
        if route.startswith('/request/') and route.endswith('/cancel'):
            request_id = route.split('/')[2]
            try:
                request = self.requests.cancel(request_id)
            except KeyError:
                return 404, dict(error='request_not_found')
            if request is None:
                return 409, dict(error='request_not_cancellable')
            return 200, self._public(request)
        if not route.startswith('/send/'):
            return 404, dict(error='not_found')
        kind = route.removeprefix('/send/')
        if kind not in ('text', 'image', 'file', 'video', 'voice', 'emoji'):
            return 404, dict(error='not_found')
        if not isinstance(payload, dict):
            return 400, dict(error='object_required')
        field = {'text': 'text', 'image': 'path', 'file': 'path', 'video': 'path',
                 'voice': 'path', 'emoji': 'emoji_id'}[kind]
        allowed = {'request_id', 'recipient', field, 'wait'}
        if set(payload) - allowed or 'request_id' not in payload or 'recipient' not in payload or field not in payload:
            return 400, dict(error='unexpected_or_missing_fields')
        if not isinstance(payload.get('wait', True), bool):
            return 400, dict(error='invalid_wait')
        request_id = payload.get('request_id')
        if not isinstance(request_id, str) or not re.fullmatch(REQUEST_ID_PATTERN, request_id):
            return 400, dict(error='valid_request_id_required')
        recipient = payload.get('recipient')
        if not isinstance(recipient, str):
            return 400, dict(error='valid_recipient_required')
        try:
            self.config.send.encode_recipient(recipient)
            if kind == 'text':
                self.config.send.encode_text(payload.get('text'))
        except PolicyError as error:
            return _error_status(error.code), dict(error=error.code, detail=str(error))
        if kind == 'emoji' and self.emoji_catalog is None:
            return 503, dict(error='emoji_catalog_disabled')
        if kind != 'text' and (not isinstance(payload.get(field), str) or not payload.get(field)):
            return 400, dict(error='valid_' + field + '_required')
        fingerprint = self._fingerprint(kind, payload)
        try:
            request, cached = self.requests.create(request_id, fingerprint, kind, recipient)
        except RequestConflict:
            return 409, dict(error='request_id_conflict')
        if cached:
            return self._status_code(request), self._public(request, cached=True)
        self._log(dict(event='request_created', request_id=request_id, kind=kind))
        try:
            self.requests.update(request_id, QUEUED)
        except ValueError:
            return self._status_code(self.requests.get(request_id)), self._public(
                self.requests.get(request_id))
        try:
            self.queue.put_nowait(dict(request_id=request_id, kind=kind, payload=payload))
        except queue.Full:
            self.requests.update(request_id, FAILED, error_code='queue_full', reason='queue_full')
            return 429, self._public(self.requests.get(request_id))
        wait = payload.get('wait', True)
        if not wait:
            return 202, self._public(self.requests.get(request_id))
        deadline = time.monotonic() + self.send_wait
        while time.monotonic() < deadline:
            request = self.requests.get(request_id)
            if request['state'] in TERMINAL or request['state'] in (
                    LOCAL_ACCEPTED, MESSAGE_RECORDED, SERVER_CONFIRMED):
                return self._status_code(request), self._public(request)
            time.sleep(0.05)
        request = self.requests.get(request_id)
        return 202, self._public(request)

    def _send_loop(self):
        while not self.stop.is_set():
            try:
                item = self.queue.get(timeout=0.5)
            except queue.Empty:
                continue
            request_id = item['request_id']
            request = self.requests.get(request_id)
            if request is None or request['state'] not in (PREPARED, QUEUED):
                continue
            self.in_flight = request_id
            try:
                self._dispatch(item)
            except Exception as error:
                self._log(dict(event='dispatch_error', request_id=request_id,
                               error=type(error).__name__, detail=str(error)[:200]))
                try:
                    current = self.requests.get(request_id)
                    if current and current['state'] not in TERMINAL:
                        self.requests.update(request_id, UNKNOWN, reason='dispatch_error')
                except Exception:
                    pass
            finally:
                self.in_flight = None
                finished = self.requests.get(request_id)
                if finished is not None:
                    self._log(dict(event='dispatch_completed', request_id=request_id,
                                   state=finished['state'], message_id=finished['message_id'],
                                   server_id=finished['server_id'],
                                   error=finished.get('error_code') or finished.get('reason')))

    def _dispatch(self, item):
        request_id, kind, payload = item['request_id'], item['kind'], item['payload']
        recipient = payload['recipient']
        try:
            self.requests.update(request_id, SENDING)
        except (KeyError, ValueError):
            return  # cancelled between dequeue and dispatch
        try:
            if kind == 'text':
                native = dict(kind='text', recipient_bytes=list(self.config.send.encode_recipient(recipient)),
                              text_bytes=list(self.config.send.encode_text(payload['text'])),
                              timeout_ms=self.config.send_timeout_ms)
            else:
                extra = {}
                if kind == 'emoji':
                    extra = dict(emoji_id=payload['emoji_id'], emoji_catalog=self.emoji_catalog)
                config = config_for(kind, path=payload.get('path'), recipient=recipient,
                                    policy=self.config.send, **extra)
                native = payload_from_config(config, self.config.send_timeout_ms)
        except PolicyError as error:
            self.requests.update(request_id, FAILED, error_code=error.code, reason=str(error)[:200])
            return
        except Exception as error:
            self.requests.update(request_id, FAILED, error_code='invalid_media',
                                 reason=type(error).__name__, detail=str(error)[:300])
            return
        runtime = self.runtime
        if runtime is None:
            self.requests.update(request_id, FAILED, error_code='worker_unavailable',
                                 reason='no_runtime')
            return
        since = None
        try:
            since = runtime.latest_seq(recipient)
        except Exception:
            since = None
        self._log(dict(event='send_dispatched', request_id=request_id, kind=kind,
                       since_seq=since))
        try:
            result = runtime.send_worker.dispatch(native)
        except WorkerUnavailable:
            self.requests.update(request_id, UNKNOWN, reason='worker_unavailable')
            return
        except Exception as error:
            self.requests.update(request_id, UNKNOWN, reason='worker_error',
                                 detail=type(error).__name__)
            return
        if result.get('accepted'):
            self.requests.update(request_id, LOCAL_ACCEPTED, accepted=True,
                                 native_error=result.get('native_error'),
                                 detail=result.get('detail'),
                                 reason=None if since is not None else 'message_tracking_unavailable')
            if since is not None:
                runtime.tracker.watch(request_id, kind=kind, conversation=recipient,
                                      text=payload.get('text'), since_seq=since)
            return
        if result.get('timed_out') or result.get('unsafe'):
            self.requests.update(request_id, UNKNOWN, accepted=None,
                                 native_error=result.get('native_error'),
                                 detail=result.get('detail'), reason='native_timeout')
            return
        if result.get('cancelled'):
            self.requests.update(request_id, UNKNOWN, reason='cancelled')
            return
        self.requests.update(request_id, FAILED, accepted=False,
                             native_error=result.get('native_error'), detail=result.get('detail'),
                             error_code='native_send_failed', reason='native_send_failed')

    # ---------------------------------------------------------------------- get
    def get(self, route, query):
        if route == '/emoji/favorites' or route.startswith('/emoji/favorites/'):
            if self.emoji_catalog is None:
                return 503, dict(error='emoji_catalog_disabled')
            try:
                if route == '/emoji/favorites':
                    if set(query) - {'offset', 'limit'} or any(len(values) != 1 for values in query.values()):
                        raise ValueError('invalid_emoji_page')
                    return 200, self.emoji_catalog.list(int(query.get('offset', ['0'])[0]),
                                                        int(query.get('limit', ['100'])[0]))
                parts = route.split('/')
                if len(parts) != 5 or parts[4] != 'content' or query:
                    return 404, dict(error='not_found')
                data, mime, _, _ = self.emoji_catalog.preview(parts[3])
                return 200, (data, mime)
            except ValueError:
                return 400, dict(error='invalid_emoji_request')
            except LookupError:
                return 502, dict(error='emoji_preview_unavailable')
            except Exception:
                return 503, dict(error='emoji_catalog_unavailable')
        if route == '/requests':
            try:
                since = float(query.get('since', ['0'])[0])
                limit = int(query.get('limit', ['200'])[0])
                if since < 0 or limit < 1:
                    raise ValueError()
            except ValueError:
                return 400, dict(error='invalid_query')
            return 200, dict(requests=[self._public(item) for item in self.requests.list_since(since, limit)])
        if route.startswith('/request/'):
            request_id = route.split('/')[2]
            request = self.requests.get(request_id)
            return (200, self._public(request)) if request else (404, dict(error='request_not_found'))
        return 404, dict(error='not_found')

    # -------------------------------------------------------------------- close
    def close(self):
        if self.state == STATE_STOPPING:
            return
        self.state = STATE_STOPPING
        self.stop.set()
        if self.http_started:
            self.server.close()
        if self.sender.is_alive():
            self.sender.join(timeout=30)
        if self.supervisor.is_alive():
            self.supervisor.join(timeout=10)
        runtime = self.runtime
        if runtime is not None:
            runtime.close()
        try:
            self.requests.close()
        except Exception:
            pass
        for handler in list(self.logger.handlers):
            try:
                handler.close()
                self.logger.removeHandler(handler)
            except Exception:
                pass


def _token(config):
    if config.token:
        return config.token
    path = config.token_file
    try:
        token = path.read_text(encoding='utf-8').strip()
    except OSError:
        token = ''
    if len(token) < 24:
        token = secrets.token_urlsafe(32)
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(token, encoding='utf-8')
        try:
            os.system('icacls "%s" /inheritance:r /grant:r "%s:F" >nul 2>nul' %
                      (path, os.environ.get('USERNAME', '')))
        except Exception:
            pass
    return token


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--port', type=int)
    parser.add_argument('--pid', type=int)
    parser.add_argument('--seconds', type=int, help='Test-only lifetime; default is resident')
    parser.add_argument('--config', type=Path)
    parser.add_argument('--db-dir')
    parser.add_argument('--account')
    parser.add_argument('--state-dir', type=Path)
    parser.add_argument('--token-file', type=Path)
    parser.add_argument('--no-media', action='store_true')
    parser.add_argument('--download', action='store_true')
    parser.add_argument('--emoji', action='store_true')
    parser.add_argument('--history', action='store_true',
                        help='Publish existing chat history instead of starting at the tail')
    parser.add_argument('--no-event-log', action='store_true',
                        help='Keep events only in the bounded in-memory buffer')
    parser.add_argument('--supervise-seconds', type=float)
    parser.add_argument('--queue-capacity', type=int)
    parser.add_argument('--send-wait', type=float, help='Seconds a synchronous /send request may wait')
    parser.add_argument('--check', action='store_true', help='Validate configuration and exit')
    args = parser.parse_args(argv)
    try:
        config = BridgeConfig.from_environment(path=args.config)
        for field, value in (('port', args.port), ('pid', args.pid), ('seconds', args.seconds),
                             ('db_dir', args.db_dir), ('account', args.account),
                             ('token_file', args.token_file)):
            if value is not None:
                setattr(config, field, value)
        if args.state_dir is not None:
            config.state_dir = args.state_dir
            config.token_file = args.token_file or (config.state_dir / 'token')
            config.log_file = config.state_dir / 'bridge.jsonl'
            config.request_db = config.state_dir / 'requests.db'
            config.event_db = config.state_dir / 'events.db'
        if args.no_media:
            config.media = False
        if args.download:
            config.download = True
        if args.emoji:
            config.emoji = True
        if args.history:
            config.history = True
        if args.no_event_log:
            config.event_log = False
        if args.supervise_seconds is not None:
            config.supervise_seconds = args.supervise_seconds
        if args.queue_capacity is not None:
            config.queue_capacity = args.queue_capacity
        if args.send_wait is not None:
            config.send_wait_seconds = args.send_wait
        config._validate()
        if not config.db_dir:
            raise ValueError('WeChat database directory not found; set WECHAT_DB_DIR or --db-dir')
    except (ValueError, OSError) as error:
        parser.error(str(error))
    if args.check:
        pinned_image()
        print(json.dumps(dict(ready=True, config=config.public()), ensure_ascii=False))
        return 0
    token = _token(config)
    service = BridgeService(config, token)
    directory = config.state_dir
    directory.mkdir(parents=True, exist_ok=True)
    session = directory / 'session.json'
    session.write_text(json.dumps(dict(url='http://127.0.0.1:%d' % service.port,
                                       token=token, pid=config.pid,
                                       config=config.public()), ensure_ascii=False), encoding='utf-8')
    print(json.dumps(dict(event='bridge_ready', url='http://127.0.0.1:%d' % service.port,
                          session=str(session), state=service.state), ensure_ascii=False), flush=True)
    stop = threading.Event()

    def handler(signum, frame):
        stop.set()

    for name in ('SIGINT', 'SIGTERM'):
        try:
            signal.signal(getattr(signal, name), handler)
        except (AttributeError, ValueError):
            pass
    service.start()
    deadline = time.monotonic() + config.seconds if config.seconds else None
    try:
        while not stop.is_set():
            if deadline is not None and time.monotonic() >= deadline:
                break
            time.sleep(0.5)
    finally:
        try:
            final_health = service.health()
        except Exception:
            final_health = dict(state='stopped')
        service.close()
        session.unlink(missing_ok=True)
        print(json.dumps(dict(event='bridge_stopped', health=final_health), ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
