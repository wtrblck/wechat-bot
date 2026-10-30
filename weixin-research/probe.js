'use strict';

// Observation core; active experiments append an explicit one-shot dispatcher.
const config = __CONFIG__;
const targetModule = Process.getModuleByName(config.module_name);
// Do not trust enumeration order / Process.mainModule on this Windows runtime.
const executableModule = Process.getModuleByName(config.process_name);
if (Process.arch !== 'x64') {
  throw new Error('Unsupported process or architecture');
}
if (targetModule.size !== config.image_size) throw new Error('Module size mismatch');
if (config.sites.length > 1) throw new Error('Only one observation site is allowed');
const listeners = [];
const counts = {};
const backend = config.callback_backend || 'native';
if (!['js', 'native'].includes(backend)) throw new Error('Unsupported callback backend');
let nativeModule = null;
let nativeCounter = null;
// Ring layout must match receive_test.c exactly: 32-byte header, then
// content[4096], sender[256], recipient[256] per slot.
const CAPTURE_RING_CAPACITY = 64;
const CAPTURE_CONTENT_MAX = 4096;
const CAPTURE_ID_MAX = 256;
const CAPTURE_SLOT_SIZE = 32 + CAPTURE_CONTENT_MAX + 2 * CAPTURE_ID_MAX;
let captureRing = null;
let captureIndex = null;
// Diagnostics block shared with receive_test.c: elements, unreadable, oversized,
// filtered, published, span_invalid, clamped, reserved.
const CAPTURE_STAT_NAMES = ['elements', 'unreadable', 'oversized', 'filtered',
                            'published', 'span_invalid', 'clamped', 'reserved',
                            'last_span_low', 'last_span_high', 'last_count', 'reserved2'];
const CAPTURE_STAT_BYTES = CAPTURE_STAT_NAMES.length * 4;
let captureStats = null;
let captureModule = null;
const captureFilter = [];
let drained = 0;
let delivered = 0;
let skipped = 0;
let invalid = 0;
let state = 'prepared';
let heartbeat = null;
let deadline = null;
let finalResult = null;

// Drain every complete ring record that has not been reclaimed. A slot whose
// index is no longer reachable was overwritten by a newer producer and is
// counted as a skip instead of being read as a torn record.
function drainCapture() {
  if (captureIndex === null) return;
  const written = captureIndex.readU32();
  let next = drained;
  while (next < written) {
    if (written >= next + CAPTURE_RING_CAPACITY) { skipped++; next++; continue; }
    const slot = captureRing.add((next % CAPTURE_RING_CAPACITY) * CAPTURE_SLOT_SIZE);
    if (slot.readU32() !== next + 1) break;  // producer still writing; retry later
    const messageType = slot.add(4).readU32();
    const messageId = slot.add(8).readU64();
    const timestamp = slot.add(16).readU32();
    const contentLength = slot.add(20).readU32();
    const senderLength = slot.add(24).readU32();
    const recipientLength = slot.add(28).readU32();
    if (contentLength > 0 && contentLength <= CAPTURE_CONTENT_MAX &&
        senderLength <= CAPTURE_ID_MAX && recipientLength <= CAPTURE_ID_MAX) {
      send({event: 'test_message',
            schema: config.capture_kind === 'send' ? 'wechat-send-ring-1' : 'wechat-sync-ring-1',
            ring_index: next, message_type: messageType, message_id: messageId.toString(),
            timestamp,
            content: slot.add(32).readUtf8String(contentLength),
            sender: slot.add(32 + CAPTURE_CONTENT_MAX).readUtf8String(senderLength),
            recipient: slot.add(32 + CAPTURE_CONTENT_MAX + CAPTURE_ID_MAX).readUtf8String(recipientLength)});
      delivered++;
    } else {
      invalid++;  // consumed slot with an unreadable or out-of-range record
    }
    next++;
  }
  drained = next;
}

function captureState() {
  if (captureIndex === null) return null;
  const state = {received: captureIndex.readU32(), delivered, skipped, invalid};
  for (let index = 0; index < CAPTURE_STAT_NAMES.length; index++) {
    state[CAPTURE_STAT_NAMES[index]] = captureStats.add(index * 4).readU32();
  }
  return state;
}

// Targets and prefix come from the observation policy; both layers must default
// to the same narrow scope. The buffers are kept alive for the whole script.
function captureFilterStrings() {
  const filter = config.capture_filter || {};
  const targets = Array.isArray(filter.targets) && filter.targets.length ? filter.targets : ['filehelper'];
  const checked = targets.map(value => {
    if (typeof value !== 'string' || value.length === 0 || value.length > 128 || value.indexOf('\n') >= 0)
      throw new Error('Invalid observation target');
    return value;
  });
  const prefix = typeof filter.prefix === 'string' ? filter.prefix : 'wxbot-';
  if (prefix.length > 64) throw new Error('Observation prefix too long');
  const mode = typeof filter.mode === 'string' ? filter.mode : 'prefix';
  if (!['prefix', 'contains'].includes(mode)) throw new Error('Unsupported observation mode');
  const joined = checked.join('\n');
  if (joined.length > 4096) throw new Error('Observation target list too long');
  captureFilter.push(Memory.allocUtf8String(joined), Memory.allocUtf8String(prefix));
  return {targets: captureFilter[captureFilter.length - 2], prefix: captureFilter[captureFilter.length - 1], mode};
}

