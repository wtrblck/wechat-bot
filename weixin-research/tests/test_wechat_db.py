import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from wechat_db import direction_for, group_prefix, recipients_for

SELF = 'wxid_self'
CONTACT = 'wxid_contact'
GROUP = '123@chatroom'


class GroupTextTest(unittest.TestCase):
    def test_group_prefix_is_split(self):
        self.assertEqual(group_prefix('wxid_member:\nhello'), ('wxid_member', 'hello'))
        self.assertEqual(group_prefix('wxid_member:\nline1\nline2'), ('wxid_member', 'line1\nline2'))

    def test_plain_text_is_unchanged(self):
        self.assertEqual(group_prefix('hello'), (None, 'hello'))
        self.assertEqual(group_prefix('hello:\nworld'), (None, 'hello:\nworld'))
        self.assertEqual(group_prefix('a b:\nbody'), (None, 'a b:\nbody'))
        self.assertEqual(group_prefix('x' * 129 + ':\nbody'), (None, 'x' * 129 + ':\nbody'))
        self.assertEqual(group_prefix(None), (None, None))


class DirectionTest(unittest.TestCase):
    def test_direction_requires_self_id(self):
        self.assertEqual(direction_for(CONTACT, ''), 'unknown')
        self.assertEqual(direction_for(SELF, SELF), 'outgoing')
        self.assertEqual(direction_for(CONTACT, SELF), 'incoming')

    def test_recipient_keeps_conversation_view(self):
        self.assertEqual(recipients_for(CONTACT, CONTACT, SELF), SELF)
        self.assertEqual(recipients_for(CONTACT, SELF, SELF), CONTACT)
        self.assertEqual(recipients_for(GROUP, CONTACT, SELF), GROUP)
        self.assertEqual(recipients_for(GROUP, SELF, SELF), GROUP)


if __name__ == '__main__':
    unittest.main()
