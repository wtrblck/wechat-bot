// One controlled call, no retained native callback and no replayed pointers.
// Text and recipient travel as explicit UTF-8 bytes; every string handed to WeChat
// is copied by WeChat's own assignment routine, so no probe buffer is retained.
const activeKeepAlive = [];
let activeUsed = false;

function activeBytes(value, name, maximum) {
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

rpc.exports.dispatch = function () {
  if (activeUsed) throw new Error('Only one active experiment per session');
  activeUsed = true;
  const request = config.active_experiment;
  if (!request || !['context', 'text', 'image', 'file', 'video', 'voice', 'emoji'].includes(request.kind))
    throw new Error('Unsupported kind');
  for (const item of request.functions) {
    const actual = Array.from(new Uint8Array(targetModule.base.add(item.rva).readByteArray(item.bytes.length)));
    if (actual.some((value, i) => value !== item.bytes[i])) throw new Error('Active function fingerprint differs: ' + item.name);
  }
  for (const item of request.data_fingerprints || []) {
    for (let i=0;i<item.pointer_rvas.length;i++) {
      if (!targetModule.base.add(item.rva+i*Process.pointerSize).readPointer().equals(targetModule.base.add(item.pointer_rvas[i])))
        throw new Error('Active data fingerprint differs');
    }
  }
  if (!request.on_app_thread) throw new Error('External-thread send calls are unsupported');
  const limits = request.limits || {};
  const recipient = activeBytes(request.recipient_bytes, 'recipient', limits.recipient_bytes || 128);
  if (recipient.length < 1) throw new Error('Recipient must not be empty');
  const text = request.kind === 'text'
    ? activeBytes(request.text_bytes, 'text', limits.text_bytes || 4096) : new Uint8Array(0);
  if (request.kind === 'text' && text.length < 1) throw new Error('Text must not be empty');
  const helper = new CModule(request.helper_source);
  activeKeepAlive.push(helper);
  const fresh = size => {
    const block = Memory.alloc(size);
    block.writeByteArray(new Uint8Array(size));
    activeKeepAlive.push(block);
    return block;
  };
  // MSVC std::string layout: {data, size, capacity|inline buffer}. Capacity 15 means
  // inline storage; a heap source only needs size/capacity to stay consistent.
  const stringFromBytes = bytes => {
    const object = fresh(32);
    if (bytes.length < 16) {
      object.writeByteArray(bytes);
      object.add(16).writeU64(bytes.length);
      object.add(24).writeU64(15);
      return object;
    }
    const buffer = fresh(bytes.length + 1);
    buffer.writeByteArray(bytes);
    object.writePointer(buffer);
    object.add(16).writeU64(bytes.length);
    object.add(24).writeU64(bytes.length);
    return object;
  };
  if (request.on_app_thread) {
    const address = name => targetModule.base.add(request.functions.find(item => item.name === name).rva);
    const job = fresh(680);
    job.add(12).writeU32({context:0, text:1, image:2, file:3, video:4, voice:5, emoji:6}[request.kind]);
    const extraBindings = {};
    if (request.kind === 'emoji') {
      if (!(request.local_emoji ? request.emoji_type === 4 : [1,2,3].includes(request.emoji_type))) throw new Error('Invalid emoji type');
      const record = fresh(0x1c0);
      const fields = {md5:0, product_id:0x20, aes_key:0x40, thumb_url:0x60, tp_url:0x80,
        auth_key:0xa0, cdn_url:0xc0, extern_url:0xe0, extern_md5:0x100, encrypt_url:0x128,
        designer_id:0x148, activity_id:0x168, caption:0x188};
      for (const [field, offset] of Object.entries(fields)) {
        const bytes = activeBytes((request.emoji_fields || {})[field] || [], 'emoji field', 4096);
        if (field === 'md5' && bytes.length !== 32 || field === 'aes_key' && bytes.length !== (request.local_emoji ? 0 : 32)) throw new Error('Invalid emoji identity/key');
        const value = stringFromBytes(bytes);
        record.add(offset).writeByteArray(value.readByteArray(32));
      }
      record.add(0x120).writeU32(request.emoji_type);
      Object.assign(extraBindings, {emoji_record:record,
        emoji_control_vtable:targetModule.base.add(request.emoji_control_vtable),
        emoji_new_fn:address('emoji_new'), emoji_construct_fn:address('emoji_construct')});
    }
    const voice = fresh(32), duration = fresh(4);
    const voiceBytes = request.voice_bytes || [];
    if (request.kind === 'voice' && (voiceBytes.length < 12 || voiceBytes.length > 2097152 ||
        !Number.isInteger(request.duration_ms) || request.duration_ms < 20 || request.duration_ms > 60000))
      throw new Error('Invalid bounded voice payload');
    const voiceBuffer = fresh(voiceBytes.length + 1);
    voiceBuffer.writeByteArray(voiceBytes);
    if (voiceBytes.length < 16) voice.writeByteArray(voiceBytes); else voice.writePointer(voiceBuffer);
    voice.add(16).writeU64(voiceBytes.length); voice.add(24).writeU64(voiceBytes.length < 16 ? 15 : voiceBytes.length);
    duration.writeU32(request.duration_ms || 0);
    const wide = fresh(32), wideBuffer = Memory.allocUtf16String(request.path || '');
    const wideLength = (request.path || '').length;
    if (wideLength < 8) wide.writeByteArray(wideBuffer.readByteArray(wideLength * 2));
    else wide.writePointer(wideBuffer);
    wide.add(16).writeU64(wideLength); wide.add(24).writeU64(wideLength < 8 ? 7 : wideLength);
    activeKeepAlive.push(wideBuffer);
    if (request.local_emoji) {
      if (request.kind !== 'emoji' || request.emoji_type !== 4 || !request.path) throw new Error('Invalid local emoji');
      const input = fresh(96), pair = fresh(16);
      input.writeByteArray(stringFromBytes(activeBytes(request.emoji_fields.md5, 'md5', 32)).readByteArray(32));
      input.add(64).writeByteArray(wide.readByteArray(32));
      pair.writePointer(input);
      job.add(20).writeU32(1);
      if (!Number.isInteger(request.local_emoji_size) || request.local_emoji_size < 1 || request.local_emoji_size > 64*1024*1024) throw new Error('Invalid local emoji length');
      const size = fresh(4); size.writeU32(request.local_emoji_size);
      Object.assign(extraBindings, {emoji_import_fn:address('emoji_import'), local_emoji_input:pair,
        emoji_local_copy_fn:address('emoji_local_copy'), local_emoji_size:size,
        local_emoji_control_vtable:targetModule.base.add(request.local_emoji_control_vtable),
        local_emoji_resource_vtable:targetModule.base.add(request.local_emoji_resource_vtable)});
    }
    const worker = new CModule(request.thread_source, {
      ...extraBindings, job, text_string:stringFromBytes(text), recipient_string:stringFromBytes(recipient),
      context_fn:address('context'), core_fn:address('core'), manager_fn:address('manager'),
      factory_fn:address('text_factory'), send_fn:address('send'), image_fn:address('image'),
      image_factory_fn:address('image_factory'), file_factory_fn:address('file_factory'),
      video_factory_fn:address('video_factory'), string_destroy_fn:address('string_destroy'),
      voice_factory_fn:address('voice_factory'), voice_string:voice, voice_duration:duration,
      wide_assign_fn:address('wide_assign'), wide_path:wide,
      narrow_assign_fn:address('narrow_assign'),
      ...(request.kind === 'emoji' ? {emoji_factory_fn:address('emoji_factory')} : {}),
      release_pair:helper.release_pair,
      read_memory:Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory'),
      get_thread_id:Process.getModuleByName('kernel32.dll').getExportByName('GetCurrentThreadId')
    });
    activeKeepAlive.push(worker, job);
    Script.pin();
    let listener;
    try {
      listener = Interceptor.attach(address('thread_checkpoint'), {onLeave:worker.on_checkpoint_leave});
    } catch (error) { Script.unpin(); throw error; }
    listeners.push(listener);
    Interceptor.flush();
    send({event:'active_checkpoint_armed', kind:request.kind,
      rva:request.functions.find(item => item.name === 'thread_checkpoint').rva, callback_backend:'native'});
    const cancel = new NativeFunction(worker.cancel_job, 'int', []);
    return new Promise(resolve => {
      const started = Date.now();
      const poll = setInterval(() => {
        const status = job.readU32();
        if (status !== 2 && (status === 1 || Date.now() - started < 10000)) return;
        if (status === 0 && cancel() !== 0) return;
        clearInterval(poll);
        listener.detach(); Interceptor.flush();
        Script.unpin();
        const output = job.add(32), error = job.add(8).readU32();
        const accepted = status === 2 && error === 0 && (request.kind === 'context' ||
          output.readU32() === 0 && output.add(4).readU32() === 0);
        const detailLength = job.add(160).readU32();
        const detail = (request.kind !== 'emoji' || request.local_emoji) && detailLength > 0 && detailLength <= 512 ? job.add(164).readUtf8String(detailLength) : null;
        resolve({event:'active_send_result', kind:request.kind, accepted, native_error:error,
          detail,
          phase:job.add(4).readU32(), thread_id:job.add(16).readU32(), job_state:status,
          local_status:request.kind !== 'context' ? [output.readU32(), output.add(4).readU32()] : [],
          local_ids:[],
          duration_ms:request.kind === 'voice' ? request.duration_ms : null,
          recipient:request.recipient, recipient_bytes:recipient.length, text_bytes:text.length,
          delivery_verified:false});
      }, 50);
    });
  }
  throw new Error('Unsupported active experiment kind');
};
