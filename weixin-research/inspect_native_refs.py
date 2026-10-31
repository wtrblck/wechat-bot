"""Read-only direct-call and RIP-relative xrefs in the pinned image."""
import json
import re
import struct
import sys
from pe_image import PEImage
from profile import DLL, SHA256

image = PEImage(DLL)
if image.sha256 != SHA256:
    raise ValueError('Pinned DLL changed')
targets = {int(arg, 0): [] for arg in sys.argv[1:]}
for section in image.sections:
    if not section['flags'] & 0x20000000:
        continue
    code = image.data[section['raw']:section['raw'] + section['size']]
    for pattern, size, offset in ((rb'(?=([\xe8\xe9].{4}))', 5, 1),
                                  (rb'(?=([\x48-\x4f][\x8d\x8b][\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))', 7, 3)):
        for match in re.finditer(pattern, code, re.S):
            rva = section['rva'] + match.start()
            dest = rva + size + struct.unpack_from('<i', match.group(1), offset)[0]
            if dest in targets:
                owner = image.owner(rva)
                targets[dest].append(dict(rva=hex(rva), function=hex(owner['begin']) if owner else None))
print(json.dumps({hex(k): v for k, v in targets.items()}, indent=2))
