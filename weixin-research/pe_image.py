"""Bounds-checked PE reader; never loads executable code."""
import bisect
import hashlib
import struct
from pathlib import Path


class PEImage:
    def __init__(self, path):
        self.path = Path(path).resolve()
        self.data = self.path.read_bytes()
        self.sha256 = hashlib.sha256(self.data).hexdigest()
        if self.data[:2] != b'MZ':
            raise ValueError('Not a PE image')
        pe = self.unpack('<I', 0x3c)[0]
        if self.slice(pe, 4) != b'PE\0\0':
            raise ValueError('Invalid PE signature')
        machine, count = self.unpack('<HH', pe + 4)
        opt_size = self.unpack('<H', pe + 20)[0]
        opt = pe + 24
        self.slice(opt, opt_size)
        if machine != 0x8664 or opt_size < 112 or self.unpack('<H', opt)[0] != 0x20b:
            raise ValueError('Expected x64 PE32+')
        self.image_base = self.unpack('<Q', opt + 24)[0]
        self.image_size = self.unpack('<I', opt + 56)[0]
        self.sections = []
        for i in range(count):
            p = opt + opt_size + i * 40
            header = self.slice(p, 40)
            virtual_size, rva, size, raw = self.unpack('<IIII', p + 8)
            self.slice(raw, size)
            self.sections.append(dict(name=header[:8].rstrip(b'\0').decode('ascii'),
                                      rva=rva, virtual_size=virtual_size, size=size,
                                      raw=raw, flags=self.unpack('<I', p + 36)[0]))
        self.functions = []
        if self.unpack('<I', opt + 108)[0] > 3 and opt_size >= 144:
            rva, size = self.unpack('<II', opt + 112 + 3 * 8)
            if rva and size:
                if size % 12:
                    raise ValueError('Invalid exception directory size')
                self.functions = sorted(struct.iter_unpack('<III', self.read_rva(rva, size)))
        self.starts = [f[0] for f in self.functions]

    def slice(self, offset, size):
        if offset < 0 or size < 0 or offset + size > len(self.data):
            raise ValueError('PE read outside file')
        return self.data[offset:offset + size]

    def unpack(self, fmt, offset):
        return struct.unpack(fmt, self.slice(offset, struct.calcsize(fmt)))

    def section_at(self, rva, size=1):
        for section in self.sections:
            if section['rva'] <= rva and rva + size <= section['rva'] + section['size']:
                return section
        raise ValueError('RVA is not backed by file bytes: ' + hex(rva))

    def read_rva(self, rva, size):
        section = self.section_at(rva, size)
        return self.slice(section['raw'] + rva - section['rva'], size)

    def owner(self, rva):
        index = bisect.bisect_right(self.starts, rva) - 1
        if index >= 0:
            begin, end, unwind = self.functions[index]
            if begin <= rva < end:
                return dict(begin=begin, end=end, unwind=unwind)
        return None
