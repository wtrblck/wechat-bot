"""Exercise the download-request ABI on our own process, never real WeChat."""
import contextlib
import io
import json
import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pe_image import PEImage
from policy import SendPolicy
from probe import Journal, run_probe
from integration_active import build_case


def main():
    directory = ROOT / 'runs/fixture-download'
    directory.mkdir(parents=True, exist_ok=True)
    executable = ROOT / 'tests/build/download-fixture.exe'
    subprocess.run(['gcc', '-O0', '-static-libgcc', str(ROOT / 'tests/download_fixture.c'), '-o', str(executable)], check=True)
    image = PEImage(executable)
    cases = []
    for recipient, identifier in [('filehelper', 9007199254740993), ('wxid_' + 'ab' * 22, 9223372036854775807)]:
        observation = directory / 'observation.json'
        with subprocess.Popen([str(executable), str(observation)], stdout=subprocess.PIPE, text=True) as process:
            try:
                download_rva = int(process.stdout.readline())
                resource_offsets = json.loads(process.stdout.readline())
                offsets = json.loads(process.stdout.readline())
                offsets['send'] = download_rva
                config = build_case('context', None, recipient, offsets, image, SendPolicy(recipients=(recipient,)))
                config['active_experiment']['thread_source'] = '#define DOWNLOAD_SERVER_ID %dULL\n' % identifier + (ROOT / 'download_request.c').read_text()
                with (directory / 'output.log').open('a', encoding='utf-8') as log, contextlib.redirect_stdout(log):
                    journal = Journal(directory)
                    code = run_probe(process.pid, config, journal)
                assert code == 0
                data = json.loads(observation.read_text())
                assert data['calls'] == 1 and data['server_id'] == str(identifier) and data['reason'] == 2, data
                assert bytes.fromhex(data['recipient_hex']).decode() == recipient
                cleanup = json.loads(process.stdout.readline())
                assert cleanup['cleanup'] and cleanup['send_calls'] == 0, cleanup
                cases.append(dict(passed=True, id_preserved=True, recipient_bytes=len(recipient.encode())))
            finally:
                process.terminate()
                process.wait(timeout=5)
                observation.unlink(missing_ok=True)
    for execute in (0, 1):
        observation = directory / 'resource-observation.json'
        with subprocess.Popen([str(executable), str(observation)], stdout=subprocess.PIPE, text=True) as process:
            try:
                process.stdout.readline()
                resource_offsets = json.loads(process.stdout.readline())
                offsets = json.loads(process.stdout.readline())
                offsets.update(resource_offsets)
                config = build_case('context', None, 'filehelper', offsets, image, SendPolicy())
                config['active_experiment']['thread_source'] = (
                    '#define DOWNLOAD_SERVER_ID 9007199254740993ULL\n#define DOWNLOAD_LOCAL_ID 133\n'
                    '#define DOWNLOAD_CREATE_TIME 1793209904\n#define DOWNLOAD_MESSAGE_TYPE 3\n'
                    '#define DOWNLOAD_EXECUTE %d\n' % execute + (ROOT / 'download_resource.c').read_text())
                with (directory / 'output.log').open('a', encoding='utf-8') as log, contextlib.redirect_stdout(log):
                    journal = Journal(directory)
                    code = run_probe(process.pid, config, journal)
                assert code == 0, journal.events
                if execute:
                    assert json.loads(observation.read_text()) == dict(resource_download=True, priority=500)
                cleanup = json.loads(process.stdout.readline())
                assert cleanup['cleanup'] and cleanup['send_calls'] == 0, cleanup
                cases.append(dict(passed=True, resource_download=bool(execute), references_released=True))
            finally:
                process.terminate()
                process.wait(timeout=5)
                observation.unlink(missing_ok=True)
    (directory / 'results.json').write_text(json.dumps(cases, indent=2))
    print(json.dumps(dict(passed=len(cases))))


if __name__ == '__main__':
    main()
