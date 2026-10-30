// Resident native media-download worker: one session, one compiled job block,
// one download at a time.  Native async work is owned by WeChat; this script
// only polls the future and releases its reference afterwards.
const downloadKeepAlive = [];
let downloadWorker = null;
let downloadBusy = false;
let downloadPoisoned = false;

function downloadFresh(size) {
  const block = Memory.alloc(size);
  block.writeByteArray(new Uint8Array(size));
  downloadKeepAlive.push(block);
  return block;
}

function downloadBytes(value, name, maximum) {
  if (!Array.isArray(value)) throw new Error(name + ' must be a byte array');
  if (value.length > maximum) throw new Error(name + ' exceeds the configured byte limit');
  const bytes = new Uint8Array(value.length);
  for (let i = 0; i < value.length; i++) {
    const item = value[i];
    if (!Number.isInteger(item) || item < 0 || item > 255) throw new Error(name + ' must hold bytes');
    bytes[i] = item;
  }
  return bytes;
}

function downloadString(header, buffer, capacity, bytes) {
  header.writeByteArray(new Uint8Array(32));
  if (bytes.length >= 16) {
    buffer.writeByteArray(bytes);
    buffer.add(bytes.length).writeU8(0);
    header.writePointer(buffer);
    header.add(16).writeU64(bytes.length);
    header.add(24).writeU64(capacity);
  } else {
    header.writeByteArray(bytes);
    header.add(bytes.length).writeU8(0);
    header.add(16).writeU64(bytes.length);
    header.add(24).writeU64(15);
  }
}

rpc.exports.startWorker = function () {
  if (downloadWorker) throw new Error('Download worker already started');
  const request = config.active_experiment;
  if (!request || request.backend !== 'download_worker') throw new Error('Missing download worker template');
  for (const item of request.functions) {
    // The checkpoint is the hook site itself; Frida rewrites its entry.
    if (item.name === 'thread_checkpoint') continue;
    const actual = Array.from(new Uint8Array(targetModule.base.add(item.rva).readByteArray(item.bytes.length)));
    if (actual.some((value, i) => value !== item.bytes[i])) throw new Error('Download function fingerprint differs: ' + item.name);
  }
  const address = name => targetModule.base.add(request.functions.find(item => item.name === name).rva);
  const job = downloadFresh(704), future = downloadFresh(16);
  const recipientHeader = downloadFresh(32), recipientBuffer = downloadFresh(129);
  const helper = new CModule(request.helper_source);
  downloadKeepAlive.push(helper);
  const worker = new CModule(request.thread_source, {
    job, future_pair:future, recipient_string:recipientHeader,
    context_fn:address('context'), core_fn:address('core'), manager_fn:address('manager'),
    send_fn:address('query'), image_factory_fn:address('download'),
    file_factory_fn:address('copy'), wide_assign_fn:address('conversation'),
    release_pair:helper.release_pair,
    read_memory:Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory'),
    get_thread_id:Process.getModuleByName('kernel32.dll').getExportByName('GetCurrentThreadId')
  });
  downloadKeepAlive.push(worker, job, future);
  const listener = Interceptor.attach(address('thread_checkpoint'), {onLeave:worker.on_checkpoint_leave});
  listeners.push(listener);
  Interceptor.flush();
  Script.pin();
  downloadWorker = {job, future, recipientHeader, recipientBuffer, worker,
    cancel:new NativeFunction(worker.cancel_job, 'int', []),
    close:new NativeFunction(worker.close_download, 'int', []), resultVtable:request.result_vtable};
  send({event:'download_worker_ready', checkpoint_rva:
    request.functions.find(item => item.name === 'thread_checkpoint').rva, backend:'native'});
  return true;
};

