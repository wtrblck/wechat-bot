"""Read-only PE analysis of an installed Weixin DLL; never loads the DLL."""
import argparse
import bisect
import hashlib
import json
import re
import struct
from pathlib import Path


def analyze(path):
    data = path.read_bytes()
    u16 = lambda p: struct.unpack_from('<H', data, p)[0]
    u32 = lambda p: struct.unpack_from('<I', data, p)[0]
    pe = u32(0x3c)
    if data[:2] != b'MZ' or data[pe:pe+4] != b'PE\0\0':
        raise ValueError('Not a PE image')
    opt = pe + 24
    if u16(opt) != 0x20b:
        raise ValueError('Expected PE32+')
    base = struct.unpack_from('<Q', data, opt+24)[0]
    sections = []
    for i in range(u16(pe+6)):
        p = opt + u16(pe+20) + i*40
        sections.append(dict(name=data[p:p+8].rstrip(b'\0').decode(),
            virtual_size=u32(p+8), rva=u32(p+12), size=u32(p+16),
            raw=u32(p+20), flags=u32(p+36)))

    def file_to_rva(offset):
        for s in sections:
            if s['raw'] <= offset < s['raw']+s['size']:
                return s['rva']+offset-s['raw']
        return None

    def rva_to_file(rva):
        for s in sections:
            if s['rva'] <= rva < s['rva']+s['size']:
                return s['raw']+rva-s['rva']
        return None

    pdata = next(s for s in sections if s['name'] == '.pdata')
    funcs = [struct.unpack_from('<III', data, p) for p in
        range(pdata['raw'], pdata['raw']+pdata['virtual_size']-11, 12)]
    funcs.sort()
    starts = [f[0] for f in funcs]

    def owner(rva):
        n = bisect.bisect_right(starts, rva)-1
        if n >= 0 and funcs[n][0] <= rva < funcs[n][1]:
            return {'begin': hex(funcs[n][0]), 'end': hex(funcs[n][1])}
        return None

    keywords = re.compile(rb'sendtext|sendmsg|sendmessage|onsync|onnewmsg|recvmsg|receivemsg|addmsg|addmessage|process msg count|newmsg|messageadded|send_text|send_msg|message.?manager|message.?service|sync.?message|on.?message|receive.?message', re.I)
    anchors = []
    for m in re.finditer(rb'[\x20-\x7e]{7,400}', data):
        value = m.group()
        if keywords.search(value) and any(s['raw'] <= m.start() < s['raw']+s['size'] and not s['flags'] & 0x20000000 for s in sections):
            anchors.append(dict(text=value.decode(), file=hex(m.start()),
                rva=hex(file_to_rva(m.start()) or 0), refs=[]))
    targets = {int(a['rva'],16): a for a in anchors}
    # Candidate RIP-relative LEA/MOV references. Byte matching is heuristic;
    # relevant matches must be verified with an instruction decoder.
    for s in sections:
        if not s['flags'] & 0x20000000:
            continue
        code = data[s['raw']:s['raw']+s['size']]
        pattern = rb'(?=((?:[\x48-\x4f][\x8d\x8b]|\x0f[\x10\x28\x6f])[\x05\x0d\x15\x1d\x25\x2d\x35\x3d].{4}))'
        for m in re.finditer(pattern, code, re.S):
            rva = s['rva']+m.start()
            dest = rva+7+struct.unpack_from('<i',m.group(1),3)[0]
            if dest in targets:
                targets[dest]['refs'].append(dict(rva=hex(rva), function=owner(rva)))
    for anchor in anchors:
        pointer = struct.pack('<Q',base+int(anchor['rva'],16))
        anchor['pointer_refs'] = []
        pos = data.find(pointer)
        while pos >= 0:
            anchor['pointer_refs'].append(hex(file_to_rva(pos) or 0))
            pos = data.find(pointer,pos+1)
    old = {}
    for name, rva in {'send_message':0x1677A30,'text_constructor':0x6B2C30,'create_param2':0xDF40}.items():
        p = rva_to_file(rva)
        old[name] = dict(reference_version='4.1.10.27', rva=hex(rva),
            current_bytes=data[p:p+24].hex(' ') if p is not None else None,
            current_function=owner(rva), valid_for_current_version=False)
    return dict(file=str(path), size=len(data), sha256=hashlib.sha256(data).hexdigest(),
        machine=hex(u16(pe+4)), image_base=hex(base), sections=sections,
        runtime_function_count=len(funcs), string_anchors=anchors,
        old_offsets=old, status='Static candidates only; no runtime verification or sending performed.')


if __name__ == '__main__':
    p = argparse.ArgumentParser()
    p.add_argument('dll', type=Path)
    p.add_argument('--output', type=Path, required=True)
    args = p.parse_args()
    result = analyze(args.dll)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps({'output':str(args.output), 'sha256':result['sha256'],
        'functions':result['runtime_function_count'], 'anchors':len(result['string_anchors']),
        'anchors_with_refs':sum(bool(a['refs']) for a in result['string_anchors'])}, indent=2))
