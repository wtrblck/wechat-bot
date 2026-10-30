"""Durable request state for the resident bridge (P5).

A request ID is the idempotency key.  The same ID with the same fingerprint
returns the stored result even after a restart; the same ID with different
content is a conflict.  A request that was queued or in flight when the process
stopped becomes ``unknown`` and is never retried automatically, because the
native side may already have sent it.

The database stores metadata only: no message text, no media bytes, no paths.
"""
import json
import sqlite3
import threading
import time
from pathlib import Path

PREPARED = 'prepared'
QUEUED = 'queued'
SENDING = 'sending'
LOCAL_ACCEPTED = 'local_accepted'
MESSAGE_RECORDED = 'message_recorded'
SERVER_CONFIRMED = 'server_confirmed'
FAILED = 'failed'
UNKNOWN = 'unknown'
CANCELLED = 'cancelled'

STATES = (PREPARED, QUEUED, SENDING, LOCAL_ACCEPTED, MESSAGE_RECORDED,
          SERVER_CONFIRMED, FAILED, UNKNOWN, CANCELLED)
TERMINAL = frozenset((SERVER_CONFIRMED, FAILED, UNKNOWN, CANCELLED))
ALLOWED = {
    PREPARED: {QUEUED, FAILED, CANCELLED},
    QUEUED: {SENDING, FAILED, CANCELLED, UNKNOWN},
    SENDING: {LOCAL_ACCEPTED, FAILED, UNKNOWN},
    LOCAL_ACCEPTED: {MESSAGE_RECORDED, SERVER_CONFIRMED, UNKNOWN, FAILED},
    MESSAGE_RECORDED: {SERVER_CONFIRMED, UNKNOWN},
    SERVER_CONFIRMED: set(),
    FAILED: set(),
    UNKNOWN: set(),
    CANCELLED: set(),
}


class RequestConflict(RuntimeError):
    def __init__(self, request_id):
        self.request_id = request_id
        super().__init__('request_id_conflict')