rpc.exports.dispatchDownload = function (payload) {
  if (!downloadWorker) throw new Error('Download worker is not started');
  if (downloadPoisoned) throw new Error('Download worker is poisoned after a native timeout');
  if (downloadBusy) throw new Error('Download worker is busy');
  downloadBusy = true;
  try {
    const w = downloadWorker;
    const recipient = downloadBytes(payload.conversation_bytes, 'conversation', 128);
    if (!recipient.length) throw new Error('Conversation must not be empty');
    if (!Number.isInteger(payload.local_id) || payload.local_id <= 0 || payload.local_id > 0xffffffff)
      throw new Error('Invalid local id');
    if (!Number.isInteger(payload.create_time) || payload.create_time <= 0 || payload.create_time > 0xffffffff)
      throw new Error('Invalid create time');
    const expectedType = payload.media_kind === 2 ? 3 : payload.media_kind === 32 ? 43 : 0;
    if (!expectedType || payload.local_type !== expectedType) throw new Error('Invalid message type or media kind');
    if (!/^[0-9]+$/.test(String(payload.server_id))) throw new Error('Invalid server id');
    const serverId = BigInt(payload.server_id);
    if (serverId <= 0n || serverId >= (1n << 63n)) throw new Error('Invalid server id');
    w.job.writeU32(3);
    w.job.add(4).writeByteArray(new Uint8Array(700));
    w.job.add(676).writeU32(payload.local_id);
    w.job.add(680).writeU32(payload.create_time);
    w.job.add(684).writeU32(payload.local_type);
    w.job.add(688).writeU32(payload.media_kind);
    w.job.add(696).writeU32(Number(serverId & 0xffffffffn));
    w.job.add(700).writeU32(Number(serverId >> 32n));
    downloadString(w.recipientHeader, w.recipientBuffer, 128, recipient);
    w.job.writeU32(0);
    const timeout = Number.isInteger(payload.timeout_ms) ? payload.timeout_ms : 10000;
    const started = Date.now();
    return new Promise(resolve => {
      const armTimer = setInterval(() => {
        const state = w.job.readU32();
        if (state === 1 && Date.now() - started < timeout) return;
        if (state === 0 && Date.now() - started < 10000) return;
        clearInterval(armTimer);
        if (state === 1) {
          downloadPoisoned = true;
          downloadBusy = false;
          resolve({event:'active_send_result', kind:'context', accepted:false,
            download_status:'native_timeout', content_verified:false, unsafe:true});
          return;
        }
        if (state === 0) {
          const previous = w.cancel();
          downloadBusy = false;
          resolve({event:'active_send_result', kind:'context', accepted:false,
            download_status:previous === 0 ? 'request_timeout' : 'native_timeout',
            content_verified:false});
          return;
        }
        // The native callback returned; a non-zero error means it never requested
        // the download, so there is no future to poll.
        const nativeError = w.job.add(8).readU32();
        if (nativeError !== 0) {
          w.close();
          downloadBusy = false;
          resolve({event:'active_send_result', kind:'context', accepted:false,
            download_status:'request_failed', native_error:nativeError,
            content_verified:false});
          return;
        }
        // Poll its future without blocking the thread.
        const check = setInterval(() => {
          const object = w.future.readPointer();
          if (object.isNull()) {
            clearInterval(check); downloadBusy = false;
            resolve({event:'active_send_result', kind:'context', accepted:false,
              download_status:'future_missing', content_verified:false});
            return;
          }
          const ready = object.add(0xc4).readU32();
          let terminal = ready !== 0;
          let status = 'pending', nativeStatus = null;
          if (ready === 1) {
            const box = object.add(0xb8).readPointer();
            if (box.isNull() || !box.readPointer().equals(targetModule.base.add(w.resultVtable))) {
              status = 'result_type_mismatch';
            } else {
              nativeStatus = [box.add(8).readU32(), box.add(12).readU32()];
              status = nativeStatus.every(x => x === 0) ? 'native_completed' : 'native_failed';
            }
          } else if (ready === 2) status = 'native_exception';
          else if (ready !== 0) status = 'future_state_invalid';
          if (!terminal && Date.now() - started < timeout) return;
          if (!terminal) {
            status = 'download_pending';
            terminal = true;
          }
          clearInterval(check);
          if (!w.close()) {
            downloadPoisoned = true;
            downloadBusy = false;
            resolve({event:'active_send_result', kind:'context', accepted:false,
              download_status:'native_callback_running', content_verified:false});
            return;
          }
          downloadBusy = false;
          resolve({event:'active_send_result', kind:'context', accepted:status === 'native_completed',
            download_status:status, native_status:nativeStatus, content_verified:false,
            elapsed_ms:Date.now() - started});
        }, 50);
      }, 50);
    });
  } catch (error) {
    downloadBusy = false;
    throw error;
  }
};

rpc.exports.workerStatus = function () {
  if (!downloadWorker) return {started:false, busy:downloadBusy, poisoned:downloadPoisoned};
  return {started:true, busy:downloadBusy, poisoned:downloadPoisoned,
    job_state:downloadWorker.job.readU32()};
};

rpc.exports.stopWorker = function () {
  if (!downloadWorker) return true;
  if (downloadWorker.job.readU32() === 1) return false;
  downloadWorker.close();
  try { Script.unpin(); } catch (error) { /* already unpinned */ }
  downloadWorker = null;
  downloadBusy = false;
  return true;
};
