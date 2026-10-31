import json
import sys
import tempfile
import threading
import time
import unittest
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from bridge_config import BridgeConfig
from bridge_service import BridgeService
from policy import ObservePolicy, SendPolicy
from receive_api import EventStore
from offline_native import patch_sender


class FakeTracker:
    def __init__(self):
        self.jobs = {}

    def watch(self, request_id, **job):
        self.jobs[request_id] = job

    def poll(self, store):
        return None

    def health(self):
        return dict(tracking=len(self.jobs))


class FakeSendWorker:
    alive = True
    poisoned = False

    def __init__(self):
        self.calls = []
        self.accepted = True
        self.closed = False
        self.entered = None
        self.release = None

    def dispatch(self, payload):
        self.calls.append(payload)
        if self.entered is not None:
            self.entered.set()
        if self.release is not None:
            self.release.wait(5)
        if not self.accepted:
            return dict(accepted=False, native_error=17, detail='fixture failure')
        return dict(accepted=True, native_error=0, detail=None)

    def health(self):
        return dict(started=True, busy=False, poisoned=False, alive=True)

    def close(self):
        self.closed = True
        return True


class FakeRuntime:
    def __init__(self, config):
        self.config = config
        self.pid = 4321
        self.store = EventStore(capacity=64, observe=config.observe,
                                state_path=config.state_dir / 'fake-events.json',
                                source_name='fake')
        self.tracker = FakeTracker()
        self.send_worker = FakeSendWorker()
        self.media_store = None
        self.download_worker = None
        self.stuck = False
        self.closed = False
        self.alive_flag = True

    @property
    def send_alive(self):
        return self.alive_flag

    def latest_seq(self, conversation):
        return 0

    def health(self):
        return dict(pid=self.pid, alive=self.alive_flag, uptime_s=0.1, last_poll_age_s=0.1,
                    poll_errors=0, last_poll_error=None,
                    send_worker=self.send_worker.health(), download_worker=None,
                    tracker=self.tracker.health(), media=None,
                    receive=self.store.health(), stuck=False)

    def close(self):
        self.closed = True
        return True


