import json
import sys
import unittest
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from policy import SendPolicy
from send_api import SendBridge


class SendAPITest(unittest.TestCase):
    policy = SendPolicy(recipients=('filehelper', 'wxid_test_contact'))

    def setUp(self):
        self.calls = []
        def execute(pid, config, journal):
            self.calls.append(config)
            text, recipient = config.get('text'), config.get('recipient')
            journal.emit(dict(event='active_send_result', accepted=True, local_status=[0, 0],
                              text_bytes=len(text.encode('utf-8')) if text else 0,
                              recipient_bytes=len(recipient.encode('utf-8')) if recipient else 0,
                              duration_ms=1000 if config['kind'] == 'voice' else None))
            journal.close('completed')
            return 0
        self.bridge = SendBridge(1, 'test-token', 0, executor=execute,
                                 builder=lambda kind, **kw: dict(kind=kind, **kw), limit=4,
                                 send_policy=self.policy)
        self.bridge.start()
        self.url = 'http://127.0.0.1:%d' % self.bridge.port

    def tearDown(self):
        self.bridge.close()

    def post(self, payload, token='test-token', route='/send/text', raw=None):
        data = json.dumps(payload).encode() if raw is None else raw
        request = Request(self.url + route, data=data, headers={'Authorization':'Bearer ' + token,
                          'Content-Type':'application/json'})
        try:
            with urlopen(request, timeout=3) as response:
                return response.status, json.load(response)
        except HTTPError as error:
            with error:
                return error.code, json.load(error)

    def payload(self, request_id='test1'):
        return dict(request_id=request_id, recipient='filehelper', text='wxbot-http')

    def test_real_http_idempotency_and_conflict(self):
        first = self.post(self.payload())
        second = self.post(self.payload())
        self.assertEqual(first[0], 200)
        self.assertTrue(second[1]['cached'])
        self.assertFalse(first[1]['delivery_verified'])
        self.assertEqual(len(self.calls), 1)
        changed = dict(self.payload(), text='wxbot-other')
        self.assertEqual(self.post(changed)[0], 409)
        self.assertEqual(len(self.calls), 1)

    def test_unauthorized_never_dispatches(self):
        self.assertEqual(self.post(self.payload(), token='wrong')[0], 401)
        self.assertEqual(self.calls, [])

    def test_recipient_is_passed_through_and_checked(self):
        status, result = self.post(dict(self.payload(), recipient='wxid_test_contact'))
        self.assertEqual(status, 200)
        self.assertEqual(self.calls[0]['recipient'], 'wxid_test_contact')
        self.assertEqual(result['recipient'], 'wxid_test_contact')
        status, error = self.post(dict(self.payload('other'), recipient='wxid_not_configured'))
        self.assertEqual((status, error['error']), (403, 'recipient_not_allowed'))
        self.assertEqual(self.post(dict(self.payload('fields'), extra=True))[0], 400)
        self.assertEqual(self.post(dict(recipient='filehelper', text='wxbot-http'))[0], 400)

    def test_utf8_and_long_text_reach_the_builder(self):
        text = '中文测试\n第二行 😀 ' + 'x' * 3000
        status, result = self.post(dict(self.payload('utf8'), text=text))
        self.assertEqual(status, 200)
        self.assertEqual(self.calls[0]['text'], text)
        self.assertEqual(result['text_bytes'], len(text.encode('utf-8')))
        self.assertEqual(self.post(dict(self.payload('toobig'), text='x' * 4097))[0], 400)

    def test_malformed_and_large_body_rejected(self):
        for body in (b'{', b'[]', b' ' * (65536 + 1)):
            self.assertEqual(self.post({}, raw=body)[0], 400)
        self.assertEqual(self.calls, [])

    def test_limit_and_busy_rejected(self):
        self.bridge.lock.acquire()
        try:
            self.assertEqual(self.post(self.payload())[0], 409)
        finally:
            self.bridge.lock.release()
        self.assertEqual(self.post(self.payload())[0], 200)
        self.bridge.limit = 1
        self.assertEqual(self.post(self.payload('test2'))[0], 429)
        self.assertEqual(len(self.calls), 1)

    def test_unknown_route_rejected(self):
        self.assertEqual(self.post(self.payload(), route='/send/unknown')[0], 404)
        self.assertEqual(self.calls, [])

    def test_voice_route_requires_path_and_keeps_duration(self):
        payload = dict(request_id='voice1', recipient='filehelper', path='generated-test.wav')
        status, result = self.post(payload, route='/send/voice')
        self.assertEqual(status, 200)
        self.assertEqual(self.calls[0]['kind'], 'voice')
        self.assertEqual(self.calls[0]['path'], 'generated-test.wav')
        self.assertFalse(result['delivery_verified'])
        self.assertEqual(result['duration_ms'], 1000)
        self.assertEqual(self.post(self.payload('voice2'), route='/send/voice')[0], 400)

    def test_send_seconds_passes_through_to_the_builder(self):
        calls = []
        def execute(pid, config, journal):
            calls.append(config)
            journal.emit(dict(event='active_send_result', accepted=True, local_status=[0, 0]))
            journal.close('completed')
            return 0
        bridge = SendBridge(1, 'fast-token', 0, executor=execute,
                            builder=lambda kind, **kw: dict(kind=kind, **kw),
                            send_policy=self.policy, send_seconds=5)
        self.addCleanup(bridge.close)
        bridge.start()
        request = Request('http://127.0.0.1:%d/send/text' % bridge.port,
                          data=json.dumps(dict(request_id='fast', recipient='filehelper', text='wxbot-fast')).encode(),
                          headers={'Authorization': 'Bearer fast-token', 'Content-Type': 'application/json'})
        with urlopen(request, timeout=3) as response:
            self.assertEqual(response.status, 200)
        self.assertEqual(calls[0]['seconds'], 5)

    def test_health_reports_policy_limits(self):
        health = self.bridge.health()
        self.assertEqual(health['recipients'], ['filehelper', 'wxid_test_contact'])
        self.assertEqual(health['limits']['text_bytes'], 4096)
        self.assertEqual(health['limits']['json_body_bytes'], 65536)


if __name__ == '__main__':
    unittest.main()
