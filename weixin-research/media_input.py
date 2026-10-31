"""Bounded outbound media input policy (P7).

The old sender only accepted generated ``fixtures/wxbot-*`` files with a manifest
hash.  That is correct for regression evidence but useless for a bot: it cannot
send a picture it just produced.  This module separates the two ideas:

* roots are configured on purpose (``WECHAT_BOT_MEDIA_ROOTS``, default fixtures);
* a file must resolve inside one of those roots and be a regular file;
* the exact bytes are hashed, then copied into a private staging directory so a
  concurrent writer cannot change the file between validation and the native
  call (the native layer receives the staged path);
* generated fixtures keep their manifest check, so tampered evidence is still
  rejected;
* static images are normalised to PNG; GIF bytes retain all animation frames;
  WAV is normalised to mono 16 kHz 16-bit PCM, which the SILK encoder accepts.

Errors are ``PolicyError`` with stable lower-case codes.
"""
import hashlib
import io
import json
import os
import re
import shutil
import subprocess
import sys
import time
import uuid
import wave
from pathlib import Path

from policy import PolicyError
from profile import ROOT

STAGING_ROOT = ROOT / 'runs' / 'media-staging'
MAX_NAME = 160
MAX_PIXELS = 50_000_000
_CONTROL = re.compile(r'[\x00-\x1f\x7f]')
_SAFE = re.compile(r'[^0-9A-Za-z._\-\u4e00-\u9fff ]')


def _inside(path, root):
    path, root = Path(path).resolve(), Path(root).resolve()
    left, right = os.path.normcase(str(path)), os.path.normcase(str(root))
    return left == right or left.startswith(right + os.sep)


def _allowed_root(path, policy):
    for root in policy.media_roots:
        if _inside(path, root):
            return Path(root).resolve()
    raise PolicyError('media_outside_allowed_roots',
                      'input must be inside one of the configured media roots')


def _safe_name(name):
    name = _SAFE.sub('_', name).strip(' ._')
    if not name:
        name = 'media'
    return name[:MAX_NAME]


def _read_source(path, policy):
    if not isinstance(path, (str, os.PathLike)):
        raise PolicyError('invalid_media_path', 'a file path is required')
    raw = str(path)
    if not raw or '\x00' in raw or _CONTROL.search(raw):
        raise PolicyError('invalid_media_path', 'path contains control characters')
    resolved = Path(raw).resolve()
    if resolved == Path(resolved.anchor) or resolved.is_dir():
        raise PolicyError('invalid_media_path', 'a file is required')
    _allowed_root(resolved, policy)
    if not resolved.is_file():
        raise PolicyError('media_not_found', 'file does not exist')
    if resolved.is_symlink():
        raise PolicyError('invalid_media_path', 'symbolic links are not accepted')
    name = resolved.name
    if len(name) > 240:
        raise PolicyError('media_name_too_long', 'file name is too long')
    size = resolved.stat().st_size
    if size <= 0:
        raise PolicyError('media_empty', 'file is empty')
    if size > policy.media_bytes:
        raise PolicyError('media_too_large', 'file exceeds the configured media limit')
    with resolved.open('rb') as source:
        data = source.read(policy.media_bytes + 1)
    if len(data) > policy.media_bytes:
        raise PolicyError('media_too_large', 'file exceeds the configured media limit')
    digest = hashlib.sha256(data).hexdigest()
    _fixture_manifest(resolved, data)
    return resolved, name, data, digest


def _fixture_manifest(path, data):
    """Generated wxbot-* fixtures keep their manifest identity.

    This preserves the reproducible test evidence while ordinary business files
    in an explicitly configured root do not need a project manifest entry.
    """
    fixtures = (ROOT / 'fixtures').resolve()
    if not _inside(path, fixtures) or not path.name.startswith('wxbot-'):
        return
    try:
        manifest = json.loads((fixtures / 'manifest.json').read_text(encoding='utf-8'))
    except (OSError, ValueError):
        raise PolicyError('fixture_manifest_unavailable', 'generated fixture manifest is missing') from None
    digest = hashlib.sha256(data).hexdigest()
    if not any(item.get('name') == path.name and item.get('sha256') == digest for item in manifest):
        raise PolicyError('fixture_manifest_mismatch',
                          'fixture differs from generated manifest; regenerate fixtures')


