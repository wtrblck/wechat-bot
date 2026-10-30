"""Bounded, hook-free local media resolution. Native requests live in media_download.

Resource mappings were checked against this account's 4.1.15.56 databases.
The V2 image format/key derivation is also documented by ChatTrace v0.5.0:
https://github.com/qiaodogbear/ChatTrace/releases/tag/v0.5.0
"""
import contextlib
import hashlib
import json
import os
import re
import struct
import threading
import time
import xml.etree.ElementTree as ET
from collections import OrderedDict
from pathlib import Path

MAX_METADATA = 1024 * 1024
MAX_FILE = 64 * 1024 * 1024
HEX32 = re.compile(r'^[a-fA-F0-9]{32}$')


def prune_expired_sessions(root, ttl=3600):
    """Remove only this feature's stale, flat session directories after a crash."""
    root = Path(root).resolve()
    root.mkdir(parents=True, exist_ok=True)
    for folder in root.iterdir():
        if not re.fullmatch('[a-f0-9]{16}', folder.name) or folder.is_symlink() or not folder.is_dir():
            continue
        if time.time() - folder.stat().st_mtime < ttl:
            continue
        files = list(folder.iterdir())
        if not all(p.is_file() and not p.is_symlink() and re.fullmatch(
                '[a-f0-9]{32}-(content|silk|original|thumbnail)\\.(png|jpg|gif|webp|mp4|silk|wav|tmp|[a-zA-Z0-9]{1,10})', p.name) for p in files):
            continue
        for path in files:
            path.unlink()
        folder.rmdir()


def decode_content(value):
    if isinstance(value, str):
        if len(value.encode('utf-8')) > MAX_METADATA:
            raise ValueError('metadata_too_large')
        return value
    if not isinstance(value, bytes):
        return ''
    if len(value) > MAX_METADATA:
        raise ValueError('metadata_too_large')
    if value.startswith(b'\x28\xb5\x2f\xfd'):
        from compression.zstd import ZstdDecompressor
        decoder = ZstdDecompressor()
        value = decoder.decompress(value, max_length=MAX_METADATA + 1)
        if len(value) > MAX_METADATA or not decoder.eof:
            raise ValueError('metadata_too_large_or_incomplete')
    return value.decode('utf-8')


def media_metadata(local_type, content):
    """Expose a small allowlist, never CDN credentials or arbitrary XML paths."""
    if int(local_type) & 0xffffffff == 47:
        from emoji_media import public_metadata
        return public_metadata(content)
    kind = {3: 'image', 34: 'voice', 43: 'video', 49: 'file'}.get(int(local_type) & 0xffffffff)
    if not kind:
        return None
    result = dict(kind=kind, state='pending', reason='not_resolved', variants={})
    try:
        if len(content.encode('utf-8')) > MAX_METADATA or '<!DOCTYPE' in content.upper() or '<!ENTITY' in content.upper():
            raise ValueError('invalid_xml')
        root = ET.fromstring(content)
        if kind == 'file':
            app = root.find('appmsg')
            if app is None or app.findtext('type') != '6':
                return None  # links/cards are not files
            result['name'] = (app.findtext('title') or 'attachment')[:255]
            size = app.findtext('appattach/totallen')
            md5 = app.findtext('md5')
            duration = None
        else:
            node = root.find({'image': 'img', 'voice': 'voicemsg', 'video': 'videomsg'}[kind])
            if node is None:
                raise ValueError('missing_media_node')
            size, md5 = node.get('length'), node.get('md5')
            duration = node.get('voicelength') if kind == 'voice' else None
            if kind == 'video' and node.get('playlength') is not None:
                duration = int(node.get('playlength')) * 1000
            if kind == 'image' and node.get('hdlength'):
                result['original_size'] = int(node.get('hdlength'))
            if kind == 'image' and node.get('hevc_mid_size'):
                hevc_size = int(node.get('hevc_mid_size'))
                if not 0 <= hevc_size <= MAX_FILE:
                    raise ValueError('invalid_hevc_size')
                if hevc_size:
                    result['hevc_mid_size'] = hevc_size
            if kind == 'video' and HEX32.fullmatch(node.get('rawmd5', '')):
                result['original_md5'] = node.get('rawmd5').lower()
        if size is not None:
            result['expected_size'] = int(size)
            if not 0 <= result['expected_size'] <= MAX_FILE:
                raise ValueError('media_too_large')
        if md5 and HEX32.fullmatch(md5):
            result['expected_md5'] = md5.lower()
        if duration is not None:
            result['declared_duration_ms'] = int(duration)
    except (ET.ParseError, ValueError, TypeError):
        result.update(state='failed', reason='invalid_media_metadata')
    return result


