"""Generate non-private, tiny transport fixtures using only the standard library."""
import hashlib
import json
import math
import struct
import wave
import zlib
from profile import ROOT


def main():
    output = ROOT / 'fixtures'
    output.mkdir(exist_ok=True)
    width, height = 160, 96
    pixels = b''.join(b'\0' + b''.join(bytes((32 + (x // 16) * 16, 80 + (y // 16) * 16, 160))
                                    for x in range(width)) for y in range(height))
    def chunk(kind, data):
        return struct.pack('>I', len(data)) + kind + data + struct.pack('>I', zlib.crc32(kind + data))
    png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', width, height, 8, 2, 0, 0, 0))
    png += chunk(b'tEXt', b'Description\0wxbot generated API test fixture')
    png += chunk(b'IDAT', zlib.compress(pixels)) + chunk(b'IEND', b'')
    (output / 'wxbot-image.png').write_bytes(png)
    (output / 'wxbot-file.txt').write_text('wxbot generated file API fixture\nNo personal data.\n', encoding='utf-8')
    def riff_chunk(kind, data):
        return kind + struct.pack('<I', len(data)) + data + (b'\0' if len(data) % 2 else b'')
    def riff_list(kind, data):
        return riff_chunk(b'LIST', kind + data)
    frame_size, count, fps = width * height * 3, 5, 5
    avih = struct.pack('<14I', 1000000 // fps, frame_size * fps, 0, 0x10, count, 0, 1,
                       frame_size, width, height, 0, 0, 0, 0)
    strh = struct.pack('<4s4sIHH8I4h', b'vids', b'DIB ', 0, 0, 0, 0, 1, fps, 0, count,
                       frame_size, 0xffffffff, 0, 0, 0, width, height)
    strf = struct.pack('<IiiHHIIiiII', 40, width, height, 1, 24, 0, frame_size, 0, 0, 0, 0)
    hdrl = riff_list(b'hdrl', riff_chunk(b'avih', avih) + riff_list(b'strl', riff_chunk(b'strh', strh) + riff_chunk(b'strf', strf)))
    frames = [b''.join(bytes((80 + n * 25, 80 + y // 2, 40 + x)) for y in range(height) for x in range(width)) for n in range(count)]
    movi = riff_list(b'movi', b''.join(riff_chunk(b'00db', frame) for frame in frames))
    index = riff_chunk(b'idx1', b''.join(struct.pack('<4sIII', b'00db', 0x10, 4 + n * (frame_size + 8), frame_size) for n in range(count)))
    avi = b'AVI ' + hdrl + movi + index
    (output / 'wxbot-video.avi').write_bytes(b'RIFF' + struct.pack('<I', len(avi)) + avi)
    with wave.open(str(output / 'wxbot-audio.wav'), 'wb') as audio:
        audio.setparams((1, 2, 8000, 0, 'NONE', 'not compressed'))
        audio.writeframes(b''.join(struct.pack('<h', int(1000 * math.sin(2 * math.pi * 440 * n / 8000)))
                                   for n in range(4000)))
    manifest = [dict(name=p.name, size=p.stat().st_size, sha256=hashlib.sha256(p.read_bytes()).hexdigest())
                for p in sorted(output.glob('wxbot-*')) if p.is_file()]
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2), encoding='utf-8')
    print(json.dumps(manifest))


if __name__ == '__main__':
    main()
