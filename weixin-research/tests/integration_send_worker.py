"""One resident Frida session must send several jobs without re-attaching."""
import json
import subprocess
import sys
import threading
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pe_image import PEImage
from policy import SendPolicy
from probe import Journal
from worker_session import WorkerSession

DIRECTORY = ROOT / 'runs' / 'fixture-send-worker'


def main():
    DIRECTORY.mkdir(parents=True, exist_ok=True)
    executable = ROOT / 'tests' / 'build' / 'active-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests' / 'active_fixture.c'),
                    '-o', str(executable)], check=True)
    image = PEImage(executable)
    observed = DIRECTORY / 'observation.jsonl'
    observed.unlink(missing_ok=True)
    process = subprocess.Popen([str(executable), str(observed)], stdout=subprocess.PIPE, text=True)
    watchdog = threading.Timer(60, process.terminate)
    watchdog.start()
    results = []
    try:
        offsets = json.loads(process.stdout.readline())
        functions = []
        for name, rva in offsets.items():
            functions.append(dict(name=name, rva=rva, bytes=list(image.read_rva(rva, 24))))
        # Emoji symbols are compiled into the resident worker; this fixture has no
        # emoji objects, so bind them to harmless existing exports and never use them.
        for name in ('emoji_factory', 'emoji_construct', 'emoji_new'):
            functions.append(dict(name=name, rva=offsets['text_factory'],
                                  bytes=list(image.read_rva(offsets['text_factory'], 24))))
        policy = SendPolicy(recipients=('filehelper',))
        config = dict(module_name=image.path.name, process_name=image.path.name,
                      module_path=str(image.path), sha256=image.sha256,
                      image_size=image.image_size, seconds=5, sites=[],
                      callback_backend='native', resident=True, quiet=True,
                      active_experiment=dict(kind='template', backend='send_worker',
                          recipient='filehelper', recipient_bytes=[ord(c) for c in 'filehelper'],
                          text=None, text_bytes=[], limits=policy.describe(),
                          helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                          thread_source='#define ENABLE_EMOJI 1\n' +
                                        (ROOT / 'app_thread_send.c').read_text(encoding='utf-8'),
                          on_app_thread=True, functions=functions,
                          emoji_control_vtable=0, data_fingerprints=[]))
        journal = Journal(DIRECTORY)
        session = WorkerSession(process.pid, config, journal=journal)
        session.call('start_worker')
        for kind, text in [('text', 'worker-one'), ('text', 'x' * 40),
                           ('text', 'wxbot-中文\n第二行'), ('text', 'worker-long-' + 'y' * 2000)]:
            payload = dict(kind=kind, recipient_bytes=[ord(c) for c in 'filehelper'],
                           text_bytes=list(text.encode('utf-8')), timeout_ms=5000)
            result = session.call('dispatch_job', payload)
            assert result['accepted'], (kind, text, result, journal.events[-3:])
            results.append(dict(kind=kind, bytes=len(text.encode('utf-8')), accepted=True))
        for kind in ('image', 'file', 'video'):
            payload = dict(kind=kind, recipient_bytes=[ord(c) for c in 'filehelper'],
                           path='E:/fixtures/wxbot-test.png', timeout_ms=5000)
            result = session.call('dispatch_job', payload)
            assert result['accepted'], (kind, result, journal.events[-3:])
            results.append(dict(kind=kind, accepted=True))
        voice = (ROOT / 'fixtures' / 'wxbot-voice.silk').read_bytes()
        payload = dict(kind='voice', recipient_bytes=[ord(c) for c in 'filehelper'],
                       voice_bytes=list(voice), duration_ms=1000, timeout_ms=5000)
        result = session.call('dispatch_job', payload)
        assert result['accepted'], (result, journal.events[-3:])
        results.append(dict(kind='voice', duration_ms=1000, accepted=True))
        lines = [json.loads(line) for line in observed.read_text(encoding='utf-8').splitlines() if line]
        assert len([line for line in lines if line.get('called')]) == 8, lines
        assert session.call('worker_status')['started'] is True
        assert session.close('stop_worker') is True
        assert process.poll() is None
        results.append(dict(jobs_in_one_session=8, session_closed=True, process_alive=True))
    finally:
        watchdog.cancel()
        if process.poll() is None:
            process.terminate()
            process.wait(timeout=5)
    (DIRECTORY / 'results.json').write_text(json.dumps(results, indent=2), encoding='utf-8')
    print(json.dumps(dict(passed=True, results=len(results), path=str(DIRECTORY / 'results.json'))))


if __name__ == '__main__':
    main()
