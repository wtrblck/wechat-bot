"""Summarize local API results separately from explicit phone delivery checks."""
import json
from pathlib import Path
from profile import ROOT, SHA256


def main():
    receipts = {item['journal']: item for item in json.loads((ROOT / 'delivery-confirmations.json').read_text(encoding='utf-8'))['confirmations']}
    runs = []
    for folder in ('active', 'send-api'):
        for path in sorted((ROOT / 'runs' / folder).glob('*.json')):
            document = json.loads(path.read_text(encoding='utf-8'))
            events = document.get('events', [])
            requested = next((event for event in events if event.get('event') == 'run_requested'), {})
            config = requested.get('config', {})
            if config.get('module_name') != 'Weixin.dll':
                continue
            request = config.get('active_experiment', {})
            result = next((event for event in events if event.get('event') == 'active_send_result'), {})
            error = next((event for event in events if event.get('event') == 'run_error'), {})
            process = next((event for event in events if event.get('event') == 'process_status'), {})
            key = folder + '/' + path.stem
            receipt = receipts.get(key)
            if request.get('path'):
                fixture = Path(request['path']).name
            elif request.get('text'):
                text = request['text']
                fixture = text if len(text) <= 40 else text[:20] + '...' + text[-8:]
            else:
                fixture = None
            runs.append(dict(journal=key, kind=request.get('kind'), fixture=fixture,
                 recipient=request.get('recipient'), recipient_bytes=request.get('recipient_size'),
                 text_bytes=request.get('text_size'), text_sha256=request.get('text_sha256'),
                 via='HTTP' if folder == 'send-api' else 'CLI', accepted=result.get('accepted', False),
                 detail=result.get('detail') or error.get('detail'), phase=result.get('phase'),
                 native_error=result.get('native_error'),
                 local_status=result.get('local_status'), process_state=process.get('state'),
                 duration_ms=result.get('duration_ms'), voice_payload_sha256=request.get('voice_payload_sha256'),
                 outcome=document.get('outcome'), phone_received=receipt['received'] if receipt else None,
                 playable=receipt.get('playable') if receipt else None))
    output = dict(version='4.1.15.56', sha256=SHA256,
                  scope='explicit policy recipients (default filehelper); generated fixtures; UTF-8 text up to 4096 bytes',
                  accepted_semantics='Native call returned local success; delivery is a separate user phone check',
                  note='Runs recorded before the general string assignment used ASCII markers only; see REPORT.md',
                  production_ready=False, runs=runs)
    path = ROOT / 'ACTIVE_TEST_RESULTS.json'
    path.write_text(json.dumps(output, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(dict(path=str(path), runs=len(runs), phone_confirmed=sum(item['phone_received'] is True for item in runs))))


if __name__ == '__main__':
    main()
