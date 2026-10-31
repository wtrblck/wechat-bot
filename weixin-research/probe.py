"""Version-locked diagnostics. Defaults to offline preparation, never attach."""
import argparse
import hashlib
import json
import os
import sys
import threading
import time
import uuid
from datetime import datetime, timezone
from pathlib import Path

from policy import ObservePolicy
from profile import ROOT, SITES, make_config
from process_watch import ProcessWatch

sys.path.insert(0, str(ROOT / 'deps'))

# Console text must never crash on a character the local code page cannot show;
# the journal file itself is always written as UTF-8.
if hasattr(sys.stdout, 'reconfigure'):
    try:
        sys.stdout.reconfigure(errors='backslashreplace')
    except (ValueError, OSError):
        pass


def render_source(config):
    config = dict(config)
    if config.get('capture_test'):
        config['capture_source'] = (ROOT / 'receive_test.c').read_text(encoding='utf-8')
        if config.get('capture_kind') == 'send':
            config['capture_source'] += '\n' + (ROOT / 'send_capture.c').read_text(encoding='utf-8')
        elif config.get('capture_kind') == 'emoji_file_read':
            config['capture_source'] += '\n' + (ROOT / 'emoji_file_read_capture.c').read_text(encoding='utf-8')
    source = (ROOT / 'probe.js').read_text(encoding='utf-8').replace('__CONFIG__', json.dumps(config))
    if config.get('active_experiment'):
        adapter = {'download_async': 'download_async.js',
                   'send_worker': 'send_worker.js',
                   'download_worker': 'download_worker.js'}.get(
                       config['active_experiment'].get('backend'), 'active_send.js')
        source += '\n' + (ROOT / adapter).read_text(encoding='utf-8')
    return source


class Journal:
    """Flush each event so an interrupted host still leaves usable evidence."""
    def __init__(self, directory):
        directory = Path(directory)
        directory.mkdir(parents=True, exist_ok=True)
        stamp = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ')
        self.stem = directory / (stamp + '-' + uuid.uuid4().hex[:8])
        self.path = self.stem.with_suffix('.jsonl')
        self.file = self.path.open('x', encoding='utf-8')
        self.lock = threading.Lock()
        self.events = []
        self.started = time.monotonic()

    def emit(self, event):
        with self.lock:
            item = dict(event, utc=datetime.now(timezone.utc).isoformat(),
                        elapsed_ms=round((time.monotonic() - self.started) * 1000))
            self.file.write(json.dumps(item, ensure_ascii=False) + '\n')
            self.file.flush()
            os.fsync(self.file.fileno())
            self.events.append(item)
        print(json.dumps(item, ensure_ascii=False), flush=True)

    def close(self, outcome):
        with self.lock:
            self.file.close()
            summary = dict(outcome=outcome, journal=str(self.path), events=self.events)
            self.stem.with_suffix('.json').write_text(
                json.dumps(summary, ensure_ascii=False, indent=2), encoding='utf-8')


def validate_loaded(config, metadata):
    expected = Path(config['module_path']).resolve()
    loaded = Path(metadata['module_path']).resolve()
    if loaded != expected:
        raise ValueError('Loaded module path differs from the verified file')
    if metadata['arch'] != 'x64' or metadata['image_size'] != config['image_size']:
        raise ValueError('Loaded module architecture or size differs')
    if metadata['process_name'].lower() != config['process_name'].lower():
        raise ValueError('Unexpected executable name')
    if hashlib.sha256(loaded.read_bytes()).hexdigest() != config['sha256']:
        raise ValueError('Loaded module file SHA256 differs')


