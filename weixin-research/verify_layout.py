"""Recheck selected disassembly evidence against pinned on-disk bytes only."""
import json
import re
from pathlib import Path

from pe_image import PEImage
from profile import DLL, ROOT, SHA256

# These are structural observations, not a usable ABI or business field mapping.
CLAIMS = [
    ('text_input_pair', 'text-send.asm', [0x55f03b4, 0x55f03b7, 0x55f04c7, 0x55f04d7,
                                       0x55f04db, 0x55f07ec, 0x55f07f0],
     'RDX is saved in RBX; two string-shaped values at RDX+0 and RDX+0x20 feed the object. R8 is a separate input.'),
    ('message_fields', 'text-send.asm', [0x55f04bd, 0x55f04cb, 0x55f0509, 0x55f07bf,
                                       0x55f0820],
     'Native object writes +0x118=1; string-shaped fields +0xB0 and +0x758 have lengths at +0xC0 and +0x768. Business meanings unverified.'),
    ('factory_ownership', 'message-factory.asm', [0x709178, 0x70918c, 0x70919e, 0x7091a2,
                                                0x7091b6, 0x7091bc, 0x7091c3],
     'Allocation is 0x7A8, object begins at allocation+0x10, zeroed size 0x798, constructor RVA 0x77AB70. Output pair stores object and control block.'),
    ('sync_input_vector', 'sync-process.asm', [0x2ebb79a, 0x2ebb7d1, 0x2ebb7d5,
                                              0x2ebb7df, 0x2ebb7e3, 0x2ebb7ed],
     'RCX supplies begin/end. Count uses (end-begin)>>4 then inverse-of-7 multiplication, consistent with 0x70-byte input elements.'),
    ('sync_intermediate_vector', 'sync-process.asm', [0x2ebb8a0, 0x2ebb8aa, 0x2ebb8b2,
                                                     0x2ebb8b8, 0x2ebb8bf, 0x2ebb96f],
     'Conversion RVA 0x2EBC830 fills a local vector; subsequent iteration advances 0x78 bytes. Do not reuse input stride.'),
    ('database_input_vector', 'sync-database.asm', [0x38e9fc6, 0x38e9fc9, 0x38e9fd3,
                                                  0x38ea27d, 0x38ea287, 0x38ea2b9, 0x38ea31d],
     'R8 supplies begin/end; main iteration advances 0x2E8 bytes. This is distinct from both sync vectors and the 0x798 native object.'),
]


def parse_asm(path):
    rows = {}
    # Objdump separates bytes and decoded instruction by tabs. Continuation rows
    # contain bytes only and are deliberately not used as instruction evidence.
    for line in path.read_text(encoding='utf-8').splitlines():
        match = re.match(r'^\s*([0-9a-fA-F]+):\s*\t([0-9a-fA-F ]+)\t(.+)$', line)
        if match:
            rows[int(match[1], 16)] = (bytes.fromhex(match[2]), match[3].strip())
    return rows


def main():
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise ValueError('Pinned DLL hash mismatch')
    results = []
    for name, filename, sites, observation in CLAIMS:
        rows = parse_asm(ROOT / filename)
        evidence = []
        for rva in sites:
            raw, instruction = rows[image.image_base + rva]
            if image.read_rva(rva, len(raw)) != raw:
                raise ValueError('Disassembly no longer matches at ' + hex(rva))
            evidence.append(dict(rva=hex(rva), bytes=raw.hex(' '), instruction=instruction))
        results.append(dict(name=name, observation=observation, source=filename,
                            status='static-only', evidence=evidence))
    assert (7 * 0x6db6db6db6db6db7) % (1 << 64) == 1
    output = ROOT / 'layout-evidence.json'
    output.write_text(json.dumps(dict(sha256=image.sha256, claims=results), indent=2), encoding='utf-8')
    print(json.dumps(dict(output=str(output), claims=len(results),
                          verified_instruction_fragments=sum(len(r['evidence']) for r in results))))


if __name__ == '__main__':
    main()
