"""Hook-free receive service: poll the local WeChat databases and serve HTTP events.

By default no Frida attach or code patching: the vendored reader decrypts the local
SQLCipher databases with keys scanned read-only from the running Weixin process,
and this service polls ``sort_seq`` per conversation into the same EventStore used
by the probe-based service. That makes text receive independent of the hooks that
correlated with WeChat exits on 2026-10-29.
Optional --media --download --pid uses a separate serial native download worker;
it briefly attaches the verified application checkpoint, never receive paths.
Type-47 emoji content is fetched from its exact message resource and decoded
without a native attach; the original GIF/PNG/JPEG/WebP bytes are retained.

    py -3.14 weixin-research/db_receive.py --conversation wxid_example --seconds 60
    py -3.14 weixin-research/db_receive.py --conversation a --conversation b@chatroom --serve

Environment: WECHAT_DB_DIR, WECHAT_DB_ACCOUNT, WECHAT_BOT_SELF, WECHAT_BOT_OBSERVE,
WECHAT_BOT_OBSERVE_PREFIX, WECHAT_BOT_OBSERVE_MODE.
"""
import argparse
import json
import secrets
import threading
import time
from pathlib import Path

from policy import ObservePolicy
from profile import ROOT
from receive_api import EventStore, ReceiveServer
from wechat_db import DatabaseSource, WORKDIR
from media_receive import LocalMediaBackend, MediaStore, prune_expired_sessions

DIRECTORY = ROOT / 'runs' / 'db-receive'


def conversations_from_policy(policy):
    if policy.wildcard:
        return []
    return [target for target in policy.targets if target != 'filehelper']


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--db-dir', help='WeChat data root (default: WECHAT_DB_DIR or auto)')
    parser.add_argument('--account', help='Account directory name (default: WECHAT_BOT_SELF match)')
    parser.add_argument('--workdir', default=str(WORKDIR))
    parser.add_argument('--keys-file')
    parser.add_argument('--conversation', action='append', default=[],
                        help='wxid or ...@chatroom (repeatable; defaults to the observe policy)')
    parser.add_argument('--poll-seconds', type=float, default=2.0)
    parser.add_argument('--tail', type=int, default=0, help='Only print the latest N messages and exit')
    parser.add_argument('--serve', action='store_true', help='Serve /health and /events while polling')
    parser.add_argument('--port', type=int, default=17869)
    parser.add_argument('--seconds', type=int, default=60)
    parser.add_argument('--media', action='store_true', help='Resolve image/file/video/voice/emoji content')
    parser.add_argument('--image-keys', type=Path, help='Local JSON with aes_key (16 ASCII bytes) and xor_key')
    parser.add_argument('--download', action='store_true', help='Enable native image/video downloads and bounded emoji resource retrieval')
    parser.add_argument('--pid', type=int, help='Verified main Weixin PID, required by --download')
    args = parser.parse_args()
    if args.seconds <= 0 or not 0 <= args.port <= 65535:
        parser.error('invalid seconds or port')
    if args.download and (not args.media or not args.pid or args.pid <= 0 or args.tail):
        parser.error('--download requires --media, a positive --pid, and polling mode')
    policy = ObservePolicy.from_environment()
    conversations = args.conversation or conversations_from_policy(policy)
    if not conversations:
        parser.error('no conversations: pass --conversation or set WECHAT_BOT_OBSERVE to explicit ids')
    if not 0.5 <= args.poll_seconds <= 30:
        parser.error('--poll-seconds must be 0.5..30')
    started = time.time()
    source = DatabaseSource(args.db_dir, args.account, args.workdir, args.keys_file,
                            state_path=DIRECTORY / 'watermarks.json')
    self_ids = frozenset({source.self_wxid}) | frozenset(
        item.strip() for item in __import__('os').environ.get('WECHAT_BOT_SELF', '').split(',') if item.strip())
    store = EventStore(observe=policy, self_ids=self_ids,
                       state_path=DIRECTORY / 'state.json', source_name='wechat-db')
    DIRECTORY.mkdir(parents=True, exist_ok=True)
    media_store = None
    if args.media and not args.tail:
        # A session directory prevents concurrent servers from removing each other's files.
        prune_expired_sessions(ROOT / 'runs' / 'media-cache')
        media_store = MediaStore(LocalMediaBackend(source.db, args.image_keys, download_emoji=args.download),
                                 ROOT / 'runs' / 'media-cache' / secrets.token_hex(8))
    downloads = None
    if args.download:
        from media_download import DownloadQueue, NativeDownloader
        downloads = DownloadQueue(NativeDownloader(args.pid, policy), policy)
    store.ingest(dict(event='started'))
    print(json.dumps(dict(event='ready', self_wxid=source.self_wxid,
                          conversations=conversations, receive='wechat-db',
                          elapsed=round(time.time() - started, 1)), ensure_ascii=False), flush=True)
    if args.tail:
        for conversation in conversations:
            for event in source.latest(conversation, args.tail):
                print(json.dumps({key: event[key] for key in
                                  ('conversation_id', 'sender', 'direction', 'message_type',
                                   'timestamp', 'local_id', 'content')}, ensure_ascii=False))
        return 0
    for conversation in conversations:
        if conversation not in source.watermarks:
            latest = source.latest(conversation, 1)
            source.watermarks[conversation] = latest[0]['sort_seq'] if latest else 0
    source.save_state()
    bridge = None
    token = secrets.token_urlsafe(32)
    if args.serve:
        bridge = ReceiveServer(store, token, args.port, media_store=media_store)
        bridge.start()
        session = DIRECTORY / 'db-session.json'
        session.write_text(json.dumps(dict(url='http://127.0.0.1:%d' % bridge.port, token=token,
                                           seconds=args.seconds, receive='wechat-db',
                                           conversations=conversations), ensure_ascii=False),
                           encoding='utf-8')
        print(json.dumps(dict(event='serving', url='http://127.0.0.1:%d' % bridge.port,
                              session=str(session), conversations=conversations)), flush=True)
    stop = threading.Event()
    deadline = time.monotonic() + args.seconds if args.serve else None
    try:
        while True:
            for conversation in conversations:
                for event in source.poll(conversation):
                    published = store.ingest(event)
                    if published and media_store and event.get('media'):
                        metadata = media_store.register(event)
                        store.update_media(event['message_id'], metadata)
                    print(json.dumps(dict(event='message', conversation_id=event['conversation_id'],
                                          sender=event['sender'], direction=event['direction'],
                                          content=event['content'][:120], local_id=event['local_id']),
                                     ensure_ascii=False), flush=True)
            if media_store:
                media_store.refresh()
                if downloads:
                    media_store.synchronize_downloads(downloads)
                for event in store.read(0)['events']:
                    if (event.get('media') or {}).get('id'):
                        metadata = media_store.metadata(event['media']['id'])
                        if metadata:
                            store.update_media(event['message_id'], metadata)
            source.save_state()
            if deadline and time.monotonic() >= deadline:
                break
            stop.wait(args.poll_seconds)
    except KeyboardInterrupt:
        pass
    finally:
        source.save_state()
        store.ingest(dict(event='run_finished', outcome='completed'))
        store.save()
        if bridge:
            bridge.close()
            (DIRECTORY / 'db-session.json').unlink(missing_ok=True)
        if downloads:
            downloads.close()
        if media_store:
            media_store.close()
    print(json.dumps(dict(event='stopped', health=store.health()), ensure_ascii=False))
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
