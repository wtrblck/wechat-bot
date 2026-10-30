"""Read-only memory search for a marker string in a running process.

No hooks, no code patching, no argument interception: Frida only enumerates
readable ranges and scans them for the UTF-8 and UTF-16LE encodings of a text.
Used to locate where WeChat keeps a message that the user just sent, so the
record and its container can be identified offline. Attaching still perturbs the
target, so keep it to short, explicit runs on a test environment when possible.

    py -3.14 weixin-research/scan_memory.py --pid PID --text wxbot-inbound-probe
"""
import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from pe_image import PEImage
from profile import ROOT, DLL, SHA256
from probe import process_path

sys.path.insert(0, str(ROOT / 'deps'))

SOURCE = r"""
const needle = __NEEDLE__;
const utf16 = __UTF16__;
const follow = __FOLLOW__;

function scan() {
  const hits = [];
  const references = [];
  let scanned = 0;
  const ranges = Process.enumerateRanges('rw-');
  for (const range of ranges) {
    if (range.size < 32 || range.size > 268435456) continue;
    for (const pattern of [needle, utf16]) {
      if (pattern.length === 0) continue;
      try {
        const found = Memory.scanSync(range.base, range.size, pattern);
        scanned += range.size;
        for (const match of found) {
          const baseOffset = parseInt(match.address, 16) - parseInt(range.base, 16);
          const before = Math.min(64, baseOffset);
          const address = match.address.sub(before);
          let hex = '';
          try { hex = Array.from(new Uint8Array(address.readByteArray(before + 96))).map(b => b.toString(16).padStart(2, '0')).join(''); } catch (error) { }
          hits.push({address: match.address.toString(), range: range.base.toString(), size: range.size, before, hex});
          if (hits.length >= 32) break;
        }
      } catch (error) { }
      if (hits.length >= 32) break;
    }
    if (hits.length >= 32) break;
  }
  // Follow pointers to each hit: an MSVC std::string stores its buffer pointer at
  // the object base, so a pointer match tells us where the owning record lives.
  if (follow) {
    for (const hit of hits.slice(0, 2)) {
      let number = BigInt(hit.address);
      let bytes = '';
      for (let i = 0; i < 8; i++) {
        bytes += (Number(number & 0xffn)).toString(16).padStart(2, '0') + ' ';
        number >>= 8n;
      }
      const pointerPattern = bytes.trim();
      let matches = [];
      for (const range of Process.enumerateRanges('rw-')) {
        if (range.size > 268435456) continue;
        try { matches = matches.concat(Memory.scanSync(range.base, range.size, pointerPattern)); } catch (error) { }
        if (matches.length >= 2) break;
      }
      for (const match of matches.slice(0, 2)) {
        const base = match.address.sub(0x10);
        let length = -1, capacity = -1, context = null;
        try {
          length = base.add(0x10).readU64().toString();
          capacity = base.add(0x18).readU64().toString();
          context = Array.from(new Uint8Array(base.readByteArray(0x80))).map(b => b.toString(16).padStart(2, '0')).join('');
        } catch (error) { }
        references.push({blob: hit.address, pointer: match.address.toString(),
                         string_base: base.toString(), length, capacity, context});
      }
    }
  }
  return {hits, references, scanned, ranges: ranges.length};
}

rpc.exports.result = scan;
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, required=True)
    parser.add_argument('--text', required=True)
    parser.add_argument('--follow', action='store_true',
                        help='Also search for pointers to each hit (locates std::string owners)')
    parser.add_argument('--max-bytes', type=int, default=1024 * 1024 * 1024,
                        help='Stop after scanning this many bytes per encoding')
    args = parser.parse_args()
    if args.pid <= 0:
        parser.error('invalid pid')
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise SystemExit('pinned DLL changed')
    if process_path(args.pid).name.lower() != 'weixin.exe':
        raise SystemExit('pid is not Weixin.exe')
    raw = args.text.encode('utf-8')
    if not raw:
        parser.error('empty text')
    needle = ' '.join('%02x' % byte for byte in raw)
    utf16 = ' '.join('%02x' % byte for byte in args.text.encode('utf-16-le'))
    import frida
    session = frida.attach(args.pid)
    source = (SOURCE.replace('__NEEDLE__', json.dumps(needle))
                    .replace('__UTF16__', json.dumps(utf16))
                    .replace('__FOLLOW__', 'true' if args.follow else 'false'))
    script = session.create_script(source, runtime='qjs')
    script.load()
    result = script.exports_sync.result()
    try:
        script.unload()
    finally:
        session.detach()
    output = ROOT / 'runs' / 'scan' / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '.json')
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(dict(pid=args.pid, text=args.text, sha256=image.sha256,
                                      scanned=result['scanned'], ranges=result['ranges'],
                                      hits=result['hits'], references=result.get('references', [])),
                                 indent=2), encoding='utf-8')
    print(json.dumps(dict(hits=len(result['hits']), scanned=result['scanned'],
                          ranges=result['ranges'], references=len(result.get('references', [])),
                          output=str(output)), ensure_ascii=False))
    for hit in result['hits'][:6]:
        print(json.dumps(dict(address=hit['address'], before=hit['before'], hex=hit['hex'][:160])))
    for reference in result.get('references', [])[:6]:
        print(json.dumps(reference, ensure_ascii=False))
    return 0 if result['hits'] else 1


if __name__ == '__main__':
    sys.exit(main())
