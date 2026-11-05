import json
import sys
import tempfile
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import version_profile


class VersionProfileTest(unittest.TestCase):
    def test_default_profile_is_complete_and_pinned(self):
        profile = version_profile.load()
        self.assertEqual(profile['version'], '4.2.0.13')
        self.assertEqual(len(profile['sha256']), 64)
        self.assertEqual(profile['send']['narrow_assign'], 0x1FE140)
        self.assertEqual(profile['download']['thread_checkpoint'], 0x4A87B0)
        self.assertEqual(profile['emoji']['control_vtable'], 0x91951D8)
        self.assertEqual(profile['download_result_vtable'], 0x939B088)
        self.assertEqual(profile['layout']['emoji_resource_allocation'], 0x1F8)
        self.assertEqual(profile['layout']['local_emoji_vtable_entries'], 19)
        self.assertIn('path', profile)

    def test_legacy_profile_remains_explicitly_pinned(self):
        profile = version_profile.load(version_profile.DIRECTORY / '4.1.15.56.json')
        self.assertEqual(profile['version'], '4.1.15.56')
        self.assertEqual(profile['send']['narrow_assign'], 0x1F9AD0)
        self.assertNotEqual(profile['sha256'], version_profile.load()['sha256'])

    def test_new_resource_layout_reaches_native_template(self):
        import profile
        from unittest.mock import patch
        self.assertIn('EMOJI_RESOURCE_ALLOCATION 504', profile.layout_definitions())
        with patch.object(profile, 'NATIVE_LAYOUT', {'emoji_resource_allocation': 128}):
            with self.assertRaises(ValueError):
                profile.layout_definitions()

    def test_missing_and_invalid_profiles_are_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / 'missing.json'
            with self.assertRaises(ValueError):
                version_profile.load(path)
            path.write_text('[1,2]', encoding='utf-8')
            with self.assertRaises(ValueError):
                version_profile.load(path)
            profile = json.loads(version_profile.DEFAULT_PROFILE.read_text(encoding='utf-8'))
            profile['send'] = {}
            path.write_text(json.dumps(profile), encoding='utf-8')
            with self.assertRaises(ValueError):
                version_profile.load(path)
            profile = json.loads(version_profile.DEFAULT_PROFILE.read_text(encoding='utf-8'))
            del profile['sha256']
            path.write_text(json.dumps(profile), encoding='utf-8')
            with self.assertRaises(ValueError):
                version_profile.load(path)


if __name__ == '__main__':
    unittest.main()