class BridgeServiceTest(unittest.TestCase):
    def setUp(self):
        patch_sender(self)
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        root = Path(self.directory.name)
        self.policy = SendPolicy(recipients=('filehelper', 'wxid_test_contact'))
        self.config = BridgeConfig(port=0, state_dir=root,
                                   request_db=root / 'requests.db',
                                   event_log=False, media=False, download=False,
                                   conversations=('filehelper',),
                                   observe=ObservePolicy(targets=('filehelper',), prefix=''),
                                   send=self.policy)
        self.service = BridgeService(self.config, 'test-token',
                                     runtime_factory=FakeRuntime, send_wait=2.0)
        self.service.start()
        self.url = 'http://127.0.0.1:%d' % self.service.port
        for _ in range(100):
            if self.service.state == 'ready':
                break
            time.sleep(0.02)

    def tearDown(self):
        self.service.close()

    def request(self, path, payload=None, token='test-token', method='GET'):
        data = None if payload is None else json.dumps(payload).encode()
        req = Request(self.url + path, data=data, method=method,
                      headers={'Authorization': 'Bearer ' + token,
                               'Content-Type': 'application/json'})
        try:
            with urlopen(req, timeout=5) as response:
                body = response.read()
                content = response.headers.get('Content-Type', '')
                return response.status, (json.loads(body) if 'json' in content else body)
        except HTTPError as error:
            with error:
                return error.code, json.load(error)

    def send(self, request_id='r1', text='wxbot-bridge', recipient='filehelper'):
        return self.request('/send/text', dict(request_id=request_id, recipient=recipient,
                                               text=text), method='POST')

    def test_health_and_ready_state(self):
        status, health = self.request('/health')
        self.assertEqual(status, 200)
        self.assertEqual(health['state'], 'ready')
        self.assertFalse(health['delivery_verified'])
        self.assertIn('requests', health)
        self.assertIn('queue', health)
        self.assertEqual(health['config']['conversations'], ['filehelper'])

    def test_send_accepts_and_is_idempotent(self):
        status, first = self.send()
        self.assertEqual(status, 200, first)
        self.assertEqual(first['state'], 'local_accepted')
        self.assertTrue(first['accepted'])
        self.assertFalse(first['delivery_verified'])
        runtime = self.service.runtime
        self.assertEqual(len(runtime.send_worker.calls), 1)
        status, second = self.send()
        self.assertEqual(status, 200)
        self.assertTrue(second['cached'])
        self.assertEqual(len(runtime.send_worker.calls), 1)
        status, conflict = self.send(text='different')
        self.assertEqual(status, 409)
        self.assertEqual(conflict['error'], 'request_id_conflict')

    def test_send_failure_and_status_routes(self):
        self.service.runtime.send_worker.accepted = False
        status, result = self.send('failed1')
        self.assertEqual(status, 502, result)
        self.assertEqual(result['state'], 'failed')
        self.assertEqual(result['native_error'], 17)
        status, fetched = self.request('/request/failed1')
        self.assertEqual((status, fetched['state']), (200, 'failed'))
        status, listing = self.request('/requests?since=0&limit=10')
        self.assertEqual(status, 200)
        self.assertIn('failed1', [item['request_id'] for item in listing['requests']])
        self.assertEqual(self.request('/request/missing')[0], 404)

    def test_policy_recipient_and_unknown_routes(self):
        status, error = self.request('/send/text', dict(request_id='bad', recipient='stranger',
                                                        text='x'), method='POST')
        self.assertEqual((status, error['error']), (403, 'recipient_not_allowed'))
        self.assertEqual(self.request('/send/unknown', dict(request_id='x'), method='POST')[0], 404)
        self.assertEqual(self.request('/health', token='wrong')[0], 401)
        self.assertEqual(self.request('/send/text', dict(request_id='y', recipient='filehelper'),
                                      method='POST')[0], 400)

    def test_media_outside_roots_is_rejected_before_dispatch(self):
        status, error = self.request('/send/image', dict(request_id='img1', recipient='filehelper',
                                                         path=str(Path(__file__).resolve())), method='POST')
        self.assertEqual(status, 400, error)
        self.assertTrue(error['error'].startswith('media_'))
        self.assertEqual(self.service.runtime.send_worker.calls, [])

    def test_image_request_tracks_actual_emoji_kind_and_deduplicates(self):
        from unittest.mock import patch
        native = dict(active_experiment=dict(kind='emoji', recipient_bytes=list(b'filehelper'),
            path='staged.gif', local_emoji=True, emoji_type=4, emoji_fields={'md5': list(b'a' * 32)}))
        body = dict(request_id='gif-native', recipient='filehelper', path='source.gif')
        with patch('bridge_service.config_for', return_value=native):
            status, result = self.request('/send/image', body, method='POST')
            self.assertEqual(status, 200, result)
            self.request('/send/image', body, method='POST')
        calls = self.service.runtime.send_worker.calls
        self.assertEqual(len(calls), 1)
        self.assertEqual(calls[0]['kind'], 'emoji')
        self.assertTrue(calls[0]['local_emoji'])
        self.assertEqual(self.service.runtime.tracker.jobs['gif-native']['kind'], 'emoji')

    def test_real_gif_preparation_uses_emoji_without_catalog_and_failure_is_cached(self):
        from PIL import Image
        root = Path(self.directory.name)
        path = root / 'animation.jpg'  # content determines routing, not suffix
        Image.new('RGB', (8, 6), 'red').save(path, format='GIF', save_all=True,
            append_images=[Image.new('RGB', (8, 6), 'blue')], duration=[80, 120], loop=2)
        self.config.send = SendPolicy(recipients=self.policy.recipients, media_roots=(root,))
        body = dict(request_id='real-gif', recipient='filehelper', path=str(path))
        status, result = self.request('/send/image', body, method='POST')
        self.assertEqual(status, 200, result)
        call = self.service.runtime.send_worker.calls[0]
        self.assertEqual(call['kind'], 'emoji')
        self.assertEqual(call['emoji_type'], 4)
        self.assertEqual(self.service.runtime.tracker.jobs['real-gif']['kind'], 'emoji')
        self.assertIsNone(self.service.emoji_catalog)
        self.request('/send/image', body, method='POST')
        self.assertEqual(len(self.service.runtime.send_worker.calls), 1)
        self.service.runtime.send_worker.accepted = False
        body['request_id'] = 'failed-gif'
        status, result = self.request('/send/image', body, method='POST')
        self.assertEqual(result['state'], 'failed', result)
        self.request('/send/image', body, method='POST')
        self.assertEqual(len(self.service.runtime.send_worker.calls), 2)

    def test_supervisor_replaces_dead_runtime_and_marks_lost_tracking_unknown(self):
        root = Path(self.directory.name) / 'reconnect'
        root.mkdir()
        created = []

        def factory(config):
            runtime = FakeRuntime(config)
            created.append(runtime)
            return runtime

        config = BridgeConfig(port=0, state_dir=root, request_db=root / 'requests.db',
                              event_log=False, media=False, download=False,
                              conversations=('filehelper',), supervise_seconds=1.0,
                              observe=ObservePolicy(targets=('filehelper',), prefix=''),
                              send=self.policy)
        service = BridgeService(config, 'reconnect-token', runtime_factory=factory,
                                send_wait=0.5)
        self.addCleanup(service.close)
        service.start()
        for _ in range(100):
            if service.state == 'ready':
                break
            time.sleep(0.05)
        old = service.runtime
        request, _ = service.requests.create('lost1', 'fp', 'text', 'filehelper')
        service.requests.update('lost1', 'queued')
        service.requests.update('lost1', 'sending')
        service.requests.update('lost1', 'local_accepted', accepted=True)
        old.tracker.watch('lost1', kind='text', conversation='filehelper', text='x', since_seq=0)
        old.alive_flag = False
        for _ in range(100):
            if len(created) >= 2 and service.runtime is not old:
                break
            time.sleep(0.05)
        self.assertTrue(old.closed)
        self.assertIsNot(service.runtime, old)
        self.assertEqual(service.requests.get('lost1')['state'], 'unknown')
        self.assertIn(service.requests.get('lost1')['reason'], ('reconnect_lost_tracking', 'service_restart'))

    def test_queue_full_returns_429(self):
        root = Path(self.directory.name) / 'queue'
        root.mkdir()
        config = BridgeConfig(port=0, state_dir=root, request_db=root / 'requests.db',
                              event_log=False, media=False, download=False,
                              conversations=('filehelper',), queue_capacity=1,
                              observe=ObservePolicy(targets=('filehelper',), prefix=''),
                              send=self.policy)
        service = BridgeService(config, 'queue-token', runtime_factory=FakeRuntime, send_wait=0.5)
        self.addCleanup(service.close)
        service.start()
        for _ in range(100):
            if service.state == 'ready':
                break
            time.sleep(0.05)
        worker = service.runtime.send_worker
        worker.entered = threading.Event()
        worker.release = threading.Event()

        def post(request_id):
            body = json.dumps(dict(request_id=request_id, recipient='filehelper',
                                   text='wxbot-' + request_id, wait=False)).encode()
            req = Request('http://127.0.0.1:%d/send/text' % service.port, data=body, method='POST',
                          headers={'Authorization': 'Bearer queue-token',
                                   'Content-Type': 'application/json'})
            try:
                with urlopen(req, timeout=5) as response:
                    return response.status
            except HTTPError as error:
                with error:
                    return error.code

        self.assertEqual(post('q1'), 202)
        self.assertTrue(worker.entered.wait(2))
        self.assertEqual(post('q2'), 202)
        self.assertEqual(post('q3'), 429)
        worker.release.set()

    def test_async_202_then_poll_and_cancel_queued(self):
        runtime = self.service.runtime
        runtime.send_worker.entered = threading.Event()
        runtime.send_worker.release = threading.Event()
        status, first = self.request('/send/text', dict(request_id='async1', recipient='filehelper',
                                                        text='wxbot-async', wait=False), method='POST')
        self.assertEqual(status, 202, first)
        self.assertIn(first['state'], ('queued', 'sending'))
        self.assertTrue(runtime.send_worker.entered.wait(2))
        status, second = self.request('/send/text', dict(request_id='async2', recipient='filehelper',
                                                         text='wxbot-cancel', wait=False), method='POST')
        self.assertEqual(status, 202, second)
        status, cancelled = self.request('/request/async2/cancel', {}, method='POST')
        self.assertEqual((status, cancelled['state']), (200, 'cancelled'))
        runtime.send_worker.release.set()
        for _ in range(100):
            if self.service.requests.get('async1')['state'] != 'sending':
                break
            time.sleep(0.02)
        self.assertEqual(self.service.requests.get('async1')['state'], 'local_accepted')
        self.assertEqual(self.service.requests.get('async2')['state'], 'cancelled')
        self.assertEqual(len(runtime.send_worker.calls), 1)

    def test_events_and_cancel_routes(self):
        self.service.runtime.store.ingest(dict(event='test_message', schema='wechat-db-1',
                                               message_id='1', sender='wxid_test_contact',
                                               recipient='filehelper', content='hello',
                                               message_type=1))
        status, events = self.request('/events?after=0')
        self.assertEqual(status, 200)
        self.assertEqual(len(events['events']), 1)
        status, error = self.request('/request/missing/cancel', {}, method='POST')
        self.assertEqual(status, 404)


if __name__ == '__main__':
    unittest.main()
