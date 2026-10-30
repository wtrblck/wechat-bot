"""Exercise actual Frida NativeFunction calls against our own ABI fixture.

Covers the shared narrow-string assignment that replaced the old inline-only
copy: 15/16 byte boundary, Chinese, non-BMP characters, multi-line text, long
text, longer recipients, and the five send kinds. The fixture reports the strings
it actually received, so the assertion is about the copied bytes, not intent.

The fixture writes its observation to a file: the host is blocked inside the
synchronous dispatch call while the job runs on the fixture thread, so a large
stdout line could deadlock on a full pipe.
"""
import json
import subprocess
import sys
import threading
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pe_image import PEImage
from policy import SendPolicy
from probe import Journal, run_probe

DIRECTORY = ROOT / 'runs' / 'fixture-active'
TEXT_CASES = [
    'wxbot-active',                     # 12 ASCII bytes, inline source
    'x' * 15,                           # inline capacity boundary
    'x' * 16,                           # first heap size
    'wxbot-中文中文中文',                # 3-byte UTF-8 sequences
    '😀 表情与中文\n第二行\t制表',        # non-BMP, newline, tab
    '长' * 700,                          # 2100 UTF-8 bytes
]
LONG_RECIPIENT = 'wxid_' + 'ab' * 22


def build_case(kind, text, recipient, offsets, image, send_policy):
    request = dict(kind=kind, recipient=recipient,
                   recipient_bytes=list(send_policy.encode_recipient(recipient)),
                   text=text if kind == 'text' else None,
                   text_bytes=list(send_policy.encode_text(text)) if kind == 'text' else [],
                   limits=send_policy.describe(),
                   helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                   thread_source=(ROOT / 'app_thread_send.c').read_text(encoding='utf-8'),
                   on_app_thread=True, path='E:/fixtures/wxbot-test.png')
    if kind == 'voice':
        request['voice_bytes'] = list((ROOT / 'fixtures' / 'wxbot-voice.silk').read_bytes())
        request['duration_ms'] = 1000
    request['functions'] = [dict(name=name, rva=rva, bytes=list(image.read_rva(rva, 24)))
                            for name, rva in offsets.items()]
    return dict(module_name=image.path.name, process_name=image.path.name,
                module_path=str(image.path), sha256=image.sha256, image_size=image.image_size,
                seconds=1, sites=[], callback_backend='native', active_experiment=request)


def expected_freed(kind, text, recipient):
    freed = 1 if len(recipient.encode('utf-8')) >= 16 else 0
    if kind == 'text' and len(text.encode('utf-8')) >= 16:
        freed += 1
    return freed


def run_case(executable, image, kind, text, recipient):
    DIRECTORY.mkdir(parents=True, exist_ok=True)
    send_policy = SendPolicy(recipients=tuple(dict.fromkeys(['filehelper', recipient])))
    observed_path = DIRECTORY / (uuid.uuid4().hex + '-observation.json')
    with subprocess.Popen([str(executable), str(observed_path)], stdout=subprocess.PIPE, text=True) as process:
        # A native job that never returns must fail the case, not hang the suite.
        watchdog = threading.Timer(60, process.terminate)
        watchdog.start()
        try:
            offsets = json.loads(process.stdout.readline())
            config = build_case(kind, text, recipient, offsets, image, send_policy)
            journal = Journal(DIRECTORY)
            code = run_probe(process.pid, config, journal)
            result = next((e for e in journal.events if e['event'] == 'active_send_result'), None)
            assert code == 0 and result and result['accepted'], (kind, text, journal.events)
            if kind != 'context':
                observed = json.loads(observed_path.read_text(encoding='utf-8'))
                expected_recipient = recipient.encode('utf-8')
                assert observed['called'] == kind and observed['valid'], observed
                assert bytes.fromhex(observed['recipient_hex']) == expected_recipient, observed
                assert observed['recipient_len'] == len(expected_recipient), observed
                assert result['detail'] == 'wxbot fixture owned result diagnostic'
                assert result['recipient'] == recipient and result['recipient_bytes'] == len(expected_recipient)
                if kind == 'text':
                    expected_text = text.encode('utf-8')
                    assert bytes.fromhex(observed['body_hex']) == expected_text, (text, observed)
                    assert observed['body_len'] == len(expected_text), observed
                    assert result['text_bytes'] == len(expected_text), result
            cleanup = json.loads(process.stdout.readline())
            assert cleanup == dict(cleanup=True, send_calls=0 if kind == 'context' else 1,
                                   freed_result_strings=0 if kind == 'context' else 1,
                                   freed_voice_payloads=1 if kind == 'voice' else 0,
                                   freed_narrow_strings=0 if kind == 'context' else expected_freed(kind, text, recipient)), cleanup
            assert process.poll() is None
            return dict(kind=kind, text_bytes=len((text or '').encode('utf-8')), recipient=recipient,
                        passed=True, journal=str(journal.path))
        finally:
            watchdog.cancel()
            if process.poll() is None:
                process.terminate(); process.wait(timeout=5)
            observed_path.unlink(missing_ok=True)


def main():
    output = ROOT / 'tests' / 'build'
    output.mkdir(parents=True, exist_ok=True)
    executable = output / 'active-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests' / 'active_fixture.c'),
                    '-o', str(executable)], check=True)
    image = PEImage(executable)
    results = []
    results.append(run_case(executable, image, 'context', None, 'filehelper'))
    for text in TEXT_CASES:
        results.append(run_case(executable, image, 'text', text, 'filehelper'))
    results.append(run_case(executable, image, 'text', 'wxbot-long-recipient', LONG_RECIPIENT))
    for kind in ('image', 'file', 'video'):
        results.append(run_case(executable, image, kind, None, 'filehelper'))
    results.append(run_case(executable, image, 'voice', None, 'filehelper'))
    results.append(run_case(executable, image, 'voice', None, LONG_RECIPIENT))
    path = DIRECTORY / 'results.json'
    path.write_text(json.dumps(results, indent=2, ensure_ascii=False), encoding='utf-8')
    print(json.dumps(dict(passed=len(results), result=str(path)), ensure_ascii=False))


if __name__ == '__main__':
    main()
