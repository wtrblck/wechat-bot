"""Hook-free receive from WeChat 4.x local databases.

The vendored ``wechatauto/db.py`` (Apache-2.0, see vendor/wechatauto/NOTICE.md)
locates the account data directory, extracts the per-database SQLCipher keys from
the running Weixin process (read-only memory scan, no hooks), decrypts the
databases page by page into a cache, and exposes ordinary sqlite3 connections.

This module adds the parts this project needs and the upstream module gets wrong
or does not expose:

- sender resolution through the message shard's own ``Name2Id`` table (upstream
  reads ``message_resource.SenderName2Id``, whose ids do not match the message
  tables on this account and produced wrong senders);
- group text prefix handling: group content is stored as ``wxid_member:\\nbody``;
- direction from the configured self wxid;
- incremental polling by ``sort_seq`` with persisted watermarks.

Only reading is performed. Nothing here sends messages or installs hooks.
"""
import hashlib
import importlib.util
import json
import os
import time
from pathlib import Path

from profile import ROOT
from media_receive import decode_content, media_metadata

VENDOR = ROOT / 'vendor' / 'wechatauto' / 'db.py'
WORKDIR = ROOT / 'runs' / 'db-cache'
STATE = ROOT / 'runs' / 'db-receive' / 'watermarks.json'
GROUP_SUFFIX = '@chatroom'


def load_upstream():
    spec = importlib.util.spec_from_file_location('wechat_db_vendor', VENDOR)
    if spec is None or spec.loader is None:
        raise RuntimeError('vendored WeChat DB module is missing: ' + str(VENDOR))
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def group_prefix(content):
    """Split ``wxid_member:\\nbody`` group text into (sender, body); else (None, content).

    Only identifier-looking first lines are split, so ordinary text such as
    "hello:\\nworld" is never rewritten.
    """
    if not isinstance(content, str) or ':\n' not in content:
        return None, content
    first, body = content.split(':\n', 1)
    if not first or len(first) > 128 or ' ' in first:
        return None, content
    if not (first.startswith('wxid_') or first.endswith(GROUP_SUFFIX)):
        return None, content
    return first, body


def direction_for(sender, self_wxid):
    if not self_wxid:
        return 'unknown'
    return 'outgoing' if sender == self_wxid else 'incoming'


def recipients_for(conversation, sender, self_wxid):
    """Store a recipient that makes EventStore.normalize derive the same view."""
    if conversation.endswith(GROUP_SUFFIX):
        return conversation
    if direction_for(sender, self_wxid) == 'outgoing':
        return conversation
    return self_wxid or conversation


def _table(user):
    return 'Msg_' + hashlib.md5(user.encode('utf-8')).hexdigest()


def _resolve_account(db_dir, account):
    """Prefer the account directory that matches the configured self wxid."""
    if account:
        return account
    configured = os.environ.get('WECHAT_BOT_SELF', '')
    if not db_dir or not configured:
        return None
    try:
        names = os.listdir(db_dir)
    except OSError:
        return None
    for name in sorted(names):
        if name == configured or name.startswith(configured + '_'):
            return name
    return None


