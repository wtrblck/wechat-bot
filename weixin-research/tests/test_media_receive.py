import hashlib
import json
import sqlite3
import struct
import sys
import tempfile
import unittest
from pathlib import Path
from urllib.request import Request, urlopen
from urllib.error import HTTPError
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from media_receive import (decode_content, media_metadata, decrypt_image, safe_child,
                           LocalMediaBackend, MediaStore, proto_fields, prune_expired_sessions)
from receive_api import ReceiveServer, EventStore
from policy import ObservePolicy


def field(number, data):
    assert len(data) < 128
    return bytes([number * 8 + 2, len(data)]) + data


class MetadataTest(unittest.TestCase):
    def test_bounded_zstd_and_unicode(self):
        from compression import zstd
        self.assertEqual(decode_content(zstd.compress('中文🙂'.encode())), '中文🙂')
        with self.assertRaises(ValueError):
            decode_content(zstd.compress(b'x' * (1024 * 1024 + 1)))
        with self.assertRaises(ValueError):
            decode_content(zstd.compress(b'hello')[:-1])

    def test_types_credentials_and_cards(self):
        media = media_metadata((6 << 32) | 49, '<msg><appmsg><type>6</type><title>中文.txt</title>'
                               '<appattach><totallen>53</totallen><aeskey>SECRET</aeskey></appattach>'
                               '<md5>' + 'a' * 32 + '</md5></appmsg></msg>')
        self.assertEqual(media['kind'], 'file')
        self.assertEqual(media['expected_size'], 53)
        self.assertNotIn('SECRET', json.dumps(media))
        self.assertIsNone(media_metadata(49, '<msg><appmsg><type>5</type></appmsg></msg>'))
        self.assertIsNone(media_metadata(1, 'plain'))
        self.assertEqual(media_metadata(34, '<msg><voicemsg voicelength="1020"/></msg>')['declared_duration_ms'], 1020)
        self.assertEqual(media_metadata(43, '<msg><videomsg playlength="3"/></msg>')['declared_duration_ms'], 3000)
        for text in ['<msg>', '<!DOCTYPE x><msg/>', '<msg><img length="-1"/></msg>']:
            self.assertEqual(media_metadata(3, text)['state'], 'failed')

    def test_resource_parser_and_path_rejection(self):
        self.assertEqual(proto_fields(field(2, b'abc'))[2], b'abc')
        for blob in [b'\x12\x7fabc', b'\x0f', b'\x00']:
            with self.assertRaises(ValueError):
                proto_fields(blob)
        with tempfile.TemporaryDirectory() as directory:
            for name in ['../secret', '..', 'a/b', 'c:\\secret', 'a:secret', 'a\x00b']:
                with self.assertRaises(ValueError):
                    safe_child(directory, name)


class ImageTest(unittest.TestCase):
    def container(self, data, head, tail, key=b'1234567890abcdef', xor=73):
        from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
        from cryptography.hazmat.primitives.padding import PKCS7
        pad = PKCS7(128).padder()
        padded = pad.update(data[:head]) + pad.finalize()
        enc = Cipher(algorithms.AES(key), modes.ECB()).encryptor()
        return b'\x07\x08V2\x08\x07' + struct.pack('<II', head, tail) + b'\x01' + enc.update(padded) + enc.finalize() + data[head:len(data)-tail if tail else None] + (bytes(x ^ xor for x in data[-tail:]) if tail else b'')

    def test_v2_padding_middle_tail_and_missing_keys(self):
        data = b'\x89PNG\r\n\x1a\n' + bytes(range(160))
        for head, tail in [(16, 32), (17, 32), (len(data), 0), (16, 0)]:
            encrypted = self.container(data, head, tail)
            self.assertEqual(decrypt_image(encrypted, b'1234567890abcdef', 73), data)
        with self.assertRaises(LookupError):
            decrypt_image(encrypted)
        with self.assertRaises(LookupError):
            decrypt_image(self.container(data, 16, 32)[:40], b'1234567890abcdef', 73)

    def test_old_xor_and_unsupported_container(self):
        data = b'GIF89a' + b'1234'
        self.assertEqual(decrypt_image(bytes(x ^ 137 for x in data)), data)
        with self.assertRaises(ValueError):
            decrypt_image(b'wxgf' + b'x' * 20)


class BackendTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        class DB:
            account_dir = str(self.root)
            cfg_dword = None
            wxid = 'self'
            _db_files = [('message/media_0.db', '', 0)]
            def _open(db, name):
                conn = sqlite3.connect(self.root / Path(name).name)
                conn.row_factory = sqlite3.Row
                return conn
        self.backend = LocalMediaBackend(DB())
        self.event = dict(conversation_id='contact', local_id=7, timestamp=1793206086,
                          local_type=(6 << 32) | 49, message_id='contact:7')
        self.data = b'attachment bytes'
        self.event['media'] = dict(kind='file', state='pending', variants={},
                                   expected_size=len(self.data), expected_md5=hashlib.md5(self.data).hexdigest())
        c = sqlite3.connect(self.root / 'message_resource.db')
        c.executescript('CREATE TABLE ChatName2Id(user_name TEXT); INSERT INTO ChatName2Id VALUES ("other");'
                        'INSERT INTO ChatName2Id VALUES ("contact");'
                        'CREATE TABLE MessageResourceInfo(message_id,chat_id,message_local_id,message_create_time,message_local_type,packed_info);'
                        'CREATE TABLE MessageResourceDetail(message_id,type,size,status,packed_info);')
        c.execute('INSERT INTO MessageResourceInfo VALUES(1,2,7,?,?,?)', (self.event['timestamp'], self.event['local_type'], b''))
        c.execute('INSERT INTO MessageResourceDetail VALUES(1,3735555,16,1,?)', (field(1, field(1,b'original.txt') + field(2,b'renamed(1).txt')),))
        c.commit()
        c.close()
        folder = self.root / 'msg/file/2026-10'
        folder.mkdir(parents=True)
        self.path = folder / 'renamed(1).txt'

    def tearDown(self):
        self.temp.cleanup()

    def test_exact_file_mapping_and_incomplete_content(self):
        variants, issues = self.backend.resolve(self.event)
        self.assertEqual(variants, {})
        self.path.write_bytes(self.data[:-1])
        self.assertEqual(self.backend.resolve(self.event)[1], ['content_incomplete'])
        self.path.write_bytes(b'x' * len(self.data))
        self.assertEqual(self.backend.resolve(self.event)[1], ['content_hash_mismatch'])
        self.path.write_bytes(self.data)
        self.assertEqual(self.backend.resolve(self.event)[0]['content'][0], self.data)
        wrong = dict(self.event, conversation_id='other')
        with self.assertRaises(LookupError):
            self.backend.resolve(wrong)

    def test_voice_ids_are_scoped_to_chat_and_time(self):
        c=sqlite3.connect(self.root/'media_0.db')
        c.executescript('CREATE TABLE Name2Id(user_name); INSERT INTO Name2Id VALUES("contact");'
                       'CREATE TABLE VoiceInfo(chat_name_id,local_id,create_time,voice_data);')
        data=b'\x02#!SILK_V3\x01\x00x'
        c.execute('INSERT INTO VoiceInfo VALUES(1,7,?,?)',(self.event['timestamp'],data))
        c.commit(); c.close()
        event=dict(self.event, media=dict(kind='voice'))
        self.assertEqual(self.backend.resolve(event)[0]['silk'][0],data)
        with self.assertRaises(LookupError):
            self.backend.resolve(dict(event, timestamp=1))

    def test_authenticated_content_pending_to_ready_and_cache_limits(self):
        media = MediaStore(self.backend, self.root/'cache',capacity=1)
        identifier = media.register(self.event)['id']
        media.refresh()
        self.assertEqual(media.content(identifier)[0],409)
        self.path.write_bytes(self.data)
        with patch('media_receive.time.monotonic', return_value=__import__('time').monotonic()+3):
            media.refresh()
        self.assertEqual(media.metadata(identifier)['state'],'ready')
        bridge = ReceiveServer(EventStore(), 'secret', 0, media_store=media)
        bridge.start()
        try:
            url='http://127.0.0.1:%d/media/%s/content' % (bridge.port, identifier)
            with self.assertRaises(HTTPError) as error:
                urlopen(url)
            self.assertEqual(error.exception.code,401)
            error.exception.close()
            with urlopen(Request(url, headers={'Authorization':'Bearer secret'})) as response:
                self.assertEqual(response.read(),self.data)
                self.assertEqual(response.headers['Cache-Control'],'no-store')
            new=media.register(dict(self.event,message_id='other:7'))['id']
            self.assertEqual(media.content(identifier)[0],404)
            self.assertEqual(media.content(new)[0],409)
        finally:
            bridge.close(); media.close()
        self.assertFalse((self.root/'cache').exists())

    def test_thumbnail_pending_limits_ttl_and_private_errors(self):
        class Backend:
            def resolve(self, event):
                return {'thumbnail': (b'preview', 'image/jpeg', '.jpg')}, []
        media = MediaStore(Backend(), self.root/'cache', ttl=10)
        identifier = media.register(self.event)['id']
        media.refresh()
        self.assertEqual(media.metadata(identifier)['state'], 'pending')
        self.assertEqual(media.content(identifier, 'thumbnail')[0], 200)
        with patch('media_receive.time.monotonic', return_value=__import__('time').monotonic()+11):
            self.assertIsNone(media.metadata(identifier))
        media.close()
        media = MediaStore(Backend(), self.root/'cache', max_bytes=2)
        identifier = media.register(self.event)['id']
        media.refresh()
        self.assertIsNone(media.metadata(identifier))
        media.close()
        with patch.object(self.backend, 'resolve', side_effect=FileNotFoundError('E:/private/key')):
            media = MediaStore(self.backend, self.root/'cache')
            identifier = media.register(self.event)['id']
            media.refresh()
            self.assertEqual(media.metadata(identifier)['reason'], 'not_downloaded')
            media.close()

    def test_cleanup_after_crash_is_limited_to_generated_sessions(self):
        import os
        root = self.root/'sessions'
        session=root/('a'*16)
        session.mkdir(parents=True)
        (session/('b'*32+'-content.bin')).write_bytes(b'content')
        os.utime(session,(1,1))
        other=root/'user-files'
        other.mkdir()
        (other/'notes.txt').write_text('keep')
        os.utime(other,(1,1))
        prune_expired_sessions(root,1)
        self.assertFalse(session.exists())
        self.assertTrue((other/'notes.txt').exists())

    def test_pending_tasks_do_not_starve_new_content(self):
        class Backend:
            def resolve(self, event):
                if event['local_id'] == 5:
                    return {'content':(b'available','application/octet-stream','.bin')}, []
                return {}, []
        media=MediaStore(Backend(),self.root/'cache')
        for local_id in range(1,6):
            identifier=media.register(dict(self.event,local_id=local_id))['id']
        media.refresh()
        with patch('media_receive.time.monotonic', return_value=__import__('time').monotonic()+3):
            media.refresh()
        self.assertEqual(media.metadata(identifier)['state'],'ready')
        media.close()

    def test_database_event_decodes_media_without_publishing_credentials(self):
        from wechat_db import DatabaseSource, load_upstream
        from compression import zstd
        source=DatabaseSource.__new__(DatabaseSource)
        source.self_wxid='self'
        source.upstream=load_upstream()
        xml='<msg><img length="53" aeskey="SECRET" md5="'+'a'*32+'"/></msg>'
        row=dict(local_id=7, local_type=3, message_content=zstd.compress(xml.encode()),
                 sender_name='contact', real_sender_id=2, create_time=10, sort_seq=11,
                 server_id=2**63-1, download_status=0)
        event=source._event('contact',row)
        self.assertEqual(event['server_id'],str(2**63-1))
        self.assertEqual(event['direction'],'incoming')
        self.assertEqual(event['media']['kind'],'image')
        self.assertNotIn('SECRET',json.dumps(event))
        store=EventStore(observe=ObservePolicy(targets=('contact',),prefix=''),self_ids=('self',),source_name='wechat-db')
        self.assertTrue(store.ingest(event))
        store.update_media(event['message_id'],dict(event['media'],state='ready'))
        self.assertEqual(store.read(0)['events'][0]['source'],'wechat-db')
        self.assertEqual(store.read(0)['events'][0]['media']['state'],'ready')
        self.assertEqual(store.health()['source'],'wechat-db')


if __name__ == '__main__':
    unittest.main()
