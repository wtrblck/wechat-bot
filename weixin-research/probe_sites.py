"""Count hits on several read-only entry points at once.

Each site gets its own tiny CModule that only increments an atomic counter, so no
JS runs on the target's threads and no message fields are read. Used to find out
which function actually participates in a path (for example an inbound message)
before writing a parser for its arguments.

    py -3.14 weixin-research/probe_sites.py --pid PID --seconds 30 ^
        --site db_sync=0x38e9f80 --site history_add=0x30c5a10
"""
import argparse
import json
import sys
import threading
import time
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from pe_image import PEImage
from profile import ROOT, DLL, SHA256
from probe import process_path

sys.path.insert(0, str(ROOT / 'deps'))

SOURCE = r"""
const module = Process.getModuleByName('Weixin.dll');
if (module.size !== __SIZE__) throw new Error('module size mismatch');
const sites = __SITES__;
const counters = [];
for (const site of sites) {
  const address = module.base.add(site.rva);
  const range = Process.findRangeByAddress(address);
  if (range === null || !range.protection.includes('x')) throw new Error('not executable: ' + site.name);
  const block = Memory.alloc(4);
  block.writeU32(0);
  const counter = new CModule(`
    extern volatile unsigned int counter;
    void on_enter(void *context) {
      __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
    }
  `, {counter: block});
  counters.push({name: site.name, rva: site.rva, block: block, counter: counter,
                 entry: Array.from(new Uint8Array(address.readByteArray(16)))});
}
for (const item of counters) {
  Interceptor.attach(module.base.add(item.rva), {onEnter: item.counter.on_enter});
}
Interceptor.flush();
function snapshot() { return counters.map(item => ({name: item.name, hits: item.block.readU32()})); }
send({event: 'armed', sites: counters.map(item => ({name: item.name, rva: item.rva, entry: item.entry}))});
const timer = setInterval(() => send({event: 'counts', counts: snapshot()}), 1000);
setTimeout(() => {
  clearInterval(timer);
  for (const item of counters) { /* counters live until the script unloads */ }
  send({event: 'finished', reason: 'deadline', counts: snapshot()});
}, __SECONDS__ * 1000);
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, required=True)
    parser.add_argument('--seconds', type=int, default=30)
    parser.add_argument('--site', action='append', default=[], help='name=0xRVA (repeatable)')
    args = parser.parse_args()
    if args.pid <= 0 or not 1 <= args.seconds <= 60:
        parser.error('invalid pid or seconds')
    if not 1 <= len(args.site) <= 6:
        parser.error('give 1..6 --site entries')
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise SystemExit('pinned DLL changed')
    sites = []
    for spec in args.site:
        name, _, value = spec.partition('=')
        try:
            rva = int(value, 0)
        except ValueError:
            parser.error('bad rva: ' + spec)
        owner = image.owner(rva)
        if not name or not owner or owner['begin'] != rva:
            parser.error('not a function entry: ' + spec)
        if not image.section_at(rva, 16)['flags'] & 0x20000000:
            parser.error('not executable: ' + spec)
        sites.append(dict(name=name, rva=rva, entry_bytes=image.read_rva(rva, 16).hex(' ')))
    if process_path(args.pid).name.lower() != 'weixin.exe':
        raise SystemExit('pid is not Weixin.exe')
    import frida
    session = frida.attach(args.pid)
    source = (SOURCE.replace('__SIZE__', str(image.image_size))
                    .replace('__SITES__', json.dumps([dict(name=s['name'], rva=s['rva']) for s in sites]))
                    .replace('__SECONDS__', str(args.seconds)))
    script = session.create_script(source, runtime='qjs')
    finished = threading.Event()
    final = {}

    def on_message(message, data):
        if message.get('type') != 'send':
            print(json.dumps(dict(event='script_error', detail=message)), flush=True)
            return
        payload = message['payload']
        if payload.get('event') == 'finished':
            final.update(payload)
            finished.set()
        print(json.dumps(payload, ensure_ascii=False), flush=True)

    script.on('message', on_message)
    script.load()
    finished.wait(args.seconds + 5)
    counts = {item['name']: item['hits'] for item in final.get('counts', [])}
    output = ROOT / 'runs' / 'sites' / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '.json')
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(dict(pid=args.pid, seconds=args.seconds, sha256=image.sha256,
                                      sites=sites, counts=counts, finished=bool(final)), indent=2),
                      encoding='utf-8')
    try:
        script.unload()
    finally:
        session.detach()
    print(json.dumps(dict(result=str(output), counts=counts), ensure_ascii=False))
    return 0 if any(counts.values()) else 1


if __name__ == '__main__':
    sys.exit(main())
