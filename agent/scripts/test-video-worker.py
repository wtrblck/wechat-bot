"""Offline integration checks: real decoding, subtitle extraction and ASR transport."""
import importlib.util
import json
import os
from pathlib import Path
import tempfile
import threading
import unittest
from http.server import BaseHTTPRequestHandler, HTTPServer

spec = importlib.util.spec_from_file_location('video_worker', Path(__file__).with_name('video-worker.py'))
worker = importlib.util.module_from_spec(spec)
spec.loader.exec_module(worker)


class VideoTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp = tempfile.TemporaryDirectory(prefix='wechat-video-test-')
        root = Path(cls.temp.name)
        cls.movie = str(root / 'audio.mp4')
        result = worker.run(['-f', 'lavfi', '-i', 'color=red:s=160x96:r=10:d=2',
                             '-f', 'lavfi', '-i', 'sine=frequency=440:duration=2',
                             '-c:v', 'libx264', '-c:a', 'aac', '-t', '2', '-y', cls.movie])
        assert result.returncode == 0
        cls.silent = str(root / 'subtitle.mp4')
        subtitle = root / 'test.srt'
        subtitle.write_text('1\n00:00:00,000 --> 00:00:01,500\nsubtitle evidence\n', encoding='utf-8')
        result = worker.run(['-f', 'lavfi', '-i', 'color=blue:s=160x96:r=10:d=2',
                             '-i', str(subtitle), '-c:v', 'libx264', '-c:s', 'mov_text', '-t', '2', '-y', cls.silent])
        assert result.returncode == 0

    @classmethod
    def tearDownClass(cls): cls.temp.cleanup()

    def args(self, **extra):
        return {'path': self.movie, 'maxDuration': 3600, 'maxSeconds': 180, **extra}

    def test_embedded_subtitles_without_audio(self):
        result = worker.transcribe(self.args(path=self.silent, embedded=True))
        self.assertEqual(result['source'], 'embedded_subtitles')
        self.assertIn('subtitle evidence', result['text'])

    def test_off_and_missing_local_model_are_honest(self):
        self.assertEqual(worker.transcribe(self.args(backend='off'))['state'], 'asr_not_configured')
        self.assertEqual(worker.transcribe(self.args(backend='local', localModel=self.temp.name))['state'], 'local_asr_model_missing')

    def test_local_cpu_asr_runs_without_network_or_pyav_container_open(self):
        model = Path(__file__).resolve().parents[1] / 'data/video-models/faster-whisper-base'
        if not (model / 'model.bin').exists(): self.skipTest('install local model first')
        result = worker.transcribe(self.args(backend='local', localModel=str(model)))
        self.assertEqual(result['state'], 'ready')
        self.assertEqual(result['source'], 'local_whisper')
        self.assertIsInstance(result['segments'], list)

    def test_endpoint_audio_multipart_offsets_and_redirect_refusal(self):
        received = []
        class Handler(BaseHTTPRequestHandler):
            redirect = False
            def do_POST(self):
                body = self.rfile.read(int(self.headers['Content-Length']))
                received.append((self.path, dict(self.headers), body))
                if self.redirect:
                    self.send_response(302); self.send_header('Location', '/secret-target'); self.end_headers(); return
                self.send_response(200); self.send_header('Content-Type', 'application/json'); self.end_headers()
                self.wfile.write(json.dumps({'text': 'recognized', 'segments': [{'start': .1, 'end': .4, 'text': 'recognized'}]}).encode())
            def log_message(self, *_): pass
        server = HTTPServer(('127.0.0.1', 0), Handler)
        thread = threading.Thread(target=server.serve_forever, daemon=True); thread.start()
        os.environ['VIDEO_TEST_KEY'] = 'fake-secret'
        try:
            args = self.args(backend='endpoint', endpoint=f'http://127.0.0.1:{server.server_port}/v1',
                             model='test', apiKeyEnv='VIDEO_TEST_KEY', **{'from': .25, 'to': 1.5})
            result = worker.transcribe(args)
            self.assertAlmostEqual(result['segments'][0]['start'], .35)
            self.assertEqual(received[0][0], '/v1/audio/transcriptions')
            self.assertIn(b'RIFF', received[0][2]); self.assertNotIn(b'fake-secret', received[0][2])
            Handler.redirect = True
            with self.assertRaisesRegex(ValueError, 'asr_redirect_denied'): worker.transcribe(args)
            self.assertEqual(len(received), 2)
        finally:
            server.shutdown(); server.server_close(); thread.join(); del os.environ['VIDEO_TEST_KEY']

    def test_real_merge_of_separate_video_and_audio(self):
        merged = str(Path(self.temp.name) / 'merged.mp4')
        worker.main({'action': 'merge', 'video': self.silent, 'audio': self.movie, 'output': merged, 'maxBytes': 1048576})
        self.assertTrue(worker.probe(merged, 30)['audio'])


if __name__ == '__main__': unittest.main()
