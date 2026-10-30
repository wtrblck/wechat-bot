"""Private type-47 resources and the current account's favorite catalog."""
import hashlib
import io
import json
import os
import re
import subprocess
import sys
import threading
import xml.etree.ElementTree as ET
from pathlib import Path
from urllib.parse import urlsplit
from urllib.request import Request, HTTPRedirectHandler, build_opener

# The isolated --inspect child must use the same project-local dependencies as
# the bridge; sys.path changes made by its parent are not inherited.
sys.path.insert(0, str(Path(__file__).resolve().parent / 'deps'))

MAX_EMOJI = 8 * 1024 * 1024
HEX32 = re.compile(r'^[0-9a-fA-F]{32}$')
CDN_HOSTS = frozenset(('vweixinf.tc.qq.com', 'wxapp.tc.qq.com'))


def parse_emoji(content):
    if not isinstance(content, str) or len(content.encode('utf-8')) > 1024 * 1024 or '<!DOCTYPE' in content.upper() or '<!ENTITY' in content.upper():
        raise ValueError('invalid_emoji_metadata')
    try:
        node = ET.fromstring(content).find('emoji')
        if node is None or not HEX32.fullmatch(node.get('md5', '')):
            raise ValueError()
        size = int(node.get('len', '0'))
        if not 0 < size <= MAX_EMOJI:
            raise ValueError()
        result = dict(md5=node.get('md5').lower(), expected_size=size,
                      product_id=node.get('productid', '')[:128],
                      url=node.get('encrypturl') or node.get('cdnurl') or '', key=node.get('aeskey', ''))
        for axis in ('width', 'height'):
            if node.get(axis):
                value = int(node.get(axis))
                if not 0 < value <= 16384:
                    raise ValueError()
                result[axis] = value
        return result
    except (ET.ParseError, ValueError, TypeError):
        raise ValueError('invalid_emoji_metadata') from None


def public_metadata(content):
    try:
        resource = parse_emoji(content)
        return dict(kind='emoji', state='pending', reason='not_resolved', variants={},
                    expected_md5=resource['md5'], **{key:resource[key] for key in
                    ('expected_size', 'product_id', 'width', 'height') if key in resource})
    except ValueError:
        return dict(kind='emoji', state='failed', reason='invalid_emoji_metadata', variants={})


def validate_url(value):
    if not isinstance(value, str) or not 0 < len(value) <= 2048 or any(ord(c) < 33 for c in value):
        raise ValueError('invalid_emoji_source')
    try:
        parsed = urlsplit(value)
        if parsed.scheme not in ('http', 'https') or parsed.hostname not in CDN_HOSTS or parsed.username or parsed.password or parsed.port is not None or parsed.fragment:
            raise ValueError()
    except ValueError:
        raise ValueError('invalid_emoji_source') from None
    return value


class NoRedirect(HTTPRedirectHandler):
    def redirect_request(self, *args, **kwargs):
        return None


def _inspect(data):
    from PIL import Image
    if not 0 < len(data) <= MAX_EMOJI:
        raise ValueError('emoji_too_large')
    with Image.open(io.BytesIO(data)) as image:
        formats = {'GIF': ('image/gif', '.gif'), 'PNG': ('image/png', '.png'),
                   'JPEG': ('image/jpeg', '.jpg'), 'WEBP': ('image/webp', '.webp')}
        if image.format not in formats:
            raise ValueError('unsupported_emoji_encoding')
        mime, ext = formats[image.format]
        width, height = image.size
        frames = getattr(image, 'n_frames', 1)
        if frames > 500 or width * height > 16_000_000 or frames * width * height > 100_000_000:
            raise ValueError('emoji_complexity_limit')
        duration = 0
        for frame in range(frames):
            image.seek(frame)
            image.load()
            duration += max(0, int(image.info.get('duration', 0)))
        if duration > 120000:
            raise ValueError('emoji_duration_limit')
        return dict(mime=mime, ext=ext, width=width, height=height, frames=frames,
                    animated=frames > 1, duration_ms=duration)


