"""Send policy: keep the restricted test target separate from real parameters.

Every outbound request is described by explicit bytes and validated against one
place.  The default policy only allows the file transfer helper, so a caller
cannot widen the target by omitting a filter somewhere else in the stack.  A
real test contact or group must be configured on purpose:

    $env:WECHAT_BOT_RECIPIENTS = 'filehelper,wxid_example'

The limits are part of the protocol: the HTTP body limit must be able to carry a
maximum-size text request, and the JavaScript layer re-checks the same numbers
instead of trusting Python alone.
"""
import os
import re
from pathlib import Path

DEFAULT_RECIPIENTS = ('filehelper',)
TEXT_BYTES = 4096
RECIPIENT_BYTES = 128
MEDIA_BYTES = 2 * 1024 * 1024
MAX_MEDIA_BYTES = 64 * 1024 * 1024
# Room for the largest text plus JSON escaping and the other required fields.
JSON_BODY_BYTES = 65536
REQUEST_ID_PATTERN = r'[a-zA-Z0-9_-]{1,64}'
# Default input roots: generated test fixtures only. Business directories must be
# named explicitly with WECHAT_BOT_MEDIA_ROOTS; nothing is widened implicitly.
DEFAULT_MEDIA_ROOTS = (Path(__file__).resolve().parent / 'fixtures',)
IMAGE_FORMATS = ('png', 'jpeg', 'gif', 'webp')
VOICE_FORMATS = ('wav', 'silk', 'mp3')
VIDEO_FORMATS = ('mp4',)
_CONTROL = re.compile(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]')

# Observation defaults: keep publishing narrow until a target is named on purpose.
DEFAULT_OBSERVE_TARGETS = ('filehelper',)
DEFAULT_OBSERVE_PREFIX = 'wxbot-'
OBSERVE_FILTER_BYTES = 4096
OBSERVE_PREFIX_BYTES = 64
DEDUP_CAPACITY = 4096


class PolicyError(ValueError):
    """Validation failure with a stable machine-readable code."""

    def __init__(self, code, detail=None):
        self.code = code
        super().__init__(code if detail is None else '%s: %s' % (code, detail))


def _encode(value, limit, name):
    if not isinstance(value, str):
        raise PolicyError('invalid_' + name, 'a string is required')
    if not value:
        raise PolicyError('invalid_' + name, 'must not be empty')
    if '\x00' in value:
        raise PolicyError('invalid_' + name, 'must not contain NUL')
    try:
        data = value.encode('utf-8')
    except UnicodeEncodeError as error:
        raise PolicyError('invalid_' + name, 'not encodable as UTF-8') from error
    if len(data) > limit:
        raise PolicyError(name + '_too_long',
                          '%d UTF-8 bytes exceed the configured %d bytes' % (len(data), limit))
    return data


def _unquote(value):
    if len(value) >= 2 and value[0] == value[-1] and value[0] in '\'"':
        return value[1:-1]
    return value


def _split_formats(raw, default):
    if raw is None or not raw.strip():
        return default
    return tuple(part.strip().lower() for part in raw.split(',') if part.strip())


def _integer(environ, name, default):
    raw = environ.get(name, '')
    if raw == '':
        return default
    try:
        value = int(raw)
    except (TypeError, ValueError):
        raise PolicyError('invalid_' + name.lower(), 'an integer is required') from None
    return value


def _boolean(raw, default):
    if raw is None or raw == '':
        return default
    return raw.strip().lower() in ('1', 'true', 'yes', 'on')


def _formats(raw, allowed, name):
    selected = tuple(dict.fromkeys(part.strip().lower() for part in raw.split(',') if part.strip()))
    if not selected:
        raise PolicyError('invalid_' + name, 'at least one format is required')
    unknown = [item for item in selected if item not in allowed]
    if unknown:
        raise PolicyError('invalid_' + name, 'unsupported formats: ' + ','.join(unknown))
    return selected