class RequestStore:
    def __init__(self, path):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.lock = threading.RLock()
        self.db = sqlite3.connect(str(self.path), check_same_thread=False, timeout=10)
        self.db.row_factory = sqlite3.Row
        with self.lock:
            self.db.execute('PRAGMA journal_mode=WAL')
            self.db.execute('PRAGMA synchronous=NORMAL')
            self.db.execute('PRAGMA busy_timeout=10000')
            self.db.executescript('''
                CREATE TABLE IF NOT EXISTS requests (
                    request_id TEXT PRIMARY KEY,
                    fingerprint TEXT NOT NULL,
                    kind TEXT NOT NULL,
                    recipient TEXT NOT NULL,
                    state TEXT NOT NULL,
                    accepted INTEGER,
                    native_error INTEGER,
                    detail TEXT,
                    message_id TEXT,
                    local_id INTEGER,
                    server_id TEXT,
                    reason TEXT,
                    error_code TEXT,
                    result TEXT,
                    created REAL NOT NULL,
                    updated REAL NOT NULL
                );
                CREATE INDEX IF NOT EXISTS requests_updated ON requests(updated);
                CREATE INDEX IF NOT EXISTS requests_state ON requests(state);
            ''')
            self.db.commit()

    @staticmethod
    def public(row):
        if row is None:
            return None
        if isinstance(row, sqlite3.Row):
            row = dict(row)
        return dict(request_id=row['request_id'], kind=row['kind'], recipient=row['recipient'],
                    state=row['state'], accepted=None if row['accepted'] is None else bool(row['accepted']),
                    delivery_verified=False, message_id=row['message_id'],
                    local_id=row['local_id'], server_id=row['server_id'],
                    native_error=row['native_error'], detail=row['detail'],
                    reason=None if row['state'] == 'server_confirmed' else row['reason'],
                    error_code=row['error_code'],
                    created=row['created'], updated=row['updated'])

    def create(self, request_id, fingerprint, kind, recipient):
        now = time.time()
        with self.lock:
            row = self.db.execute('SELECT * FROM requests WHERE request_id=?', (request_id,)).fetchone()
            if row:
                if row['fingerprint'] != fingerprint:
                    raise RequestConflict(request_id)
                return self.public(row), True
            self.db.execute(
                'INSERT INTO requests(request_id,fingerprint,kind,recipient,state,created,updated) '
                'VALUES(?,?,?,?,?,?,?)',
                (request_id, fingerprint, kind, recipient, PREPARED, now, now))
            self.db.commit()
            return self.public(self.db.execute('SELECT * FROM requests WHERE request_id=?',
                                               (request_id,)).fetchone()), False

    def update(self, request_id, state=None, *, accepted=None, native_error=None, detail=None,
               message_id=None, local_id=None, server_id=None, reason=None, error_code=None):
        with self.lock:
            row = self.db.execute('SELECT * FROM requests WHERE request_id=?', (request_id,)).fetchone()
            if row is None:
                raise KeyError(request_id)
            current = row['state']
            if state is not None and state != current:
                if state not in STATES:
                    raise ValueError('unknown request state')
                if state not in ALLOWED.get(current, set()):
                    raise ValueError('illegal transition %s -> %s' % (current, state))
            fields = dict(accepted=accepted, native_error=native_error, detail=detail,
                          message_id=message_id, local_id=local_id, server_id=server_id,
                          reason=reason, error_code=error_code)
            assignments, values = [], []
            for key, value in fields.items():
                if value is not None:
                    assignments.append(key + '=?')
                    values.append(value)
            if state is not None:
                assignments.append('state=?')
                values.append(state)
            assignments.append('updated=?')
            values.append(time.time())
            values.append(request_id)
            self.db.execute('UPDATE requests SET ' + ','.join(assignments) + ' WHERE request_id=?', values)
            self.db.commit()
            return self.public(self.db.execute('SELECT * FROM requests WHERE request_id=?',
                                               (request_id,)).fetchone())

    def get(self, request_id):
        with self.lock:
            return self.public(self.db.execute('SELECT * FROM requests WHERE request_id=?',
                                               (request_id,)).fetchone())

    def list_since(self, since=0.0, limit=200):
        limit = max(1, min(int(limit), 1000))
        with self.lock:
            rows = self.db.execute('SELECT * FROM requests WHERE updated>=? ORDER BY updated LIMIT ?',
                                   (float(since), limit)).fetchall()
            return [self.public(row) for row in rows]

    def recover(self):
        """Mark in-flight requests unknown after an unclean stop; never retry."""
        now = time.time()
        with self.lock:
            rows = self.db.execute(
                "SELECT request_id, state FROM requests WHERE state IN (?,?,?)",
                (PREPARED, QUEUED, SENDING)).fetchall()
            for row in rows:
                reason = 'service_restart' if row['state'] != PREPARED else 'never_queued'
                self.db.execute('UPDATE requests SET state=?, reason=?, updated=? WHERE request_id=?',
                                (UNKNOWN, reason, now, row['request_id']))
            self.db.commit()
            return [row['request_id'] for row in rows]

    def cancel(self, request_id):
        with self.lock:
            row = self.db.execute('SELECT * FROM requests WHERE request_id=?', (request_id,)).fetchone()
            if row is None:
                raise KeyError(request_id)
            if row['state'] not in (PREPARED, QUEUED):
                return None
            return self.update(request_id, CANCELLED, reason='cancelled_by_client')

    def counts(self):
        with self.lock:
            rows = self.db.execute('SELECT state, COUNT(*) AS n FROM requests GROUP BY state').fetchall()
            return {row['state']: row['n'] for row in rows}

    def purge(self, before):
        with self.lock:
            cursor = self.db.execute('DELETE FROM requests WHERE updated<?', (float(before),))
            self.db.commit()
            return cursor.rowcount

    def close(self):
        with self.lock:
            self.db.close()