def process_path(pid):
    """Query the OS executable path without trusting Frida module ordering."""
    import ctypes
    from ctypes import wintypes
    kernel = ctypes.WinDLL('kernel32', use_last_error=True)
    kernel.OpenProcess.argtypes = [wintypes.DWORD, wintypes.BOOL, wintypes.DWORD]
    kernel.OpenProcess.restype = wintypes.HANDLE
    kernel.QueryFullProcessImageNameW.argtypes = [wintypes.HANDLE, wintypes.DWORD,
                                                 wintypes.LPWSTR, ctypes.POINTER(wintypes.DWORD)]
    kernel.QueryFullProcessImageNameW.restype = wintypes.BOOL
    kernel.CloseHandle.argtypes = [wintypes.HANDLE]
    kernel.CloseHandle.restype = wintypes.BOOL
    handle = kernel.OpenProcess(0x1000, False, pid)
    if not handle:
        raise ctypes.WinError(ctypes.get_last_error())
    try:
        size = wintypes.DWORD(32768)
        buffer = ctypes.create_unicode_buffer(size.value)
        if not kernel.QueryFullProcessImageNameW(handle, 0, buffer, ctypes.byref(size)):
            raise ctypes.WinError(ctypes.get_last_error())
        return Path(buffer.value)
    finally:
        kernel.CloseHandle(handle)


