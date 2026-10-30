"""Pending native work must outlive our script without retaining its callbacks."""
import contextlib
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
import probe
from pe_image import PEImage
from policy import SendPolicy
from integration_active import build_case


def main():
    directory = ROOT / 'runs/fixture-download-async'
    directory.mkdir(parents=True, exist_ok=True)
    executable = ROOT / 'tests/build/download-async-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests/download_async_fixture.c'),
                    '-o', str(executable)], check=True)
    image = PEImage(executable)
    cases = []
    for delay, native_code, timeout, identifier, expected in [
        (250, 0, 1200, 9007199254740993, 'native_completed'),
        (250, 4, 1200, 9007199254740993, 'native_failed'),
        (1800, 0, 200, 9007199254740993, 'download_pending'),
        (250, 0, 1200, 9007199254740994, 'request_failed'),
    ]:
        observation = directory / 'observation.json'
        with subprocess.Popen([str(executable), str(observation), str(delay), str(native_code)],
                              stdout=subprocess.PIPE, text=True) as process:
            try:
                offsets = json.loads(process.stdout.readline())
                result_vtable = offsets.pop('result_vtable')
                offsets.update(json.loads(process.stdout.readline()))
                config = build_case('context', None, 'filehelper', offsets, image, SendPolicy())
                request = config['active_experiment']
                request.update(backend='download_async', result_vtable=result_vtable, download_timeout_ms=timeout)
                config['finish_after_dispatch'] = True
                request['thread_source'] = (
                    f'#define DOWNLOAD_SERVER_ID {identifier}ULL\n#define DOWNLOAD_LOCAL_ID 133\n'
                    '#define DOWNLOAD_CREATE_TIME 1793209904\n#define DOWNLOAD_MESSAGE_TYPE 3\n'
                    '#define DOWNLOAD_MEDIA_KIND 2\n#define DOWNLOAD_EXECUTE 1\n'
                    + (ROOT / 'download_async.c').read_text(encoding='utf-8'))
                with (directory / 'output.log').open('a', encoding='utf-8') as log, contextlib.redirect_stdout(log):
                    journal = probe.Journal(directory)
                    code = probe.run_probe(process.pid, config, journal)
                result = next(x for x in journal.events if x['event'] == 'active_send_result')
                assert result['download_status'] == expected, result
                assert (code == 0) == (expected == 'native_completed')
                cleanup = json.loads(process.stdout.readline())
                assert cleanup['cleanup'] and cleanup['send_calls'] == 0, cleanup
                if expected != 'request_failed':
                    assert json.loads(observation.read_text()) == dict(
                        message_download=True, kind=2, reason=0, flags=1, capacities=[7, 7])
                else:
                    assert not observation.read_text(), 'Identity mismatch started a download'
                cases.append(dict(passed=True, status=expected, references_released=True))
            finally:
                process.terminate()
                process.wait(timeout=5)
                observation.unlink(missing_ok=True)
    (directory / 'results.json').write_text(json.dumps(cases, indent=2), encoding='utf-8')
    print(json.dumps(dict(passed=len(cases))))


if __name__ == '__main__':
    main()
