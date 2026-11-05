"""Validate native message construction and cleanup without invoking send_fn.

Uses only the task checkpoint, never receive-path interceptors. Run explicitly
against the logged-in process with a pinned WECHAT_BOT_PROFILE.
"""
import argparse
import hashlib
import json
from pathlib import Path

from active_send import config_for, worker_config
from policy import SendPolicy
from process_discovery import find_main_pid, process_alive
from profile import DLL, ROOT, VERSION
from send_worker import payload_from_config
from worker_session import WorkerSession


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--media', action='store_true')
    args = parser.parse_args()
    policy = SendPolicy.from_environment({})
    config = worker_config(policy)
    config['active_experiment']['thread_source'] = (
        '#define WECHAT_BUILD_ONLY 1\n' + config['active_experiment']['thread_source'])
    pid = find_main_pid(DLL)
    output = ROOT / 'runs' / ('version-' + VERSION) / 'native-build-validation.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    report = dict(version=VERSION, pid=pid, sends_enabled=False, results=[])
    def save():
        output.write_text(json.dumps(report, indent=2), encoding='utf-8')
    save()
    session = WorkerSession(pid, config)
    try:
        assert session.call('start_worker')
        jobs = [('context', {}), ('text', dict(text='wxbot-ABI-validation-中文\nsecond line'))]
        if args.media:
            jobs += [(kind, dict(path=ROOT / 'fixtures' / name)) for kind, name in (
                ('image', 'wxbot-image.png'), ('file', 'wxbot-file.txt'),
                ('video', 'wxbot-video.mp4'), ('voice', 'wxbot-voice.silk'))]
        for kind, kwargs in jobs:
            payload = payload_from_config(config_for(kind, policy=policy, **kwargs))
            result = session.call('dispatch_job', payload)
            report['results'].append(result)
            save()
            print(json.dumps(result), flush=True)
            assert result['accepted'] and result['phase'] == (3 if kind == 'context' else 6), result
        if args.media:
            result = session.call('dispatch_job', dict(kind='emoji', recipient_bytes=list(b'filehelper'),
                text_bytes=[], emoji_fields={'md5': list(b'0'*32), 'aes_key': list(b'0'*32)},
                emoji_type=1, timeout_ms=20000))
            report['results'].append(result)
            save()
            print(json.dumps(result), flush=True)
            assert result['accepted'] and result['phase'] == 6, result
            path = ROOT / 'fixtures' / 'cold-186.gif'
            result = session.call('dispatch_job', dict(kind='emoji', recipient_bytes=list(b'filehelper'),
                text_bytes=[], emoji_fields={'md5': list(hashlib.md5(path.read_bytes()).hexdigest().encode())},
                emoji_type=4, local_emoji=True, path=path.as_posix(),
                local_emoji_size=path.stat().st_size, timeout_ms=20000))
            result['validation_case'] = 'local_gif'
            report['results'].append(result)
            save()
            print(json.dumps(result), flush=True)
            assert result['accepted'] and result['phase'] == 6, result
    finally:
        report['clean_shutdown'] = session.close('stop_worker')
        report['process_alive'] = process_alive(pid)
        save()
    return 0


if __name__ == '__main__':
    raise SystemExit(main())
