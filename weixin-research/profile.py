"""Offsets are valid only for the pinned binary, never an arbitrary report."""
from pathlib import Path

import version_profile
from pe_image import PEImage

ROOT = Path(__file__).resolve().parent
PROFILE = version_profile.load()
DLL = Path(PROFILE['dll'])
SHA256 = PROFILE['sha256']
VERSION = PROFILE['version']
SITES = dict(PROFILE['sites'])
SEND_FUNCTIONS = dict(PROFILE['send'])
DOWNLOAD_FUNCTIONS = dict(PROFILE['download'])
EMOJI_VTABLE = PROFILE['emoji']['control_vtable']
LOCAL_EMOJI_CONTROL = PROFILE['emoji'].get('local_control_vtable')
LOCAL_EMOJI_RESOURCE = PROFILE['emoji'].get('local_resource_vtable')
DOWNLOAD_RESULT_VTABLE = PROFILE['download_result_vtable']


def make_config(site=None, seconds=10, dll=DLL, resident=False, quiet=False):
    if not resident and not 1 <= seconds <= 60:
        raise ValueError('Duration must be between 1 and 60 seconds')
    if resident and not 1 <= seconds <= 86400:
        raise ValueError('Resident duration must be between 1 and 86400 seconds')
    if site is not None and site not in SITES:
        raise ValueError('Unknown observation site')
    image = PEImage(dll)
    if image.sha256 != SHA256:
        raise ValueError('DLL does not match pinned %s SHA256' % VERSION)
    sites = []
    if site:
        rva = SITES[site]
        owner = image.owner(rva)
        if not owner or owner['begin'] != rva:
            raise ValueError('Observation site is not a runtime function entry')
        if not image.section_at(rva, 32)['flags'] & 0x20000000:
            raise ValueError('Observation site is not executable')
        sites.append(dict(name=site, rva=rva, bytes=list(image.read_rva(rva, 32))))
    return dict(module_name=PROFILE['module'], process_name=PROFILE['process'],
                module_path=str(image.path), sha256=image.sha256,
                image_size=image.image_size, seconds=seconds, sites=sites,
                resident=bool(resident), quiet=bool(quiet), version=VERSION)
