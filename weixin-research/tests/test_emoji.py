import hashlib
import io
import json
import sqlite3
import sys
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch
from urllib.error import HTTPError
from urllib.request import Request, urlopen

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from emoji_media import (FavoriteCatalog, MAX_EMOJI, NoRedirect, fetch, inspect_image,
                         parse_emoji, public_metadata, validate_url)
from media_receive import LocalMediaBackend, MediaStore, media_metadata
from policy import ObservePolicy, SendPolicy
from receive_api import EventStore, ReceiveServer
from send_api import SendBridge


def gif():
    from PIL import Image
    output=io.BytesIO()
    Image.new('RGB',(16,12),'red').save(output,format='GIF',save_all=True,
        append_images=[Image.new('RGB',(16,12),'blue')],duration=[100,140],loop=0)
    return output.getvalue()


def xml(data):
    return '<msg><emoji md5="%s" len="%d" width="16" height="12" aeskey="%s" encrypturl="http://wxapp.tc.qq.com/SECRET"/></msg>' % (
        hashlib.md5(data).hexdigest(), len(data), '01'*16)


class Response(io.BytesIO):
    headers={}


class EmojiResourceTest(unittest.TestCase):
    def test_metadata_redacts_credentials_and_bounds(self):
        data=gif()
        metadata=media_metadata(47,xml(data))
        self.assertEqual(metadata['kind'],'emoji')
        self.assertEqual(metadata['expected_size'],len(data))
        self.assertNotIn('SECRET',json.dumps(metadata))
        self.assertNotIn('aeskey',json.dumps(metadata))
        for bad in ['<!DOCTYPE msg><msg/>','<msg/>',xml(data).replace('len="%d"'%len(data),'len="-1"'),
                    xml(data).replace('width="16"','width="999999"')]:
            self.assertEqual(public_metadata(bad)['state'],'failed')

    def test_urls_cannot_reach_arbitrary_hosts_ports_or_redirects(self):
        for url in ['file:///secret','http://127.0.0.1/','http://wxapp.tc.qq.com.evil.test/x',
                    'http://wxapp.tc.qq.com@127.0.0.1/','http://wxapp.tc.qq.com:80/x',
                    'http://wxapp.tc.qq.com/x\r\ny','http://wxapp.tc.qq.com/x#fragment']:
            with self.subTest(url=url),self.assertRaises(ValueError):validate_url(url)
        self.assertEqual(validate_url('https://wxapp.tc.qq.com/x'),'https://wxapp.tc.qq.com/x')
        self.assertIsNone(NoRedirect().redirect_request(None,None,None,None,None,None))

    def test_aes_cbc_full_gif_hash_size_and_animation_preserved(self):
        from cryptography.hazmat.primitives.ciphers import Cipher,algorithms,modes
        from cryptography.hazmat.primitives.padding import PKCS7
        data=gif();resource=parse_emoji(xml(data));key=bytes.fromhex(resource['key'])
        pad=PKCS7(128).padder();plain=pad.update(data)+pad.finalize()
        cipher=Cipher(algorithms.AES(key),modes.CBC(key)).encryptor()
        encrypted=cipher.update(plain)+cipher.finalize()
        class Opener:
            def open(self,request,timeout):return Response(encrypted)
        content,mime,ext,info=fetch(resource,Opener())
        self.assertEqual(content,data)
        self.assertEqual((mime,ext,info['frames'],info['duration_ms']),('image/gif','.gif',2,240))
        self.assertTrue(info['animated'])
        resource['md5']='f'*32
        with self.assertRaisesRegex(ValueError,'emoji_hash_mismatch'):fetch(resource,Opener())

    def test_plaintext_hash_size_and_failure_errors_hide_source(self):
        data=gif();resource=parse_emoji(xml(data))
        class Opener:
            def open(self,request,timeout):return Response(data)
        self.assertEqual(fetch(resource,Opener())[0],data)
        resource['expected_size']+=1
        with self.assertRaisesRegex(ValueError,'emoji_size_mismatch'):fetch(resource,Opener())
        class Broken:
            def open(self,*args,**kwargs):raise RuntimeError('SECRET url/key')
        with self.assertRaisesRegex(LookupError,'^emoji_download_failed$'):fetch(resource,Broken())

    def test_download_and_animation_complexity_are_bounded(self):
        data=gif();resource=parse_emoji(xml(data))
        class BigResponse(Response):headers={'Content-Length':str(MAX_EMOJI+17)}
        class Opener:
            def open(self,request,timeout):return BigResponse(b'')
        with self.assertRaisesRegex(ValueError,'emoji_too_large'):fetch(resource,Opener())
        from emoji_media import _inspect
        from PIL import Image
        with patch.object(Image,'open') as open_image:
            image=open_image.return_value.__enter__.return_value
            image.format='GIF';image.size=(10000,10000);image.n_frames=2
            with self.assertRaisesRegex(ValueError,'emoji_complexity_limit'):_inspect(b'fake')
            image.load.assert_not_called()
        with self.assertRaisesRegex(ValueError,'emoji_decode_failed'):inspect_image(b'not a GIF')

    def test_database_event_never_publishes_type47_xml(self):
        from wechat_db import DatabaseSource,load_upstream
        source=DatabaseSource.__new__(DatabaseSource);source.self_wxid='self';source.upstream=load_upstream()
        row=dict(local_id=7,local_type=47,message_content='wxid_member:\n'+xml(gif()),sender_name='wrong',
                 real_sender_id=4,create_time=10,sort_seq=11,server_id=123,download_status=0)
        event=source._event('123@chatroom',row)
        self.assertEqual(event['sender'],'wxid_member')
        self.assertEqual(event['content'],'[emoji]')
        self.assertEqual(event['media']['kind'],'emoji')
        self.assertNotIn('SECRET',json.dumps(event))


