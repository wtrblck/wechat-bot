import io
import sys
import tempfile
import unittest
import wave
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from media_input import prepare_media
from policy import PolicyError, SendPolicy


def png_bytes():
    from PIL import Image
    output = io.BytesIO()
    Image.new('RGBA', (8, 6), (10, 20, 30, 255)).save(output, format='PNG')
    return output.getvalue()


def jpeg_bytes():
    from PIL import Image
    output = io.BytesIO()
    Image.new('RGB', (8, 6), (10, 20, 30)).save(output, format='JPEG')
    return output.getvalue()


def stereo_wav(rate=44100):
    import struct
    frames = int(rate * 0.4)
    samples = b''.join(struct.pack('<hh', 1000, 1000) for _ in range(frames))
    output = io.BytesIO()
    with wave.open(output, 'wb') as target:
        target.setparams((2, 2, rate, 0, 'NONE', 'not compressed'))
        target.writeframes(samples)
    return output.getvalue()


class MediaInputTest(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.root = Path(self.directory.name)
        self.policy = SendPolicy(recipients=('filehelper',), media_roots=(self.root,))

    def tearDown(self):
        self.directory.cleanup()

    def write(self, name, data):
        path = self.root / name
        path.write_bytes(data)
        return path

    def test_png_passthrough_and_jpeg_conversion(self):
        original = png_bytes()
        png = self.write('图片 with spaces.png', original)
        prepared = prepare_media('image', png, self.policy)
        self.assertEqual(prepared['media']['format'], 'png')
        self.assertIsNone(prepared['media']['converted_from'])
        self.assertEqual(Path(prepared['path']).read_bytes(), original)
        jpeg = self.write('photo.jpeg', jpeg_bytes())
        prepared = prepare_media('image', jpeg, self.policy)
        self.assertEqual(prepared['media']['converted_from'], 'jpeg')
        self.assertTrue(Path(prepared['path']).read_bytes().startswith(b'\x89PNG'))
        from PIL import Image
        with Image.open(prepared['path']) as image:
            self.assertEqual(image.size, (8, 6))

    def test_wav_is_normalised_to_mono_16k(self):
        wav = self.write('voice 44k stereo.wav', stereo_wav())
        prepared = prepare_media('voice', wav, self.policy)
        self.assertEqual(prepared['media']['format'], 'wav')
        with wave.open(prepared['path'], 'rb') as source:
            self.assertEqual((source.getnchannels(), source.getsampwidth(), source.getframerate()),
                             (1, 2, 16000))
            self.assertEqual(source.getnframes() % 320, 0)
        self.assertEqual(self.policy.voice_formats, ('wav', 'silk'))

    def test_file_inside_root_and_bounded(self):
        text = self.write('附件.txt', 'hello'.encode('utf-8'))
        prepared = prepare_media('file', text, self.policy)
        self.assertEqual(prepared['media']['size'], 5)
        self.assertTrue(Path(prepared['path']).is_file())
        self.assertEqual(Path(prepared['path']).read_bytes(), b'hello')

    def test_outside_root_empty_and_oversize_rejected(self):
        with self.assertRaises(PolicyError) as raised:
            prepare_media('file', Path(__file__).resolve(), self.policy)
        self.assertEqual(raised.exception.code, 'media_outside_allowed_roots')
        empty = self.write('empty.txt', b'')
        with self.assertRaises(PolicyError) as raised:
            prepare_media('file', empty, self.policy)
        self.assertEqual(raised.exception.code, 'media_empty')
        small = SendPolicy(recipients=('filehelper',), media_roots=(self.root,), media_bytes=4)
        large = self.write('large.bin', b'x' * 5)
        with self.assertRaises(PolicyError) as raised:
            prepare_media('file', large, small)
        self.assertEqual(raised.exception.code, 'media_too_large')

    def test_wrong_formats_are_explicit(self):
        text = self.write('not-an-image.txt', b'text')
        with self.assertRaises(PolicyError) as raised:
            prepare_media('image', text, self.policy)
        self.assertEqual(raised.exception.code, 'image_format_unsupported')
        video = self.write('clip.avi', b'RIFF' + bytes(100))
        with self.assertRaises(PolicyError) as raised:
            prepare_media('video', video, self.policy)
        self.assertEqual(raised.exception.code, 'video_format_unsupported')
        with self.assertRaises(PolicyError) as raised:
            prepare_media('voice', video, self.policy)
        self.assertEqual(raised.exception.code, 'audio_format_unsupported')

    def test_optional_video_conversion_to_mp4(self):
        from media_input import _ffmpeg
        if not _ffmpeg():
            self.skipTest('ffmpeg is not available')
        policy = SendPolicy(recipients=('filehelper',),
                            media_roots=(Path(__file__).resolve().parents[1] / 'fixtures',),
                            media_bytes=8 * 1024 * 1024, convert_video=True)
        prepared = prepare_media('video', Path(__file__).resolve().parents[1] /
                                 'fixtures' / 'wxbot-video.avi', policy)
        self.assertEqual(prepared['media']['format'], 'mp4')
        self.assertEqual(prepared['media']['converted_from'], 'converted')
        self.assertEqual(Path(prepared['path']).read_bytes()[4:8], b'ftyp')

    def test_optional_mp3_voice_conversion(self):
        from media_input import _ffmpeg
        if not _ffmpeg():
            self.skipTest('ffmpeg is not available')
        import subprocess
        source = self.write('source.wav', stereo_wav(16000))
        mp3 = self.root / 'source.mp3'
        subprocess.run([_ffmpeg(), '-y', '-loglevel', 'error', '-i', str(source), str(mp3)], check=True)
        policy = SendPolicy(recipients=('filehelper',), media_roots=(self.root,),
                            voice_formats=('wav', 'silk', 'mp3'))
        prepared = prepare_media('voice', mp3, policy)
        self.assertEqual(prepared['media']['format'], 'wav')
        self.assertIn('mp3->wav', prepared['media']['converted_from'])

    def test_staging_is_private_and_cleanup_only_removes_own_dirs(self):
        text = self.write('note.txt', b'note')
        prepared = prepare_media('file', text, self.policy, staging_root=self.root / 'stage')
        stage_dir = Path(prepared['directory'])
        self.assertEqual(stage_dir.parent, self.root / 'stage')
        self.assertTrue((stage_dir / 'note.txt').is_file())
        (self.root / 'stage' / 'keep').mkdir()
        from media_input import cleanup_staging
        self.assertEqual(cleanup_staging(self.root / 'stage', ttl=0), 1)
        self.assertTrue((self.root / 'stage' / 'keep').is_dir())


if __name__ == '__main__':
    unittest.main()
