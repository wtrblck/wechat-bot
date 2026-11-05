"""Static-only candidate mapping from archived disassembly; never attach to or call WeChat."""
import collections
import json
import re
import struct
import sys
from pathlib import Path
from pe_image import PEImage

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / 'deps'))
import capstone
from capstone.x86 import X86_OP_MEM, X86_OP_IMM, X86_REG_RIP

NEW_DLL = Path('E:/Tencent/Weixin/4.2.0.13/Weixin.dll')
OUT = ROOT / 'runs/version-4.2.0.13'


def archived_bytes():
    memory = {}
    for path in ROOT.rglob('*.asm'):
        if OUT in path.parents:
            continue
        for line in path.read_text(encoding='utf-8', errors='replace').splitlines():
            m = re.match(r'^\s*([0-9a-fA-F]{9,16}):\s*\t([0-9a-fA-F ]+)\t?(.*)$', line)
            if not m:
                continue
            address, data = int(m[1], 16), bytes.fromhex(m[2])
            if not 0x180000000 <= address < 0x190000000:
                continue
            for offset, byte in enumerate(data):
                memory.setdefault(address + offset, byte)
    # Old live logs retain the exact guarded function prefixes even where full disassembly was not archived.
    for folder in ('active', 'animation-trial', 'emoji', 'bridge'):
        for path in (ROOT / 'runs' / folder).glob('*.json'):
            try:
                document = json.loads(path.read_text(encoding='utf-8'))
            except (ValueError, OSError):
                continue
            if not isinstance(document, dict):
                continue
            for event in document.get('events', []):
                config = event.get('config') or {}
                if config.get('sha256') != 'e0428a7b691853de496532523c2c09aa095f90941c37c9f4cfb3f137f3c66556':
                    continue
                for function in config.get('active_experiment', {}).get('functions', []):
                    for offset, byte in enumerate(function.get('bytes', [])):
                        memory.setdefault(0x180000000 + function['rva'] + offset, byte)
    return memory


def signature(instructions):
    pattern, concrete = [], 0
    for ins in instructions:
        data = bytearray(ins.bytes)
        mask = set()
        if any(op.type == X86_OP_MEM and op.mem.base == X86_REG_RIP for op in ins.operands):
            mask.update(range(ins.disp_offset, ins.disp_offset + ins.disp_size))
        if ins.group(capstone.CS_GRP_JUMP) or ins.group(capstone.CS_GRP_CALL):
            if ins.imm_size:
                mask.update(range(ins.imm_offset, ins.imm_offset + ins.imm_size))
        if any(op.type == X86_OP_IMM and 0x180000000 <= op.imm < 0x190000000 for op in ins.operands):
            mask.update(range(ins.imm_offset, ins.imm_offset + ins.imm_size))
        for i, byte in enumerate(data):
            if i in mask:
                pattern.append(b'.')
            else:
                pattern.append(re.escape(bytes([byte])))
                concrete += 1
    return b''.join(pattern), concrete


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    image = PEImage(NEW_DLL)
    old = json.loads((ROOT / 'versions/4.1.15.56.json').read_text())
    targets = {}
    for section in ('sites', 'send', 'download'):
        for key, value in old[section].items():
            targets.setdefault(int(value, 0), []).append(section + '.' + key)
    if '--extra' in sys.argv:
        targets = {address: ['extra.' + hex(address)] for address in (
          0x2c196b0, 0x55e9a40, 0x55ead40, 0x55ebf50, 0x22fde10, 0x22fd4c0, 0x22fc560, 0x22fc160, 0x55ed160)}
    memory = archived_bytes()
    cs = capstone.Cs(capstone.CS_ARCH_X86, capstone.CS_MODE_64)
    cs.detail = True
    code = [(s, image.data[s['raw']:s['raw'] + s['size']]) for s in image.sections if s['flags'] & 0x20000000]
    results = []
    for address, names in targets.items():
        start = 0x180000000 + address
        data = bytearray()
        for p in range(start, start + 1800):
            if p not in memory:
                break
            data.append(memory[p])
        instructions = []
        for ins in cs.disasm(bytes(data), start):
            instructions.append(ins)
            if ins.mnemonic == 'ret':
                break
        votes, details = collections.Counter(), collections.defaultdict(list)
        for offset in range(0, len(instructions), 5):
            chunk = []
            for ins in instructions[offset:]:
                chunk.append(ins)
                if sum(i.size for i in chunk) >= (36 if '--extra' in sys.argv else 56):
                    break
            size = sum(i.size for i in chunk)
            if size < 20:
                continue
            raw, concrete = signature(chunk)
            if concrete < 16:
                continue
            pattern = re.compile(raw, re.S)
            matches = []
            for section, payload in code:
                for match in pattern.finditer(payload):
                    rva = section['rva'] + match.start()
                    owner = image.owner(rva)
                    if owner:
                        matches.append((owner['begin'], rva))
                        if len(matches) > 100:
                            break
            if len(matches) > 100:
                continue
            for owner, rva in matches:
                votes[owner] += concrete / max(1, len(matches))
                details[owner].append(dict(old_offset=hex(chunk[0].address - start), new_match=hex(rva), bytes=size, unique=len(matches) == 1))
        candidates = []
        for candidate, score in votes.most_common(6):
            owner = image.owner(candidate)
            candidates.append(dict(rva=hex(candidate), score=round(score, 2), size=owner['end'] - owner['begin'], matches=details[candidate]))
        result = dict(names=names, old=hex(address), old_bytes=len(data), decoded=len(instructions), candidates=candidates)
        results.append(result)
        print(json.dumps({k: result[k] for k in ('names', 'old', 'old_bytes')} | {'candidates': [{k: c[k] for k in ('rva', 'score', 'size')} for c in candidates[:3]]}), flush=True)
    output = dict(dll=str(NEW_DLL), sha256=image.sha256, image_base=hex(image.image_base), functions=len(image.functions),
                  status='Unverified static candidates. No native ABI or runtime validation.', results=results)
    (OUT / ('extra-static.json' if '--extra' in sys.argv else 'static-mapping.json')).write_text(json.dumps(output, indent=2), encoding='utf-8')


if __name__ == '__main__':
    main()
