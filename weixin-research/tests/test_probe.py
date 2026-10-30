import contextlib
import io
import json
import sys
import tempfile
import unittest
from pathlib import Path
from types import SimpleNamespace
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from pe_image import PEImage
from probe import Journal, main, run_probe, validate_loaded
from profile import make_config


class ProbeTests(unittest.TestCase):
    def setUp(self):
        watch = patch('probe.ProcessWatch')
        watcher = watch.start().return_value
        watcher.status.return_value = dict(state='running')
        self.addCleanup(watch.stop)
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.directory = Path(self.tmp.name)
        self.dll = self.directory / 'test.dll'
        self.dll.write_bytes(b'test-image')
        import hashlib
        self.config = dict(module_path=str(self.dll), sha256=hashlib.sha256(b'test-image').hexdigest(),
                           image_size=1000, process_name='test.exe', sites=[], seconds=1)
        self.metadata = dict(module_path=str(self.dll), arch='x64', image_size=1000,
                             process_name='test.exe')

    def test_wrong_loaded_path_hash_arch_size_and_process_fail(self):
        for key, value in [('module_path', str(self.directory / 'other.dll')), ('arch', 'ia32'),
                           ('image_size', 1001), ('process_name', 'other.exe')]:
            metadata = dict(self.metadata, **{key: value})
            with self.subTest(key=key), self.assertRaises(ValueError):
                validate_loaded(self.config, metadata)
        self.dll.write_bytes(b'changed')
        with self.assertRaises(ValueError):
            validate_loaded(self.config, self.metadata)

    def test_no_attach_by_default(self):
        with patch('probe.make_config', return_value=self.config), patch('probe.ROOT', self.directory), \
             patch('probe.render_source', return_value='// prepared'), patch('probe.run_probe') as run:
            with contextlib.redirect_stdout(io.StringIO()):
                self.assertEqual(main([]), 0)
            run.assert_not_called()
            self.assertTrue((self.directory / 'probe.generated.js').is_file())

    def test_invalid_cli_never_runs(self):
        for args in (['--observe'], ['--observe', '--pid', '0'],
                     ['--baseline', '--site', 'text_send_candidate'], ['--observe', '--prepare-only']):
            with self.subTest(args=args), contextlib.redirect_stderr(io.StringIO()), \
                 self.assertRaises(SystemExit):
                main(args)

    def test_invalid_duration_and_unknown_site(self):
        for seconds in (0, 61):
            with self.assertRaises(ValueError):
                make_config(seconds=seconds)
        with self.assertRaises(ValueError):
            make_config('unknown')

    def test_profile_rejects_unpinned_image(self):
        image = SimpleNamespace(sha256='0' * 64)
        with patch('profile.PEImage', return_value=image), self.assertRaises(ValueError):
            make_config()

    def test_journal_is_incremental_and_does_not_overwrite(self):
        with contextlib.redirect_stdout(io.StringIO()):
            a, b = Journal(self.directory), Journal(self.directory)
            self.assertNotEqual(a.path, b.path)
            a.emit(dict(event='first'))
            self.assertEqual(json.loads(a.path.read_text(encoding='utf-8'))['event'], 'first')
            a.close('failed')
            b.close('completed')
        self.assertEqual(json.loads(a.stem.with_suffix('.json').read_text())['outcome'], 'failed')

    def fake_frida(self, scenario):
        callbacks = {}
        script = SimpleNamespace()
        script.on = lambda name, handler: callbacks.update({name: handler})
        script.load = lambda: None
        script.unload = lambda: None
        script.exports_sync = SimpleNamespace(inspect=lambda: self.metadata)
        session = SimpleNamespace()
        session.on = lambda name, handler: callbacks.update({name: handler})
        session.create_script = lambda *args, **kwargs: script
        session.detach = lambda: callbacks['detached']('application-requested')

        def start():
            if scenario == 'detach':
                callbacks['detached']('process-terminated', SimpleNamespace(report='crash details'))
            elif scenario == 'script-error':
                callbacks['message'](dict(type='error', description='broken'), None)
            elif scenario == 'load-error':
                raise RuntimeError('start failed')
            else:
                callbacks['message'](dict(type='send', payload=dict(event='finished', reason='deadline', counts={})), None)

        script.exports_sync.start = start
        script.exports_sync.finish = lambda: None
        if scenario == 'cleanup-error':
            def fail():
                raise RuntimeError('cleanup failed')
            script.exports_sync.finish = fail
        return SimpleNamespace(attach=lambda pid: session)

    def test_completion_and_failures_preserve_evidence(self):
        for scenario in ('success', 'detach', 'script-error', 'load-error', 'cleanup-error'):
            with self.subTest(scenario=scenario), contextlib.redirect_stdout(io.StringIO()), \
                 patch('probe.process_path', return_value=Path('test.exe')):
                journal = Journal(self.directory)
                code = run_probe(123, self.config, journal, self.fake_frida(scenario))
                self.assertEqual(code, 0 if scenario == 'success' else 1)
                summary = json.loads(journal.stem.with_suffix('.json').read_text())
                self.assertEqual(summary['outcome'], 'completed' if code == 0 else 'failed')
                if scenario == 'detach':
                    event = next(e for e in journal.events if e['event'] == 'session_detached')
                    self.assertEqual(event['crash_report'], 'crash details')
                    self.assertFalse(any(e['event'] == 'cleanup_error' for e in journal.events))

    def test_wrong_os_process_rejected_before_attach(self):
        with patch('probe.process_path', return_value=Path('other.exe')), \
             contextlib.redirect_stdout(io.StringIO()):
            frida = SimpleNamespace(attach=unittest.mock.Mock())
            journal = Journal(self.directory)
            self.assertEqual(run_probe(123, self.config, journal, frida), 1)
            frida.attach.assert_not_called()


class PETests(unittest.TestCase):
    def test_truncated_and_invalid_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            file = Path(tmp) / 'bad.dll'
            for data in (b'', b'MZ', b'MZ' + bytes(62), b'not a PE'):
                file.write_bytes(data)
                with self.subTest(size=len(data)), self.assertRaises(ValueError):
                    PEImage(file)


if __name__ == '__main__':
    unittest.main()
