"""Explicit one-shot sender experiment; offline preparation is the default.

The recipient is an explicit parameter all the way down to the native call.
Whether a target is permitted is decided once, by the send policy, not by
filters hidden in each layer.
"""
import argparse
import json
import hashlib
import subprocess
import struct
import sys
import uuid
from pathlib import Path
from pe_image import PEImage
from policy import SendPolicy
from profile import (ROOT, DLL, SHA256, SEND_FUNCTIONS, EMOJI_VTABLE, VERSION,
                     make_config)
from probe import Journal, render_source, run_probe


def voice_worker(*arguments):
    try:
        completed = subprocess.run([sys.executable, str(ROOT / 'voice_codec.py'), *map(str, arguments)],
                                   capture_output=True, text=True, timeout=20)
    except subprocess.TimeoutExpired as error:
        raise ValueError('Voice codec worker timed out; no send was started') from error
    if completed.returncode:
        raise ValueError('Voice codec worker failed: ' + completed.stderr[-500:])
    return json.loads(completed.stdout)

FUNCTIONS = dict(SEND_FUNCTIONS)

KINDS = ('context', 'text', 'image', 'file', 'video', 'voice', 'emoji')


_IMAGE_CACHE = {}


def pinned_image():
    stat = DLL.stat()
    key = (str(DLL), stat.st_mtime_ns, stat.st_size)
    image = _IMAGE_CACHE.get(key)
    # Never reuse an image built by a patched/test reader class.
    if image is None or type(image) is not PEImage:
        image = PEImage(DLL)
        _IMAGE_CACHE.clear()
        _IMAGE_CACHE[key] = image
    if image.sha256 != SHA256:
        raise ValueError('Pinned DLL changed')
    return image


def config_for(kind, text=None, path=None, recipient='filehelper', seconds=15, policy=None,
               emoji_id=None, emoji_catalog=None):
    config = make_config(seconds=seconds)
    image = pinned_image()
    if kind not in KINDS:
        raise ValueError('Unsupported active experiment')
    policy = policy or SendPolicy.from_environment()
    recipient_bytes = policy.encode_recipient(recipient)
    text_bytes = policy.encode_text(text) if kind == 'text' else b''
    request = dict(kind=kind, recipient=recipient, recipient_bytes=list(recipient_bytes),
                   text=text if kind == 'text' else None, text_bytes=list(text_bytes),
                   limits=policy.describe(),
                   helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                   thread_source=(ROOT / 'app_thread_send.c').read_text(encoding='utf-8'),
                   on_app_thread=True, functions=[])
    if kind in ('image', 'file', 'video', 'voice'):
        from media_input import prepare_media
        prepared = prepare_media(kind, path, policy)
        staged = Path(prepared['path'])
        request['path'] = staged.as_posix()
        request['media'] = prepared['media']
        if kind == 'voice':
            if prepared['media']['format'] == 'silk':
                data = staged.read_bytes()
                encoded_info = voice_worker('--inspect-silk', staged, '--trusted')
                if hashlib.sha256(data).hexdigest() != encoded_info['sha256']:
                    raise ValueError('Inspected voice hash differs')
            else:
                destination = ROOT / 'runs' / 'voice-codec' / (uuid.uuid4().hex + '.silk')
                encoded_info = voice_worker('--encode-wav', staged, '--output', destination,
                                            '--trusted-input')
                data = destination.read_bytes()
                if hashlib.sha256(data).hexdigest() != encoded_info['sha256']:
                    raise ValueError('Encoded voice hash differs')
                # The local SILK SDK crashes on a second operation in one process, so
                # the duration check runs in its own worker against the written file.
                encoded_info = voice_worker('--inspect-silk', destination, '--trusted')
                if encoded_info['sha256'] != hashlib.sha256(data).hexdigest():
                    raise ValueError('Encoded voice verification differs')
            request['voice_bytes'] = list(data)
            duration = encoded_info['duration_ms']
            if not isinstance(duration, int) or not 20 <= duration <= 60000 or duration % 20:
                raise ValueError('Decoded voice duration outside experiment bounds')
            request['duration_ms'] = duration
        config['staging_directory'] = prepared['directory']
    functions = dict(FUNCTIONS)
    if kind == 'emoji':
        if emoji_catalog is None:
            raise ValueError('emoji_catalog_required')
        from emoji_media import HEX32, validate_url
        selected = emoji_catalog.select(emoji_id)
        validate_url(selected['url'])
        if not HEX32.fullmatch(selected['key']) or selected['type'] not in (1, 2, 3):
            raise ValueError('unsupported_favorite_emoji')
        fields = selected['native_fields']
        if any(not isinstance(value,str) or '\0' in value or len(value.encode('utf-8')) > 4096 for value in fields.values()):
            raise ValueError('invalid_favorite_emoji_fields')
        request.update(emoji_id=selected['md5'], emoji_type=selected['type'],
                       emoji_fields={key:list(value.encode('utf-8')) for key,value in fields.items()},
                       emoji_control_vtable=EMOJI_VTABLE,
                       data_fingerprints=[dict(rva=EMOJI_VTABLE, pointer_rvas=[address-image.image_base
                           for address in struct.unpack('<QQ',image.read_rva(EMOJI_VTABLE,16))])])
        request['thread_source'] = '#define ENABLE_EMOJI 1\n' + request['thread_source']
    for name, rva in functions.items():
        owner = image.owner(rva)
        if owner is not None and owner['begin'] != rva:
            raise ValueError('Function manifest points inside another function: ' + name)
        if not image.section_at(rva, 24)['flags'] & 0x20000000:
            raise ValueError('Function is not executable')
        request['functions'].append(dict(name=name, rva=rva, bytes=list(image.read_rva(rva, 24))))
    config.update(callback_backend='native', active_experiment=request)
    return config


