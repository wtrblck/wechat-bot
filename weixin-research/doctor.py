"""Read-only readiness checks: disk fingerprint and optional OS module inventory.

Does not load Frida, attach a runtime, install hooks, or read message objects.
"""
import argparse
import ctypes
import json
import sys
from ctypes import wintypes
from pathlib import Path

from probe import process_path
from profile import DLL, SHA256, SITES
from pe_image import PEImage


def loaded_module_paths(pid):
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    psapi = ctypes.WinDLL('psapi', use_last_error=True)
    kernel.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
    kernel.OpenProcess.restype = wintypes.HANDLE
    kernel.CloseHandle.argtypes = [wintypes.HANDLE]
    kernel.CloseHandle.restype = wintypes.BOOL
    psapi.EnumProcessModulesEx.argtypes = [wintypes.HANDLE, ctypes.POINTER(wintypes.HMODULE),
                                          wintypes.DWORD, ctypes.POINTER(wintypes.DWORD), wintypes.DWORD]
    psapi.EnumProcessModulesEx.restype = wintypes.BOOL
    psapi.GetModuleFileNameExW.argtypes = [wintypes.HANDLE, wintypes.HMODULE,
                                         wintypes.LPWSTR, wintypes.DWORD]
    psapi.GetModuleFileNameExW.restype = wintypes.DWORD
    handle = kernel.OpenProcess(0x0400 | 0x0010, False, pid)
    if not handle:
        raise ctypes.WinError(ctypes.get_last_error())
    try:
        count = 256
        for attempt in range(4):
            modules = (wintypes.HMODULE * count)()
            needed = wintypes.DWORD()
            if not psapi.EnumProcessModulesEx(handle, modules, ctypes.sizeof(modules), ctypes.byref(needed), 3):
                raise ctypes.WinError(ctypes.get_last_error())
            if needed.value <= ctypes.sizeof(modules):
                paths = []
                for module in modules[:needed.value // ctypes.sizeof(wintypes.HMODULE)]:
                    buffer = ctypes.create_unicode_buffer(32768)
                    if not psapi.GetModuleFileNameExW(handle, module, buffer, len(buffer)):
                        raise ctypes.WinError(ctypes.get_last_error())
                    paths.append(Path(buffer.value))
                return paths
            count = needed.value // ctypes.sizeof(wintypes.HMODULE) + 32
        raise RuntimeError('Module inventory kept changing; retry when process is idle')
    finally:
        kernel.CloseHandle(handle)


def check(pid=None):
    result = dict(send_ready=False, receive_ready=False, runtime_verified=False,
                  observation_ready=False, scope='read-only-preflight', checks=[])
    try:
        image = PEImage(DLL)
        if image.sha256 != SHA256:
            raise ValueError('Installed DLL fingerprint changed')
        sites = []
        for name, rva in SITES.items():
            owner = image.owner(rva)
            if not owner or owner['begin'] != rva or not image.section_at(rva, 32)['flags'] & 0x20000000:
                raise ValueError('Invalid candidate function entry: ' + name)
            sites.append(dict(name=name, rva=hex(rva), end=hex(owner['end']),
                              entry_bytes=image.read_rva(rva, 32).hex(' ')))
        result['checks'].append(dict(name='disk_profile', ok=True, sha256=image.sha256,
                                     dll=str(image.path), sites=sites))
    except (OSError, ValueError) as error:
        result['checks'].append(dict(name='disk_profile', ok=False, detail=str(error)))
        return result
    if pid is not None:
        try:
            executable = process_path(pid)
            if executable.name.lower() != 'weixin.exe':
                raise ValueError('PID is not Weixin.exe')
            modules = loaded_module_paths(pid)
            matches = [p for p in modules if p.name.lower() == 'weixin.dll']
            if len(matches) != 1 or matches[0].resolve() != DLL.resolve():
                raise ValueError('PID does not load the pinned Weixin.dll path')
            result['checks'].append(dict(name='process_modules', ok=True, pid=pid,
                                         executable=str(executable), dll=str(matches[0])))
            result['observation_ready'] = True
        except (OSError, ValueError, RuntimeError) as error:
            result['checks'].append(dict(name='process_modules', ok=False, pid=pid, detail=str(error)))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int)
    args = parser.parse_args()
    if args.pid is not None and args.pid <= 0:
        parser.error('--pid must be positive')
    result = check(args.pid)
    print(json.dumps(result, ensure_ascii=False, indent=2))
    return 0 if all(c['ok'] for c in result['checks']) else 1


if __name__ == '__main__':
    sys.exit(main())
