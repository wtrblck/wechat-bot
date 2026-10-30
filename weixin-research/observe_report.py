"""Distill observed marker messages into identifiers the caller can act on.

Shared by the read-only resolver and by any later tooling that needs to know
which conversation a marker message belonged to.  Nothing here guesses: it only
reports the sender/recipient strings the sync callback actually carried.
"""
MARKER_FIELDS = ('content', 'sender', 'recipient', 'message_type', 'timestamp',
                 'message_id', 'ring_index')


def summarize(events, prefix=''):
    observed = []
    for event in events:
        if event.get('event') != 'test_message':
            continue
        content = event.get('content')
        if not isinstance(content, str) or (prefix and not content.startswith(prefix)):
            continue
        observed.append({key: event.get(key) for key in MARKER_FIELDS})
    identifiers = []
    conversations = []
    for item in observed:
        for key in ('sender', 'recipient'):
            value = item.get(key)
            if not isinstance(value, str) or not value or value in identifiers:
                continue
            identifiers.append(value)
            if value.endswith('@chatroom'):
                conversations.append(value)
    return dict(observed=observed, identifiers=identifiers, conversations=conversations)
