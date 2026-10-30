"""Pinned, serial native downloads for observed incoming images and videos.

Reception itself stays hook-free. Each download briefly uses the already tested
application task checkpoint; native task/future ownership survives script unload.
Native success is never a substitute for MediaStore content validation.
"""
import threading
import time
from collections import OrderedDict
from copy import deepcopy

from pe_image import PEImage
from profile import ROOT, DLL, DOWNLOAD_FUNCTIONS, DOWNLOAD_RESULT_VTABLE, make_config
from probe import Journal, run_probe
from media_receive import MAX_FILE

FUNCTIONS = dict(DOWNLOAD_FUNCTIONS)
RESULT_VTABLE = DOWNLOAD_RESULT_VTABLE


def validate_event(event, policy):
    conversation = event.get('conversation_id', '')
    encoded = conversation.encode('utf-8')
    if not encoded or len(encoded) > 128 or any(b < 32 or b == 127 for b in encoded):
        raise ValueError('invalid_download_conversation')
    if not policy.conversation_allowed(conversation) or not policy.content_allowed(event.get('content')):
        raise ValueError('download_outside_observe_policy')
    if event.get('direction') != 'incoming':
        raise ValueError('download_requires_incoming_message')
    media = event.get('media') or {}
    kind = media.get('kind')
    if kind not in ('image', 'video') or media.get('state') != 'pending':
        raise ValueError('download_not_required')
    if type(media.get('expected_size')) is not int or not 0 < media['expected_size'] <= MAX_FILE:
        raise ValueError('invalid_download_size')
    for field in ('local_id', 'timestamp'):
        if type(event.get(field)) is not int or not 0 < event[field] <= 0xffffffff:
            raise ValueError('invalid_download_identifier')
    server_id = event.get('server_id', '')
    if not isinstance(server_id, str) or not server_id.isascii() or not server_id.isdecimal() or not 0 < int(server_id) < 2**63:
        raise ValueError('invalid_download_server_id')
    if event.get('local_type') != {'image': 3, 'video': 43}[kind]:
        raise ValueError('invalid_download_message_type')
    return encoded


def config_for(event, policy):
    recipient = validate_event(event, policy)
    config = make_config(seconds=15)
    image = PEImage(DLL)
    functions = []
    for name, rva in FUNCTIONS.items():
        owner = image.owner(rva)
        # The verified core getter is a leaf function without a .pdata entry.
        if (owner and owner['begin'] != rva) or (not owner and name != 'core') or not image.section_at(rva, 24)['flags'] & 0x20000000:
            raise ValueError('invalid_download_profile')
        functions.append(dict(name=name, rva=rva, bytes=list(image.read_rva(rva, 24))))
    definitions = dict(LOCAL_ID=event['local_id'], CREATE_TIME=event['timestamp'],
                       SERVER_ID=str(int(event['server_id'])) + 'ULL', MESSAGE_TYPE=event['local_type'],
                       MEDIA_KIND=2 if event['media']['kind'] == 'image' else 32, EXECUTE=1)
    source = ''.join('#define DOWNLOAD_%s %s\n' % item for item in definitions.items())
    config.update(callback_backend='native', finish_after_dispatch=True, active_experiment=dict(
        kind='context', backend='download_async', recipient_bytes=list(recipient),
        helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
        thread_source=source + (ROOT / 'download_async.c').read_text(encoding='utf-8'),
        functions=functions, result_vtable=RESULT_VTABLE, download_timeout_ms=10000))
    return config


def worker_config(policy):
    """Resident download-worker template: one compile, many bounded jobs."""
    from active_send import pinned_image
    config = make_config(seconds=60, resident=True, quiet=True)
    image = pinned_image()
    functions = []
    for name, rva in FUNCTIONS.items():
        owner = image.owner(rva)
        if (owner and owner['begin'] != rva) or (not owner and name != 'core') or \
                not image.section_at(rva, 24)['flags'] & 0x20000000:
            raise ValueError('invalid_download_profile')
        functions.append(dict(name=name, rva=rva, bytes=list(image.read_rva(rva, 24))))
    request = dict(kind='context', backend='download_worker', recipient='filehelper',
                   recipient_bytes=[ord(c) for c in 'filehelper'],
                   text=None, text_bytes=[], limits=policy.describe(),
                   helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                   thread_source=(ROOT / 'download_worker.c').read_text(encoding='utf-8'),
                   functions=functions, result_vtable=RESULT_VTABLE,
                   download_timeout_ms=10000)
    config.update(callback_backend='native', active_experiment=request)
    return config