def _image_format(data):
    if data.startswith(b'\x89PNG\r\n\x1a\n'):
        return 'png'
    if data.startswith(b'\xff\xd8\xff'):
        return 'jpeg'
    if data.startswith((b'GIF87a', b'GIF89a')):
        return 'gif'
    if data[:4] == b'RIFF' and data[8:12] == b'WEBP':
        return 'webp'
    return None


def _normalise_image(data, policy):
    fmt = _image_format(data)
    if fmt is None:
        raise PolicyError('image_format_unsupported',
                          'image must be one of ' + ', '.join(policy.image_formats).upper())
    if fmt not in policy.image_formats:
        raise PolicyError('image_format_not_allowed',
                          'image must be one of ' + ', '.join(policy.image_formats).upper())
    try:
        from PIL import Image
    except ImportError:
        raise PolicyError('image_decoder_unavailable', 'Pillow is required for image validation') from None
    try:
        with Image.open(io.BytesIO(data)) as image:
            if image.width * image.height > MAX_PIXELS:
                raise PolicyError('image_dimensions_too_large', 'image dimensions exceed the limit')
            frames = getattr(image, 'n_frames', 1)
            if frames > 500 or frames * image.width * image.height > 100_000_000:
                raise PolicyError('image_animation_too_large', 'animation exceeds the frame or pixel limit')
            duration = 0
            animation = []
            durations = []
            loop = image.info.get('loop', 0)
            for frame in range(frames):
                image.seek(frame)
                image.load()
                delay = max(0, int(image.info.get('duration', 0)))
                duration += delay
                if duration > 120000:
                    raise PolicyError('image_animation_too_large', 'animation exceeds the duration limit')
                if frames > 1 and fmt != 'gif':
                    animation.append(image.convert('RGBA').copy())
                    durations.append(delay)
            if fmt == 'gif':
                return data, 'image/gif', 'gif', None
            if animation:
                output = io.BytesIO()
                animation[0].save(output, format='GIF', save_all=True, append_images=animation[1:],
                                  duration=durations, loop=loop, disposal=2)
                return output.getvalue(), 'image/gif', 'gif', fmt
            image.seek(0)
            image.load()
            if fmt == 'png':
                return data, 'image/png', 'png', None
            if image.mode not in ('RGB', 'RGBA'):
                image = image.convert('RGBA' if 'A' in image.getbands() else 'RGB')
            output = io.BytesIO()
            image.save(output, format='PNG')
            return output.getvalue(), 'image/png', 'png', fmt
    except PolicyError:
        raise
    except Exception:
        raise PolicyError('image_decode_failed', 'image could not be decoded') from None


def _normalise_wav(data):
    try:
        with wave.open(io.BytesIO(data), 'rb') as source:
            channels = source.getnchannels()
            width = source.getsampwidth()
            rate = source.getframerate()
            frames = source.getnframes()
            compression = source.getcomptype()
            raw = source.readframes(frames)
    except (wave.Error, EOFError):
        raise PolicyError('audio_format_unsupported', 'voice must be WAV or Tencent SILK') from None
    if compression != 'NONE' or channels not in (1, 2) or width not in (1, 2, 3, 4):
        raise PolicyError('audio_format_unsupported', 'voice WAV must be uncompressed mono/stereo PCM')
    if not 8000 <= rate <= 48000:
        raise PolicyError('audio_sample_rate_unsupported', 'voice sample rate must be 8..48 kHz')
    if frames <= 0 or frames > rate * 60:
        raise PolicyError('audio_duration_out_of_range', 'voice must be 20 ms..60 s')
    pcm16 = _to_s16(raw, width)
    if channels == 2:
        pcm16 = _downmix_s16(pcm16)
    if rate != 16000:
        pcm16 = _resample(pcm16, rate, 16000)
    frame_bytes = 320 * 2
    remainder = len(pcm16) % frame_bytes
    if remainder:
        pcm16 += b'\x00' * (frame_bytes - remainder)
    if not 320 * 2 <= len(pcm16) <= 16000 * 2 * 60:
        raise PolicyError('audio_duration_out_of_range', 'voice must be 20 ms..60 s')
    output = io.BytesIO()
    with wave.open(output, 'wb') as target:
        target.setparams((1, 2, 16000, 0, 'NONE', 'not compressed'))
        target.writeframes(pcm16)
    return output.getvalue(), 'audio/wav', 'wav', (channels, width, rate)


