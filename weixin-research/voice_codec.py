"""Offline SILK codec worker using the pinned, locally installed WeChat codec.

Runs in its own Python process using the installed DLL, without attaching to WeChat.
SDK ABI reference: https://github.com/laysent/silk-sdk (Skype SILK SDK headers).
"""
import argparse
import ctypes as c
import hashlib
import json
import math
import os
import struct
import subprocess
import sys
import wave
import io
from pathlib import Path
from profile import ROOT, DLL

CODEC_DLL = DLL.parent / 'VoipEngine.dll'
CODEC_SHA256 = 'ec7cfdbc32842111be3287753832559c0403a79a3042a3a9ae57dd3908bc225c'
MAGIC = b'\x02#!SILK_V3'


class EncoderControl(c.Structure):
    _fields_ = [(name, c.c_int32) for name in ('API_sampleRate', 'maxInternalSampleRate', 'packetSize',
                 'bitRate', 'packetLossPercentage', 'complexity', 'useInBandFEC', 'useDTX')]


class DecoderControl(c.Structure):
    _fields_ = [(name, c.c_int32) for name in ('API_sampleRate', 'frameSize', 'framesPerPacket',
                                             'moreInternalDecoderFrames', 'inBandFECOffset')]


def packets(data):
    if not data.startswith(MAGIC):
        raise ValueError('Expected Tencent SILK v3 header')
    position, result = len(MAGIC), []
    while position < len(data):
        if position + 2 > len(data):
            raise ValueError('Truncated SILK packet size')
        size = struct.unpack_from('<h', data, position)[0]
        position += 2
        if not 0 < size <= 1250 or position + size > len(data):
            raise ValueError('Invalid SILK packet')
        result.append(data[position:position + size])
        position += size
    if not result or len(result) > 3000:
        raise ValueError('SILK duration outside experiment bounds')
    return result


def wav_pcm(data):
    with wave.open(io.BytesIO(data), 'rb') as source:
        if source.getnchannels() != 1 or source.getsampwidth() != 2 or source.getframerate() != 16000 or source.getcomptype() != 'NONE':
            raise ValueError('Voice WAV must be uncompressed mono 16 kHz 16-bit PCM')
        frames = source.getnframes()
        if not 320 <= frames <= 960000 or frames % 320:
            raise ValueError('Voice duration must be 20..60000 ms in whole 20 ms frames')
        pcm = source.readframes(frames)
        if len(pcm) != frames * 2:
            raise ValueError('Truncated WAV samples')
        return pcm


def fixture_bytes(source):
    source = Path(source).resolve()
    if (ROOT / 'fixtures').resolve() not in source.parents or not source.name.startswith('wxbot-'):
        raise ValueError('Only generated voice fixtures are permitted')
    if not source.is_file() or source.stat().st_size > 2 * 1024 * 1024:
        raise ValueError('Voice fixture missing or too large')
    data = source.read_bytes()
    manifest = json.loads((ROOT / 'fixtures' / 'manifest.json').read_text(encoding='utf-8'))
    if not any(item['name'] == source.name and item['sha256'] == hashlib.sha256(data).hexdigest() for item in manifest):
        raise ValueError('Voice fixture hash differs')
    return data


def project_bytes(source):
    """Trusted path for files this project wrote itself (encoded SILK output).

    Encoding and decoding must not run in the same process: the local SILK SDK
    crashes on the second operation, so the caller encodes in one worker and
    verifies in another.
    """
    source = Path(source).resolve()
    if ROOT.resolve() not in source.parents:
        raise ValueError('Voice file must be inside this project')
    if not source.is_file() or source.stat().st_size > 2 * 1024 * 1024:
        raise ValueError('Voice file missing or too large')
    return source.read_bytes()


