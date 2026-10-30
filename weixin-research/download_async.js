// Experimental native-future adapter. Nothing calls wait/get on WeChat's thread.
const downloadKeepAlive = [];
let downloadUsed = false;
rpc.exports.dispatch = function () {
  if (downloadUsed) throw new Error('One download per session');
  downloadUsed = true;
  const request = config.active_experiment;
  const address = name => targetModule.base.add(request.functions.find(x => x.name === name).rva);
  for (const entry of request.functions) {
    const actual = new Uint8Array(targetModule.base.add(entry.rva).readByteArray(entry.bytes.length));
    if (actual.some((v, i) => v !== entry.bytes[i])) throw new Error('Function fingerprint differs: ' + entry.name);
  }
  const fresh = size => {
    const p = Memory.alloc(size); p.writeByteArray(new Uint8Array(size));
    downloadKeepAlive.push(p); return p;
  };
  const recipient = new Uint8Array(request.recipient_bytes);
  if (!recipient.length || recipient.length > 128) throw new Error('Invalid conversation');
  const username = fresh(32), bytes = fresh(recipient.length + 1);
  bytes.writeByteArray(recipient);
  if (recipient.length < 16) username.writeByteArray(recipient); else username.writePointer(bytes);
  username.add(16).writeU64(recipient.length);
  username.add(24).writeU64(recipient.length < 16 ? 15 : recipient.length);
  const job = fresh(680), future = fresh(16), helper = new CModule(request.helper_source);
  const worker = new CModule(request.thread_source, {
    job, future_pair:future, recipient_string:username,
    context_fn:address('context'), core_fn:address('core'), manager_fn:address('manager'),
    send_fn:address('query'), image_factory_fn:address('download'),
    file_factory_fn:address('copy'), wide_assign_fn:address('conversation'),
    release_pair:helper.release_pair,
    read_memory:Process.getModuleByName('kernel32.dll').getExportByName('ReadProcessMemory'),
    get_thread_id:Process.getModuleByName('kernel32.dll').getExportByName('GetCurrentThreadId')
  });
  downloadKeepAlive.push(helper, worker, job, future);
  const cancel = new NativeFunction(worker.cancel_job, 'int', []);
  const close = new NativeFunction(worker.close_download, 'int', []);
  Script.pin();
  let listener;
  try { listener = Interceptor.attach(address('thread_checkpoint'), {onLeave:worker.on_checkpoint_leave}); }
  catch (error) { Script.unpin(); throw error; }
  listeners.push(listener); Interceptor.flush();
  const started = Date.now();
  return new Promise(resolve => {
    const timer = setInterval(() => {
      try {
      let state = job.readU32();
      // A running native callback is never unloaded or represented as completed.
      if (state === 1) return;
      if (state === 0) {
        if (Date.now() - started < 10000) return;
        if (cancel() !== 0) return;
        state = 3;
      }
      let terminal = state === 3 || job.add(8).readU32() !== 0;
      let status = terminal ? 'request_failed' : 'pending';
      let nativeStatus = null;
      if (!terminal) {
        const object = future.readPointer();
        if (object.isNull()) { terminal = true; status = 'future_missing'; }
        else {
          const ready = object.add(0xc4).readU32();
          if (ready === 1) {
            const box = object.add(0xb8).readPointer();
            terminal = true;
            if (box.isNull() || !box.readPointer().equals(targetModule.base.add(request.result_vtable))) status = 'result_type_mismatch';
            else {
              nativeStatus = [box.add(8).readU32(), box.add(12).readU32()];
              status = nativeStatus.every(x => x === 0) ? 'native_completed' : 'native_failed';
            }
          } else if (ready === 2) { terminal = true; status = 'native_exception'; }
          else if (ready !== 0) { terminal = true; status = 'future_state_invalid'; }
        }
      }
      if (!terminal && Date.now() - started < request.download_timeout_ms) return;
      if (!terminal) status = 'download_pending';
      clearInterval(timer);
      listener.detach(); Interceptor.flush();
      if (!close()) throw new Error('Native callback still running');
      Script.unpin();
      resolve({event:'active_send_result', kind:'context', accepted:status === 'native_completed',
        download_status:status, native_status:nativeStatus, native_error:job.add(8).readU32(),
        phase:job.add(4).readU32(), job_state:state, content_verified:false});
      } catch (error) {
        if (job.readU32() === 1) return;
        clearInterval(timer); listener.detach(); Interceptor.flush();
        close(); Script.unpin();
        resolve({event:'active_send_result', kind:'context', accepted:false,
          download_status:'inspection_failed', detail:String(error), content_verified:false});
      }
    }, 50);
  });
};
