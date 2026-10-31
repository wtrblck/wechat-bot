import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from service_lifecycle import ServiceStop


class ServiceLifecycleTest(unittest.TestCase):
    def test_only_current_generation_stops_and_replacement_is_preserved(self):
        with tempfile.TemporaryDirectory() as directory:
            lifecycle = ServiceStop(directory)
            for value in ({}, dict(lifecycle.identity, token='stale'), dict(lifecycle.identity, pid=1)):
                lifecycle.request.write_text(json.dumps(value), encoding='utf-8')
                self.assertFalse(lifecycle.requested())
            lifecycle.request.write_text(json.dumps(lifecycle.identity), encoding='utf-8')
            self.assertTrue(lifecycle.requested())
            self.assertFalse(lifecycle.requested())
            replacement = dict(lifecycle.identity, token='replacement')
            lifecycle.descriptor.write_text(json.dumps(replacement), encoding='utf-8')
            lifecycle.close()
            self.assertEqual(json.loads(lifecycle.descriptor.read_text(encoding='utf-8')), replacement)

    def test_malformed_oversized_requests_never_stop(self):
        with tempfile.TemporaryDirectory() as directory:
            lifecycle = ServiceStop(directory)
            for value in ('{', 'x' * 257):
                lifecycle.request.write_text(value, encoding='utf-8')
                self.assertFalse(lifecycle.requested())
            lifecycle.close()
            self.assertFalse(lifecycle.descriptor.exists())


if __name__ == '__main__':
    unittest.main()
