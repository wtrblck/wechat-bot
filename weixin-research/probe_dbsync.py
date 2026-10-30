"""Dump the first 0x2E8 records of one inbound sync container at 0x38E9F80.

One-shot, read-only structural research: the native callback copies at most two
records into a preallocated block and never interprets them. The raw bytes stay in
runs/sites (gitignored) so the field layout can be derived offline; message text
from the user's own test messages may appear in that dump.

    py -3.14 weixin-research/probe_dbsync.py --pid PID --seconds 60
"""
import argparse
import json
import sys
import threading
from datetime import datetime, timezone
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from pe_image import PEImage
from profile import ROOT, DLL, SHA256
from probe import process_path

sys.path.insert(0, str(ROOT / 'deps'))

ELEMENT_SIZE = 0x2E8
MAX_ELEMENTS = 2

SOURCE = r"""
const module = Process.getModuleByName('Weixin.dll');
if (module.size !== __SIZE__) throw new Error('module size mismatch');
const site = module.base.add(__RVA__);
const range = Process.findRangeByAddress(site);
if (range === null || !range.protection.includes('x')) throw new Error('site not executable');
const counter = Memory.alloc(4); counter.writeU32(0);
const done = Memory.alloc(4); done.writeU32(0);
const elementSize = Memory.alloc(4); elementSize.writeU32(__ELEMENT_SIZE__);
const maxElements = Memory.alloc(4); maxElements.writeU32(__MAX_ELEMENTS__);
const output = Memory.alloc(8 + __ELEMENT_SIZE__ * __MAX_ELEMENTS__);
output.writeByteArray(new Uint8Array(8 + __ELEMENT_SIZE__ * __MAX_ELEMENTS__));
const worker = new CModule(`
#include <stdint.h>
#include <gum/guminterceptor.h>
extern int read_memory(void *, const void *, void *, uint64_t, uint64_t *);
extern volatile unsigned int counter;
extern volatile unsigned int done;
extern unsigned int *element_size;
extern unsigned int *max_elements;
extern unsigned char output[];
static int read_at(const void *p, void *out, uint64_t size) {
    uint64_t n = 0;
    return p && read_memory((void *)(intptr_t)-1, p, out, size, &n) && n == size;
}
void on_enter(void *context) {
    __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
    if (done) return;
    void *container = gum_invocation_context_get_nth_argument(context, 2);
    uint64_t begin = 0, end = 0;
    if (!read_at(container, &begin, 8)) return;
    if (!read_at((void *)(uintptr_t)((uintptr_t)container + 8), &end, 8)) return;
    if (end <= begin) return;
    uint64_t span = end - begin;
    uint32_t size = *element_size;
    if (size == 0 || span % size != 0) return;
    uint64_t count = span / size;
    if (count > *max_elements) count = *max_elements;
    for (uint32_t i = 0; i < count; i++) {
        if (!read_at((void *)(uintptr_t)(begin + (uint64_t)i * size), output + 8 + i * size, size)) return;
    }
    *(uint32_t *)output = (uint32_t)count;
    __asm__ __volatile__("" : : : "memory");
    done = 1;
}
`, {read_memory: Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory'),
    counter, done, element_size: elementSize, max_elements: maxElements, output});
Interceptor.attach(site, {onEnter: worker.on_enter});
Interceptor.flush();
send({event: 'armed', rva: __RVA__, entry: Array.from(new Uint8Array(site.readByteArray(16)))});
const heartbeat = setInterval(() => send({event: 'counts', hits: counter.readU32(), done: done.readU32()}), 1000);
const timer = setInterval(() => {
  if (done.readU32()) {
    clearInterval(timer);
    clearInterval(heartbeat);
    const count = output.readU32();
    const bytes = Array.from(new Uint8Array(output.add(8).readByteArray(__ELEMENT_SIZE__ * count)));
    send({event: 'dump', count, hits: counter.readU32(), hex: bytes.map(b => b.toString(16).padStart(2, '0')).join('')});
  }
}, 100);
setTimeout(() => { clearInterval(timer); clearInterval(heartbeat); send({event: 'timeout', hits: counter.readU32()}); }, __SECONDS__ * 1000);
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--pid', type=int, required=True)
    parser.add_argument('--seconds', type=int, default=60)
    parser.add_argument('--rva', type=lambda value: int(value, 0), default=0x38E9F80)
    args = parser.parse_args()
    if args.pid <= 0 or not 1 <= args.seconds <= 60:
        parser.error('invalid pid or seconds')
    image = PEImage(DLL)
    if image.sha256 != SHA256:
        raise SystemExit('pinned DLL changed')
    owner = image.owner(args.rva)
    if not owner or owner['begin'] != args.rva:
        raise SystemExit('not a function entry')
    if process_path(args.pid).name.lower() != 'weixin.exe':
        raise SystemExit('pid is not Weixin.exe')
    import frida
    session = frida.attach(args.pid)
    source = (SOURCE.replace('__SIZE__', str(image.image_size))
                    .replace('__RVA__', str(args.rva))
                    .replace('__ELEMENT_SIZE__', str(ELEMENT_SIZE))
                    .replace('__MAX_ELEMENTS__', str(MAX_ELEMENTS))
                    .replace('__SECONDS__', str(args.seconds)))
    script = session.create_script(source, runtime='qjs')
    finished = threading.Event()
    result = {}

    def on_message(message, data):
        if message.get('type') != 'send':
            print(json.dumps(dict(event='script_error', detail=message)), flush=True)
            finished.set()
            return
        payload = message['payload']
        print(json.dumps({key: value for key, value in payload.items() if key != 'hex'}, ensure_ascii=False), flush=True)
        if payload.get('event') in ('dump', 'timeout'):
            result.update(payload)
            finished.set()

    script.on('message', on_message)
    script.load()
    finished.wait(args.seconds + 5)
    output = ROOT / 'runs' / 'sites' / (datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%SZ') + '-dbsync.json')
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(dict(pid=args.pid, rva=args.rva, element_size=ELEMENT_SIZE,
                                      sha256=image.sha256, result=result), indent=2), encoding='utf-8')
    try:
        script.unload()
    finally:
        session.detach()
    print(json.dumps(dict(result=str(output), count=result.get('count', 0))), flush=True)
    return 0 if result.get('count') else 1


if __name__ == '__main__':
    sys.exit(main())
