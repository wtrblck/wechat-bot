"""Real Frida regression on our own compiled process; never touches Weixin."""
import copy
import ctypes
import argparse
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pe_image import PEImage
from probe import Journal, run_probe


def read_code(pid, address, size):
    from ctypes import wintypes
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    kernel.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
    kernel.OpenProcess.restype = wintypes.HANDLE
    kernel.ReadProcessMemory.argtypes = [wintypes.HANDLE, ctypes.c_void_p, ctypes.c_void_p,
                                         ctypes.c_size_t, ctypes.POINTER(ctypes.c_size_t)]
    kernel.ReadProcessMemory.restype = wintypes.BOOL
    kernel.CloseHandle.argtypes = [wintypes.HANDLE]
    handle = kernel.OpenProcess(0x0010, False, pid)
    if not handle:
        raise ctypes.WinError(ctypes.get_last_error())
    try:
        buffer = ctypes.create_string_buffer(size)
        read = ctypes.c_size_t()
        if not kernel.ReadProcessMemory(handle, address, buffer, size, ctypes.byref(read)):
            raise ctypes.WinError(ctypes.get_last_error())
        assert read.value == size
        return buffer.raw
    finally:
        kernel.CloseHandle(handle)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--case', help='Run one named fixture case instead of the full suite')
    args = parser.parse_args()
    output = ROOT / 'tests' / 'build'
    output.mkdir(parents=True, exist_ok=True)
    executable = output / 'probe-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests' / 'fixture.c'),
                    '-o', str(executable)], check=True, timeout=30)
    image = PEImage(executable)
    results = []
    variants = {'capture-custom-target': 'nonhelper', 'capture-any-prefix': 'nonmarker',
                'capture-burst': 'burst', 'capture-wildcard': 'nonhelper',
                'capture-contains': 'group', 'capture-group-prefix-miss': 'group'}
    limits = {'early-exit': '150', 'capture-burst': '200'}
    for mode in ('baseline', 'single-site', 'native-single-site', 'capture-test', 'capture-send',
                 'capture-nonmarker', 'capture-nonhelper', 'capture-invalidpointer',
                 'capture-custom-target', 'capture-any-prefix', 'capture-wildcard',
                 'capture-contains', 'capture-group-prefix-miss', 'capture-burst',
                 'bad-fingerprint', 'early-exit', 'bad-host-hash'):
        if args.case and mode != args.case:
            continue
        variant = variants.get(mode) or (mode[len('capture-'):] if mode.startswith('capture-') else 'test')
        limit = limits.get(mode, '2000')
        with subprocess.Popen([str(executable), limit, variant],
                              stdout=subprocess.PIPE, text=True) as process:
            try:
                rva, base = map(int, process.stdout.readline().split())
                site = dict(name='fixture', rva=rva, bytes=list(image.read_rva(rva, 32)))
                config = dict(module_name=executable.name, process_name=executable.name,
                              module_path=str(executable.resolve()), sha256=image.sha256,
                              image_size=image.image_size, seconds=3,
                              sites=[] if mode == 'baseline' else [site])
                config['callback_backend'] = 'native' if mode == 'native-single-site' or mode.startswith('capture-') else 'js'
                config['capture_test'] = mode.startswith('capture-')
                config['capture_kind'] = 'send' if mode == 'capture-send' else 'receive'
                if mode == 'capture-custom-target':
                    config['capture_filter'] = dict(targets=['other-user'], prefix='wxbot-')
                elif mode == 'capture-any-prefix':
                    config['capture_filter'] = dict(targets=['filehelper'], prefix='')
                elif mode == 'capture-wildcard':
                    config['capture_filter'] = dict(targets=['*'], prefix='wxbot-')
                elif mode == 'capture-contains':
                    config['capture_filter'] = dict(targets=['filehelper'], prefix='wxbot-', mode='contains')
                if mode == 'bad-fingerprint':
                    config['sites'][0]['bytes'][0] ^= 0xff
                if mode == 'bad-host-hash':
                    config['sha256'] = '0' * 64
                journal = Journal(ROOT / 'runs' / 'fixture')
                code = run_probe(process.pid, copy.deepcopy(config), journal)
                events = journal.events
                expected_code = 0 if mode in ('baseline', 'single-site', 'native-single-site') or mode.startswith('capture-') else 1
                assert code == expected_code, (mode, code)
                if mode in ('single-site', 'native-single-site', 'capture-test', 'capture-burst'):
                    final = next(e for e in events if e['event'] == 'finished')
                    assert final['counts']['fixture'] > 0, final
                    assert process.poll() is None, 'Fixture should survive cleanup'
                    assert read_code(process.pid, base + rva, 32) == image.read_rva(rva, 32), 'Hook bytes not restored'
                if mode in ('capture-test', 'capture-send'):
                    message = next(e for e in events if e['event'] == 'test_message')
                    assert message['content'] == 'wxbot-fixture-1028', message
                    assert message['recipient'] == 'filehelper', message
                    assert message['message_id'] == ('0' if mode == 'capture-send' else '123456789012345'), message
                    assert message['message_type'] == 1, message
                if mode in ('capture-nonmarker', 'capture-nonhelper', 'capture-invalidpointer'):
                    assert not any(e['event'] == 'test_message' for e in events), mode
                    assert process.poll() is None, mode
                    if mode != 'capture-invalidpointer':
                        final = next(e for e in events if e['event'] == 'finished')
                        assert final['capture']['filtered'] > 0, final
                if mode == 'capture-burst':
                    final = next(e for e in events if e['event'] == 'finished')
                    capture = final['capture']
                    messages = [e for e in events if e['event'] == 'test_message']
                    assert capture['received'] == 200, capture
                    assert capture['delivered'] + capture['skipped'] + capture['invalid'] == capture['received'], capture
                    assert capture['invalid'] == 0, capture
                    assert capture['delivered'] == len(messages), (capture, len(messages))
                    assert capture['skipped'] >= capture['received'] - 64, capture
                    assert capture['delivered'] > 0, capture
                    assert all(m['content'] == 'wxbot-fixture-1028' for m in messages), messages[:2]
                    assert len({m['ring_index'] for m in messages}) == len(messages), 'ring index must be unique'
                if mode == 'capture-contains':
                    message = next(e for e in events if e['event'] == 'test_message')
                    assert message['content'] == 'wxid_fixture_sender:\nwxbot-fixture-1028', message
                    final = next(e for e in events if e['event'] == 'finished')
                    assert final['capture']['delivered'] > 0, final
                if mode == 'capture-group-prefix-miss':
                    assert not any(e['event'] == 'test_message' for e in events), mode
                    final = next(e for e in events if e['event'] == 'finished')
                    assert final['capture']['filtered'] > 0, final
                if mode in ('capture-custom-target', 'capture-any-prefix', 'capture-wildcard'):
                    message = next(e for e in events if e['event'] == 'test_message')
                    final = next(e for e in events if e['event'] == 'finished')
                    consumed = final['capture']['delivered'] + final['capture']['skipped'] + final['capture']['invalid']
                    assert final['capture']['received'] > 16, final
                    assert consumed <= final['capture']['received'], final
                    assert final['capture']['delivered'] > 0, final
                    if mode == 'capture-custom-target':
                        assert message['recipient'] == 'other-user', message
                        assert message['content'] == 'wxbot-fixture-1028', message
                    elif mode == 'capture-wildcard':
                        assert message['recipient'] == 'other-user', message
                        assert message['content'] == 'wxbot-fixture-1028', message
                    else:
                        assert message['content'] == 'ordinary-fixture-text', message
                if mode in ('bad-fingerprint', 'bad-host-hash'):
                    assert not any(e['event'] == 'started' for e in events)
                    assert process.poll() is None
                if mode == 'early-exit':
                    assert any(e['event'] == 'session_detached' and not e['expected'] for e in events)
                    assert not any(e['event'] == 'cleanup_error' for e in events)
                results.append(dict(case=mode, passed=True, journal=str(journal.path)))
            finally:
                if process.poll() is None:
                    process.terminate()
                    process.wait(timeout=10)
    if not results:
        raise ValueError('Unknown fixture case')
    report = ROOT / 'runs' / 'fixture' / ('case-results.json' if args.case else 'integration-results.json')
    report.write_text(json.dumps(results, indent=2), encoding='utf-8')
    print(json.dumps(dict(passed=len(results), report=str(report))))


if __name__ == '__main__':
    main()