function snapshot() {
  drainCapture();
  if (nativeCounter !== null && config.sites.length === 1) {
    counts[config.sites[0].name] = nativeCounter.readU32();
  }
  return {...counts};
}

function finish(reason) {
  if (state === 'finished') return finalResult;
  clearInterval(heartbeat);
  clearTimeout(deadline);
  for (const listener of listeners) listener.detach();
  Interceptor.flush();
  state = 'finished';
  finalResult = {event: 'finished', reason, counts: snapshot(), capture: captureState()};
  send(finalResult);
  return finalResult;
}

rpc.exports = {
  inspect() {
    return {pid: Process.id, module_path: targetModule.path,
            image_size: targetModule.size, arch: Process.arch,
            process_name: executableModule.name, frida_version: Frida.version,
            runtime: Script.runtime};
  },
  start() {
    if (state !== 'prepared') throw new Error('Probe already started or finished');
    for (const site of config.sites) {
      if (!Number.isInteger(site.rva) || site.rva < 0 || site.rva + site.bytes.length > targetModule.size) {
        throw new Error('Site outside module');
      }
      const address = targetModule.base.add(site.rva);
      const range = Process.findRangeByAddress(address);
      if (range === null || !range.protection.includes('x')) throw new Error('Site is not executable');
      const actual = Array.from(new Uint8Array(address.readByteArray(site.bytes.length)));
      if (actual.some((value, i) => value !== site.bytes[i])) {
        throw new Error('Runtime fingerprint mismatch at ' + site.name);
      }
    }
    try {
      if (backend === 'native' && config.sites.length === 1) {
        nativeCounter = Memory.alloc(4);
        nativeCounter.writeU32(0);
      }
      if (config.capture_test) {
        if (backend !== 'native' || config.sites.length !== 1) throw new Error('Capture requires one native site');
        const filter = captureFilterStrings();
        captureRing = Memory.alloc(CAPTURE_SLOT_SIZE * CAPTURE_RING_CAPACITY);
        captureRing.writeByteArray(new Uint8Array(CAPTURE_SLOT_SIZE * CAPTURE_RING_CAPACITY));
        captureIndex = Memory.alloc(4);
        captureIndex.writeU32(0);
        captureStats = Memory.alloc(CAPTURE_STAT_BYTES);
        captureStats.writeByteArray(new Uint8Array(CAPTURE_STAT_BYTES));
        const filterMode = Memory.alloc(4);
        filterMode.writeU32(filter.mode === 'contains' ? 1 : 0);
        captureModule = new CModule(config.capture_source, {
          capture_index: captureIndex, ring: captureRing, counter: nativeCounter,
          capture_stats: captureStats, filter_mode: filterMode,
          filter_targets: filter.targets, filter_prefix: filter.prefix,
          read_memory: Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory')
        });
      }
      if (backend === 'native' && config.sites.length === 1) {
        nativeModule = new CModule(`
          extern volatile unsigned int counter;
          void on_enter(void *context) {
            __asm__ __volatile__("lock incl %0" : "+m" (counter) : : "memory");
          }
        `, {counter: nativeCounter});
      }
      for (const site of config.sites) {
        counts[site.name] = 0;
        listeners.push(Interceptor.attach(targetModule.base.add(site.rva), {
          onEnter: captureModule !== null ? (config.capture_kind === 'send' ? captureModule.capture_send_enter : captureModule.capture_enter) :
            (nativeModule !== null ? nativeModule.on_enter : function () { counts[site.name]++; })
        }));
      }
      Interceptor.flush();
      state = 'running';
      // A resident worker has no fixed deadline; the host owns its lifecycle.
      if (!config.resident) deadline = setTimeout(() => finish('deadline'), config.seconds * 1000);
      if (!config.quiet) heartbeat = setInterval(() => send({event: 'counts', counts: snapshot(), capture: captureState(),
                                        frida_heap_size: Frida.heapSize}), 1000);
      send({event: 'started', pid: Process.id, mode: config.sites.length ? 'single-site' : 'baseline',
            callback_backend: backend, sites: config.sites.map(site => site.name)});
      return true;
    } catch (error) {
      finish('setup-failed');
      throw error;
    }
  },
  finish() { return finish('host-request'); }
};
