import sys
import tempfile
import time
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from message_tracker import MessageTracker
from request_store import (FAILED, LOCAL_ACCEPTED, MESSAGE_RECORDED, QUEUED,
                           SERVER_CONFIRMED, SENDING, UNKNOWN, RequestConflict,
                           RequestStore)


class StoreTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.path = Path(self.directory.name) / 'requests.db'

    def tearDown(self):
        self.directory.cleanup()

    def test_idempotency_conflict_and_restart(self):
        store = RequestStore(self.path)
        request, cached = store.create('r1', 'fp1', 'text', 'filehelper')
        self.assertFalse(cached)
        self.assertEqual(request['state'], 'prepared')
        same, cached = store.create('r1', 'fp1', 'text', 'filehelper')
        self.assertTrue(cached)
        with self.assertRaises(RequestConflict):
            store.create('r1', 'fp2', 'text', 'filehelper')
        store.update('r1', QUEUED)
        store.update('r1', SENDING)
        store.update('r1', LOCAL_ACCEPTED, accepted=True, detail='ok')
        store.close()
        reopened = RequestStore(self.path)
        request, cached = reopened.create('r1', 'fp1', 'text', 'filehelper')
        self.assertTrue(cached)
        self.assertEqual(request['state'], 'local_accepted')
        self.assertTrue(request['accepted'])
        self.assertFalse(request['delivery_verified'])
        reopened.close()

    def test_recovery_marks_inflight_unknown(self):
        store = RequestStore(self.path)
        store.create('a', 'f', 'text', 'filehelper')
        store.update('a', QUEUED)
        store.create('b', 'f', 'text', 'filehelper')
        store.update('b', QUEUED)
        store.update('b', SENDING)
        recovered = store.recover()
        self.assertEqual(sorted(recovered), ['a', 'b'])
        self.assertEqual(store.get('a')['state'], UNKNOWN)
        self.assertEqual(store.get('b')['reason'], 'service_restart')
        self.assertEqual(store.get('a')['reason'], 'service_restart')
        store.close()

    def test_cancel_and_terminal_states(self):
        store = RequestStore(self.path)
        store.create('a', 'f', 'text', 'filehelper')
        self.assertEqual(store.cancel('a')['state'], 'cancelled')
        self.assertIsNone(store.cancel('a'))
        store.create('b', 'f', 'text', 'filehelper')
        store.update('b', QUEUED)
        store.update('b', SENDING)
        store.update('b', FAILED, error_code='native_send_failed')
        with self.assertRaises(ValueError):
            store.update('b', LOCAL_ACCEPTED)
        store.close()

    def test_cursor_listing_and_purge(self):
        store = RequestStore(self.path)
        for index in range(3):
            store.create('r%d' % index, 'f%d' % index, 'text', 'filehelper')
        self.assertEqual(len(store.list_since(0)), 3)
        self.assertEqual(len(store.list_since(time.time() + 1)), 0)
        self.assertEqual(store.purge(time.time() + 1), 3)
        self.assertEqual(len(store.list_since(0)), 0)
        store.close()


class TrackerTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.store = RequestStore(Path(self.directory.name) / 'requests.db')
        self.events = []

    def tearDown(self):
        self.store.close()
        self.directory.cleanup()

    def source(self, conversation, since, limit):
        return [event for event in self.events if event['sort_seq'] > since][:limit]

    def accepted(self, request_id='r1'):
        self.store.create(request_id, 'f', 'text', 'filehelper')
        self.store.update(request_id, QUEUED)
        self.store.update(request_id, SENDING)
        self.store.update(request_id, LOCAL_ACCEPTED, accepted=True)

    def test_matches_text_and_updates_real_ids(self):
        self.accepted()
        tracker = MessageTracker(None, self.source)
        tracker.watch('r1', kind='text', conversation='filehelper', text='hello', since_seq=0)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper', content='hello',
                                sort_seq=5, message_id='filehelper:9', local_id=9, server_id='123',
                                local_type=1))
        tracker.poll(self.store)
        request = self.store.get('r1')
        self.assertEqual(request['state'], SERVER_CONFIRMED)
        self.assertEqual(request['message_id'], 'filehelper:9')
        self.assertEqual(request['local_id'], 9)
        self.assertEqual(request['server_id'], '123')

    def test_missing_row_becomes_unknown_not_failed(self):
        self.accepted()
        tracker = MessageTracker(None, self.source, observe_timeout=0.0)
        tracker.watch('r1', kind='text', conversation='filehelper', text='hello', since_seq=0)
        tracker.poll(self.store)
        request = self.store.get('r1')
        self.assertEqual(request['state'], UNKNOWN)
        self.assertEqual(request['reason'], 'message_not_observed')

    def test_local_row_without_server_id_is_recorded_then_confirmed(self):
        self.accepted()
        tracker = MessageTracker(None, self.source)
        tracker.watch('r1', kind='image', conversation='filehelper', since_seq=0)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper', content='[image]',
                                sort_seq=7, message_id='filehelper:11', local_id=11, server_id='0',
                                local_type=3))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], MESSAGE_RECORDED)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper', content='[image]',
                                sort_seq=8, message_id='filehelper:11', local_id=11, server_id='456',
                                local_type=3))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], SERVER_CONFIRMED)
        self.assertEqual(self.store.get('r1')['server_id'], '456')

    def test_emoji_identity_prevents_matching_another_pending_send(self):
        self.accepted()
        tracker = MessageTracker(None, self.source)
        tracker.watch('r1', kind='emoji', conversation='filehelper', md5='b' * 32, since_seq=0)
        self.events.extend([dict(direction='outgoing', conversation_id='filehelper', sort_seq=7,
            message_id='filehelper:11', local_id=11, server_id='1', local_type=47, emoji_md5='a'*32),
            dict(direction='outgoing', conversation_id='filehelper', sort_seq=8,
            message_id='filehelper:12', local_id=12, server_id='2', local_type=47, emoji_md5='b'*32)])
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['message_id'], 'filehelper:12')

    def test_native_failure_after_local_row_is_terminal_and_never_retried(self):
        self.accepted()
        tracker = MessageTracker(None, self.source)
        tracker.watch('r1', kind='emoji', conversation='filehelper', since_seq=0)
        event = dict(direction='outgoing', conversation_id='filehelper', sort_seq=7,
            message_id='filehelper:11', local_id=11, server_id='0', local_type=47, send_status=1)
        self.events.append(event)
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], MESSAGE_RECORDED)
        event['send_status'] = 5
        tracker.poll(self.store)
        result = self.store.get('r1')
        self.assertEqual(result['state'], FAILED)
        self.assertEqual(result['error_code'], 'native_message_failed')
        self.assertNotIn('r1', tracker.jobs)
        self.assertTrue(self.store.create('r1', 'f', 'text', 'filehelper')[1])

    def test_emoji_row_visible_after_newer_text_is_still_confirmed(self):
        self.accepted()
        tracker = MessageTracker(None, self.source)
        tracker.watch('r1', kind='emoji', conversation='filehelper', md5='b'*32, since_seq=5)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper',
            sort_seq=9, message_id='filehelper:13', local_id=13, local_type=1, server_id='3'))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], LOCAL_ACCEPTED)
        self.events.insert(0, dict(direction='outgoing', conversation_id='filehelper',
            sort_seq=8, message_id='filehelper:12', local_id=12, local_type=47,
            emoji_md5='b'*32, server_id='2'))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], SERVER_CONFIRMED)
        self.assertEqual(self.store.get('r1')['message_id'], 'filehelper:12')

    def test_same_emoji_concurrent_requests_cannot_claim_same_row(self):
        self.accepted('r1')
        self.accepted('r2')
        tracker = MessageTracker(None, self.source)
        for request in ('r1', 'r2'):
            tracker.watch(request, kind='emoji', conversation='filehelper', md5='a'*32, since_seq=5)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper',
            sort_seq=8, message_id='filehelper:12', local_id=12, local_type=47,
            emoji_md5='a'*32, server_id='2'))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], SERVER_CONFIRMED)
        self.assertEqual(self.store.get('r2')['state'], LOCAL_ACCEPTED)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper',
            sort_seq=9, message_id='filehelper:13', local_id=13, local_type=47,
            emoji_md5='a'*32, server_id='3'))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r2')['message_id'], 'filehelper:13')

    def test_confirmation_timeout_becomes_unknown_instead_of_sticking_recorded(self):
        self.accepted()
        tracker = MessageTracker(None, self.source, confirm_timeout=-1)
        tracker.watch('r1', kind='emoji', conversation='filehelper', since_seq=0)
        self.events.append(dict(direction='outgoing', conversation_id='filehelper', sort_seq=7,
            message_id='filehelper:11', local_id=11, server_id='0', local_type=47))
        tracker.poll(self.store)
        self.assertEqual(self.store.get('r1')['state'], UNKNOWN)
        self.assertEqual(self.store.get('r1')['reason'], 'server_confirmation_timeout')

    def test_restart_reconciles_exact_failed_row_without_sending(self):
        self.accepted()
        self.store.update('r1', MESSAGE_RECORDED, message_id='filehelper:11', local_id=11, server_id='0')
        tracker = MessageTracker(None, self.source)
        calls = []
        def lookup(conversation, local_id):
            calls.append((conversation, local_id))
            return dict(direction='outgoing', conversation_id=conversation, message_id='filehelper:11',
                local_id=11, local_type=47, sort_seq=7, server_id='0', send_status=5)
        tracker.restore_recorded(self.store, lookup)
        self.assertEqual(calls, [('filehelper', 11)])
        self.assertEqual(self.store.get('r1')['state'], FAILED)
        self.assertEqual(tracker.jobs, {})


if __name__ == '__main__':
    unittest.main()
