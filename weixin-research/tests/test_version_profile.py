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
        self.assertEqual(profile['version'], '4.1.15.56')
        self.assertEqual(len(profile['sha256']), 64)
        self.assertEqual(profile['send']['narrow_assign'], 0x1F9AD0)
        self.assertEqual(profile['download']['thread_checkpoint'], 0x4A1FD0)
        self.assertEqual(profile['emoji']['control_vtable'], 0x908AA98)
        self.assertEqual(profile['download_result_vtable'], 0x928C3D8)
        self.assertIn('path', profile)

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
