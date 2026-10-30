"""Bounded, durable event spool for the resident bridge (P6).

The in-memory EventStore is deliberately small.  A bot that reconnects after a
restart can resume from its cursor as long as the spool still holds the gap;
when it does not, ``truncated`` is returned instead of silently skipping.
"""
import json
import sqlite3
import threading
import time
from pathlib import Path

DEFAULT_MAX_EVENTS = 50000


class EventLog:
    def __init__(self, path, max_events=DEFAULT_MAX_EVENTS):
        self.path = Path(path)
        self.path.parent.mkdir(parents=True, exist_ok=True)
        self.max_events = int(max_events)
        self.lock = threading.RLock()
        self.db = sqlite3.connect(str(self.path), check_same_thread=False, timeout=10)
        with self.lock:
            self.db.execute('PRAGMA journal_mode=WAL')
            self.db.execute('PRAGMA synchronous=NORMAL')
            self.db.execute('''CREATE TABLE IF NOT EXISTS events (
                seq INTEGER PRIMARY KEY, created REAL NOT NULL,
                message_id TEXT, payload TEXT NOT NULL)''')
            self.db.commit()

    def append(self, sequence, event):
        with self.lock:
            self.db.execute('INSERT OR REPLACE INTO events(seq,created,message_id,payload) VALUES(?,?,?,?)',
                            (int(sequence), time.time(), event.get('message_id'),
                             json.dumps(event, ensure_ascii=False)))
            self.db.commit()

    def read(self, after, limit=500):
        with self.lock:
            rows = self.db.execute('SELECT seq,payload FROM events WHERE seq>? ORDER BY seq LIMIT ?',
                                   (int(after), max(1, min(int(limit), 2000)))).fetchall()
        result = []
        for sequence, payload in rows:
            try:
                event = json.loads(payload)
            except ValueError:
                continue
            event['sequence'] = sequence
            result.append(event)
        return result

    def update_media(self, message_id, media):
        with self.lock:
            rows = self.db.execute('SELECT seq,payload FROM events WHERE message_id=?', (message_id,)).fetchall()
            for sequence, payload in rows:
                try:
                    event = json.loads(payload)
                except ValueError:
                    continue
                event['media'] = media
                self.db.execute('UPDATE events SET payload=? WHERE seq=?',
                                (json.dumps(event, ensure_ascii=False), sequence))
            self.db.commit()

    def max_seq(self):
        with self.lock:
            row = self.db.execute('SELECT MAX(seq) FROM events').fetchone()
            return int(row[0] or 0)

    def min_seq(self):
        with self.lock:
            row = self.db.execute('SELECT MIN(seq) FROM events').fetchone()
            return int(row[0] or 0)

    def trim(self, days=7.0, max_events=None):
        max_events = self.max_events if max_events is None else int(max_events)
        cutoff_seq = None
        with self.lock:
            if max_events > 0:
                row = self.db.execute('SELECT MAX(seq) FROM events').fetchone()
                maximum = int(row[0] or 0)
                cutoff_seq = maximum - max_events
            if cutoff_seq is not None and cutoff_seq > 0:
                self.db.execute('DELETE FROM events WHERE seq<=?', (cutoff_seq,))
            if days > 0:
                self.db.execute('DELETE FROM events WHERE created<?', (time.time() - days * 86400,))
            self.db.commit()
            return self.db.total_changes

    def close(self):
        with self.lock:
            self.db.close()