def run_probe(pid, config, journal, frida_module=None):
    """Shared runner for pinned Weixin and an independent integration fixture."""
    done = threading.Event()
    detached = threading.Event()
    failed = threading.Event()
    completed = threading.Event()
    cleaning = threading.Event()
    session = script = None
    process_watch = None
    outcome = 'failed'

    def on_message(message, data):
        if message.get('type') == 'send' and isinstance(message.get('payload'), dict):
            event = message['payload']
        else:
            event = dict(event='script_error', detail=message)
            failed.set()
            done.set()
        journal.emit(event)
        if event.get('event') == 'finished':
            if event.get('reason') in ('deadline', 'host-request'):
                completed.set()
            else:
                failed.set()
            done.set()

    def on_detached(reason, crash=None):
        detached.set()
        if not cleaning.is_set():
            failed.set()
        journal.emit(dict(event='session_detached', reason=reason,
                          expected=cleaning.is_set(), crash_report=getattr(crash, 'report', None)))
        done.set()

    journal_config = dict(config)
    if config.get('active_experiment'):
        experiment = dict(config['active_experiment'])
        # Binary payloads stay out of the journal; only size and hash are evidence.
        for key, label in (('voice_bytes', 'voice_payload'), ('text_bytes', 'text'),
                           ('recipient_bytes', 'recipient')):
            data = experiment.pop(key, None)
            if data is None:
                continue
            experiment[label + '_size'] = len(data)
            experiment[label + '_sha256'] = hashlib.sha256(bytes(data)).hexdigest()
        thread_source = experiment.pop('thread_source', None)
        if thread_source is not None:
            experiment['thread_sha256'] = hashlib.sha256(thread_source.encode('utf-8')).hexdigest()
        helper_source = experiment.pop('helper_source', '')
        experiment['helper_sha256'] = hashlib.sha256(helper_source.encode('utf-8')).hexdigest()
        emoji_fields = experiment.pop('emoji_fields', None)
        if emoji_fields is not None:
            experiment['emoji_fields_sha256'] = hashlib.sha256(json.dumps(emoji_fields, sort_keys=True).encode()).hexdigest()
        journal_config['active_experiment'] = experiment
    journal.emit(dict(event='run_requested', pid=pid, config=journal_config))
    try:
        executable = process_path(pid)
        if executable.name.lower() != config['process_name'].lower():
            raise ValueError('OS executable name differs from expected process')
        journal.emit(dict(event='process_checked', executable=str(executable)))
        process_watch = ProcessWatch(pid)
        if frida_module is None:
            if sys.version_info < (3, 9):
                raise RuntimeError('Use Python 3.9+ for bundled Frida (on this machine: py -3.14)')
            import frida as frida_module
        session = frida_module.attach(pid)
        session.on('detached', on_detached)
        script = session.create_script(render_source(config), runtime='qjs')
        script.on('message', on_message)
        script.load()
        metadata = script.exports_sync.inspect()
        journal.emit(dict(event='module_inspected', metadata=metadata))
        validate_loaded(config, metadata)
        script.exports_sync.start()
        if config.get('active_experiment'):
            result = script.exports_sync.dispatch()
            journal.emit(result)
            if not result.get('accepted'):
                failed.set()
            if config.get('finish_after_dispatch'):
                script.exports_sync.finish()
        if not done.wait(config['seconds'] + 5):
            journal.emit(dict(event='host_timeout'))
            failed.set()
        outcome = 'completed' if completed.is_set() and not failed.is_set() else 'failed'
    except KeyboardInterrupt:
        outcome = 'interrupted'
        journal.emit(dict(event='interrupted'))
    except Exception as error:
        journal.emit(dict(event='run_error', error_type=type(error).__name__, detail=str(error)))
    finally:
        cleaning.set()
        if script and not detached.is_set():
            try:
                script.exports_sync.finish()
            except Exception as error:
                outcome = 'failed'
                journal.emit(dict(event='cleanup_error', detail=str(error)))
            try:
                script.unload()
            except Exception as error:
                outcome = 'failed'
                journal.emit(dict(event='unload_error', detail=str(error)))
        if session and not detached.is_set():
            try:
                session.detach()
            except Exception as error:
                outcome = 'failed'
                journal.emit(dict(event='detach_error', detail=str(error)))
        if outcome == 'completed' and failed.is_set():
            outcome = 'failed'
        if process_watch:
            try:
                status = process_watch.status()
                journal.emit(dict(event='process_status', **status))
                if status['state'] == 'exited':
                    outcome = 'failed'
            except OSError as error:
                journal.emit(dict(event='process_status_error', detail=str(error)))
                outcome = 'failed'
            finally:
                process_watch.close()
        journal.emit(dict(event='run_finished', outcome=outcome))
        journal.close(outcome)
    return 0 if outcome == 'completed' else 1


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, help='Required only with --observe')
    parser.add_argument('--seconds', type=int, default=10)
    parser.add_argument('--callback', choices=('js', 'native'), default='native',
                        help='Native counter avoids executing JS on the observed business thread')
    parser.add_argument('--capture-test', action='store_true',
                        help='Experimental bounded capture of wxbot-* filehelper messages only')
    modes = parser.add_mutually_exclusive_group()
    modes.add_argument('--baseline', action='store_true', help='Load runtime without hooks (default)')
    modes.add_argument('--site', choices=sorted(SITES), help='Observe exactly one candidate')
    actions = parser.add_mutually_exclusive_group()
    actions.add_argument('--prepare-only', action='store_true')
    actions.add_argument('--observe', action='store_true', help='Explicitly attach in an isolated test session')
    parser.add_argument('--output-dir', type=Path, default=ROOT / 'runs')
    args = parser.parse_args(argv)
    if args.observe and (args.pid is None or args.pid <= 0):
        parser.error('--observe requires a positive --pid')
    if args.capture_test and (args.site not in ('sync_process_candidate', 'send_stage_candidate_a') or args.callback != 'native'):
        parser.error('--capture-test requires a supported receive/send-stage site and --callback native')
    try:
        config = make_config(args.site, args.seconds)
        config['callback_backend'] = args.callback
        config['capture_test'] = args.capture_test
        config['capture_kind'] = 'send' if args.site == 'send_stage_candidate_a' else 'receive'
        if args.capture_test:
            # The native filter and the HTTP event store share one policy.
            config['capture_filter'] = ObservePolicy.from_environment().describe()
    except (ValueError, OSError) as error:
        parser.error(str(error))
    if not args.observe:
        output = ROOT / 'probe.generated.js'
        output.write_text(render_source(config), encoding='utf-8')
        print(json.dumps(dict(prepared=str(output), mode='single-site' if args.site else 'baseline',
                              sites=[s['name'] for s in config['sites']]), ensure_ascii=False))
        return 0
    return run_probe(args.pid, config, Journal(args.output_dir))


if __name__ == '__main__':
    sys.exit(main())
