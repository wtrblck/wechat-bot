import sys
import hashlib
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import active_send
from policy import PolicyError, SendPolicy
from offline_native import patch_sender


class ActiveSendValidationTest(unittest.TestCase):
    def setUp(self):
        patch_sender(self)
        self.fixtures = active_send.ROOT / 'fixtures'
        self.policy = SendPolicy(recipients=('filehelper', 'wxid_test_contact'))

    def test_valid_generated_requests_require_app_thread(self):
        for kind, name in [('text', None), ('image', 'wxbot-image.png'),
                           ('file', 'wxbot-audio.wav'), ('video', 'wxbot-video.mp4')]:
            config = active_send.config_for(kind, text='wxbot-active' if kind == 'text' else None,
                                            path=self.fixtures / name if name else None,
                                            policy=self.policy)
            request = config['active_experiment']
            self.assertTrue(request['on_app_thread'])
            self.assertEqual(request['recipient'], 'filehelper')
            self.assertEqual(bytes(request['recipient_bytes']), b'filehelper')
            self.assertEqual(config['sites'], [])

    def test_text_is_explicit_utf8_bytes(self):
        cases = ['wxbot-active', 'x' * 15, 'x' * 16, '中文消息', '😀 表情\n第二行', '长' * 700]
        for text in cases:
            with self.subTest(text=text[:12]):
                request = active_send.config_for('text', text=text, policy=self.policy)['active_experiment']
                self.assertEqual(bytes(request['text_bytes']), text.encode('utf-8'))
                self.assertEqual(request['text'], text)
        self.assertEqual(len(cases), 6)

    def test_text_limits_and_controls_rejected(self):
        over = 'a' * (self.policy.text_bytes + 1)
        for text in ('', 'wxbot-a\x00b', 'bell\x07char', None):
            with self.subTest(text=repr(text)[:16]), self.assertRaises(PolicyError):
                active_send.config_for('text', text=text, policy=self.policy)
        with self.assertRaises(PolicyError):
            active_send.config_for('text', text=over, policy=self.policy)

    def test_recipient_must_be_explicitly_allowed(self):
        with self.assertRaises(PolicyError) as raised:
            active_send.config_for('text', text='hello', recipient='wxid_unknown')
        self.assertEqual(raised.exception.code, 'recipient_not_allowed')
        config = active_send.config_for('text', text='hello', recipient='wxid_test_contact', policy=self.policy)
        self.assertEqual(config['active_experiment']['recipient'], 'wxid_test_contact')
        self.assertEqual(bytes(config['active_experiment']['recipient_bytes']), b'wxid_test_contact')
        self.assertTrue(config['active_experiment']['limits']['recipients'])

    def test_recipient_length_is_bounded(self):
        recipient = 'wxid_' + 'a' * self.policy.recipient_bytes
        policy = SendPolicy(recipients=('filehelper', recipient))
        with self.assertRaises(PolicyError) as raised:
            active_send.config_for('text', text='hello', recipient=recipient, policy=policy)
        self.assertEqual(raised.exception.code, 'recipient_too_long')

    def test_files_outside_fixture_root_rejected(self):
        with self.assertRaises(ValueError):
            active_send.config_for('file', path=active_send.ROOT / 'REPORT.md', policy=self.policy)

    def test_tampered_fixture_rejected(self):
        with tempfile.TemporaryDirectory(dir=self.fixtures, prefix='wxbot-unit-') as directory:
            resolved = Path(directory).resolve()
            self.assertIn(active_send.ROOT.resolve(), resolved.parents)
            path = resolved / 'wxbot-image.png'
            path.write_bytes(b'tampered')
            with self.assertRaisesRegex(ValueError, 'manifest'):
                active_send.config_for('image', path=path, policy=self.policy)

    def test_wrong_media_kind_and_avi_native_video_rejected(self):
        with self.assertRaisesRegex(ValueError, 'PNG'):
            active_send.config_for('image', path=self.fixtures / 'wxbot-audio.wav', policy=self.policy)
        with self.assertRaisesRegex(ValueError, 'MP4'):
            active_send.config_for('video', path=self.fixtures / 'wxbot-video.avi', policy=self.policy)

    def test_voice_silk_duration_is_derived_and_payload_is_binary(self):
        data = (self.fixtures / 'wxbot-voice.silk').read_bytes()
        # SDK decoding is a separate native integration, not a portable unit test.
        with patch.object(active_send, 'voice_worker', return_value=dict(sha256=hashlib.sha256(data).hexdigest(), duration_ms=1000)):
            config = active_send.config_for('voice', path=self.fixtures / 'wxbot-voice.silk', policy=self.policy)
        request = config['active_experiment']
        self.assertEqual(request['duration_ms'], 1000)
        self.assertIn(0, request['voice_bytes'])
        self.assertEqual(bytes(request['voice_bytes']), (self.fixtures / 'wxbot-voice.silk').read_bytes())

    def test_voice_requires_encoded_silk_or_pcm_wav(self):
        with self.assertRaisesRegex(ValueError, 'WAV or Tencent SILK'):
            active_send.config_for('voice', path=self.fixtures / 'wxbot-video.mp4', policy=self.policy)

    def test_voice_worker_timeout_is_a_validation_failure(self):
        with patch.object(active_send.subprocess, 'run', side_effect=active_send.subprocess.TimeoutExpired('codec', 20)):
            with self.assertRaisesRegex(ValueError, 'timed out'):
                active_send.voice_worker('--inspect-silk', 'unused')

    def test_function_manifest_includes_general_assignment(self):
        config = active_send.config_for('text', text='hello', policy=self.policy)
        names = {item['name']: item['rva'] for item in config['active_experiment']['functions']}
        self.assertEqual(names['narrow_assign'], 0x1F9AD0)
        self.assertEqual(names['wide_assign'], 0x9B5E0)


class NativeVersionGuardTest(unittest.TestCase):
    def test_production_pinned_image_rejects_wrong_hash_without_loading_wechat(self):
        from types import SimpleNamespace
        with tempfile.TemporaryDirectory() as directory:
            dll = Path(directory) / 'fixture.dll'
            dll.write_bytes(b'not the matching WeChat image')
            with patch.object(active_send, 'DLL', dll), patch.object(active_send, 'PEImage', return_value=SimpleNamespace(sha256='0' * 64)):
                with self.assertRaisesRegex(ValueError, 'Pinned DLL changed'):
                    active_send.pinned_image()


if __name__ == '__main__':
    unittest.main()
