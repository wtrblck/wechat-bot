import json
import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from run_bridge import apply_policy, main
from policy import ObservePolicy


class BridgeLauncherTest(unittest.TestCase):
    def test_explicit_empty_prefix_and_unicode_survive(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / 'policy.json'
            path.write_text(json.dumps({'WECHAT_BOT_OBSERVE_PREFIX': '', 'WECHAT_DB_DIR': 'E:/微信资料'}, ensure_ascii=False), encoding='utf-8-sig')
            environ = {'WECHAT_BOT_OBSERVE_PREFIX': 'wxbot-'}
            apply_policy(path, environ)
            self.assertEqual(environ['WECHAT_BOT_OBSERVE_PREFIX'], '')
            self.assertEqual(environ['WECHAT_DB_DIR'], 'E:/微信资料')
            self.assertEqual(ObservePolicy.from_environment(environ).prefix, '')

    def test_invalid_keys_or_values_do_not_partially_mutate_environment(self):
        for bad in [{'PATH': 'bad'}, {'WECHAT_BOT_OBSERVE_PREFIX': None}]:
            with tempfile.TemporaryDirectory() as folder:
                path = Path(folder) / 'policy.json'
                path.write_text(json.dumps({'WECHAT_DB_DIR': 'new', **bad}), encoding='utf-8')
                environ = {'WECHAT_DB_DIR': 'original'}
                with self.assertRaises(ValueError):
                    apply_policy(path, environ)
                self.assertEqual(environ, {'WECHAT_DB_DIR': 'original'})

    def test_same_interpreter_receives_policy_and_service_arguments(self):
        with tempfile.TemporaryDirectory() as folder:
            path = Path(folder) / 'policy.json'
            path.write_text(json.dumps({'WECHAT_BOT_OBSERVE_PREFIX': ''}), encoding='utf-8')
            captured = {}
            def run(script, run_name):
                captured.update(prefix=os.environ.get('WECHAT_BOT_OBSERVE_PREFIX', 'wxbot-'),
                                argv=list(sys.argv), name=run_name, script=script)
            with mock.patch.dict(os.environ, {}, clear=True), mock.patch.object(sys, 'argv', ['run_bridge.py']), \
                    mock.patch.object(sys, 'path', list(sys.path)), mock.patch('run_bridge.runpy.run_path', side_effect=run):
                main(['--policy', str(path), '--config', str(Path(folder) / 'bridge.json'), '--check', '--seconds', '5'])
            self.assertEqual(captured['prefix'], '')
            self.assertEqual(captured['name'], '__main__')
            self.assertEqual(captured['argv'][-3:], ['--check', '--seconds', '5'])
            self.assertTrue(captured['script'].endswith('bridge_service.py'))


if __name__ == '__main__':
    unittest.main()