class DatabaseSource:
    def __init__(self, db_dir=None, account=None, workdir=None, keys_file=None, state_path=None):
        self.upstream = load_upstream()
        db_dir = db_dir or os.environ.get('WECHAT_DB_DIR') or None
        self.db = self.upstream.WeChatDB(
            db_dir=db_dir,
            account=_resolve_account(db_dir, account or os.environ.get('WECHAT_DB_ACCOUNT')),
            workdir=str(workdir or WORKDIR),
            keys_file=str(keys_file or (Path(workdir or WORKDIR) / 'keys.json')),
        )
        self.self_wxid = self.db.wxid
        self.state_path = Path(state_path) if state_path else STATE
        self.watermarks = {}
        self._load_state()

    def _load_state(self):
        try:
            self.watermarks = {str(k): int(v) for k, v in
                               json.loads(self.state_path.read_text(encoding='utf-8')).items()}
        except (OSError, ValueError, TypeError):
            self.watermarks = {}

    def save_state(self):
        self.state_path.parent.mkdir(parents=True, exist_ok=True)
        temporary = self.state_path.with_suffix('.tmp')
        temporary.write_text(json.dumps(self.watermarks, ensure_ascii=False), encoding='utf-8')
        temporary.replace(self.state_path)

    def _query(self, conversation, since, limit, descending, local_id=None):
        found = self.db._msg_conn(conversation)
        if found is None:
            return []
        conn, table = found
        try:
            order = 'DESC' if descending else 'ASC'
            condition = 'm.sort_seq > ?' if local_id is None else 'm.local_id = ?'
            rows = conn.execute(
                "SELECT m.local_id, m.local_type, m.real_sender_id, m.create_time, "
                "m.message_content, m.sort_seq, m.server_id, m.download_status, m.status, n.user_name AS sender_name "
                "FROM %s AS m LEFT JOIN Name2Id AS n ON n.rowid = m.real_sender_id "
                "WHERE %s ORDER BY m.sort_seq %s LIMIT ?" % (table, condition, order),
                (since if local_id is None else int(local_id), limit),
            ).fetchall()
        finally:
            conn.close()
        return list(reversed(rows)) if descending else rows

    def _event(self, conversation, row):
        local_type = row['local_type']
        type_name = self.upstream.WeChatDB._msg_type_name(local_type)
        content = row['message_content']
        if isinstance(content, bytes):
            try:
                content = decode_content(content)
            except (ValueError, UnicodeError):
                content = '[unreadable message content]'
        sender = row['sender_name'] or ''
        if conversation.endswith(GROUP_SUFFIX):
            prefixed, body = group_prefix(content)
            if prefixed:
                sender = prefixed
                content = body
        sender = sender or 'unknown'
        recipient = recipients_for(conversation, sender, self.self_wxid)
        from emoji_media import emoji_identity
        emoji_md5 = emoji_identity(content) if int(local_type or 0) & 0xffffffff == 47 else None
        media = media_metadata(local_type, content if isinstance(content, str) else '')
        if media:
            content = media.get('name') or '[%s]' % media['kind']
        return dict(event='test_message', schema='wechat-db-1',
                    conversation_id=conversation, sender=sender, recipient=recipient,
                    message_id='%s:%s' % (conversation, row['local_id']),
                    local_id=row['local_id'], message_type=type_name,
                    server_id=str(row['server_id'] or 0), download_status=row['download_status'],
                    send_status=row['status'] if 'status' in row.keys() else None,
                    emoji_md5=emoji_md5,
                    media=media,
                    local_type=int(local_type or 0), timestamp=int(row['create_time'] or 0),
                    sort_seq=int(row['sort_seq'] or 0), content=content if isinstance(content, str) else '',
                    sender_id=row['real_sender_id'], self_wxid=self.self_wxid,
                    direction=direction_for(sender, self.self_wxid), source='wechat-db')

    def latest(self, conversation, limit=5):
        return [self._event(conversation, row) for row in self._query(conversation, 0, limit, True)]

    def message_by_local_id(self, conversation, local_id):
        rows = self._query(conversation, 0, 1, False, local_id=local_id)
        return self._event(conversation, rows[0]) if rows else None

    def messages_since(self, conversation, since, limit=50):
        """Read-only query used to correlate an outgoing send; never moves watermarks."""
        return [self._event(conversation, row) for row in self._query(conversation, int(since), limit, False)]

    def latest_sort_seq(self, conversation):
        rows = self._query(conversation, 0, 1, True)
        return int(rows[0]['sort_seq'] or 0) if rows else 0

    def poll(self, conversation, limit=200):
        since = int(self.watermarks.get(conversation, 0))
        rows = self._query(conversation, since, limit, False)
        events = [self._event(conversation, row) for row in rows]
        for event in events:
            self.watermarks[conversation] = max(int(self.watermarks.get(conversation, 0)), event['sort_seq'])
        return events


def main():
    import argparse
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--db-dir', help='WeChat data root (default: WECHAT_DB_DIR or auto)')
    parser.add_argument('--account', help='Account directory name (default: most recent)')
    parser.add_argument('--workdir', default=str(WORKDIR))
    parser.add_argument('--keys-file')
    parser.add_argument('--conversation', action='append', default=[],
                        help='wxid or ...@chatroom (repeatable)')
    parser.add_argument('--tail', type=int, default=0, help='Print the latest N messages per conversation')
    parser.add_argument('--poll', type=int, default=0, help='Print new messages per conversation')
    args = parser.parse_args()
    if not args.conversation:
        parser.error('at least one --conversation is required')
    started = time.time()
    source = DatabaseSource(args.db_dir, args.account, args.workdir, args.keys_file)
    print(json.dumps(dict(event='ready', self_wxid=source.self_wxid,
                          conversations=args.conversation,
                          elapsed=round(time.time() - started, 1)), ensure_ascii=False))
    output = []
    for conversation in args.conversation:
        if args.tail:
            output += source.latest(conversation, args.tail)
        if args.poll:
            output += source.poll(conversation, args.poll)
    source.save_state()
    for event in output:
        print(json.dumps({key: event[key] for key in
                          ('conversation_id', 'sender', 'direction', 'message_type', 'timestamp',
                           'local_id', 'sort_seq', 'content')}, ensure_ascii=False))
    print(json.dumps(dict(event='done', messages=len(output)), ensure_ascii=False))
    return 0 if output else 1


if __name__ == '__main__':
    raise SystemExit(main())
