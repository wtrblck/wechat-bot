"""Install a pinned multilingual CPU Whisper model; verify upstream blob digests."""
import hashlib
import json
from pathlib import Path
import urllib.request

REVISION = 'ebe41f70d5b6dfa9166e2c581c45c9c0cfc57b66'
REPO = 'Systran/faster-whisper-base'
FILES = ('config.json', 'model.bin', 'tokenizer.json', 'vocabulary.txt')
root = Path(__file__).resolve().parents[1] / 'data' / 'video-models' / 'faster-whisper-base'
root.mkdir(parents=True, exist_ok=True)
with urllib.request.urlopen(f'https://huggingface.co/api/models/{REPO}/revision/{REVISION}?blobs=true', timeout=30) as response:
    info = json.load(response)
assert info['sha'] == REVISION
manifest = {}
for name in FILES:
    blob = next(s for s in info['siblings'] if s['rfilename'] == name)
    destination = root / name
    def valid(data):
        if blob.get('lfs'):
            return hashlib.sha256(data).hexdigest() == blob['lfs']['sha256']
        return hashlib.sha1(f'blob {len(data)}\0'.encode() + data).hexdigest() == blob['blobId']
    if not destination.is_file() or not valid(destination.read_bytes()):
        with urllib.request.urlopen(f'https://huggingface.co/{REPO}/resolve/{REVISION}/{name}', timeout=60) as response:
            data = response.read(256 * 1024 * 1024 + 1)
        if len(data) > 256 * 1024 * 1024 or not valid(data):
            raise ValueError('model_integrity_failed: ' + name)
        temporary = destination.with_suffix(destination.suffix + '.part')
        temporary.write_bytes(data)
        temporary.replace(destination)
    manifest[name] = hashlib.sha256(destination.read_bytes()).hexdigest()
(root / 'verified.json').write_text(json.dumps({'revision': REVISION, 'sha256': manifest}, indent=2), encoding='utf-8')
print(json.dumps({'installed': True, 'revision': REVISION, 'files': list(manifest)}))
