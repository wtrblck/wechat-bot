"""One resident Frida session must run several native downloads."""
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

DIRECTORY = ROOT / 'runs' / 'fixture-download-worker'


def main():
    DIRECTORY.mkdir(parents=True, exist_ok=True)
    executable = ROOT / 'tests' / 'build' / 'download-worker-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests' / 'download_async_fixture.c'),
                    '-o', str(executable)], check=True)
    image = PEImage(executable)
    observation = DIRECTORY / 'observation.jsonl'
    observation.unlink(missing_ok=True)
    process = subprocess.Popen([str(executable), str(observation), '250', '0'],
                               stdout=subprocess.PIPE, text=True)
    watchdog = threading.Timer(60, process.terminate)
    watchdog.start()
    results = []
    try:
        offsets = json.loads(process.stdout.readline())
        offsets.update(json.loads(process.stdout.readline()))
        result_vtable = offsets.pop('result_vtable')
        function_names = ('context', 'core', 'manager', 'query', 'copy', 'download',
                          'conversation', 'thread_checkpoint')
        functions = [dict(name=name, rva=offsets[name],
                          bytes=list(image.read_rva(offsets[name], 24)))
                     for name in function_names]
        policy = SendPolicy(recipients=('filehelper',))
        config = dict(module_name=image.path.name, process_name=image.path.name,
                      module_path=str(image.path), sha256=image.sha256,
                      image_size=image.image_size, seconds=5, sites=[],
                      callback_backend='native', resident=True, quiet=True,
                      active_experiment=dict(kind='context', backend='download_worker',
                          recipient='filehelper', recipient_bytes=[ord(c) for c in 'filehelper'],
                          text=None, text_bytes=[], limits=policy.describe(),
                          helper_source=(ROOT / 'active_send.c').read_text(encoding='utf-8'),
                          thread_source=(ROOT / 'download_worker.c').read_text(encoding='utf-8'),
                          functions=functions, result_vtable=result_vtable,
                          download_timeout_ms=5000))
        journal = Journal(DIRECTORY)
        session = WorkerSession(process.pid, config, journal=journal)
        session.call('start_worker')
        base = dict(conversation_bytes=[ord(c) for c in 'contact'],
                    local_id=133, create_time=1793209904,
                    server_id='9007199254740993', local_type=3, media_kind=2, timeout_ms=5000)
        for identifier in (133, 134):
            payload = dict(base, local_id=identifier)
            result = session.call('dispatch_download', payload)
            assert result['download_status'] == 'native_completed', result
            results.append(dict(local_id=identifier, status='native_completed'))
        mismatch = session.call('dispatch_download',
                                dict(base, server_id='9007199254740994', timeout_ms=5000))
        assert mismatch['download_status'] == 'request_failed', mismatch
        results.append(dict(server_id='9007199254740994', status='request_failed'))
        assert session.call('worker_status')['started'] is True
        assert session.close('stop_worker') is True
        assert process.poll() is None
        lines = [json.loads(line) for line in observation.read_text(encoding='utf-8').splitlines() if line]
        assert sum(1 for line in lines if line.get('message_download')) == 2, lines
        results.append(dict(jobs_in_one_session=3, session_closed=True, process_alive=True))
    finally:
        watchdog.cancel()
        if process.poll() is None:
            process.terminate()
            process.wait(timeout=5)
    (DIRECTORY / 'results.json').write_text(json.dumps(results, indent=2), encoding='utf-8')
    print(json.dumps(dict(passed=True, results=len(results), path=str(DIRECTORY / 'results.json'))))


if __name__ == '__main__':
    main()
