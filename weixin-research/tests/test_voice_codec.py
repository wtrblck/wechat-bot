import io
import struct
import sys
import unittest
import wave
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from voice_codec import MAGIC, packets, wav_pcm


def wav(rate=16000, channels=1, width=2, frames=320):
    buffer = io.BytesIO()
    with wave.open(buffer, 'wb') as output:
        output.setparams((channels, width, rate, 0, 'NONE', 'not compressed'))
        output.writeframes(bytes(frames * width * channels))
    return buffer.getvalue()


class VoiceFormatTest(unittest.TestCase):
    def test_binary_silk_packets_preserve_nuls(self):
        payload = b'\0abc\xff\0'
        encoded = MAGIC + struct.pack('<h', len(payload)) + payload
        self.assertEqual(packets(encoded), [payload])

    def test_invalid_and_truncated_silk_rejected(self):
        for encoded in (b'RIFF', MAGIC, MAGIC + b'\1', MAGIC + b'\0\0',
                        MAGIC + b'\xff\xff', MAGIC + b'\3\0ab', MAGIC + b'\xff\x7fabc'):
            with self.subTest(data=encoded), self.assertRaises(ValueError):
                packets(encoded)

    def test_valid_wav_has_exact_pcm_length(self):
        self.assertEqual(len(wav_pcm(wav(frames=16000))), 32000)

    def test_wrong_format_and_partial_frames_rejected(self):
        for data in (wav(rate=8000), wav(channels=2), wav(width=1), wav(frames=319), wav(frames=321)):
            with self.assertRaises(ValueError):
                wav_pcm(data)

    def test_fixture_duration_and_round_trip_evidence_match(self):
        from profile import ROOT
        encoded = (ROOT / 'fixtures' / 'wxbot-voice.silk').read_bytes()
        self.assertEqual(len(packets(encoded)), 50)
        self.assertEqual(len(wav_pcm((ROOT / 'fixtures' / 'wxbot-voice.wav').read_bytes())), 32000)
        self.assertEqual(len(wav_pcm((ROOT / 'fixtures' / 'wxbot-voice-decoded.wav').read_bytes())), 32000)


if __name__ == '__main__':
    unittest.main()
