"""Version-pinned, static-only download candidates. Never loads or calls WeChat."""
import json
import re
import struct
from pe_image import PEImage
from profile import DLL, ROOT, SHA256


def main():
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise ValueError('Pinned DLL changed')
    pattern = re.compile(rb'(download.{0,70}(image|video|attach|file|voice|media)|'
                         rb'(image|video|attach|file|voice|media).{0,70}download)', re.I)
    anchors = []
    for match in re.finditer(rb'[\x20-\x7e]{8,500}', image.data):
        if not pattern.search(match.group()):
            continue
        for section in image.sections:
            if section['raw'] <= match.start() < section['raw'] + section['size'] and not section['flags'] & 0x20000000:
                anchors.append(dict(text=match.group().decode(), rva=section['rva'] + match.start() - section['raw'], refs=[]))
                break
    targets = {anchor['rva']: anchor for anchor in anchors}
    for section in image.sections:
        if not section['flags'] & 0x20000000:
            continue
        code = image.data[section['raw']:section['raw'] + section['size']]
        for match in re.finditer(rb'(?=([\x48-\x4f][\x8d\x8b][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))', code, re.S):
            rva = section['rva'] + match.start()
            destination = rva + 7 + struct.unpack_from('<i', match.group(1), 3)[0]
            if destination in targets:
                targets[destination]['refs'].append(dict(rva=hex(rva), function=image.owner(rva)))
    output = ROOT / 'runs' / 'p4' / 'download-candidates.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(dict(sha256=image.sha256, anchors=anchors,
                                      status='Heuristic xrefs only; ABI, ownership, thread and download completion unverified.'),
                                 indent=2), encoding='utf-8')
    print(json.dumps(dict(anchors=len(anchors), referenced=sum(bool(a['refs']) for a in anchors), output=str(output))))


if __name__ == '__main__':
    main()
