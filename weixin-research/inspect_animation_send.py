"""Read-only pinned DLL inventory for native local-animation sending."""
import json
import re
import struct

from pe_image import PEImage
from profile import DLL, SHA256


def main():
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise ValueError('Pinned DLL changed')
    pattern = re.compile(rb'(gif|emoticon|emoji).{0,100}(upload|local|file|path)|'
                         rb'(upload|local|file|path).{0,100}(gif|emoticon|emoji)', re.I)
    anchors = {}
    for match in re.finditer(rb'[\x20-\x7e]{8,500}', image.data):
        if not pattern.search(match.group()):
            continue
        for section in image.sections:
            if section['raw'] <= match.start() < section['raw'] + section['size'] and not section['flags'] & 0x20000000:
                rva = section['rva'] + match.start() - section['raw']
                anchors[rva] = dict(text=match.group().decode('ascii'), rva=hex(rva), refs=[])
                break
    for section in image.sections:
        if not section['flags'] & 0x20000000:
            continue
        code = image.data[section['raw']:section['raw'] + section['size']]
        for match in re.finditer(rb'(?=([\x48-\x4f][\x8d\x8b][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))', code, re.S):
            rva = section['rva'] + match.start()
            dest = rva + 7 + struct.unpack_from('<i', match.group(1), 3)[0]
            for start, anchor in anchors.items():
                if start <= dest < start + len(anchor['text']):
                    owner = image.owner(rva)
                    anchor['refs'].append(dict(rva=hex(rva), function=hex(owner['begin']) if owner else None))
    print(json.dumps(list(anchors.values()), indent=2))


if __name__ == '__main__':
    main()