def _downmix_s16(pcm):
    import array
    values = array.array('h')
    values.frombytes(pcm[:len(pcm) // 2 * 2])
    if sys.byteorder == 'big':
        values.byteswap()
    mixed = array.array('h')
    for index in range(0, len(values) - 1, 2):
        mixed.append((int(values[index]) + int(values[index + 1])) // 2)
    if sys.byteorder == 'big':
        mixed.byteswap()
    return mixed.tobytes()


def _to_s16(raw, width):
    import array
    if width == 2:
        return raw
    values = array.array('h')
    if width == 1:
        for value in raw:
            values.append((value - 128) << 8)
    elif width == 3:
        for index in range(0, len(raw) - 2, 3):
            sample = int.from_bytes(raw[index:index + 3], 'little', signed=True)
            values.append(sample >> 8)
    else:
        source = array.array('i')
        source.frombytes(raw[:len(raw) // 4 * 4])
        if sys.byteorder == 'big':
            source.byteswap()
        for sample in source:
            values.append(sample >> 16)
    if sys.byteorder == 'big':
        values.byteswap()
    return values.tobytes()


def _resample(pcm, rate, target_rate):
    import array
    source = array.array('h')
    source.frombytes(pcm[:len(pcm) // 2 * 2])
    if sys.byteorder == 'big':
        source.byteswap()
    count = int(len(source) * target_rate / rate)
    step = rate / target_rate
    result = array.array('h')
    for index in range(count):
        position = index * step
        left = int(position)
        fraction = position - left
        first = source[left]
        second = source[left + 1] if left + 1 < len(source) else first
        result.append(int(first + (second - first) * fraction))
    if sys.byteorder == 'big':
        result.byteswap()
    return result.tobytes()


def _normalise_voice(data, policy, source_format):
    if source_format == 'silk':
        from voice_codec import packets
        try:
            packets(data)
        except ValueError:
            raise PolicyError('audio_format_unsupported', 'Tencent SILK container is invalid') from None
        return data, 'audio/silk', 'silk', None
    if source_format == 'wav':
        return _normalise_wav(data)
    if source_format == 'mp3' and 'mp3' in policy.voice_formats:
        return _transcode_audio(data)
    raise PolicyError('audio_format_unsupported', 'voice must be WAV or Tencent SILK')


def _voice_format(data):
    if data.startswith(b'#!SILK_V3') or data.startswith(b'\x02#!SILK_V3'):
        return 'silk'
    if data.startswith(b'RIFF') and data[8:12] == b'WAVE':
        return 'wav'
    if data.startswith((b'ID3', b'\xff\xfb', b'\xff\xf3', b'\xff\xf2')):
        return 'mp3'
    return None


def _ffmpeg():
    deps = Path(__file__).resolve().parent / 'deps'
    if str(deps) not in sys.path:
        sys.path.insert(0, str(deps))
    try:
        import imageio_ffmpeg
        return imageio_ffmpeg.get_ffmpeg_exe()
    except Exception:
        return shutil.which('ffmpeg')


def _run_ffmpeg(arguments, timeout=120):
    executable = _ffmpeg()
    if not executable:
        raise PolicyError('media_converter_unavailable', 'ffmpeg is not available')
    try:
        completed = subprocess.run([executable, '-hide_banner', '-loglevel', 'error', '-nostdin', *arguments],
                                   capture_output=True, timeout=timeout,
                                   creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
    except (subprocess.TimeoutExpired, OSError):
        raise PolicyError('media_conversion_failed', 'media conversion failed or timed out') from None
    if completed.returncode:
        raise PolicyError('media_conversion_failed', 'media conversion failed')


def _transcode_audio(data):
    import tempfile
    with tempfile.TemporaryDirectory(prefix='wxbot-audio-') as directory:
        source = Path(directory) / 'input.audio'
        output = Path(directory) / 'output.wav'
        source.write_bytes(data)
        _run_ffmpeg(['-i', str(source), '-ac', '1', '-ar', '16000', '-sample_fmt', 's16',
                     '-f', 'wav', '-y', str(output)], timeout=60)
        if not output.is_file() or output.stat().st_size > 8 * 1024 * 1024:
            raise PolicyError('media_conversion_failed', 'audio conversion produced no bounded output')
        return _normalise_wav(output.read_bytes())


def _normalise_video(data, policy):
    if data[4:8] == b'ftyp':
        return data, 'video/mp4', 'mp4', None
    if not policy.convert_video:
        raise PolicyError('video_format_unsupported',
                          'native video requires MP4; enable WECHAT_BOT_VIDEO_CONVERT to transcode')
    import tempfile
    with tempfile.TemporaryDirectory(prefix='wxbot-video-') as directory:
        source = Path(directory) / 'input.video'
        output = Path(directory) / 'output.mp4'
        source.write_bytes(data)
        _run_ffmpeg(['-i', str(source), '-t', '60', '-c:v', 'libx264', '-pix_fmt', 'yuv420p',
                     '-preset', 'veryfast', '-c:a', 'aac', '-movflags', '+faststart',
                     '-f', 'mp4', '-y', str(output)])
        if not output.is_file():
            raise PolicyError('media_conversion_failed', 'video conversion produced no output')
        result = output.read_bytes()
        if len(result) > policy.media_bytes:
            raise PolicyError('media_too_large', 'converted video exceeds the configured media limit')
        if result[4:8] != b'ftyp':
            raise PolicyError('media_conversion_failed', 'video conversion did not produce MP4')
        return result, 'video/mp4', 'mp4', 'converted'


def _stage(name, data, suffix, root=None):
    root = Path(root or STAGING_ROOT)
    directory = root / uuid.uuid4().hex
    directory.mkdir(parents=True, exist_ok=False)
    stem = _safe_name(Path(name).stem)
    path = directory / (stem + suffix)
    temporary = path.with_suffix(path.suffix + '.tmp')
    temporary.write_bytes(data)
    temporary.replace(path)
    return directory, path


def prepare_media(kind, path, policy, staging_root=None):
    """Validate, normalise and stage one outbound media file.

    Returns a dict with ``path`` (the staged file the native layer receives),
    ``directory`` (removed after the send) and public ``media`` metadata.
    """
    source, name, data, digest = _read_source(path, policy)
    converted_from = None
    if kind == 'image':
        data, mime, output_format, converted_from = _normalise_image(data, policy)
        suffix = '.' + output_format
    elif kind == 'file':
        mime, output_format = 'application/octet-stream', (source.suffix.lower().lstrip('.') or 'bin')
        suffix = source.suffix[:16] if source.suffix else '.bin'
    elif kind == 'video':
        data, mime, output_format, converted_from = _normalise_video(data, policy)
        suffix = '.mp4'
    elif kind == 'voice':
        source_format = _voice_format(data)
        if source_format is None or source_format not in policy.voice_formats:
            raise PolicyError('audio_format_unsupported', 'voice must be WAV or Tencent SILK')
        data, mime, output_format, audio = _normalise_voice(data, policy, source_format)
        suffix = '.silk' if output_format == 'silk' else '.wav'
        if source_format != output_format:
            converted_from = 'audio/%s->%s' % (source_format, output_format)
        elif audio:
            converted_from = 'wav(%d Hz, %d ch, %d-bit)->wav(16000 Hz, mono, 16-bit)' % audio
    else:
        raise PolicyError('unsupported_media_kind', 'unsupported media kind')
    if len(data) > policy.media_bytes:
        raise PolicyError('media_too_large', 'normalised media exceeds the configured media limit')
    digest = hashlib.sha256(data).hexdigest()
    directory, staged = _stage(name, data, suffix, staging_root)
    return dict(path=str(staged), directory=str(directory),
                media=dict(source_name=name, size=len(data), sha256=digest, mime=mime,
                           format=output_format, converted_from=converted_from,
                           source_size=source.stat().st_size))


def cleanup_staging(root=None, ttl=3600):
    """Remove only this feature's private staging directories."""
    root = Path(root or STAGING_ROOT)
    if not root.is_dir():
        return 0
    removed = 0
    for folder in root.iterdir():
        try:
            if not folder.is_dir() or folder.is_symlink() or not re.fullmatch('[a-f0-9]{32}', folder.name):
                continue
            if time.time() - folder.stat().st_mtime < ttl:
                continue
            shutil.rmtree(folder, ignore_errors=True)
            removed += 1
        except OSError:
            continue
    return removed
