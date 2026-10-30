"""Correlate an accepted native send with the local message row (P5).

The native send result carries two status DWORDs and a diagnostic string, not a
message identifier.  We therefore read the account's own message database
(read-only, same hook-free path as receive) for a new outgoing row after the
sort-seq watermark taken just before the send.  That gives a real local ID and,
when the server has acknowledged the message, a real server ID.

A missing row is not proof of failure: the state becomes ``unknown`` and nothing
is retried.  ``delivery_verified`` is never set here; only a manual device
confirmation can claim the target actually received it.
"""
import time

from request_store import (LOCAL_ACCEPTED, MESSAGE_RECORDED, SERVER_CONFIRMED,
                           UNKNOWN)

TYPE_BY_KIND = {'image': 3, 'video': 43, 'voice': 34, 'file': 49, 'emoji': 47}


class MessageTracker:
    def __init__(self, source, query, *, observe_timeout=60.0, confirm_timeout=120.0,
                 on_transition=None):
        self.source = source
        self.query = query
        self.observe_timeout = observe_timeout
        self.confirm_timeout = confirm_timeout
        self.on_transition = on_transition
        self.jobs = {}

    def _transition(self, request_id, state, event, server_id):
        if self.on_transition is not None:
            try:
                self.on_transition(dict(event='request_tracked', request_id=request_id,
                                        state=state, message_id=event.get('message_id'),
                                        local_id=event.get('local_id'),
                                        server_id=server_id))
            except Exception:
                pass

    def watch(self, request_id, *, kind, conversation, text=None, since_seq=0, started=None):
        if since_seq is None:
            return
        self.jobs[request_id] = dict(kind=kind, conversation=conversation, text=text,
                                     since_seq=int(since_seq), last_seq=int(since_seq),
                                     started=started or time.monotonic(), found=False,
                                     found_at=None)

    def forget(self, request_id):
        self.jobs.pop(request_id, None)

    def poll(self, store):
        now = time.monotonic()
        for request_id, job in list(self.jobs.items()):
            request = store.get(request_id)
            if request is None:
                self.jobs.pop(request_id, None)
                continue
            if request['state'] not in (LOCAL_ACCEPTED, MESSAGE_RECORDED):
                self.jobs.pop(request_id, None)
                continue
            if not job['found']:
                if now - job['started'] > self.observe_timeout:
                    self.jobs.pop(request_id, None)
                    try:
                        store.update(request_id, UNKNOWN, reason='message_not_observed')
                    except (KeyError, ValueError):
                        pass
                    continue
                events = self.query(job['conversation'], job['last_seq'], 50)
                for event in events:
                    job['last_seq'] = max(job['last_seq'], int(event.get('sort_seq') or 0))
                    if not self.matches(event, job):
                        continue
                    job['found'] = True
                    job['found_at'] = now
                    job['found_seq'] = int(event.get('sort_seq') or 0)
                    job['message_id'] = event['message_id']
                    server_id = str(event.get('server_id') or '0')
                    state = SERVER_CONFIRMED if server_id.isdigit() and int(server_id) else MESSAGE_RECORDED
                    try:
                        store.update(request_id, state,
                                     message_id=event['message_id'], local_id=event['local_id'],
                                     server_id=server_id,
                                     reason=None if state == SERVER_CONFIRMED else 'server_id_pending')
                    except (KeyError, ValueError):
                        pass
                    self._transition(request_id, state, event, server_id)
                    if state == SERVER_CONFIRMED:
                        self.jobs.pop(request_id, None)
                    break
            if job['found'] and request_id in self.jobs and now - job['found_at'] <= self.confirm_timeout:
                # server_id is updated in place on the same row, so re-read from
                # just before that row instead of only following newer rows.
                since = max(0, int(job.get('found_seq') or 0) - 1)
                events = self.query(job['conversation'], since, 50)
                for event in events:
                    if event.get('message_id') != job.get('message_id'):
                        continue
                    server_id = str(event.get('server_id') or '0')
                    if server_id.isdigit() and int(server_id):
                        try:
                            store.update(request_id, SERVER_CONFIRMED, message_id=event['message_id'],
                                         local_id=event['local_id'], server_id=server_id)
                        except (KeyError, ValueError):
                            pass
                        self._transition(request_id, SERVER_CONFIRMED, event, server_id)
                        self.jobs.pop(request_id, None)
                        break
            elif job['found']:
                self.jobs.pop(request_id, None)

    def matches(self, event, job):
        if event.get('direction') != 'outgoing':
            return False
        if event.get('conversation_id') != job['conversation']:
            return False
        if job['kind'] == 'text':
            content = event.get('content') or ''
            text = job.get('text') or ''
            if content == text:
                return True
            return bool(text) and content.endswith('\n' + text) and len(content) <= len(text) + 130
        return int(event.get('local_type') or 0) & 0xffffffff == TYPE_BY_KIND.get(job['kind'], -1)

    def health(self):
        return dict(tracking=len(self.jobs))
