import hashlib
import io
import sqlite3
import sys
import threading
import unittest
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from media_download import DownloadQueue, validate_event, config_for
from media_receive import decode_wxgf, media_metadata
from policy import ObservePolicy
import test_media_receive as media_tests
field = media_tests.field


def event():
    return dict(conversation_id='contact', direction='incoming', content='[image]',
                local_id=7, timestamp=1793206086, server_id='9007199254740993', local_type=3,
                media=dict(kind='image', state='pending', expected_size=100, variants={}))


class DownloadTest(unittest.TestCase):
    def setUp(self):
        self.policy = ObservePolicy(targets=('contact',), prefix='')

    def test_exact_ids_and_observe_incoming_scope(self):
        self.assertEqual(validate_event(event(), self.policy), b'contact')
        for changes in [dict(direction='outgoing'), dict(direction='unknown'),
                        dict(conversation_id='other'), dict(server_id=9007199254740993),
                        dict(server_id='9223372036854775808'), dict(local_id=True),
                        dict(timestamp=-1), dict(local_type=43), dict(server_id='12\n')]:
            with self.subTest(changes=changes), self.assertRaises(ValueError):
                validate_event(dict(event(), **changes), self.policy)

    def test_pinned_profile_and_uint64_definition_render_offline(self):
        from probe import render_source
        config = config_for(event(), self.policy)
        source = config['active_experiment']['thread_source']
        self.assertIn('#define DOWNLOAD_SERVER_ID 9007199254740993ULL', source)
        self.assertEqual(config['active_experiment']['backend'], 'download_async')
        self.assertTrue(config['finish_after_dispatch'])
        rendered = render_source(config)
        self.assertIn('close_download', rendered)
        self.assertIn('future_state_invalid', rendered)

    def test_serial_bounded_deduplication_and_shutdown(self):
        entered, release = threading.Event(), threading.Event()
        calls = []
        def runner(item):
            calls.append(item['local_id'])
            entered.set()
            release.wait(5)
            return dict(state='native_completed')
        queue = DownloadQueue(runner, self.policy, capacity=2)
        try:
            self.assertTrue(queue.submit(event()))
            self.assertTrue(entered.wait(2))
            self.assertFalse(queue.submit(event()))
            self.assertTrue(queue.submit(dict(event(), local_id=8)))
            self.assertFalse(queue.submit(dict(event(), local_id=9)))
            self.assertEqual(queue.status(event())['state'], 'requesting')
            # The worker never changes the supplied media to ready.
            self.assertEqual(event()['media']['state'], 'pending')
            with queue.condition:
                queue.stopping = True
                queue.condition.notify_all()
        finally:
            release.set()
            queue.close()
        self.assertEqual(calls, [7])
        self.assertEqual(queue.status(dict(event(), local_id=8))['state'], 'cancelled')

    def test_two_attempts_backoff_errors_private_and_no_unbounded_history(self):
        def runner(item):
            raise RuntimeError('private path / credential')
        queue = DownloadQueue(runner, self.policy, history=1, retry_seconds=30)
        try:
            self.assertTrue(queue.submit(event()))
            with queue.condition:
                self.assertTrue(queue.condition.wait_for(lambda: queue.entries[queue.key(event())]['state'] == 'request_failed', 3))
            self.assertFalse(queue.submit(event()))
            self.assertFalse(queue.submit(dict(event(), local_id=8)))
            queue.retry_seconds = 0
            self.assertTrue(queue.submit(event()))
            with queue.condition:
                self.assertTrue(queue.condition.wait_for(lambda: queue.entries[queue.key(event())]['attempts'] == 2 and queue.entries[queue.key(event())]['state'] == 'request_failed', 3))
            self.assertFalse(queue.submit(event()))
            self.assertEqual(queue.status(event()), dict(state='exhausted', attempts=2))
        finally:
            queue.close()


