// Resident send worker: one Frida session, one native checkpoint interceptor,
// pre-allocated buffers reused for every message.  No per-message attach and no
// JS on a WeChat business thread.  The native template is app_thread_send.c.
const sendKeepAlive = [];
let sendWorker = null;
let sendBusy = false;
let sendPoisoned = false;

function sendBytes(value, name, maximum) {
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

function sendFresh(size) {
  const block = Memory.alloc(size);
  block.writeByteArray(new Uint8Array(size));
  sendKeepAlive.push(block);
  return block;
}

function resetStringHeader(header) {
  header.writeByteArray(new Uint8Array(32));
}

// MSVC std::string source: inline below 16 bytes, otherwise a stable buffer.
function writeString(header, buffer, capacity, bytes) {
  resetStringHeader(header);
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

function resetWideHeader(header) {
  header.writeByteArray(new Uint8Array(32));
}

function writeWide(header, buffer, capacity, path) {
  resetWideHeader(header);
  const units = path.length;
  if (units >= 8) {
    buffer.writeUtf16String(path);
    buffer.add(units * 2).writeU16(0);
    header.writePointer(buffer);
    header.add(16).writeU64(units);
    header.add(24).writeU64(capacity);
  } else {
    header.writeUtf16String(path);
    header.add(units * 2).writeU16(0);
    header.add(16).writeU64(units);
    header.add(24).writeU64(7);
  }
}

rpc.exports.startWorker = function () {
  if (sendWorker) throw new Error('Send worker already started');
  const request = config.active_experiment;
  if (!request || request.backend !== 'send_worker') throw new Error('Missing send worker template');
  for (const item of request.functions) {
    // The checkpoint is the hook site itself: Frida rewrites its entry. Its
    // original bytes are verified on disk and all callees keep their check.
    if (item.name === 'thread_checkpoint') continue;
    const actual = Array.from(new Uint8Array(targetModule.base.add(item.rva).readByteArray(item.bytes.length)));
    if (actual.some((value, i) => value !== item.bytes[i])) throw new Error('Send function fingerprint differs: ' + item.name);
  }
  for (const item of request.data_fingerprints || []) {
    for (let i = 0; i < item.pointer_rvas.length; i++) {
      if (!targetModule.base.add(item.rva + i * Process.pointerSize).readPointer()
          .equals(targetModule.base.add(item.pointer_rvas[i])))
        throw new Error('Send data fingerprint differs');
    }
  }
  const address = name => targetModule.base.add(request.functions.find(item => item.name === name).rva);
  const job = sendFresh(680);
  const textHeader = sendFresh(32), textBuffer = sendFresh(4097);
  const recipientHeader = sendFresh(32), recipientBuffer = sendFresh(129);
  const voiceHeader = sendFresh(32), voiceBuffer = sendFresh(2 * 1024 * 1024 + 2);
  const duration = sendFresh(4);
  const wideHeader = sendFresh(32), wideBuffer = sendFresh(4096 * 2);
  const record = sendFresh(0x1c0);
  const fieldOffsets = {md5:0, product_id:0x20, aes_key:0x40, thumb_url:0x60, tp_url:0x80,
    auth_key:0xa0, cdn_url:0xc0, extern_url:0xe0, extern_md5:0x100, encrypt_url:0x128,
    designer_id:0x148, activity_id:0x168, caption:0x188};
  const fieldBuffers = {};
  for (const [field, offset] of Object.entries(fieldOffsets)) {
    const header = record.add(offset);
    resetStringHeader(header);
    header.add(24).writeU64(15);
    fieldBuffers[field] = sendFresh(4097);
  }
  const localInput = sendFresh(96), localPair = sendFresh(16), localSize = sendFresh(4);
  localPair.writePointer(localInput);
  const localMd5Buffer = sendFresh(4097), localPathBuffer = sendFresh(8192);
  const helper = new CModule(request.helper_source);
  sendKeepAlive.push(helper);
  const worker = new CModule(request.thread_source, {
    job, text_string:textHeader, recipient_string:recipientHeader, wide_path:wideHeader,
    voice_string:voiceHeader, voice_duration:duration,
    context_fn:address('context'), core_fn:address('core'), manager_fn:address('manager'),
    factory_fn:address('text_factory'), send_fn:address('send'), image_fn:address('image'),
    image_factory_fn:address('image_factory'), file_factory_fn:address('file_factory'),
    video_factory_fn:address('video_factory'), string_destroy_fn:address('string_destroy'),
    voice_factory_fn:address('voice_factory'), wide_assign_fn:address('wide_assign'),
    narrow_assign_fn:address('narrow_assign'),
    emoji_record:record, emoji_control_vtable:targetModule.base.add(request.emoji_control_vtable),
    emoji_new_fn:address('emoji_new'), emoji_construct_fn:address('emoji_construct'),
    emoji_factory_fn:address('emoji_factory'),
    ...(request.local_emoji ? {emoji_import_fn:address('emoji_import'), local_emoji_input:localPair,
      emoji_local_copy_fn:address('emoji_local_copy'), local_emoji_size:localSize,
      local_emoji_control_vtable:targetModule.base.add(request.local_emoji_control_vtable),
      local_emoji_resource_vtable:targetModule.base.add(request.local_emoji_resource_vtable)} : {}),
    release_pair:helper.release_pair,
    read_memory:Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory'),
    get_thread_id:Process.getModuleByName('kernel32.dll').getExportByName('GetCurrentThreadId')
  });
  sendKeepAlive.push(worker, job);
  const listener = Interceptor.attach(address('thread_checkpoint'), {onLeave:worker.on_checkpoint_leave});
  listeners.push(listener);
  Interceptor.flush();
  Script.pin();
  sendWorker = {job, textHeader, textBuffer, recipientHeader, recipientBuffer, voiceHeader,
    voiceBuffer, duration, wideHeader, wideBuffer, record, fieldOffsets, fieldBuffers,
    localInput, localPair, localMd5Buffer, localPathBuffer, localSize, worker};
  send({event:'send_worker_ready', checkpoint_rva:
    request.functions.find(item => item.name === 'thread_checkpoint').rva, backend:'native'});
  return true;
};

rpc.exports.dispatchJob = function (payload) {
  if (!sendWorker) throw new Error('Send worker is not started');
  if (sendPoisoned) throw new Error('Send worker is poisoned after a native timeout');
  if (sendBusy) throw new Error('Send worker is busy');
  sendBusy = true;
  try {
    const request = config.active_experiment;
    const limits = request.limits || {};
    const kindNames = {context:0, text:1, image:2, file:3, video:4, voice:5, emoji:6};
    const kind = payload.kind;
    if (!(kind in kindNames)) throw new Error('Unsupported kind');
    const recipient = sendBytes(payload.recipient_bytes, 'recipient', limits.recipient_bytes || 128);
    if (recipient.length < 1) throw new Error('Recipient must not be empty');
    const text = kind === 'text' ? sendBytes(payload.text_bytes || [], 'text', limits.text_bytes || 4096) : new Uint8Array(0);
    if (kind === 'text' && text.length < 1) throw new Error('Text must not be empty');
    const w = sendWorker;
    w.job.writeU32(3);                       // disarm while rewriting the job
    w.job.add(4).writeByteArray(new Uint8Array(676));
    w.job.add(12).writeU32(kindNames[kind]);
    writeString(w.recipientHeader, w.recipientBuffer, 128, recipient);
    writeString(w.textHeader, w.textBuffer, 4096, text);
    if (kind === 'voice') {
      const voiceBytes = sendBytes(payload.voice_bytes || [], 'voice', 2 * 1024 * 1024);
      if (voiceBytes.length < 12) throw new Error('Invalid bounded voice payload');
      const ms = payload.duration_ms;
      if (!Number.isInteger(ms) || ms < 20 || ms > 60000 || ms % 20) throw new Error('Invalid voice duration');
      if (voiceBytes.length >= 16) {
        w.voiceBuffer.writeByteArray(voiceBytes);
        w.voiceBuffer.add(voiceBytes.length).writeU8(0);
        resetStringHeader(w.voiceHeader);
        w.voiceHeader.writePointer(w.voiceBuffer);
        w.voiceHeader.add(16).writeU64(voiceBytes.length);
        w.voiceHeader.add(24).writeU64(2 * 1024 * 1024);
      } else {
        writeString(w.voiceHeader, w.voiceBuffer, 2 * 1024 * 1024, voiceBytes);
      }
      w.duration.writeU32(ms);
    } else {
      resetStringHeader(w.voiceHeader);
      w.voiceHeader.add(24).writeU64(15);
      w.duration.writeU32(0);
    }
    if (kind === 'image' || kind === 'file' || kind === 'video' || (kind === 'emoji' && payload.local_emoji)) {
      const path = typeof payload.path === 'string' ? payload.path : '';
      if (!path) throw new Error('Path is required');
      if (path.length > 1024) throw new Error('Path is too long');
      writeWide(w.wideHeader, w.wideBuffer, 4096, path);
    } else {
      resetWideHeader(w.wideHeader);
      w.wideHeader.add(24).writeU64(7);
    }
    if (kind === 'emoji') {
      const fields = payload.emoji_fields || {};
      const local = payload.local_emoji === true;
      if (local && !request.local_emoji) throw new Error('Local emoji unavailable');
      for (const [field, offset] of Object.entries(w.fieldOffsets)) {
        const bytes = sendBytes(fields[field] || [], 'emoji field', 4096);
        if (field === 'md5' && (bytes.length !== 32 || !/^[a-f0-9]{32}$/.test(String.fromCharCode(...bytes)))) throw new Error('Invalid emoji identity');
        if (field === 'aes_key' && bytes.length !== (local ? 0 : 32)) throw new Error('Invalid emoji key');
        if (local && field !== 'md5' && field !== 'caption' && bytes.length) throw new Error('Unexpected local emoji resource');
        writeString(w.record.add(offset), w.fieldBuffers[field], 4096, bytes);
      }
      const type = payload.emoji_type;
      if (!(local ? type === 4 : [1, 2, 3].includes(type))) throw new Error('Invalid emoji type');
      w.record.add(0x120).writeU32(type);
      if (local) {
        const path = payload.path;
        if (typeof path !== 'string' || !path || path.length > 1024 || /[\x00-\x1f]/.test(path)) throw new Error('Invalid local emoji path');
        writeString(w.localInput, w.localMd5Buffer, 4096, sendBytes(fields.md5, 'md5', 32));
        writeWide(w.localInput.add(64), w.localPathBuffer, 4096, path);
        if (!Number.isInteger(payload.local_emoji_size) || payload.local_emoji_size < 1 || payload.local_emoji_size > 64*1024*1024) throw new Error('Invalid local emoji length');
        w.localSize.writeU32(payload.local_emoji_size);
        w.job.add(20).writeU32(1);
      }
    }
    w.job.writeU32(0);                       // arm: the native claim observes this last
    const timeout = Number.isInteger(payload.timeout_ms) ? payload.timeout_ms : 20000;
    const started = Date.now();
    return new Promise(resolve => {
      const poll = setInterval(() => {
        const status = w.job.readU32();
        if (status === 2) {
          clearInterval(poll);
          sendBusy = false;
          const output = w.job.add(32), error = w.job.add(8).readU32();
          const accepted = error === 0 && (kind === 'context' ||
            output.readU32() === 0 && output.add(4).readU32() === 0);
          const detailLength = w.job.add(160).readU32();
          const detail = kind !== 'emoji' && detailLength > 0 && detailLength <= 512
            ? w.job.add(164).readUtf8String(detailLength) : null;
          resolve({event:'active_send_result', kind, accepted, native_error:error,
            detail, phase:w.job.add(4).readU32(), thread_id:w.job.add(16).readU32(),
            job_state:status, local_status:kind !== 'context'
              ? [output.readU32(), output.add(4).readU32()] : [],
            duration_ms:kind === 'voice' ? payload.duration_ms : null,
            recipient_bytes:recipient.length, text_bytes:text.length,
            delivery_verified:false});
          return;
        }
        if (status === 3) {
          clearInterval(poll);
          sendBusy = false;
          resolve({event:'active_send_result', kind, accepted:false, job_state:3,
            cancelled:true, delivery_verified:false, native_error:null, detail:'cancelled'});
          return;
        }
        if (Date.now() - started < timeout) return;
        clearInterval(poll);
        if (status === 1) {
          // A native callback is still running: never unload it or reuse the job.
          sendPoisoned = true;
          resolve({event:'active_send_result', kind, accepted:false, timed_out:true,
            unsafe:true, job_state:1, delivery_verified:false,
            native_error:null, detail:'native timeout while running'});
          return;
        }
        const cancel = new NativeFunction(w.worker.cancel_job, 'int', []);
        const previous = cancel();
        sendBusy = false;
        resolve({event:'active_send_result', kind, accepted:false, timed_out:true,
          unsafe:previous !== 0, job_state:previous === 0 ? 3 : 1,
          delivery_verified:false, native_error:null,
          detail:previous === 0 ? 'no checkpoint before timeout' : 'cancellation raced'});
      }, 50);
    });
  } catch (error) {
    sendBusy = false;
    throw error;
  }
};

rpc.exports.workerStatus = function () {
  if (!sendWorker) return {started:false, busy:sendBusy, poisoned:sendPoisoned, job_state:null};
  return {started:true, busy:sendBusy, poisoned:sendPoisoned, job_state:sendWorker.job.readU32()};
};

rpc.exports.stopWorker = function () {
  if (!sendWorker) return true;
  const state = sendWorker.job.readU32();
  if (state === 1) return false;             // never unload a running native callback
  sendWorker.job.writeU32(3);
  try { Script.unpin(); } catch (error) { /* the runtime may already be unpinned */ }
  sendWorker = null;
  sendBusy = false;
  return true;
};