class SendPolicy:
    """Validated outbound targets, encoded payload limits and media input scope."""

    def __init__(self, recipients=DEFAULT_RECIPIENTS, *, text_bytes=TEXT_BYTES,
                 recipient_bytes=RECIPIENT_BYTES, media_bytes=MEDIA_BYTES,
                 media_roots=DEFAULT_MEDIA_ROOTS, image_formats=IMAGE_FORMATS,
                 voice_formats=('wav', 'silk'), video_formats=('mp4',),
                 convert_video=False):
        cleaned = tuple(dict.fromkeys(item.strip() for item in recipients if item and item.strip()))
        if not cleaned:
            raise PolicyError('invalid_policy', 'at least one recipient must be configured')
        if not 0 < media_bytes <= MAX_MEDIA_BYTES:
            raise PolicyError('invalid_media_bytes', 'media limit must be 1..%d bytes' % MAX_MEDIA_BYTES)
        roots = tuple(dict.fromkeys(Path(item).resolve() for item in media_roots if item))
        if not roots:
            raise PolicyError('invalid_media_roots', 'at least one input root is required')
        self.recipients = cleaned
        self.text_bytes = text_bytes
        self.recipient_bytes = recipient_bytes
        self.media_bytes = media_bytes
        self.media_roots = roots
        self.image_formats = _formats(','.join(image_formats), IMAGE_FORMATS, 'image_formats')
        self.voice_formats = _formats(','.join(voice_formats), VOICE_FORMATS, 'voice_formats')
        self.video_formats = _formats(','.join(video_formats), VIDEO_FORMATS, 'video_formats')
        self.convert_video = bool(convert_video)

    @classmethod
    def from_environment(cls, environ=None):
        environ = os.environ if environ is None else environ
        raw = environ.get('WECHAT_BOT_RECIPIENTS', '')
        recipients = tuple(item for item in (part.strip() for part in raw.split(',')) if item)
        roots = tuple(item for item in (_unquote(root.strip()) for root in
                                        environ.get('WECHAT_BOT_MEDIA_ROOTS', '').split(os.pathsep)) if item)
        media_bytes = _integer(environ, 'WECHAT_BOT_MEDIA_BYTES', MEDIA_BYTES)
        return cls(recipients or DEFAULT_RECIPIENTS,
                   media_bytes=media_bytes,
                   media_roots=roots or DEFAULT_MEDIA_ROOTS,
                   image_formats=_split_formats(environ.get('WECHAT_BOT_IMAGE_FORMATS'), IMAGE_FORMATS),
                   voice_formats=_split_formats(environ.get('WECHAT_BOT_VOICE_FORMATS'), ('wav', 'silk')),
                   video_formats=_split_formats(environ.get('WECHAT_BOT_VIDEO_FORMATS'), ('mp4',)),
                   convert_video=_boolean(environ.get('WECHAT_BOT_VIDEO_CONVERT'), False))

    def encode_recipient(self, value):
        """Return UTF-8 bytes for an allowed recipient; never guesses the target."""
        data = _encode(value, self.recipient_bytes, 'recipient')
        if value not in self.recipients:
            raise PolicyError('recipient_not_allowed',
                              'configured test recipients: ' + ','.join(self.recipients))
        return data

    def encode_text(self, value):
        """Return UTF-8 bytes for message text: any script, multi-line, bounded."""
        if isinstance(value, str) and _CONTROL.search(value):
            raise PolicyError('invalid_text', 'control characters other than tab/newline are not allowed')
        return _encode(value, self.text_bytes, 'text')

    def describe(self):
        return dict(recipients=list(self.recipients), text_bytes=self.text_bytes,
                    recipient_bytes=self.recipient_bytes, media_bytes=self.media_bytes,
                    media_roots=[str(root) for root in self.media_roots],
                    image_formats=list(self.image_formats),
                    voice_formats=list(self.voice_formats),
                    video_formats=list(self.video_formats),
                    convert_video=self.convert_video)


class ObservePolicy:
    """Which observed conversations may be published, and which content matches.

    The native capture filter receives these values, and the Python event store
    repeats the same checks.  Both default to the file helper plus the wxbot-
    marker so ordinary chat history is never published by accident.  An empty
    prefix accepts every content and must be configured explicitly:

        $env:WECHAT_BOT_OBSERVE = 'filehelper,wxid_contact'
        $env:WECHAT_BOT_OBSERVE_PREFIX = ''

    ``mode`` is ``prefix`` (default) or ``contains``.  Group text may carry a
    sender prefix inside the content field, so resolution runs use ``contains``.
    """

    MODES = ('prefix', 'contains')

    def __init__(self, targets=DEFAULT_OBSERVE_TARGETS, prefix=DEFAULT_OBSERVE_PREFIX,
                 mode='prefix'):
        cleaned = tuple(dict.fromkeys(item.strip() for item in targets if item and item.strip()))
        if not cleaned:
            raise PolicyError('invalid_observe_policy', 'at least one conversation must be observed')
        total = 0
        for target in cleaned:
            if _CONTROL.search(target) or '\n' in target:
                raise PolicyError('invalid_observe_target', 'target must not contain control characters')
            total += len(target.encode('utf-8')) + 1
        if total > OBSERVE_FILTER_BYTES:
            raise PolicyError('observe_targets_too_long',
                              'joined targets exceed %d bytes' % OBSERVE_FILTER_BYTES)
        if not isinstance(prefix, str) or _CONTROL.search(prefix):
            raise PolicyError('invalid_observe_prefix', 'prefix must be a plain string')
        if len(prefix.encode('utf-8')) > OBSERVE_PREFIX_BYTES:
            raise PolicyError('observe_prefix_too_long',
                              'prefix exceeds %d bytes' % OBSERVE_PREFIX_BYTES)
        if mode not in self.MODES:
            raise PolicyError('invalid_observe_mode', 'mode must be prefix or contains')
        self.targets = cleaned
        self.prefix = prefix
        self.mode = mode

    @property
    def wildcard(self):
        """A single '*' observes every conversation; the content filter still applies."""
        return self.targets == ('*',)

    def conversation_allowed(self, *identifiers):
        if self.wildcard:
            return True
        allowed = set(self.targets)
        return bool(set(identifiers) & allowed)

    def content_allowed(self, content):
        if not self.prefix:
            return True
        if not isinstance(content, str):
            return False
        return content.startswith(self.prefix) if self.mode == 'prefix' else self.prefix in content

    @classmethod
    def from_environment(cls, environ=None):
        environ = os.environ if environ is None else environ
        raw = environ.get('WECHAT_BOT_OBSERVE', '')
        targets = tuple(item for item in (part.strip() for part in raw.split(',')) if item)
        prefix = environ.get('WECHAT_BOT_OBSERVE_PREFIX', DEFAULT_OBSERVE_PREFIX)
        mode = environ.get('WECHAT_BOT_OBSERVE_MODE', 'prefix')
        return cls(targets or DEFAULT_OBSERVE_TARGETS, prefix, mode)

    def matches(self, event):
        """Apply the same checks the native filter performs."""
        return (self.content_allowed(event.get('content')) and
                self.conversation_allowed(event.get('sender'), event.get('recipient')))

    def describe(self):
        return dict(targets=list(self.targets), prefix=self.prefix, mode=self.mode)
