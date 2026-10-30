import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from bridge_config import BridgeConfig
from policy import ObservePolicy, SendPolicy


class BridgeConfigTest(unittest.TestCase):
    def test_defaults_are_local_and_narrow(self):
        config = BridgeConfig.from_environment({})
        self.assertEqual((config.host, config.port), ('127.0.0.1', 17870))
        self.assertEqual(config.conversations, ('filehelper',))
        self.assertFalse(config.download)
        self.assertFalse(config.emoji)
        self.assertFalse(config.history)
        self.assertEqual(config.send.recipients, ('filehelper',))
        self.assertGreaterEqual(config.queue_capacity, 1)

    def test_environment_overrides(self):
        config = BridgeConfig.from_environment({
            'WECHAT_BOT_PORT': '19000', 'WECHAT_BOT_RECIPIENTS': 'filehelper,wxid_x',
            'WECHAT_BOT_CONVERSATIONS': 'wxid_x,123@chatroom',
            'WECHAT_BOT_QUEUE': '8', 'WECHAT_BOT_HISTORY': '1',
            'WECHAT_BOT_MEDIA_ROOTS': 'C:/one;C:/two',
        })
        self.assertEqual(config.port, 19000)
        self.assertEqual(config.conversations, ('wxid_x', '123@chatroom'))
        self.assertEqual(config.queue_capacity, 8)
        self.assertTrue(config.history)
        self.assertEqual(len(config.send.media_roots), 2)
        self.assertIn('wxid_x', config.send.recipients)

    def test_wildcard_requires_explicit_conversations(self):
        with self.assertRaises(ValueError):
            BridgeConfig(observe=ObservePolicy(targets=('*',), prefix=''), send=SendPolicy())
        config = BridgeConfig(observe=ObservePolicy(targets=('*',), prefix=''),
                              conversations=('wxid_x',), send=SendPolicy())
        self.assertEqual(config.conversations, ('wxid_x',))

    def test_json_config_and_unknown_keys(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'bridge.json'
            path.write_text(json.dumps(dict(port=18001, media=False,
                                            conversations=['filehelper'])), encoding='utf-8')
            config = BridgeConfig.from_environment({}, path=path)
            self.assertEqual(config.port, 18001)
            self.assertFalse(config.media)
            path.write_text(json.dumps(dict(unknown=True)), encoding='utf-8')
            with self.assertRaises(ValueError):
                BridgeConfig.from_environment({}, path=path)

    def test_invalid_numbers_rejected(self):
        for values in (dict(port=70000), dict(poll_seconds=0.1), dict(queue_capacity=0),
                       dict(send_timeout_ms=10), dict(send_wait_seconds=0),
                       dict(event_capacity=1), dict(retention_days=-1)):
            with self.subTest(values=values), self.assertRaises(ValueError):
                BridgeConfig(**values)


if __name__ == '__main__':
    unittest.main()