WORKER_FUNCTIONS = dict(SEND_FUNCTIONS)


def worker_config(policy=None, seconds=60):
    """Build the resident send-worker template (P6).

    The template carries function fingerprints and the native job layout, but no
    message payload: every job arrives through ``dispatch_job``.  Emoji support is
    compiled in once, so a single session can send every supported kind.
    """
    policy = policy or SendPolicy.from_environment()
    config = make_config(seconds=seconds, resident=True, quiet=True)
    image = pinned_image()
    functions = dict(WORKER_FUNCTIONS)
    request = dict(kind='template', backend='send_worker', recipient='filehelper',
                   recipient_bytes=[ord(c) for c in 'filehelper'],
                   text=None, text_bytes=[], limits=policy.describe(),
                   helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                   thread_source='#define ENABLE_EMOJI 1\n' +
                                 (ROOT / 'app_thread_send.c').read_text(encoding='utf-8'),
                   on_app_thread=True, functions=[], emoji_control_vtable=EMOJI_VTABLE,
                   data_fingerprints=[dict(rva=EMOJI_VTABLE, pointer_rvas=[
                       address - image.image_base for address in
                       struct.unpack('<QQ', image.read_rva(EMOJI_VTABLE, 16))])])
    for name, rva in functions.items():
        owner = image.owner(rva)
        if owner is not None and owner['begin'] != rva:
            raise ValueError('Function manifest points inside another function: ' + name)
        if not image.section_at(rva, 24)['flags'] & 0x20000000:
            raise ValueError('Function is not executable')
        request['functions'].append(dict(name=name, rva=rva,
                                         bytes=list(image.read_rva(rva, 24))))
    config.update(callback_backend='native', active_experiment=request)
    return config


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--kind', choices=KINDS, required=True)
    parser.add_argument('--pid', type=int)
    parser.add_argument('--recipient', default='filehelper',
                        help='Explicit target; must also be listed in WECHAT_BOT_RECIPIENTS')
    parser.add_argument('--text', default='wxbot-active')
    parser.add_argument('--text-file', type=Path, help='Read message text as UTF-8 from a file')
    parser.add_argument('--path', type=Path)
    parser.add_argument('--emoji-id')
    parser.add_argument('--db-dir')
    parser.add_argument('--account')
    parser.add_argument('--execute', action='store_true')
    args = parser.parse_args()
    if args.execute and (not args.pid or args.pid <= 0):
        parser.error('--execute requires a positive --pid')
    if args.kind in ('image', 'file', 'video', 'voice') and args.path is None:
        parser.error('Image/file requires --path to a generated test fixture')
    if args.kind == 'emoji' and not args.emoji_id:
        parser.error('emoji requires --emoji-id from the favorite catalog')
    text = args.text
    if args.text_file:
        text = args.text_file.read_text(encoding='utf-8')
    try:
        extra = {}
        if args.kind == 'emoji':
            from emoji_media import create_catalog
            extra = dict(emoji_id=args.emoji_id, emoji_catalog=create_catalog(args.db_dir,args.account))
        config = config_for(args.kind, text, args.path, args.recipient, **extra)
    except ValueError as error:
        parser.error(str(error))
    if not args.execute:
        output = ROOT / 'active-send.generated.js'
        if args.kind == 'emoji':
            output = ROOT / 'runs/emoji-send/emoji-send.generated.js'
            output.parent.mkdir(parents=True,exist_ok=True)
        output.write_text(render_source(config), encoding='utf-8')
        print(json.dumps(dict(prepared=str(output), kind=args.kind, recipient=args.recipient,
                              text_bytes=len(config['active_experiment']['text_bytes']),
                              attached=False)))
        return 0
    return run_probe(args.pid, config, Journal(ROOT / 'runs' / 'active'))


if __name__ == '__main__':
    raise SystemExit(main())
