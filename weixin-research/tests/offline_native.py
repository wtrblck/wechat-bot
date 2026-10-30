"""Unit-test native manifest fixtures; never read or load an installed WeChat DLL."""
import struct
from unittest.mock import patch

from profile import SHA256, EMOJI_VTABLE


class PinnedImage:
    sha256 = SHA256
    image_base = 0x180000000
    image_size = 0x10000000

    def __init__(self, path=None):
        pass

    def owner(self, rva):
        return dict(begin=rva)

    def section_at(self, rva, size):
        return dict(flags=0x20000000)

    def read_rva(self, rva, size):
        if rva == EMOJI_VTABLE and size == 16:
            return struct.pack('<QQ', self.image_base + 0x1000, self.image_base + 0x2000)
        return b'\x90' * size


def manifest(**options):
    return dict(module_name='Weixin.dll', module_path='unit-fixture.dll',
                process_name='Weixin.exe', sha256=SHA256,
                image_size=PinnedImage.image_size, sites=[], **options)


def patch_sender(test):
    for target, replacement in [('active_send.make_config', manifest),
                                ('active_send.pinned_image', PinnedImage)]:
        guard = patch(target, replacement)
        guard.start()
        test.addCleanup(guard.stop)