class NativeDownloadWorker:
    """Persistent version of NativeDownloader used by the resident service."""

    def __init__(self, pid, policy, *, journal=None, on_event=None):
        from worker_session import WorkerSession, WorkerUnavailable
        self.pid, self.policy = pid, policy
        self.poisoned = False
        self.busy = False
        self.config = worker_config(policy)
        self.session = WorkerSession(pid, self.config, journal=journal, on_event=on_event)
        if not self.session.call('start_worker'):
            raise WorkerUnavailable('download worker refused to start')

    @property
    def alive(self):
        return self.session.alive

    def __call__(self, event):
        try:
            recipient = validate_event(event, self.policy)
            media_kind = 2 if event['media']['kind'] == 'image' else 32
            payload = dict(conversation_bytes=list(recipient),
                           local_id=event['local_id'], create_time=event['timestamp'],
                           server_id=str(event['server_id']), local_type=event['local_type'],
                           media_kind=media_kind, timeout_ms=10000)
        except Exception:
            return dict(state='request_failed')
        self.busy = True
        try:
            result = self.session.call('dispatch_download', payload)
            status = result.get('download_status', 'request_failed')
            if result.get('unsafe') or status in ('native_timeout', 'native_callback_running'):
                self.poisoned = True
            if status == 'native_completed':
                return dict(state='native_completed', native_status=result.get('native_status'),
                            content_verified=False)
            return dict(state=status, native_status=result.get('native_status'))
        except Exception:
            self.poisoned = True
            return dict(state='request_failed')
        finally:
            self.busy = False

    def health(self):
        health = self.session.health()
        health.update(dict(started=self.session.alive, busy=self.busy,
                           poisoned=self.poisoned or not self.session.alive))
        return health

    def close(self):
        return self.session.close('stop_worker')


class NativeDownloader:
    def __init__(self, pid, policy, directory=None):
        if type(pid) is not int or pid <= 0:
            raise ValueError('invalid_download_pid')
        self.pid, self.policy = pid, policy
        self.directory = directory or ROOT / 'runs' / 'media-download'

    def __call__(self, event):
        journal = Journal(self.directory)
        try:
            config = config_for(event, self.policy)
        except Exception as error:
            journal.emit(dict(event='download_setup_failed', error_type=type(error).__name__))
            journal.close('failed')
            return dict(state='request_failed')
        code = run_probe(self.pid, config, journal)
        result = next((x for x in journal.events if x['event'] == 'active_send_result'), {})
        status = result.get('download_status', 'request_failed')
        process_exited = any(x.get('event') == 'process_status' and x.get('state') == 'exited' for x in journal.events)
        if process_exited or (code and status == 'native_completed'):
            status = 'request_failed'
        return dict(state=status, native_status=result.get('native_status'))


class DownloadQueue:
    """One active task, bounded waiting/history, two attempts with backoff.

    close cancels waiting work and joins the active native request. It never
    force-unloads a running native callback. Long-term reconnect belongs to P6.
    """
    def __init__(self, runner, policy, capacity=32, history=128, retry_seconds=30):
        self.runner, self.policy = runner, policy
        self.capacity, self.history, self.retry_seconds = capacity, history, retry_seconds
        self.entries = OrderedDict()
        self.condition = threading.Condition()
        self.stopping = False
        self.worker = threading.Thread(target=self._work, name='wechat-media-download', daemon=True)
        self.worker.start()

    @staticmethod
    def key(event):
        return (event['conversation_id'], event['local_id'], event['timestamp'], event['server_id'])

    def submit(self, event):
        try:
            validate_event(event, self.policy)
        except (ValueError, TypeError, AttributeError):
            return False
        key, now = self.key(event), time.monotonic()
        with self.condition:
            if self.stopping:
                return False
            for old, entry in list(self.entries.items()):
                if entry['state'] not in ('queued', 'requesting') and now - entry['updated'] > 3600:
                    del self.entries[old]
            entry = self.entries.get(key)
            if entry:
                if entry['state'] in ('queued', 'requesting') or now - entry['updated'] < self.retry_seconds:
                    return False
                if entry['attempts'] >= 2:
                    entry['state'] = 'exhausted'
                    return False
            elif len(self.entries) >= self.history:
                return False
            if sum(x['state'] in ('queued', 'requesting') for x in self.entries.values()) >= self.capacity:
                return False
            attempts = entry['attempts'] if entry else 0
            self.entries[key] = dict(event=deepcopy(event), state='queued', attempts=attempts, updated=now)
            self.condition.notify()
            return True

    def status(self, event):
        with self.condition:
            entry = self.entries.get(self.key(event))
            if not entry:
                return None
            return {key: deepcopy(entry[key]) for key in ('state', 'attempts', 'native_status') if key in entry}

    def _work(self):
        while True:
            with self.condition:
                self.condition.wait_for(lambda: self.stopping or any(x['state'] == 'queued' for x in self.entries.values()))
                if self.stopping:
                    return
                entry = next(x for x in self.entries.values() if x['state'] == 'queued')
                entry.update(state='requesting', attempts=entry['attempts'] + 1)
            try:
                result = self.runner(entry['event'])
            except Exception:
                result = dict(state='request_failed')  # logs/paths never enter public metadata
            with self.condition:
                entry.update(result, updated=time.monotonic())
                self.condition.notify_all()

    def close(self):
        with self.condition:
            self.stopping = True
            for entry in self.entries.values():
                if entry['state'] == 'queued':
                    entry['state'] = 'cancelled'
            self.condition.notify_all()
        self.worker.join()
