"""Persistent Frida session shared by the send and download workers (P6).

The one-shot probe attaches, dispatches and detaches for every message.  This
module keeps one session and one pinned script alive; each job is an RPC call
into the already-loaded native worker.  A native callback that is still running
is never unloaded: close() reports failure and the caller must treat the worker
as stuck instead of risking the target process.
"""
import json
import sys
import threading
from pathlib import Path

from probe import Journal, render_source, validate_loaded
from profile import ROOT

sys.path.insert(0, str(ROOT / 'deps'))


class WorkerUnavailable(RuntimeError):
    pass


class WorkerSession:
    def __init__(self, pid, config, *, journal=None, on_event=None):
        self.pid = pid
        self.config = config
        self.journal = journal
        self.on_event = on_event
        self.lock = threading.RLock()
        self.detached = threading.Event()
        self.detach_reason = None
        self.session = None
        self.script = None
        self.closed = False
        try:
            self._start()
        except Exception:
            # A partially loaded script must not leave a pinned/hooked session.
            try:
                self.close(stop_export=None)
            except Exception:
                pass
            raise

    def _emit(self, event):
        if self.journal is not None:
            self.journal.emit(event)
        if self.on_event is not None:
            try:
                self.on_event(event)
            except Exception:
                pass

    def _start(self):
        import frida
        self._emit(dict(event='worker_attach_requested', pid=self.pid,
                        backend=self.config.get('active_experiment', {}).get('backend')))
        self.session = frida.attach(self.pid)
        self.session.on('detached', self._on_detached)
        self.script = self.session.create_script(render_source(self.config), runtime='qjs')
        self.script.on('message', self._on_message)
        self.script.load()
        metadata = self.script.exports_sync.inspect()
        self._emit(dict(event='worker_module_inspected', metadata=metadata))
        validate_loaded(self.config, metadata)
        self.script.exports_sync.start()
        self._emit(dict(event='worker_probe_started'))

    def _on_message(self, message, data):
        if message.get('type') == 'send' and isinstance(message.get('payload'), dict):
            self._emit(dict(message['payload'], source='worker'))
        else:
            self._emit(dict(event='worker_script_error', detail=message))
            self.detached.set()

    def _on_detached(self, reason, crash=None):
        self.detach_reason = reason
        self.detached.set()
        self._emit(dict(event='worker_session_detached', reason=reason,
                        expected=self.closed, crash_report=getattr(crash, 'report', None)))

    @property
    def alive(self):
        return not self.closed and not self.detached.is_set()

    def call(self, name, *args):
        if not self.alive:
            raise WorkerUnavailable('worker session is not alive')
        with self.lock:
            try:
                return getattr(self.script.exports_sync, name)(*args)
            except Exception as error:
                if self.detached.is_set():
                    raise WorkerUnavailable('worker session detached: %s' % self.detach_reason) from error
                raise

    def close(self, stop_export='stop_worker'):
        """Stop the worker and unload only when no native callback is running."""
        if self.closed:
            return True
        stopped = True
        if self.alive and stop_export:
            try:
                stopped = bool(self.call(stop_export))
            except Exception as error:
                self._emit(dict(event='worker_stop_error', detail=str(error)))
                stopped = False
        if not stopped:
            self._emit(dict(event='worker_stop_refused', reason='native_callback_running'))
            return False
        self.closed = True
        if self.script is not None and not self.detached.is_set():
            try:
                self.script.exports_sync.finish()
            except Exception as error:
                self._emit(dict(event='worker_finish_error', detail=str(error)))
            try:
                self.script.unload()
            except Exception as error:
                self._emit(dict(event='worker_unload_error', detail=str(error)))
        if self.session is not None and not self.detached.is_set():
            try:
                self.session.detach()
            except Exception as error:
                self._emit(dict(event='worker_detach_error', detail=str(error)))
        return True

    def health(self):
        return dict(pid=self.pid, alive=self.alive, detach_reason=self.detach_reason,
                    closed=self.closed)