def proto_fields(blob, depth=0):
    """Read length-delimited protobuf fields without guessing printable substrings."""
    if depth > 4 or len(blob) > MAX_METADATA:
        raise ValueError('invalid_resource_metadata')
    position = 0

    def varint():
        nonlocal position
        value = 0
        for shift in range(0, 70, 7):
            if position >= len(blob):
                break
            byte = blob[position]
            position += 1
            value |= (byte & 127) << shift
            if byte < 128:
                return value
        raise ValueError('invalid_resource_metadata')

    result = {}
    while position < len(blob):
        tag = varint()
        field, wire = tag >> 3, tag & 7
        if not field:
            raise ValueError('invalid_resource_metadata')
        if wire == 2:
            size = varint()
            if size > len(blob) - position:
                raise ValueError('invalid_resource_metadata')
            result[field] = blob[position:position + size]
            position += size
        elif wire == 0:
            varint()
        elif wire in (1, 5):
            position += 8 if wire == 1 else 4
            if position > len(blob):
                raise ValueError('invalid_resource_metadata')
        else:
            raise ValueError('invalid_resource_metadata')
    return result


def nested_field(blob, *fields):
    for depth, field in enumerate(fields):
        blob = proto_fields(blob, depth).get(field, b'')
    return blob.decode('utf-8')


def safe_child(root, *parts):
    root = Path(root).resolve()
    # Reject path components taken from metadata, including Windows drive/ADS forms.
    for part in parts:
        if not isinstance(part, str) or not part or part in ('.', '..') or any(c in part for c in '/\\:\x00'):
            raise ValueError('invalid_media_path')
    target = root.joinpath(*parts).resolve()
    if root not in target.parents:
        raise ValueError('invalid_media_path')
    return target


def image_format(data):
    if data.startswith(b'\x89PNG\r\n\x1a\n'):
        return 'image/png', '.png'
    if data.startswith(b'\xff\xd8\xff'):
        return 'image/jpeg', '.jpg'
    if data.startswith((b'GIF87a', b'GIF89a')):
        return 'image/gif', '.gif'
    if data[:4] == b'RIFF' and data[8:12] == b'WEBP':
        return 'image/webp', '.webp'
    raise ValueError('unsupported_image_encoding')


