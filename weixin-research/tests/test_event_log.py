import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from event_log import EventLog
from policy import ObservePolicy
from receive_api import EventStore


def message(identifier, content='wxbot-durable'):
    return dict(event='test_message', schema='wechat-db-1', message_id=str(identifier),
                sender='filehelper', recipient='filehelper', content=content, message_type=1)


class EventLogTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.path = Path(self.directory.name) / 'events.db'
        self.journal = EventLog(self.path)

    def tearDown(self):
        try:
            self.journal.close()
        except Exception:
            pass
        self.directory.cleanup()

    def test_old_cursor_reads_durable_tail_without_duplicates(self):
        store = EventStore(capacity=2, journal=self.journal)
        for index in range(1, 6):
            store.ingest(message(index))
        result = store.read(0)
        self.assertEqual([item['sequence'] for item in result['events']], [1, 2, 3, 4, 5])
        self.assertFalse(result['truncated'])
        result = store.read(3)
        self.assertEqual([item['sequence'] for item in result['events']], [4, 5])
        self.assertFalse(result['truncated'])
        self.assertTrue(store.health()['durable_events'])
        self.assertEqual(store.health()['event_journal_max'], 5)

    def test_trimmed_gap_reports_truncated(self):
        store = EventStore(capacity=1, journal=self.journal)
        for index in range(1, 6):
            store.ingest(message(index))
        self.journal.trim(days=0, max_events=2)
        result = store.read(0)
        self.assertTrue(result['truncated'])
        self.assertEqual([item['sequence'] for item in result['events']], [4, 5])

    def test_sequence_continues_after_restart(self):
        store = EventStore(capacity=2, journal=self.journal)
        for index in range(1, 4):
            store.ingest(message(index))
        self.journal.close()
        journal = EventLog(self.path)
        try:
            second = EventStore(capacity=2, journal=journal)
            self.assertEqual(second.sequence, 3)
            second.ingest(message(4))
            self.assertEqual(second.sequence, 4)
            self.assertEqual([item['sequence'] for item in second.read(0)['events']], [1, 2, 3, 4])
        finally:
            journal.close()


if __name__ == '__main__':
    unittest.main()
