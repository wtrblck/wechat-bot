"""Normalized event view shared by the HTTP API and later consumers.

Only derives fields the native capture actually carries. Anything that needs the
account's own identifiers is left as ``unknown``/fallback unless the user names
them through ``WECHAT_BOT_SELF``; the project does not guess which side is self.
"""
import os

GROUP_SUFFIX = '@chatroom'


def parse_self_ids(value):
    """Parse a comma separated list of this account's own identifiers."""
    if not isinstance(value, str):
        return frozenset()
    return frozenset(item.strip() for item in value.split(',') if item.strip())


def self_ids_from_environment(environ=None):
    environ = os.environ if environ is None else environ
    return parse_self_ids(environ.get('WECHAT_BOT_SELF', ''))


def normalize(event, self_ids=()):
    """Add conversation_id, sender_id, recipient_id and direction.

    Direction rules, deliberately conservative:
    - sender is a configured self id -> 'outgoing' (covers phone-to-desktop echo);
    - otherwise a group conversation means a member wrote it -> 'incoming';
    - otherwise recipient is a self id -> 'incoming';
    - anything else stays 'unknown'.
    """
    sender = event.get('sender') or ''
    recipient = event.get('recipient') or ''
    self_ids = frozenset(self_ids)
    group = next((value for value in (recipient, sender) if value.endswith(GROUP_SUFFIX)), '')
    if group:
        conversation = group
    elif sender in self_ids and recipient:
        conversation = recipient
    elif recipient in self_ids and sender:
        conversation = sender
    else:
        conversation = recipient or sender
    if sender in self_ids:
        direction = 'outgoing'
    elif group or recipient in self_ids:
        direction = 'incoming'
    else:
        direction = 'unknown'
    return dict(conversation_id=conversation, sender_id=sender, recipient_id=recipient,
                direction=direction)