class WxgfTest(unittest.TestCase):
    def test_real_hevc_frame_and_invalid_container(self):
        from PIL import Image
        data = (Path(__file__).parent / 'fixtures/wxgf-frame.bin').read_bytes()
        with Image.open(io.BytesIO(decode_wxgf(data))) as image:
            image.load()
            self.assertEqual(image.size, (96, 64))
            self.assertGreater(image.convert('RGB').getpixel((0, 0))[0], 240)
        for broken in [b'wxgf' + b'x' * 60, b'wxgf' + bytes(28) + b'\0\0\0\1bad']:
            with self.assertRaises(ValueError):
                decode_wxgf(broken)
        self.assertEqual(media_metadata(3, '<msg><img length="10" hevc_mid_size="-1"/></msg>')['state'], 'failed')
        plain = media_metadata(3, '<msg><img length="10" hevc_mid_size="0"/></msg>')
        self.assertEqual(plain['state'], 'pending')
        self.assertNotIn('hevc_mid_size', plain)


class ImageBackendTest(unittest.TestCase):
    setUp = media_tests.BackendTest.setUp
    tearDown = media_tests.BackendTest.tearDown

    def test_native_completion_does_not_make_thumbnail_ready(self):
        from media_receive import MediaStore
        class Queue:
            def submit(self, event):
                return True
            def status(self, event):
                return dict(state='native_completed', attempts=1, native_status=[0, 0])
        with patch.object(self.backend, 'resolve', return_value=({'thumbnail': (b'preview', 'image/jpeg', '.jpg')}, [])):
            media = MediaStore(self.backend, self.root / 'cache')
            try:
                identifier = media.register(event())['id']
                media.refresh()
                media.synchronize_downloads(Queue())
                self.assertEqual(media.metadata(identifier)['download']['state'], 'native_completed')
                self.assertEqual(media.metadata(identifier)['state'], 'pending')
                self.assertEqual(media.content(identifier)[0], 409)
            finally:
                media.close()
    def test_wxgf_variant_size_and_hash_semantics(self):
        from PIL import Image
        data = (Path(__file__).parent / 'fixtures/wxgf-frame.bin').read_bytes()
        item = dict(self.event, local_type=3, media=dict(kind='image', state='pending', variants={},
                    expected_size=9999, expected_md5='a' * 32, hevc_mid_size=len(data)))
        stem = 'b' * 32
        folder = self.root / 'msg/attach' / hashlib.md5(b'contact').hexdigest() / '2026-10/Img'
        folder.mkdir(parents=True)
        (folder / (stem + '.dat')).write_bytes(data)
        with patch.object(self.backend, 'resources', return_value=[dict(packed_info=field(2, field(1, stem.encode())))]):
            variants, issues = self.backend.resolve(item)
            self.assertEqual(issues, [])
            payload = variants['content']
            self.assertEqual(payload[3]['source_sha256'], hashlib.sha256(data).hexdigest())
            self.assertEqual(payload[3]['source_size'], len(data))
            self.assertEqual(payload[3]['transcoded_from'], 'image/wxgf')
            with Image.open(io.BytesIO(payload[0])) as image:
                self.assertEqual(image.size, (96, 64))
            item['media']['hevc_mid_size'] += 1
            with patch('media_receive.decode_wxgf') as decoder:
                self.assertEqual(self.backend.resolve(item), ({}, ['content_incomplete']))
                decoder.assert_not_called()
            del item['media']['hevc_mid_size']
            self.assertEqual(self.backend.resolve(item), ({}, ['image_variant_unverified']))

    def test_group_identifier_fallback_is_exact_and_typed(self):
        path = self.root / 'message.db'
        conn = sqlite3.connect(path)
        conn.execute('CREATE TABLE Msg(local_id INTEGER,create_time INTEGER,server_id INTEGER,local_type INTEGER,packed_info_data BLOB)')
        blob = field(3, field(4, b'c' * 32))
        conn.execute('INSERT INTO Msg VALUES(7,10,123,3,?)', (blob,))
        conn.commit(); conn.close()
        self.backend.db._msg_conn = lambda conversation: (sqlite3.connect(path), 'Msg')
        item = dict(event(), timestamp=10, server_id='123')
        self.assertEqual(self.backend.message_stem(item), 'c' * 32)
        with self.assertRaises(LookupError):
            self.backend.message_stem(dict(item, server_id=124))


if __name__ == '__main__':
    unittest.main()