def inspect_silk(source, trusted=False, decoded_wav=None):
    data = project_bytes(source) if trusted else fixture_bytes(source)
    decoded = Codec().decode_silk(data)
    if decoded_wav is not None:
        target = Path(decoded_wav).resolve()
        if ROOT.resolve() not in target.parents or target.suffix != '.wav':
            raise ValueError('Decoded output must be a project WAV file')
        target.parent.mkdir(parents=True, exist_ok=True)
        with wave.open(str(target), 'wb') as output:
            output.setparams((1, 2, 16000, 0, 'NONE', 'not compressed'))
            output.writeframes(decoded)
    return dict(duration_ms=len(decoded) // 32, decoded_samples=len(decoded) // 2,
                packets=len(packets(data)), sha256=hashlib.sha256(data).hexdigest(),
                codec_sha256=CODEC_SHA256, decoded=True)


def encode_wav(source, destination, trusted_input=False):
    """Encode only; the caller verifies duration in a separate worker process.

    ``trusted_input`` accepts a normalised WAV that this project staged itself
    (P7 media input) instead of a generated fixture with a manifest entry.
    """
    source, destination = Path(source).resolve(), Path(destination).resolve()
    if ROOT.resolve() not in destination.parents or destination.suffix != '.silk':
        raise ValueError('Output must be a project SILK file')
    data = project_bytes(source) if trusted_input else fixture_bytes(source)
    pcm = wav_pcm(data)
    encoded = Codec().encode_pcm(pcm)
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(encoded)
    return dict(path=str(destination), duration_ms=len(pcm) // 32, packets=len(packets(encoded)),
                size=len(encoded), sha256=hashlib.sha256(encoded).hexdigest(), encoded=True)


def verify_silk_child(source, decoded_wav=None):
    """Run the decoder in a fresh process; the SDK crashes on a second operation."""
    command = [sys.executable, str(Path(__file__).resolve()), '--inspect-silk', str(source), '--trusted']
    if decoded_wav is not None:
        command += ['--decoded-wav', str(decoded_wav)]
    completed = subprocess.run(command, capture_output=True, text=True, timeout=20)
    if completed.returncode:
        raise ValueError('SILK verification process failed: ' + completed.stderr[-500:])
    return json.loads(completed.stdout)


