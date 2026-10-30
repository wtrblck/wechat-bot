import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from event_model import normalize, parse_self_ids, self_ids_from_environment

SELF = 'wxid_self'


class NormalizeTests(unittest.TestCase):
    def test_direct_inbound_and_outbound(self):
        incoming = normalize(dict(sender='wxid_peer', recipient=SELF), {SELF})
        self.assertEqual(incoming['conversation_id'], 'wxid_peer')
        self.assertEqual(incoming['sender_id'], 'wxid_peer')
        self.assertEqual(incoming['recipient_id'], SELF)
        self.assertEqual(incoming['direction'], 'incoming')
        outgoing = normalize(dict(sender=SELF, recipient='wxid_peer'), {SELF})
        self.assertEqual(outgoing['conversation_id'], 'wxid_peer')
        self.assertEqual(outgoing['direction'], 'outgoing')

    def test_group_member_and_self_echo(self):
        member = normalize(dict(sender='wxid_member', recipient='123@chatroom'), {SELF})
        self.assertEqual(member['conversation_id'], '123@chatroom')
        self.assertEqual(member['sender_id'], 'wxid_member')
        self.assertEqual(member['direction'], 'incoming')
        echo = normalize(dict(sender=SELF, recipient='123@chatroom'), {SELF})
        self.assertEqual(echo['conversation_id'], '123@chatroom')
        self.assertEqual(echo['direction'], 'outgoing')

    def test_without_self_ids_direction_is_unknown(self):
        event = normalize(dict(sender='a', recipient='b'))
        self.assertEqual(event['direction'], 'unknown')
        self.assertEqual(event['conversation_id'], 'b')

    def test_missing_fields_do_not_guess(self):
        event = normalize(dict(content='x'))
        self.assertEqual(event['conversation_id'], '')
        self.assertEqual(event['sender_id'], '')
        self.assertEqual(event['direction'], 'unknown')

    def test_self_id_parsing(self):
        self.assertEqual(parse_self_ids('wxid_a, wxid_b ,, '), frozenset({'wxid_a', 'wxid_b'}))
        self.assertEqual(parse_self_ids(None), frozenset())
        self.assertEqual(parse_self_ids(''), frozenset())
        self.assertEqual(self_ids_from_environment({'WECHAT_BOT_SELF': 'me'}), frozenset({'me'}))
        self.assertEqual(self_ids_from_environment({}), frozenset())


if __name__ == '__main__':
    unittest.main()
