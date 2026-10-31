"""Cooperative service shutdown, scoped to an unpredictable process generation."""
import json
import os
import uuid
from pathlib import Path


class ServiceStop:
    def __init__(self, folder):
        folder = Path(folder)
        folder.mkdir(parents=True, exist_ok=True)
        self.descriptor = folder / 'bridge.json'
        self.request = folder / 'bridge.stop.json'
        self.identity = dict(pid=os.getpid(), token=uuid.uuid4().hex)
        temporary = self.descriptor.with_suffix('.tmp')
        temporary.write_text(json.dumps(self.identity), encoding='utf-8')
        temporary.replace(self.descriptor)

    def requested(self):
        try:
            if self.request.stat().st_size > 256:
                return False
            value = json.loads(self.request.read_text(encoding='utf-8'))
            if value != self.identity:
                return False
            self.request.unlink(missing_ok=True)
            return True
        except (OSError, ValueError):
            return False

    def close(self):
        try:
            if json.loads(self.descriptor.read_text(encoding='utf-8')) == self.identity:
                self.descriptor.unlink(missing_ok=True)
        except (OSError, ValueError):
            pass
