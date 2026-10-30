"""Read-only, version-pinned media sender anchor and caller inventory."""
import json
import re
import struct
from pe_image import PEImage
from profile import DLL, ROOT, SHA256


def main():
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise ValueError('Pinned DLL changed')
    pattern = re.compile(rb'send.{0,40}(image|img|video|file|media|voice)|(?:image|video|file|media).{0,30}send|message::send|StartSend|send_text_message_failed', re.I)
    anchors = []
    for match in re.finditer(rb'[\x20-\x7e]{8,400}', image.data):
        if not pattern.search(match.group()):
            continue
        for section in image.sections:
            if section['raw'] <= match.start() < section['raw'] + section['size'] and not section['flags'] & 0x20000000:
                anchors.append(dict(text=match.group().decode('ascii'),
                                    rva=section['rva'] + match.start() - section['raw'], refs=[]))
                break
    targets = {a['rva']: a for a in anchors}
    for section in image.sections:
        if not section['flags'] & 0x20000000:
            continue
        code = image.data[section['raw']:section['raw'] + section['size']]
        for match in re.finditer(rb'(?=([\x48-\x4f][\x8d\x8b][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))', code, re.S):
            rva = section['rva'] + match.start()
            dest = rva + 7 + struct.unpack_from('<i', match.group(1), 3)[0]
            if dest in targets:
                targets[dest]['refs'].append(dict(rva=hex(rva), function=image.owner(rva)))
    output = ROOT / 'media-analysis.json'
    output.write_text(json.dumps(dict(sha256=image.sha256, anchors=anchors,
                                     status='Heuristic xrefs; decode instructions before using'), indent=2), encoding='utf-8')
    print(json.dumps([a for a in anchors if a['refs']], indent=2))


if __name__ == '__main__':
    main()
