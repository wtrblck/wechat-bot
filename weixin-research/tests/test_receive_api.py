import json
import sys
import tempfile
import unittest
from pathlib import Path
from urllib.error import HTTPError
from urllib.request import Request, urlopen

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from policy import ObservePolicy, PolicyError
from receive_api import EventStore, ReceiveServer


def message(identifier='123'):
    return dict(event='test_message', schema='wechat-sync-ring-1', message_id=identifier,
                sender='fixture-user', recipient='filehelper', content='wxbot-fixture', message_type=1)


class EventStoreTests(unittest.TestCase):
    def test_filters_and_deduplicates(self):
        store = EventStore()
        for item in (dict(message(), content='ordinary'), dict(message(), recipient='other-user'),
                     dict(message(), schema='experimental-send-stage'), message('0')):
            store.ingest(item)
        self.assertEqual(store.read(0)['events'], [])
        store.ingest(message())
        store.ingest(message())
        self.assertEqual(store.read(0)['cursor'], 1)
        self.assertEqual(store.read(0)['events'][0]['source'], 'wechat-sync')
        counters = store.health()['counters']
        self.assertEqual(counters['filtered_prefix'], 1)
        self.assertEqual(counters['filtered_target'], 1)
        self.assertEqual(counters['filtered_schema'], 1)
        self.assertEqual(counters['invalid_id'], 1)
        self.assertEqual(counters['duplicate'], 1)

    def test_cursor_gap_and_failure_state(self):
        store = EventStore(capacity=2)
        for identifier in ('1', '2', '3'):
            store.ingest(message(identifier))
        self.assertTrue(store.read(0)['truncated'])
        self.assertEqual([e['message_id'] for e in store.read(1)['events']], ['2', '3'])
        self.assertFalse(store.read(1)['truncated'])
        self.assertEqual(store.health()['counters']['evicted'], 1)
        store.ingest(dict(event='started'))
        self.assertEqual(store.health()['state'], 'observing')
        store.ingest(dict(event='session_detached', expected=False))
        self.assertEqual(store.health()['state'], 'failed')
        self.assertFalse(store.health()['send_ready'])

    def test_dedup_window_is_bounded(self):
        policy = ObservePolicy(targets=('wxbot-contact',), prefix='note-')
        store = EventStore(capacity=2, observe=policy, dedup_capacity=2)
        base = dict(event='test_message', schema='wechat-sync-ring-1', message_type=1,
                    sender='wxbot-contact', recipient='wxbot-contact')
        store.ingest(dict(base, message_id='1', content='note-one'))
        store.ingest(dict(base, message_id='2', content='note-two'))
        store.ingest(dict(base, message_id='2', content='note-two'))
        store.ingest(dict(base, message_id='3', content='note-three'))
        store.ingest(dict(base, message_id='1', content='note-one'))
        store.ingest(dict(base, message_id='4', content='plain-text'))
        store.ingest(dict(base, message_id='5', content='note-five', sender='stranger', recipient='filehelper'))
        health = store.health()
        self.assertEqual(health['receive_scope'],
                         dict(targets=['wxbot-contact'], prefix='note-', mode='prefix'))
        self.assertEqual(health['counters']['published'], 4)
        self.assertEqual(health['counters']['duplicate'], 1)
        self.assertEqual(health['counters']['evicted'], 2)
        self.assertEqual(health['counters']['filtered_prefix'], 1)
        self.assertEqual(health['counters']['filtered_target'], 1)
        self.assertEqual(health['dedup_window'], 2)
        self.assertEqual([e['message_id'] for e in store.read(0)['events']], ['3', '1'])

    def test_events_carry_direction_and_conversation(self):
        store = EventStore(self_ids=('wxid_self',))
        store.ingest(dict(event='test_message', schema='wechat-sync-ring-1', message_id='1',
                          sender='wxid_self', recipient='filehelper', content='wxbot-out', message_type=1))
        store.ingest(dict(event='test_message', schema='wechat-sync-ring-1', message_id='2',
                          sender='filehelper', recipient='wxid_self', content='wxbot-in', message_type=1))
        events = store.read(0)['events']
        self.assertEqual([e['direction'] for e in events], ['outgoing', 'incoming'])
        self.assertEqual([e['conversation_id'] for e in events], ['filehelper', 'filehelper'])
        self.assertEqual(store.health()['self_ids_configured'], True)

    def test_state_file_restores_cursor_and_dedup(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'state.json'
            first = EventStore(state_path=path, self_ids=('wxid_self',))
            first.ingest(message('1'))
            first.ingest(message('2'))
            self.assertTrue(first.save())
            second = EventStore(state_path=path, self_ids=('wxid_self',))
            self.assertEqual(second.sequence, 2)
            self.assertTrue(second.health()['state_restored'])
            self.assertFalse(second.health()['durable_events'])
            second.ingest(message('2'))
            self.assertEqual(second.health()['counters']['duplicate'], 1)
            second.ingest(message('3'))
            result = second.read(0)
            self.assertEqual(result['events'][0]['sequence'], 3)
            self.assertTrue(result['truncated'])
            path.write_text('{not json', encoding='utf-8')
            third = EventStore(state_path=path)
            self.assertEqual(third.sequence, 0)
            self.assertFalse(third.health()['state_restored'])

    def test_observe_policy_defaults_and_environment(self):
        default = ObservePolicy.from_environment({})
        self.assertEqual(default.targets, ('filehelper',))
        self.assertEqual(default.prefix, 'wxbot-')
        self.assertTrue(default.matches(dict(sender='a', recipient='filehelper', content='wxbot-x')))
        self.assertFalse(default.matches(dict(sender='a', recipient='filehelper', content='hello')))
        self.assertEqual(default.describe()['mode'], 'prefix')
        custom = ObservePolicy.from_environment({'WECHAT_BOT_OBSERVE': 'filehelper, wxid_x',
                                                 'WECHAT_BOT_OBSERVE_PREFIX': ''})
        self.assertEqual(custom.targets, ('filehelper', 'wxid_x'))
        self.assertEqual(custom.prefix, '')
        self.assertTrue(custom.matches(dict(sender='wxid_x', recipient='me', content='anything')))
        for targets, prefix in ((('bad\ntarget',), 'x'), ((), 'x'), (('ok',), 'p\x07')):
            with self.subTest(targets=targets, prefix=prefix), self.assertRaises(PolicyError):
                ObservePolicy(targets=targets, prefix=prefix)

    def test_wildcard_observes_any_conversation(self):
        policy = ObservePolicy(targets=('*',), prefix='note-')
        self.assertTrue(policy.wildcard)
        self.assertTrue(policy.matches(dict(sender='anyone', recipient='anywhere', content='note-x')))
        self.assertFalse(policy.matches(dict(sender='anyone', recipient='anywhere', content='plain')))
        store = EventStore(observe=policy)
        store.ingest(dict(event='test_message', schema='wechat-sync-ring-1', message_id='9',
                          sender='wxid_other', recipient='wxid_me', content='note-resolve', message_type=1))
        self.assertEqual(store.health()['counters']['published'], 1)
        self.assertEqual(store.health()['receive_scope'], dict(targets=['*'], prefix='note-', mode='prefix'))

    def test_contains_mode_matches_group_style_content(self):
        policy = ObservePolicy(targets=('filehelper',), prefix='note-', mode='contains')
        group_text = 'wxid_sender:\nnote-resolve-group'
        self.assertTrue(policy.matches(dict(sender='a', recipient='filehelper', content=group_text)))
        self.assertFalse(policy.matches(dict(sender='a', recipient='filehelper', content='plain')))
        store = EventStore(observe=policy)
        store.ingest(dict(event='test_message', schema='wechat-sync-ring-1', message_id='7',
                          sender='wxid_member', recipient='filehelper', content=group_text, message_type=1))
        self.assertEqual(store.health()['counters']['published'], 1)
        with self.assertRaises(PolicyError):
            ObservePolicy(targets=('filehelper',), prefix='x', mode='anywhere')


class HTTPTests(unittest.TestCase):
    def test_local_authenticated_routes(self):
        store = EventStore()
        bridge = ReceiveServer(store, 'fixture-token', port=0)
        self.addCleanup(bridge.close)
        bridge.start()
        url = 'http://127.0.0.1:%d' % bridge.port

        def request(path, token='fixture-token', host=None, method='GET'):
            headers = dict(Authorization='Bearer ' + token)
            if host:
                headers['Host'] = host
            try:
                with urlopen(Request(url + path, headers=headers, method=method), timeout=3) as response:
                    return response.status, json.load(response)
            except HTTPError as error:
                with error:
                    return error.code, json.load(error)

        self.assertEqual(bridge.server.server_address[0], '127.0.0.1')
        self.assertEqual(request('/health', token='wrong')[0], 401)
        self.assertEqual(request('/events', host='example.invalid')[0], 403)
        self.assertEqual(request('/health')[1]['state'], 'starting')
        self.assertIn('counters', request('/health')[1])
        self.assertEqual(request('/health')[1]['receive_scope'],
                         dict(targets=['filehelper'], prefix='wxbot-', mode='prefix'))
        store.ingest(message())
        code, result = request('/events?after=0')
        self.assertEqual(code, 200)
        self.assertEqual(result['events'][0]['content'], 'wxbot-fixture')
        self.assertEqual(result['counters']['published'], 1)
        self.assertEqual(request('/events?after=1')[1]['events'], [])
        self.assertEqual(request('/events?after=-1')[0], 400)
        self.assertEqual(request('/events?after=x')[0], 400)
        self.assertEqual(request('/missing')[0], 404)
        self.assertEqual(request('/send', method='POST')[0], 501)


if __name__ == '__main__':
    unittest.main()
