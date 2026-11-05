"""Static call-site alignment to extend candidate mapping; results are not executable profiles."""
import collections
import difflib
import json
import re
import sys
from pathlib import Path
from map_version_static import ROOT, OUT, NEW_DLL, archived_bytes
from pe_image import PEImage
import capstone


def main():
    oldbytes = archived_bytes()
    image = PEImage(NEW_DLL)
    cs = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    cs.detail = True
    seeds = json.loads((OUT / 'static-mapping.json').read_text())
    if (OUT / 'extra-static.json').exists():
        seeds['results'].extend(json.loads((OUT / 'extra-static.json').read_text())['results'])
    mapped = {int(r['old'], 16): int(r['candidates'][0]['rva'], 16) for r in seeds['results']
              if r['candidates'] and r['candidates'][0]['score'] > 80 and
              (len(r['candidates']) == 1 or r['candidates'][0]['score'] > r['candidates'][1]['score'] * 3)}
    evidence = collections.defaultdict(list)

    def decode_old(rva):
        data = bytearray()
        for address in range(0x180000000 + rva, 0x180000000 + rva + 20000):
            if address not in oldbytes:
                break
            data.append(oldbytes[address])
        result = []
        for ins in cs.disasm(bytes(data), rva):
            result.append(ins)
            if ins.mnemonic == 'ret':
                break
        return result

    def decode_new(rva):
        owner = image.owner(rva)
        size = owner['end'] - rva if owner and owner['begin'] == rva else 512
        result = []
        for ins in cs.disasm(image.read_rva(rva, size), rva):
            result.append(ins)
            if ins.mnemonic == 'ret':
                break
        return result

    def token(ins):
        if ins.group(capstone.CS_GRP_JUMP) or ins.group(capstone.CS_GRP_CALL):
            return ins.mnemonic + (' <relative>' if ins.imm_size else ' ' + ins.op_str)
        text = re.sub(r'\[rip [+-] 0x[0-9a-f]+\]', '[rip relative]', ins.op_str)
        return ins.mnemonic + ' ' + text

    visited = set()
    for round in range(4):
        additions = {}
        for old, new in list(mapped.items()):
            if old in visited:
                continue
            visited.add(old)
            left, right = decode_old(old), decode_new(new)
            if len(left) < 5 or len(right) < 5:
                continue
            alignment = difflib.SequenceMatcher(None, [token(i) for i in left], [token(i) for i in right], autojunk=False)
            for block in alignment.get_matching_blocks():
                if block.size < 4:
                    continue
                for a, b in zip(left[block.a:block.a + block.size], right[block.b:block.b + block.size]):
                    if a.mnemonic != 'call' or not a.imm_size or not b.imm_size:
                        continue
                    old_target, new_target = a.operands[0].imm, b.operands[0].imm
                    if 0 <= old_target < 0x10000000 and 0 <= new_target < image.image_size:
                        evidence[old_target].append(dict(new=hex(new_target), old_caller=hex(old), new_caller=hex(new),
                          old_site=hex(a.address), new_site=hex(b.address), matching_block=block.size))
        for old, facts in evidence.items():
            counts = collections.Counter(int(f['new'], 16) for f in facts)
            if old not in mapped and len(counts) == 1:
                candidate = next(iter(counts))
                if max(f['matching_block'] for f in facts) >= 7:
                    additions[old] = candidate
        mapped.update(additions)
        print(json.dumps(dict(round=round, mapped=len(mapped), added=len(additions))), flush=True)
        if not additions:
            break
    targets = json.loads((ROOT / 'versions/4.1.15.56.json').read_text())
    for section in ('send', 'download'):
        for key, value in targets[section].items():
            old = int(value, 0)
            print(json.dumps(dict(name=section + '.' + key, old=value, new=hex(mapped[old]) if old in mapped else None,
                                 evidence=evidence.get(old, []))), flush=True)
    (OUT / 'call-mapping.json').write_text(json.dumps(dict(mapping={hex(k): hex(v) for k, v in mapped.items()},
        evidence={hex(k): v for k, v in evidence.items()}, status='Static candidates only, independently verify structure and ownership.'), indent=2))


if __name__ == '__main__':
    main()