def inspect_image(data):
    try:
        result = subprocess.run([sys.executable, str(Path(__file__).resolve()), '--inspect'],
            input=data, capture_output=True, timeout=12,
            creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
        if result.returncode:
            raise ValueError('emoji_decode_failed')
        return json.loads(result.stdout)
    except (OSError, subprocess.TimeoutExpired, ValueError):
        raise ValueError('emoji_decode_failed') from None


def fetch(resource, opener=None):
    """Read only declared Tencent resources. Never expose keys/URLs in errors."""
    url = validate_url(resource.get('url'))
    md5 = resource.get('md5', '')
    if not HEX32.fullmatch(md5):
        raise ValueError('invalid_emoji_md5')
    opener = opener or build_opener(NoRedirect())
    try:
        with opener.open(Request(url, headers={'User-Agent': 'WeChat'}), timeout=10) as response:
            length = response.headers.get('Content-Length')
            if length and int(length) > MAX_EMOJI + 16:
                raise ValueError('emoji_too_large')
            data = response.read(MAX_EMOJI + 17)
    except ValueError:
        raise ValueError('emoji_too_large') from None
    except Exception:
        raise LookupError('emoji_download_failed') from None
    if len(data) > MAX_EMOJI + 16:
        raise ValueError('emoji_too_large')
    if hashlib.md5(data).hexdigest() != md5.lower():
        key = resource.get('key', '')
        if not HEX32.fullmatch(key) or not data or len(data) % 16:
            raise ValueError('invalid_emoji_encryption')
        from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
        from cryptography.hazmat.primitives.padding import PKCS7
        key = bytes.fromhex(key)
        decoder = Cipher(algorithms.AES(key), modes.CBC(key)).decryptor()
        plain = decoder.update(data) + decoder.finalize()
        try:
            padding = PKCS7(128).unpadder()
            data = padding.update(plain) + padding.finalize()
        except ValueError:
            raise ValueError('invalid_emoji_encryption') from None
    if hashlib.md5(data).hexdigest() != md5.lower():
        raise ValueError('emoji_hash_mismatch')
    if resource.get('expected_size') is not None and len(data) != resource['expected_size']:
        raise ValueError('emoji_size_mismatch')
    info = inspect_image(data)
    return data, info.pop('mime'), info.pop('ext'), info


class FavoriteCatalog:
    """The favorite-order table is authoritative, rechecked at each selection."""
    def __init__(self, db):
        self.db = db
        self.lock = threading.RLock()

    def _open(self):
        return self.db._open(os.path.join('emoticon', 'emoticon.db'))

    def list(self, offset=0, limit=100):
        if type(offset) is not int or type(limit) is not int or offset < 0 or not 1 <= limit <= 128:
            raise ValueError('invalid_emoji_page')
        with self.lock:
            conn = self._open()
            try:
                total = conn.execute('SELECT count(*) FROM kFavEmoticonOrderTable').fetchone()[0]
                rows = conn.execute('SELECT f.md5,n.caption,n.product_id FROM kFavEmoticonOrderTable f '
                    'LEFT JOIN kNonStoreEmoticonTable n ON f.md5=n.md5 ORDER BY f.rowid LIMIT ? OFFSET ?', (limit,offset)).fetchall()
                items = [dict(emoji_id=row['md5'].lower(), caption=(row['caption'] or '')[:255],
                    product_id=(row['product_id'] or '')[:128], preview_url='/emoji/favorites/'+row['md5'].lower()+'/content')
                    for row in rows if isinstance(row['md5'],str) and HEX32.fullmatch(row['md5'])]
                return dict(items=items, total=total, offset=offset, limit=limit)
            finally:
                conn.close()

    def select(self, emoji_id):
        if not isinstance(emoji_id,str) or not HEX32.fullmatch(emoji_id):
            raise ValueError('invalid_emoji_id')
        with self.lock:
            conn = self._open()
            try:
                row = conn.execute('SELECT n.* FROM kFavEmoticonOrderTable f JOIN kNonStoreEmoticonTable n '
                                   'ON f.md5=n.md5 WHERE lower(f.md5)=?', (emoji_id.lower(),)).fetchone()
                if not row:
                    raise ValueError('emoji_not_favorited')
                record = dict(row)
                return dict(md5=record['md5'].lower(), key=record.get('aes_key') or '',
                    url=record.get('encrypt_url') or record.get('cdn_url') or '',
                    product_id=record.get('product_id') or '', type=record['type'],
                    caption=(record.get('caption') or '')[:255],
                    native_fields={key:record.get(key) or '' for key in ('md5','product_id','aes_key','thumb_url','tp_url','auth_key','cdn_url','extern_url','extern_md5','encrypt_url','designer_id','activity_id','caption')})
            finally:
                conn.close()

    def preview(self, emoji_id):
        with self.lock:
            return fetch(self.select(emoji_id))


def create_catalog(db_dir=None, account=None):
    from wechat_db import DatabaseSource, WORKDIR
    source = DatabaseSource(db_dir, account, workdir=Path(__file__).resolve().parent/'runs/emoji-db-cache',
                            keys_file=WORKDIR/'keys.json')
    return FavoriteCatalog(source.db)


if __name__ == '__main__':
    try:
        print(json.dumps(_inspect(sys.stdin.buffer.read(MAX_EMOJI + 1))))
    except Exception:
        raise SystemExit(1)