def decrypt_image(data, aes_key=None, xor_key=None, allow_wxgf=False):
    if len(data) > MAX_FILE:
        raise ValueError('media_too_large')
    if data[:6] in (b'\x07\x08V1\x08\x07', b'\x07\x08V2\x08\x07'):
        if len(data) < 31:
            raise ValueError('incomplete_image')
        if data[3] == ord('1'):
            aes_key = b'cfcd208495d565ef'
        if aes_key is None:
            raise LookupError('image_key_unavailable')
        if len(aes_key) != 16:
            raise ValueError('invalid_image_key')
        plain_size, tail_size = struct.unpack_from('<II', data, 6)
        cipher_size = (plain_size // 16 + 1) * 16
        if 15 + cipher_size + tail_size > len(data):
            raise LookupError('incomplete_image')
        from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
        from cryptography.hazmat.primitives.padding import PKCS7
        decryptor = Cipher(algorithms.AES(aes_key), modes.ECB()).decryptor()
        padded = decryptor.update(data[15:15 + cipher_size]) + decryptor.finalize()
        unpad = PKCS7(128).unpadder()
        try:
            head = unpad.update(padded) + unpad.finalize()
        except ValueError:
            raise LookupError('image_key_mismatch') from None
        if len(head) != plain_size:
            raise ValueError('invalid_image_length')
        end = len(data) - tail_size
        if tail_size and xor_key is None:
            raise LookupError('image_xor_key_unavailable')
        decoded = head + data[15 + cipher_size:end]
        if tail_size:
            decoded += bytes(byte ^ xor_key for byte in data[end:])
    else:
        if allow_wxgf and data.startswith(b'wxgf'):
            return data
        try:
            image_format(data)
            return data
        except ValueError:
            pass
        decoded = None
        for magic in (b'\xff\xd8\xff', b'\x89PNG\r\n\x1a\n', b'GIF89a', b'GIF87a'):
            if len(data) >= len(magic):
                key = data[0] ^ magic[0]
                if bytes(byte ^ key for byte in data[:len(magic)]) == magic:
                    decoded = bytes(byte ^ key for byte in data)
                    break
        if decoded is None:
            raise ValueError('unsupported_image_container')
    if not (allow_wxgf and decoded.startswith(b'wxgf')):
        image_format(decoded)
    return decoded


def decode_wxgf(data):
    """Decode one HEVC frame in an isolated, bounded-time process."""
    import subprocess
    import sys
    import tempfile
    sys.path.insert(0, str(Path(__file__).resolve().parent / 'deps'))
    try:
        import imageio_ffmpeg
    except ImportError:
        raise LookupError('image_decoder_unavailable') from None
    start = data.find(b'\x00\x00\x00\x01', 4, 4096)
    if not data.startswith(b'wxgf') or start < 0 or len(data) > MAX_FILE:
        raise ValueError('invalid_wxgf')
    with tempfile.TemporaryDirectory(prefix='wxbot-image-') as directory:
        source, output = Path(directory) / 'frame.hevc', Path(directory) / 'frame.png'
        source.write_bytes(data[start:])
        try:
            result = subprocess.run([imageio_ffmpeg.get_ffmpeg_exe(), '-hide_banner', '-loglevel', 'error',
                '-nostdin', '-max_alloc', '134217728', '-threads', '1', '-f', 'hevc', '-i', str(source),
                '-frames:v', '1', '-threads', '1', '-fs', str(MAX_FILE), '-y', str(output)],
                stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=15,
                creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
        except (subprocess.TimeoutExpired, OSError):
            raise ValueError('image_decode_failed') from None
        if result.returncode or not output.is_file() or not 0 < output.stat().st_size <= MAX_FILE:
            raise ValueError('image_decode_failed')
        return output.read_bytes()


class LocalMediaBackend:
    """Used only by the media worker; HTTP threads never open source databases.

    ``lock`` serializes only the database/cache accesses with the receive poller;
    file reads, decryption and decoding stay concurrent.
    """
    def __init__(self, db, image_keys=None, download_emoji=False, lock=None):
        self.db = db
        self.download_emoji = download_emoji
        self.lock = lock
        self.root = Path(db.account_dir).resolve()
        self.aes_key = self.xor_key = None
        if image_keys:
            keys = json.loads(Path(image_keys).read_text(encoding='utf-8'))
            self.aes_key = keys['aes_key'].encode('ascii')
            self.xor_key = int(keys['xor_key'])
            if len(self.aes_key) != 16 or not 0 <= self.xor_key <= 255:
                raise ValueError('invalid_image_keys')
        elif db.cfg_dword is not None:
            self.aes_key = hashlib.md5((str(db.cfg_dword) + db.wxid).encode()).hexdigest()[:16].encode()
            self.xor_key = db.cfg_dword & 255

    def _locked(self):
        return self.lock if self.lock is not None else contextlib.nullcontext()

    def _open(self, name):
        rel = os.path.join('message', name)
        if hasattr(self.db, '_keys') and rel not in self.db._keys:
            raise LookupError('media_database_key_unavailable')
        return self.db._open(rel)

    def resources(self, event):
        with self._locked():
            conn = self._open('message_resource.db')
            try:
                rows = conn.execute(
                    'SELECT i.packed_info, d.type, d.size, d.status, d.packed_info AS detail_info '
                    'FROM MessageResourceInfo i JOIN ChatName2Id n ON n.rowid=i.chat_id '
                    'LEFT JOIN MessageResourceDetail d ON d.message_id=i.message_id '
                    'WHERE n.user_name=? AND i.message_local_id=? AND i.message_create_time=? '
                    'AND i.message_local_type=?',
                    (event['conversation_id'], event['local_id'], event['timestamp'], event['local_type'])).fetchall()
                return [dict(row) for row in rows]
            finally:
                conn.close()

    def read_file(self, path):
        path = Path(path).resolve()
        if self.root not in path.parents:
            raise ValueError('invalid_media_path')
        with path.open('rb') as source:
            data = source.read(MAX_FILE + 1)
        if len(data) > MAX_FILE:
            raise ValueError('media_too_large')
        return data

    def message_stem(self, event):
        # Group images can have no MessageResourceInfo row. Their exact message
        # still carries a typed resource identifier in packed_info_data (3, 4).
        with self._locked():
            found = self.db._msg_conn(event['conversation_id']) if hasattr(self.db, '_msg_conn') else None
            if found is None:
                raise LookupError('resource_not_indexed')
            conn, table = found
            try:
                row = conn.execute('SELECT packed_info_data FROM ' + table +
                    ' WHERE local_id=? AND create_time=? AND server_id=? AND local_type=?',
                    (event['local_id'], event['timestamp'], event['server_id'], event['local_type'])).fetchone()
                if not row or not isinstance(row[0], bytes):
                    raise LookupError('resource_not_indexed')
                return nested_field(row[0], 3, 4)
            finally:
                conn.close()

    def resolve(self, event):
        media = event['media']
        if media['kind'] == 'emoji':
            return self._emoji(event)
        if media['kind'] == 'voice':
            return self._voice(event)
        rows = self.resources(event)
        if not rows and media['kind'] == 'file':
            raise LookupError('resource_not_indexed')
        from datetime import datetime
        month = datetime.fromtimestamp(event['timestamp']).strftime('%Y-%m')
        if media['kind'] == 'file':
            variants = []
            for row in rows:
                if row['detail_info']:
                    name = nested_field(row['detail_info'], 1, 2)
                    if name:
                        path = safe_child(self.root, 'msg', 'file', month, name)
                        variants.append(('content', path, 'application/octet-stream', '.bin', media.get('expected_md5')))
            if not variants:
                raise LookupError('file_path_not_indexed')
        else:
            stem = nested_field(rows[0]['packed_info'], 2, 1) if rows else self.message_stem(event)
            if not HEX32.fullmatch(stem):
                raise ValueError('invalid_resource_identifier')
            if media['kind'] == 'image':
                folder = safe_child(self.root, 'msg', 'attach', hashlib.md5(event['conversation_id'].encode()).hexdigest(), month, 'Img')
                variants = [(variant, safe_child(folder, stem + suffix + '.dat'), None, None, media.get('expected_md5') if variant != 'thumbnail' else None)
                            for variant, suffix in [('original', '_h'), ('content', ''), ('thumbnail', '_t')]]
            else:
                folder = safe_child(self.root, 'msg', 'video', month)
                variants = [(variant, safe_child(folder, stem + suffix), mime, ext, md5) for variant, suffix, mime, ext, md5 in [
                    ('content', '.mp4', 'video/mp4', '.mp4', media.get('expected_md5')),
                    ('original', '_raw.mp4', 'video/mp4', '.mp4', media.get('original_md5')),
                    ('thumbnail', '_thumb.jpg', 'image/jpeg', '.jpg', None)]]
        result, issues = {}, []
        for variant, path, mime, ext, expected_md5 in variants:
            if not path.is_file():
                continue
            try:
                data = self.read_file(path)
                extra = {}
                if not data:
                    raise LookupError('content_incomplete')
                if media['kind'] == 'image':
                    data = decrypt_image(data, self.aes_key, self.xor_key, allow_wxgf=True)
                    if data.startswith(b'wxgf'):
                        # XML length/md5 refer to the JPEG original, not this HEVC rendition.
                        if variant != 'content' or not media.get('hevc_mid_size'):
                            raise LookupError('image_variant_unverified')
                        if len(data) != media['hevc_mid_size']:
                            raise LookupError('content_incomplete')
                        extra = dict(transcoded_from='image/wxgf', source_size=len(data),
                                     source_sha256=hashlib.sha256(data).hexdigest())
                        data = decode_wxgf(data)
                        expected_md5 = None
                    mime, ext = image_format(data)
                    import io
                    from PIL import Image
                    with Image.open(io.BytesIO(data)) as image:
                        if image.width * image.height > 50_000_000:
                            raise ValueError('image_dimensions_too_large')
                        image.load()
                if variant == 'content' and not extra and media.get('expected_size') is not None and len(data) != media['expected_size']:
                    raise LookupError('content_incomplete')
                if expected_md5 and hashlib.md5(data).hexdigest() != expected_md5:
                    raise LookupError('content_hash_mismatch')
                if mime == 'video/mp4' and data[4:8] != b'ftyp':
                    raise ValueError('unsupported_video_encoding')
                result[variant] = (data, mime, ext, extra) if extra else (data, mime, ext)
            except (ValueError, LookupError) as error:
                issues.append(str(error))
        return result, issues

    def _emoji(self, event):
        if not self.download_emoji:
            raise LookupError('emoji_download_disabled')
        with self._locked():
            found = self.db._msg_conn(event['conversation_id'])
            if found is None:
                raise LookupError('emoji_message_not_found')
            conn, table = found
            try:
                row = conn.execute('SELECT message_content FROM ' + table +
                    ' WHERE local_id=? AND create_time=? AND server_id=? AND local_type=?',
                    (event['local_id'], event['timestamp'], event['server_id'], event['local_type'])).fetchone()
            finally:
                conn.close()
        if not row:
            raise LookupError('emoji_message_not_found')
        content = decode_content(row[0])
        if not content.startswith('<') and ':\n' in content:
            content = content.split(':\n', 1)[1]
        from emoji_media import parse_emoji, fetch
        resource = parse_emoji(content)
        if resource['md5'] != event['media'].get('expected_md5') or resource['expected_size'] != event['media'].get('expected_size'):
            raise ValueError('emoji_identity_mismatch')
        return {'content': fetch(resource)}, []

    def _voice(self, event):
        with self._locked():
            self.db._refresh_db_files() if hasattr(self.db, '_refresh_db_files') else None
            rels = [rel for rel, _, _ in self.db._db_files if re.fullmatch(r'message[/\\]media_\d+\.db', rel)]
            for rel in rels:
                if hasattr(self.db, '_keys') and rel not in self.db._keys:
                    continue
                conn = self.db._open(rel)
                try:
                    row = conn.execute('SELECT v.voice_data FROM VoiceInfo v JOIN Name2Id n '
                                       'ON n.rowid=v.chat_name_id WHERE n.user_name=? AND v.local_id=? '
                                       'AND v.create_time=?', (event['conversation_id'], event['local_id'], event['timestamp'])).fetchone()
                finally:
                    conn.close()
                if row:
                    data = row[0]
                    if not isinstance(data, bytes) or len(data) > 2 * 1024 * 1024:
                        raise ValueError('invalid_voice_data')
                    from voice_codec import packets
                    packets(data)  # actual container validation, never prepend a guessed header
                    expected = event['media'].get('expected_size')
                    if expected is not None and len(data) != expected:
                        raise LookupError('voice_content_incomplete')
                    return {'silk': (data, 'audio/silk', '.silk')}, []
        raise LookupError('voice_not_downloaded')


class MediaStore:
    """Session-only opaque IDs, finite metadata/cache, TTL and authenticated reads."""
    def __init__(self, backend, cache_dir, capacity=128, max_bytes=256 * 1024 * 1024, ttl=3600):
        self.backend = backend
        self.cache = Path(cache_dir).resolve()
        self.cache.mkdir(parents=True, exist_ok=True)
        self.capacity, self.max_bytes, self.ttl = capacity, max_bytes, ttl
        self.entries = OrderedDict()
        self.lock = threading.RLock()

    def register(self, event):
        import secrets
        with self.lock:
            media_id = secrets.token_hex(16)
            media = dict(event['media'], id=media_id, url='/media/' + media_id)
            self.entries[media_id] = dict(event=dict(event, media=media), media=media,
                                          created=time.monotonic(), paths={}, attempted=0, processing=False,
                                          retry_after=0, emoji_attempts=0)
            self._cleanup()
            return dict(media)

    def _cleanup(self):
        now = time.monotonic()
        total = 0
        for path in self.cache.glob('*'):
            try:
                total += path.stat().st_size if path.is_file() else 0
            except FileNotFoundError:
                pass  # A polling-worker temporary file was atomically renamed.
        for key, entry in list(self.entries.items()):
            if entry['processing']:
                continue
            if len(self.entries) <= self.capacity and now - entry['created'] < self.ttl and total <= self.max_bytes:
                continue
            for path in entry['paths'].values():
                if path.is_file():
                    total -= path.stat().st_size
                    path.unlink()
            del self.entries[key]

    def _write(self, media_id, variant, data, mime, ext, entry):
        if len(data) > MAX_FILE:
            raise ValueError('media_too_large')
        path = self.cache / (media_id + '-' + variant + ext)
        temporary = path.with_suffix('.tmp')
        try:
            temporary.write_bytes(data)
            temporary.replace(path)
        finally:
            temporary.unlink(missing_ok=True)
        with self.lock:
            entry['paths'][variant] = path
        return dict(size=len(data), sha256=hashlib.sha256(data).hexdigest(), mime=mime,
                    url='/media/%s/content?variant=%s' % (media_id, variant))

    def refresh(self):
        # All decrypting/database/codec work stays on the polling worker.
        with self.lock:
            self.cache.touch()
            self._cleanup()
            pending = sorted(((key, entry) for key, entry in self.entries.items()
                              if entry['media']['state'] == 'pending' and time.monotonic() - entry['attempted'] >= 2
                              and time.monotonic() >= entry.get('retry_after', 0)),
                             key=lambda item: item[1]['attempted'])[:4]
        for key, entry in pending:
            entry['attempted'] = time.monotonic()
            with self.lock:
                if key not in self.entries:
                    continue
                entry['processing'] = True
            emoji_download = entry['media']['kind'] == 'emoji' and getattr(self.backend, 'download_emoji', False)
            if emoji_download:
                entry['emoji_attempts'] += 1
                entry['media']['download'] = dict(state='requesting', attempts=entry['emoji_attempts'])
            try:
                variants, issues = self.backend.resolve(entry['event'])
                descriptors = {}
                for variant, payload in variants.items():
                    data, mime, ext = payload[:3]
                    descriptors[variant] = self._write(key, variant, data, mime, ext, entry)
                    if len(payload) == 4:
                        descriptors[variant].update(payload[3])
                if 'silk' in variants:
                    from voice_codec import verify_silk_child
                    wav = self.cache / (key + '-content.wav')
                    with self.lock:
                        entry['paths']['content'] = wav
                    verified = verify_silk_child(entry['paths']['silk'], wav)
                    data = wav.read_bytes()
                    descriptors['content'] = self._write(key, 'content', data, 'audio/wav', '.wav', entry)
                    entry['media']['duration_ms'] = verified['duration_ms']
                if 'original' in descriptors and 'content' not in descriptors:
                    descriptors['content'] = dict(descriptors['original'], url='/media/%s/content?variant=content' % key)
                    with self.lock:
                        entry['paths']['content'] = entry['paths']['original']
                ready = 'content' in descriptors or 'original' in descriptors
                with self.lock:
                    entry['media'].update(variants=descriptors, state='ready' if ready else 'pending',
                                          reason=None if ready else (issues[0] if issues else 'not_downloaded'))
                    if emoji_download:
                        entry['media']['download'] = dict(state='completed', attempts=entry['emoji_attempts'])
            except (LookupError, FileNotFoundError) as error:
                with self.lock:
                    entry['media'].update(reason=(str(error) if re.fullmatch('[a-z_]+', str(error)) else 'not_downloaded'))
                    if emoji_download:
                        exhausted = entry['emoji_attempts'] >= 2
                        entry['retry_after'] = time.monotonic() + 30
                        entry['media'].update(state='failed' if exhausted else 'pending',
                            download=dict(state='failed' if exhausted else 'retry_wait', attempts=entry['emoji_attempts']))
            except Exception as error:
                # Do not put SQL, filesystem paths or codec logs into public responses.
                with self.lock:
                    entry['media'].update(state='failed', reason=(str(error) if isinstance(error, ValueError) and re.fullmatch('[a-z_]+', str(error)) else 'media_processing_failed'))
                    if emoji_download:
                        entry['media']['download'] = dict(state='failed', attempts=entry['emoji_attempts'])
            with self.lock:
                entry['processing'] = False
                self._cleanup()

    def metadata(self, media_id):
        with self.lock:
            self._cleanup()
            entry = self.entries.get(media_id)
            return json.loads(json.dumps(entry['media'])) if entry else None

    def snapshot(self):
        """Public metadata for every registered item, keyed by message id."""
        with self.lock:
            return [(entry['event']['message_id'], json.loads(json.dumps(entry['media'])))
                    for entry in self.entries.values()]

    def stats(self):
        with self.lock:
            states = {}
            for entry in self.entries.values():
                state = entry['media'].get('state', 'unknown')
                states[state] = states.get(state, 0) + 1
            return dict(items=len(self.entries), capacity=self.capacity, states=states)

    def synchronize_downloads(self, queue):
        with self.lock:
            entries = [(key, dict(entry['event'], media=dict(entry['media'])))
                       for key, entry in self.entries.items()
                       if entry['media']['kind'] in ('image', 'video')]
        for key, event in entries:
            if event['media']['state'] == 'pending':
                queue.submit(event)
            status = queue.status(event)
            if status:
                with self.lock:
                    if key in self.entries:
                        self.entries[key]['media']['download'] = status

    def content(self, media_id, variant='content'):
        with self.lock:
            self._cleanup()
            entry = self.entries.get(media_id)
            if not entry:
                return 404, dict(error='media_not_found')
            info = entry['media']['variants'].get(variant)
            path = entry['paths'].get(variant)
            if not info or not path or not path.is_file():
                return 409, dict(error='media_not_ready', state=entry['media']['state'])
            return 200, (path.read_bytes(), info['mime'])

    def close(self):
        with self.lock:
            for entry in self.entries.values():
                for path in entry['paths'].values():
                    path.unlink(missing_ok=True)
            self.entries.clear()
            for path in self.cache.glob('*'):
                if path.is_file():
                    path.unlink()
            self.cache.rmdir()
