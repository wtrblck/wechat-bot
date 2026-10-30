"""Find the Weixin process that actually owns the pinned core module (P6).

Multiple Weixin.exe processes can exist; only the main one loads Weixin.dll.
The OS module list is queried instead of trusting enumeration order, matching the
existing read-only doctor checks.
"""
import ctypes
from ctypes import wintypes
from pathlib import Path

TH32CS_SNAPPROCESS = 0x00000002
PROCESS_QUERY_INFORMATION = 0x0400
PROCESS_VM_READ = 0x0010
SYNCHRONIZE = 0x00100000


class PROCESSENTRY32W(ctypes.Structure):
    _fields_ = [('dwSize', wintypes.DWORD), ('cntUsage', wintypes.DWORD),
                ('th32ProcessID', wintypes.DWORD), ('th32DefaultHeapID', ctypes.POINTER(wintypes.ULONG)),
                ('th32ModuleID', wintypes.DWORD), ('cntThreads', wintypes.DWORD),
                ('th32ParentProcessID', wintypes.DWORD), ('pcPriClassBase', ctypes.c_long),
                ('dwFlags', wintypes.DWORD), ('szExeFile', wintypes.WCHAR * 260)]


_kernel32 = ctypes.WinDLL('kernel32', use_last_error=True)
_psapi = ctypes.WinDLL('psapi', use_last_error=True)
_kernel32.CreateToolhelp32Snapshot.argtypes = [wintypes.DWORD, wintypes.DWORD]
_kernel32.CreateToolhelp32Snapshot.restype = wintypes.HANDLE
_kernel32.Process32FirstW.argtypes = [wintypes.HANDLE, ctypes.POINTER(PROCESSENTRY32W)]
_kernel32.Process32FirstW.restype = wintypes.BOOL
_kernel32.Process32NextW.argtypes = [wintypes.HANDLE, ctypes.POINTER(PROCESSENTRY32W)]
_kernel32.Process32NextW.restype = wintypes.BOOL
_kernel32.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
_kernel32.OpenProcess.restype = wintypes.HANDLE
_kernel32.CloseHandle.argtypes = [wintypes.HANDLE]
_kernel32.CloseHandle.restype = wintypes.BOOL
_kernel32.WaitForSingleObject.argtypes = [wintypes.HANDLE, wintypes.DWORD]
_kernel32.WaitForSingleObject.restype = wintypes.DWORD
_psapi.EnumProcessModules.argtypes = [wintypes.HANDLE, ctypes.POINTER(wintypes.HMODULE),
                                      wintypes.DWORD, ctypes.POINTER(wintypes.DWORD)]
_psapi.EnumProcessModules.restype = wintypes.BOOL
_psapi.GetModuleFileNameExW.argtypes = [wintypes.HANDLE, wintypes.HMODULE,
                                        wintypes.LPWSTR, wintypes.DWORD]
_psapi.GetModuleFileNameExW.restype = wintypes.DWORD


def process_ids(name='Weixin.exe'):
    snapshot = _kernel32.CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    if snapshot == wintypes.HANDLE(-1).value:
        raise ctypes.WinError(ctypes.get_last_error())
    entry = PROCESSENTRY32W()
    entry.dwSize = ctypes.sizeof(entry)
    result = []
    try:
        if not _kernel32.Process32FirstW(snapshot, ctypes.byref(entry)):
            return result
        while True:
            if entry.szExeFile.lower() == name.lower():
                result.append(int(entry.th32ProcessID))
            if not _kernel32.Process32NextW(snapshot, ctypes.byref(entry)):
                break
    finally:
        _kernel32.CloseHandle(snapshot)
    return result


def process_alive(pid):
    handle = _kernel32.OpenProcess(SYNCHRONIZE | PROCESS_QUERY_INFORMATION, False, int(pid))
    if not handle:
        return False
    try:
        return _kernel32.WaitForSingleObject(handle, 0) == 258
    finally:
        _kernel32.CloseHandle(handle)


def module_paths(pid):
    handle = _kernel32.OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, False, int(pid))
    if not handle:
        raise PermissionError('cannot query modules for pid %s' % pid)
    try:
        modules = (wintypes.HMODULE * 2048)()
        needed = wintypes.DWORD()
        if not _psapi.EnumProcessModules(handle, modules, ctypes.sizeof(modules), ctypes.byref(needed)):
            raise ctypes.WinError(ctypes.get_last_error())
        count = min(len(modules), int(needed.value) // ctypes.sizeof(wintypes.HMODULE))
        buffer = ctypes.create_unicode_buffer(32768)
        result = []
        for index in range(count):
            if _psapi.GetModuleFileNameExW(handle, modules[index], buffer, len(buffer)):
                result.append(str(buffer.value))
        return result
    finally:
        _kernel32.CloseHandle(handle)


def find_main_pid(dll_path, name='Weixin.exe'):
    """Return the single PID whose loaded module path equals the pinned DLL."""
    expected = str(Path(dll_path).resolve()).lower()
    matches, denied = [], []
    for pid in process_ids(name):
        try:
            paths = [str(Path(path).resolve()).lower() for path in module_paths(pid)]
        except (PermissionError, OSError) as error:
            denied.append((pid, str(error)))
            continue
        if expected in paths:
            matches.append(pid)
    if len(matches) > 1:
        raise RuntimeError('multiple Weixin processes load the pinned DLL: ' +
                           ','.join(map(str, matches)))
    if not matches:
        detail = '; '.join('%s:%s' % item for item in denied)
        raise LookupError('no Weixin process loads the pinned DLL' + ((' (' + detail + ')') if detail else ''))
    return matches[0]