class Codec:
    def __init__(self):
        if hashlib.sha256(CODEC_DLL.read_bytes()).hexdigest() != CODEC_SHA256:
            raise ValueError('Local codec DLL fingerprint changed')
        self.directory = os.add_dll_directory(str(CODEC_DLL.parent))
        self.module = c.WinDLL(str(CODEC_DLL))
        self.get_encoder = self.bind('Get_Encoder_Size', [c.POINTER(c.c_int32)])
        self.init_encoder = self.bind('InitEncoder', [c.c_void_p, c.POINTER(EncoderControl)])
        self.encode = self.bind('Encode', [c.c_void_p, c.POINTER(EncoderControl), c.c_void_p,
                                          c.c_int32, c.c_void_p, c.POINTER(c.c_int16)])
        self.get_decoder = self.bind('Get_Decoder_Size', [c.POINTER(c.c_int32)])
        self.init_decoder = self.bind('InitDecoder', [c.c_void_p])
        self.decode = self.bind('Decode', [c.c_void_p, c.POINTER(DecoderControl), c.c_int32,
                                          c.c_void_p, c.c_int32, c.c_void_p, c.POINTER(c.c_int16)])

    def bind(self, name, arguments):
        function = getattr(self.module, 'SKP_Silk_SDK_' + name)
        function.argtypes, function.restype = arguments, c.c_int32
        return function

    @staticmethod
    def check(code):
        if code != 0:
            raise RuntimeError('SILK SDK error %d' % code)

    def encode_pcm(self, pcm, sample_rate=16000):
        if sample_rate != 16000 or len(pcm) % 640:
            raise ValueError('Expected whole 20 ms frames of mono 16 kHz s16le PCM')
        size = c.c_int32()
        self.check(self.get_encoder(c.byref(size)))
        if not 0 < size.value < 1024 * 1024:
            raise ValueError('Encoder state size differs')
        state = c.create_string_buffer(size.value)
        control = EncoderControl()
        self.check(self.init_encoder(state, c.byref(control)))
        control = EncoderControl(sample_rate, sample_rate, 320, 16000, 0, 2, 0, 0)
        output = bytearray(MAGIC)
        for position in range(0, len(pcm), 640):
            frame = c.create_string_buffer(pcm[position:position + 640])
            payload, count = c.create_string_buffer(1250), c.c_int16(1250)
            self.check(self.encode(state, c.byref(control), frame, 320, payload, c.byref(count)))
            if not 0 < count.value <= 1250:
                raise ValueError('Encoder returned an invalid packet size')
            output += struct.pack('<h', count.value) + payload.raw[:count.value]
        return bytes(output)

    def decode_silk(self, data):
        size = c.c_int32()
        self.check(self.get_decoder(c.byref(size)))
        if not 0 < size.value < 1024 * 1024:
            raise ValueError('Decoder state size differs')
        state, control = c.create_string_buffer(size.value), DecoderControl(16000, 0, 0, 0, 0)
        self.check(self.init_decoder(state))
        decoded = bytearray()
        for packet in packets(data):
            payload = c.create_string_buffer(packet)
            for frame_index in range(5):
                output, count = c.create_string_buffer(1920), c.c_int16(960)
                self.check(self.decode(state, c.byref(control), 0, payload, len(packet), output, c.byref(count)))
                if not 0 < count.value <= 960:
                    raise ValueError('Decoder returned an invalid frame size')
                decoded += output.raw[:count.value * 2]
                if len(decoded) > 16000 * 2 * 60:
                    raise ValueError('Decoded voice exceeds 60 seconds')
                if not control.moreInternalDecoderFrames:
                    break
            else:
                raise ValueError('Too many frames in packet')
        return bytes(decoded)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    actions = parser.add_mutually_exclusive_group(required=True)
    actions.add_argument('--make-fixture', action='store_true')
    actions.add_argument('--encode-wav', type=Path)
    actions.add_argument('--inspect-silk', type=Path)
    parser.add_argument('--output', type=Path)
    parser.add_argument('--trusted', action='store_true',
                        help='Accept any file inside this project (its own encoded output)')
    parser.add_argument('--trusted-input', action='store_true',
                        help='Accept a normalised WAV staged by this project for encoding')
    parser.add_argument('--decoded-wav', type=Path,
                        help='Write the decoded PCM to this project WAV (with --trusted)')
    args = parser.parse_args()
    if args.inspect_silk:
        print(json.dumps(inspect_silk(args.inspect_silk, args.trusted, args.decoded_wav)))
        return
    if args.encode_wav:
        if not args.output:
            parser.error('--encode-wav requires --output')
        print(json.dumps(encode_wav(args.encode_wav, args.output, args.trusted_input)))
        return
    fixtures = ROOT / 'fixtures'
    fixtures.mkdir(exist_ok=True)
    # A recognizable ascending two-tone signal, with short fade to avoid clicks.
    samples = [int(1800 * min(1, n / 160, (15999 - n) / 160) *
                   math.sin(2 * math.pi * (440 if n < 8000 else 660) * n / 16000)) for n in range(16000)]
    pcm = struct.pack('<16000h', *samples)
    encoded = Codec().encode_pcm(pcm)
    target = fixtures / 'wxbot-voice.silk'
    target.write_bytes(encoded)
    with wave.open(str(fixtures / 'wxbot-voice.wav'), 'wb') as output:
        output.setparams((1, 2, 16000, 0, 'NONE', 'not compressed'))
        output.writeframes(pcm)
    # Verify in a fresh process: a second codec operation in one process crashes.
    verified = verify_silk_child(target, fixtures / 'wxbot-voice-decoded.wav')
    decoded = wav_pcm((fixtures / 'wxbot-voice-decoded.wav').read_bytes())
    if verified['decoded_samples'] != len(pcm) // 2 or max(struct.unpack('<16000h', decoded)) < 100:
        raise ValueError('Round-trip audio verification failed')
    report = dict(codec_sha256=CODEC_SHA256, encoded_size=len(encoded), packets=len(packets(encoded)),
                  duration_ms=1000, decoded_samples=verified['decoded_samples'], round_trip_passed=True,
                  sha256=hashlib.sha256(encoded).hexdigest())
    (fixtures / 'voice-codec-result.json').write_text(json.dumps(report, indent=2), encoding='utf-8')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
