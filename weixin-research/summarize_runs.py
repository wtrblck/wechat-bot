"""Build a compact evidence index without publishing account identifiers."""
import json
from profile import ROOT


def main():
    records = []
    for path in sorted((ROOT / 'runs').glob('*.json')):
        data = json.loads(path.read_text(encoding='utf-8'))
        events = data.get('events', [])
        if not events or events[0].get('event') != 'run_requested':
            continue
        config = events[0]['config']
        records.append(dict(journal=path.name, started_utc=events[0]['utc'],
                            pid=events[0]['pid'], seconds=config['seconds'],
                            sites=[s['name'] for s in config['sites']],
                            backend=config.get('callback_backend', 'js'), outcome=data['outcome'],
                            last_counts=next((e['counts'] for e in reversed(events) if 'counts' in e), {}),
                            detach=[dict(reason=e['reason'], expected=e['expected']) for e in events if e['event'] == 'session_detached'],
                            process_status=[{k: v for k, v in e.items() if k not in ('event', 'utc', 'elapsed_ms')}
                                            for e in events if e['event'] == 'process_status'],
                            test_messages=[dict(schema=e['schema'], content=e['content'], message_type=e['message_type'],
                                                message_id=e['message_id'], recipient=e['recipient'])
                                           for e in events if e['event'] == 'test_message']))
    api_path = ROOT / 'runs' / 'api' / 'last-api-result.json'
    api = json.loads(api_path.read_text(encoding='utf-8')) if api_path.exists() else {}
    result = dict(scope='Short-lived filehelper wxbot-* experiments only',
                  send_api_verified=False,
                  receive_http_verified=api.get('http_check', {}).get('passed', False),
                  http_check=dict(passed=api.get('http_check', {}).get('passed', False),
                                  via=api.get('http_check', {}).get('via'),
                                  content=api.get('http_check', {}).get('message', {}).get('content'),
                                  journal=api.get('journal')),
                  runs=records)
    output = ROOT / 'LIVE_TEST_RESULTS.json'
    output.write_text(json.dumps(result, ensure_ascii=False, indent=2), encoding='utf-8')
    print(json.dumps(dict(output=str(output), runs=len(records),
                          receive_http_verified=result['receive_http_verified'], send_api_verified=False)))


if __name__ == '__main__':
    main()
