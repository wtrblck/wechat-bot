"""Python facade for the resident native send worker (P5/P6)."""
import threading

from active_send import config_for, worker_config
from policy import SendPolicy
from worker_session import WorkerSession, WorkerUnavailable


def payload_from_config(config, timeout_ms=20000):
    request = config['active_experiment']
    return dict(kind=request['kind'], recipient_bytes=request['recipient_bytes'],
                text_bytes=request.get('text_bytes') or [], path=request.get('path'),
                voice_bytes=request.get('voice_bytes'),
                duration_ms=request.get('duration_ms'),
                emoji_fields=request.get('emoji_fields'),
                local_emoji=request.get('local_emoji', False),
                local_emoji_size=request.get('local_emoji_size'),
                emoji_type=request.get('emoji_type'), timeout_ms=timeout_ms)


class SendWorker:
    def __init__(self, pid, policy=None, *, journal=None, on_event=None):
        self.pid = pid
        self.policy = policy or SendPolicy.from_environment()
        self.lock = threading.RLock()
        self.config = worker_config(self.policy)
        self.poisoned = False
        self.busy = False
        self.session = WorkerSession(pid, self.config, journal=journal, on_event=on_event)
        if not self.session.call('start_worker'):
            raise WorkerUnavailable('send worker refused to start')

    @property
    def alive(self):
        return self.session.alive

    def dispatch(self, payload):
        with self.lock:
            self.busy = True
            try:
                result = self.session.call('dispatch_job', payload)
            except WorkerUnavailable:
                self.poisoned = True
                raise
            finally:
                self.busy = False
            if result.get('unsafe'):
                self.poisoned = True
            return result

    def send_config(self, config, timeout_ms=20000):
        return self.dispatch(payload_from_config(config, timeout_ms))

    def prepare(self, kind, **kwargs):
        return config_for(kind, policy=self.policy, **kwargs)

    def status(self):
        return dict(started=self.session.alive, busy=self.busy,
                    poisoned=self.poisoned or not self.session.alive, job_state=None)

    def health(self):
        health = self.session.health()
        health.update(self.status())
        return health

    def close(self):
        with self.lock:
            return self.session.close('stop_worker')