class EmojiIntegrationTest(unittest.TestCase):
    def setUp(self):
        from offline_native import patch_sender
        patch_sender(self)
        self.temp=tempfile.TemporaryDirectory();self.root=Path(self.temp.name)
        self.data=gif();self.identifier=hashlib.md5(self.data).hexdigest()
        conn=sqlite3.connect(self.root/'emoticon.db')
        conn.executescript('CREATE TABLE kFavEmoticonOrderTable(md5 TEXT);'
          'CREATE TABLE kNonStoreEmoticonTable(type INTEGER,md5 TEXT,caption TEXT,product_id TEXT,aes_key TEXT,thumb_url TEXT,tp_url TEXT,auth_key TEXT,cdn_url TEXT,extern_url TEXT,extern_md5 TEXT,encrypt_url TEXT,designer_id TEXT,activity_id TEXT);')
        conn.execute('INSERT INTO kFavEmoticonOrderTable VALUES(?)',(self.identifier,))
        conn.execute('INSERT INTO kNonStoreEmoticonTable(type,md5,caption,product_id,aes_key,encrypt_url) VALUES(3,?,?,?,?,?)',
                     (self.identifier,'收藏🙂','','01'*16,'http://wxapp.tc.qq.com/SECRET'))
        conn.execute('INSERT INTO kNonStoreEmoticonTable(type,md5,caption) VALUES(3,?,?)',('f'*32,'not a favorite'))
        conn.commit();conn.close()
        root=self.root
        class DB:
            account_dir=str(root);cfg_dword=None
            def _open(self,name):
                connection=sqlite3.connect(root/Path(name).name);connection.row_factory=sqlite3.Row;return connection
            def _msg_conn(self,conversation):
                return sqlite3.connect(root/'message.db'),'Msg'
        self.db=DB();self.catalog=FavoriteCatalog(self.db)

    def tearDown(self):self.temp.cleanup()

    def test_only_current_favorites_list_and_select_no_secrets(self):
        listing=self.catalog.list()
        self.assertEqual(listing['total'],1)
        self.assertEqual(listing['items'][0]['emoji_id'],self.identifier)
        self.assertNotIn('SECRET',json.dumps(listing))
        for bad in ['f'*32,'../secret',None]:
            with self.assertRaises(ValueError):self.catalog.select(bad)
        for args in [(-1,10),(0,129)]:
            with self.assertRaises(ValueError):self.catalog.list(*args)
        conn=sqlite3.connect(self.root/'emoticon.db');conn.execute('DELETE FROM kFavEmoticonOrderTable');conn.commit();conn.close()
        with self.assertRaisesRegex(ValueError,'emoji_not_favorited'):self.catalog.select(self.identifier)

    def test_receive_http_preserves_full_gif_and_exact_message_identity(self):
        conn=sqlite3.connect(self.root/'message.db')
        conn.execute('CREATE TABLE Msg(local_id INTEGER,create_time INTEGER,server_id INTEGER,local_type INTEGER,message_content TEXT)')
        conn.execute('INSERT INTO Msg VALUES(7,10,123,47,?)',(xml(self.data),));conn.commit();conn.close()
        event=dict(message_id='chat:7',conversation_id='chat',local_id=7,timestamp=10,server_id='123',local_type=47,
                   media=media_metadata(47,xml(self.data)))
        backend=LocalMediaBackend(self.db,download_emoji=True)
        with patch('emoji_media.fetch',return_value=(self.data,'image/gif','.gif',dict(frames=2,animated=True,duration_ms=240))):
            media=MediaStore(backend,self.root/'cache');identifier=media.register(event)['id'];media.refresh()
            bridge=ReceiveServer(EventStore(),'secret',0,media_store=media);bridge.start()
            try:
                self.assertEqual(media.metadata(identifier)['state'],'ready')
                request=Request('http://127.0.0.1:%d/media/%s/content'%(bridge.port,identifier),headers={'Authorization':'Bearer secret'})
                with urlopen(request) as response:
                    self.assertEqual(response.read(),self.data)
                    self.assertEqual(response.headers['Content-Type'],'image/gif')
                with self.assertRaises(LookupError):backend.resolve(dict(event,server_id='124'))
                disabled=LocalMediaBackend(self.db)
                with self.assertRaisesRegex(LookupError,'emoji_download_disabled'):disabled.resolve(event)
            finally:bridge.close();media.close()

    def test_emoji_network_failures_have_backoff_and_attempt_limit(self):
        class Backend:
            download_emoji=True
            def resolve(self,event):raise LookupError('emoji_download_failed')
        backend=Backend();media=MediaStore(backend,self.root/'retry-cache')
        identifier=media.register(dict(media=media_metadata(47,xml(self.data))))['id']
        clock=__import__('time').monotonic()
        try:
            with patch.object(backend,'resolve',wraps=backend.resolve) as resolve:
                with patch('media_receive.time.monotonic',return_value=clock):media.refresh()
                self.assertEqual(media.metadata(identifier)['download']['state'],'retry_wait')
                with patch('media_receive.time.monotonic',return_value=clock+3):media.refresh()
                self.assertEqual(resolve.call_count,1)
                with patch('media_receive.time.monotonic',return_value=clock+31):media.refresh()
                self.assertEqual(media.metadata(identifier)['state'],'failed')
                with patch('media_receive.time.monotonic',return_value=clock+62):media.refresh()
                self.assertEqual(resolve.call_count,2)
        finally:media.close()

    def test_sender_http_catalog_auth_preview_and_native_dispatch_boundary(self):
        from active_send import config_for
        calls=[]
        def executor(pid,config,journal):
            calls.append(config)
            journal.emit(dict(event='active_send_result',accepted=True,local_status=[0,0]))
            journal.close('completed');return 0
        bridge=SendBridge(1,'secret',0,emoji_catalog=self.catalog,executor=executor,send_policy=SendPolicy())
        bridge.start();base='http://127.0.0.1:%d'%bridge.port
        def request(path,payload=None,token='secret'):
            body=json.dumps(payload).encode() if payload else None
            req=Request(base+path,data=body,headers={'Authorization':'Bearer '+token,'Content-Type':'application/json'})
            try:
                with urlopen(req) as response:return response.status,response.read()
            except HTTPError as error:
                with error:return error.code,error.read()
        try:
            self.assertEqual(request('/emoji/favorites',token='bad')[0],401)
            self.assertEqual(json.loads(request('/emoji/favorites')[1])['total'],1)
            self.assertEqual(request('/emoji/favorites?limit=129')[0],400)
            with patch.object(self.catalog,'preview',return_value=(self.data,'image/gif','.gif',{})):
                self.assertEqual(request('/emoji/favorites/'+self.identifier+'/content')[1],self.data)
            payload=dict(request_id='favorite1',recipient='filehelper',emoji_id=self.identifier)
            for changed in [dict(payload,emoji_id='f'*32),dict(payload,url='http://evil/'),dict(payload,recipient='other')]:
                self.assertIn(request('/send/emoji',changed)[0],(400,403))
            first=request('/send/emoji',payload)
            self.assertEqual(first[0],200)
            self.assertTrue(json.loads(request('/send/emoji',payload)[1])['cached'])
            self.assertEqual(len(calls),1)
            self.assertIn('#define ENABLE_EMOJI',calls[0]['active_experiment']['thread_source'])
            self.assertEqual(calls[0]['active_experiment']['emoji_id'],self.identifier)
            self.assertFalse(json.loads(first[1])['delivery_verified'])
        finally:bridge.close()


if __name__=='__main__':unittest.main()
