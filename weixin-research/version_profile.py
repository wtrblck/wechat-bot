"""Load one explicit ABI profile (P7).

Offsets are evidence, not configuration: each profile names a DLL and its
SHA256, and every consumer must verify the file before using it.  A new WeChat
version requires a new JSON profile and fresh checks; numbers are never guessed
from the version string.
"""
import json
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parent
DIRECTORY = ROOT / 'versions'
DEFAULT_PROFILE = DIRECTORY / '4.1.15.56.json'
REQUIRED = ('version', 'process', 'module', 'dll', 'sha256', 'sites', 'send', 'download',
            'emoji', 'download_result_vtable')


def _number(value, name):
    if isinstance(value, int):
        return value
    if not isinstance(value, str):
        raise ValueError('profile value is not an integer: ' + name)
    try:
        return int(value, 0)
    except ValueError:
        raise ValueError('profile value is not an integer: ' + name) from None


def _section(raw, name):
    if not isinstance(raw, dict):
        raise ValueError('profile section is not an object: ' + name)
    return {key: _number(value, name + '.' + key) for key, value in raw.items()}


def load(path=None):
    path = Path(path or os.environ.get('WECHAT_BOT_PROFILE') or DEFAULT_PROFILE)
    try:
        raw = json.loads(path.read_text(encoding='utf-8'))
    except OSError:
        raise ValueError('ABI profile is missing: ' + str(path)) from None
    except ValueError:
        raise ValueError('ABI profile is not valid JSON: ' + str(path)) from None
    if not isinstance(raw, dict):
        raise ValueError('ABI profile must contain an object')
    missing = [name for name in REQUIRED if name not in raw]
    if missing:
        raise ValueError('ABI profile is missing: ' + ','.join(missing))
    if not isinstance(raw['sha256'], str) or len(raw['sha256']) != 64:
        raise ValueError('ABI profile SHA256 is invalid')
    profile = dict(raw)
    profile['path'] = str(path)
    profile['sites'] = _section(raw['sites'], 'sites')
    profile['send'] = _section(raw['send'], 'send')
    profile['download'] = _section(raw['download'], 'download')
    profile['emoji'] = _section(raw['emoji'], 'emoji')
    profile['download_result_vtable'] = _number(raw['download_result_vtable'],
                                                'download_result_vtable')
    for section in ('sites', 'send', 'download'):
        if not profile[section]:
            raise ValueError('ABI profile section is empty: ' + section)
    return profile
