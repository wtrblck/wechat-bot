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
                           UNKNOWN, FAILED)

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

    def watch(self, request_id, *, kind, conversation, text=None, md5=None, since_seq=0, started=None):
        if since_seq is None:
            return
        self.jobs[request_id] = dict(kind=kind, conversation=conversation, text=text, md5=md5,
                                     since_seq=int(since_seq), last_seq=int(since_seq),
                                     started=started or time.monotonic(), found=False,
                                     found_at=None)

    def forget(self, request_id):
        self.jobs.pop(request_id, None)

    def restore_recorded(self, store, lookup):
        """Resume exact-row observation after restart, never dispatch a send."""
        for request in store.pending_confirmation():
            request_id = request['request_id']
            if not request.get('local_id') or not request.get('message_id'):
                store.update(request_id, UNKNOWN, reason='restart_lost_message_identity')
                continue
            event = lookup(request['recipient'], request['local_id'])
            if not event or event.get('direction') != 'outgoing' or event.get('message_id') != request['message_id'] or event.get('conversation_id') != request['recipient']:
                store.update(request_id, UNKNOWN, reason='restart_message_not_found')
                continue
            server_id = str(event.get('server_id') or '0')
            state = self.row_state(event, server_id)
            if state in (FAILED, SERVER_CONFIRMED):
                store.update(request_id, state, server_id=server_id,
                    error_code='native_message_failed' if state == FAILED else None,
                    reason='native_message_failed' if state == FAILED else None)
                self._transition(request_id, state, event, server_id)
                continue
            kind = next((k for k, v in TYPE_BY_KIND.items() if v == (int(event.get('local_type') or 0) & 0xffffffff)), request['kind'])
            self.watch(request_id, kind=kind, conversation=request['recipient'], md5=event.get('emoji_md5'), since_seq=event['sort_seq'])
            self.jobs[request_id].update(found=True, found_at=time.monotonic(),
                found_seq=event['sort_seq'], message_id=event['message_id'])

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
                # A newer text row can become visible before an earlier emoji
                # row. Always revisit the send watermark until a match exists.
                # Bound each read; exhausting the window leads to unknown, never
                # to a retry or an invented match.
                events = self.query(job['conversation'], job['since_seq'], 1000)
                for event in events:
                    if not self.matches(event, job):
                        continue
                    if store.message_claimed(event['message_id'], request_id):
                        continue
                    job['found'] = True
                    job['found_at'] = now
                    job['found_seq'] = int(event.get('sort_seq') or 0)
                    job['message_id'] = event['message_id']
                    server_id = str(event.get('server_id') or '0')
                    state = self.row_state(event, server_id)
                    try:
                        store.update(request_id, state,
                                     message_id=event['message_id'], local_id=event['local_id'],
                                     server_id=server_id,
                                     error_code='native_message_failed' if state == FAILED else None,
                                     reason='native_message_failed' if state == FAILED else None if state == SERVER_CONFIRMED else 'server_id_pending')
                    except (KeyError, ValueError):
                        pass
                    self._transition(request_id, state, event, server_id)
                    if state in (SERVER_CONFIRMED, FAILED):
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
                    state = self.row_state(event, server_id)
                    if state in (SERVER_CONFIRMED, FAILED):
                        try:
                            store.update(request_id, state, message_id=event['message_id'],
                                         local_id=event['local_id'], server_id=server_id,
                                         error_code='native_message_failed' if state == FAILED else None,
                                         reason='native_message_failed' if state == FAILED else None)
                        except (KeyError, ValueError):
                            pass
                        self._transition(request_id, state, event, server_id)
                        self.jobs.pop(request_id, None)
                        break
            elif job['found']:
                try:
                    store.update(request_id, UNKNOWN, reason='server_confirmation_timeout')
                except (KeyError, ValueError):
                    pass
                self.jobs.pop(request_id, None)

    @staticmethod
    def row_state(event, server_id):
        if server_id.isdigit() and int(server_id):
            return SERVER_CONFIRMED
        # Fixed 4.1.15.56 evidence: failed outgoing rows 167/168/176/177 have
        # status=5 and server_id=0; confirmed rows have status=2 and server ID.
        return FAILED if event.get('send_status') == 5 else MESSAGE_RECORDED

    def matches(self, event, job):
        if event.get('direction') != 'outgoing':
            return False
        if event.get('conversation_id') != job['conversation']:
            return False
        if job['kind'] == 'emoji' and job.get('md5') and event.get('emoji_md5') != job['md5']:
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
