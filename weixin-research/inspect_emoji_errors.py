"""Offline string/xref inventory, including references into merged literals."""
import bisect
import json
import re
import struct
from pe_image import PEImage
from profile import DLL, ROOT, SHA256

image = PEImage(DLL)
assert image.sha256 == SHA256
anchors = []
for section in image.sections:
    if section['flags'] & 0x20000000:
        continue
    data = image.data[section['raw']:section['raw'] + section['size']]
    for match in re.finditer(rb'[\x20-\x7e]{6,1000}', data):
        if re.search(rb'emoticon|emoji|upload.{0,80}(fail|error)', match.group(), re.I):
            anchors.append(dict(rva=section['rva'] + match.start(), text=match.group().decode(), refs=[]))
anchors.sort(key=lambda a: a['rva'])
starts = [a['rva'] for a in anchors]
for section in image.sections:
    if not section['flags'] & 0x20000000:
        continue
    data = image.data[section['raw']:section['raw'] + section['size']]
    for match in re.finditer(rb'(?=([\x48-\x4f\x0f][\x8d\x8b\x10\x28][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))', data, re.S):
        rva = section['rva'] + match.start()
        dest = rva + 7 + struct.unpack_from('<i', match.group(1), 3)[0]
        i = bisect.bisect_right(starts, dest) - 1
        if i >= 0 and dest < starts[i] + len(anchors[i]['text']):
            owner = image.owner(rva)
            anchors[i]['refs'].append(dict(rva=hex(rva), function=hex(owner['begin']) if owner else None))
path = ROOT / 'runs/gif-upload-fix/error-anchors.json'
path.write_text(json.dumps(anchors, indent=2))
print(json.dumps([a for a in anchors if a['refs']], indent=2))
