"""Native type-47 ownership, identity rejection and asynchronous survival."""
import contextlib,json,subprocess,sys,threading,struct,time
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from integration_active import build_case
from pe_image import PEImage
from policy import SendPolicy
from probe import Journal,run_probe
from worker_session import WorkerSession

def resident_case(executable,image,directory):
 observation=directory/'resident-observation.jsonl'
 with subprocess.Popen([str(executable),str(observation)],stdout=subprocess.PIPE,text=True) as process:
  session=None
  watchdog=threading.Timer(30,process.terminate);watchdog.start()
  try:
   extra=json.loads(process.stdout.readline());vtable=extra.pop('emoji_control_vtable')
   local_control=extra.pop('local_control_vtable');local_resource=extra.pop('local_resource_vtable')
   offsets=json.loads(process.stdout.readline());offsets.update(extra)
   offsets['emoji_factory']=offsets['text_factory']
   config=build_case('emoji',None,'filehelper',offsets,image,SendPolicy())
   config.update(resident=True,quiet=True)
   request=config['active_experiment']
   request.update(kind='template',backend='send_worker',emoji_control_vtable=vtable,local_emoji=True,
       local_emoji_control_vtable=local_control,local_emoji_resource_vtable=local_resource,
       data_fingerprints=[dict(rva=vtable,pointer_rvas=[a-image.image_base for a in struct.unpack('<QQ',image.read_rva(vtable,16))])])
   request['thread_source']='#define ENABLE_EMOJI 1\n#define ENABLE_LOCAL_EMOJI 1\n'+request['thread_source']
   with (directory/'resident-output.log').open('a',encoding='utf-8') as output,contextlib.redirect_stdout(output):
    session=WorkerSession(process.pid,config,journal=Journal(directory))
    assert session.call('start_worker')
    for index,local in enumerate((True,False,True)):
     payload=dict(kind='emoji',recipient_bytes=list(b'filehelper'),emoji_type=4 if local else 3,
         local_emoji=local,local_emoji_size=123456,path='E:/fixtures/local-animation.gif',timeout_ms=2000,
         emoji_fields=dict(md5=list(b'abcdef0123456789abcdef0123456789'),
                           aes_key=[] if local else list(b'0123456789abcdef0123456789abcdef')))
     if index==0:
      bad=dict(payload,path='E:/fixtures/missing.gif')
      result=session.call('dispatch_job',bad)
      assert not result['accepted'] and result['native_error']==14,result
     result=session.call('dispatch_job',payload)
     assert result['accepted'],result
     deadline=time.monotonic()+3
     while time.monotonic()<deadline:
      lines=observation.read_text().splitlines()
      if len(lines)==index+1: break
      time.sleep(.02)
     assert len(lines)==index+1,lines
     assert json.loads(lines[-1])['valid'],lines
    assert session.close('stop_worker')
    session=None
   assert process.poll() is None
  finally:
   if session: session.close('stop_worker')
   watchdog.cancel();process.terminate();process.wait(timeout=5)
 return dict(resident=True,jobs=3,import_failure_without_send=True,passed=True)

def main():
 directory=ROOT/'runs/fixture-emoji';directory.mkdir(parents=True,exist_ok=True)
 executable=ROOT/'tests/build/emoji-fixture.exe'
 subprocess.run(['gcc','-O0','-static-libgcc',str(ROOT/'tests/emoji_fixture.c'),'-o',str(executable)],check=True)
 image=PEImage(executable);results=[]
 for recipient,corrupt,error,build_only,local,import_error in [('filehelper',0,0,False,False,0),('wxid_long_recipient_for_owned_string',0,0,False,False,0),('filehelper',1,0,False,False,0),('filehelper',0,1,False,False,0),('filehelper',0,0,True,False,0),('filehelper',0,0,False,True,0),('filehelper',0,0,False,True,1),('filehelper',0,0,True,True,0)]:
  observation=directory/'observation.json'
  with subprocess.Popen([str(executable),str(observation),str(corrupt),str(error),str(import_error)],stdout=subprocess.PIPE,text=True) as process:
   watchdog=threading.Timer(30,process.terminate);watchdog.start()
   try:
    extra=json.loads(process.stdout.readline());data_vtable=extra.pop('emoji_control_vtable')
    local_control=extra.pop('local_control_vtable');local_resource=extra.pop('local_resource_vtable')
    offsets=json.loads(process.stdout.readline());offsets.update(extra)
    offsets['emoji_factory']=offsets['text_factory']
    config=build_case('emoji',None,recipient,offsets,image,SendPolicy(recipients=(recipient,)))
    request=config['active_experiment'];request['emoji_type']=3;request['emoji_control_vtable']=data_vtable
    fields=dict(md5='abcdef0123456789abcdef0123456789',product_id='',aes_key='0123456789abcdef0123456789abcdef',
       thumb_url='',tp_url='',auth_key='',cdn_url='http://vweixinf.tc.qq.com/test',extern_url='',extern_md5='',
       encrypt_url='http://vweixinf.tc.qq.com/test',designer_id='',activity_id='',caption='收藏表情🙂')
    if local:
     fields['aes_key']='';fields['cdn_url']='';fields['encrypt_url']=''
     request.update(local_emoji=True,emoji_type=4,path='E:/fixtures/local-animation.gif',local_emoji_size=123456,
                    local_emoji_control_vtable=local_control,local_emoji_resource_vtable=local_resource)
    request['emoji_fields']={key:list(value.encode()) for key,value in fields.items()}
    request['data_fingerprints']=[dict(rva=data_vtable,pointer_rvas=[address-image.image_base for address in struct.unpack('<QQ',image.read_rva(data_vtable,16))])]
    request['thread_source']=('#define ENABLE_EMOJI 1\n'+('#define ENABLE_LOCAL_EMOJI 1\n' if local else '')+('#define EMOJI_BUILD_ONLY 1\n' if build_only else '')+request['thread_source'])
    config['finish_after_dispatch']=True
    with (directory/'output.log').open('a',encoding='utf-8') as output,contextlib.redirect_stdout(output):
     journal=Journal(directory);code=run_probe(process.pid,config,journal)
    result=next(row for row in journal.events if row['event']=='active_send_result')
    assert (code==0)==(not corrupt and not error and not import_error),result
    if import_error: assert result['native_error']==14,result
    cleanup=json.loads(process.stdout.readline());assert cleanup['cleanup'],cleanup
    assert cleanup['send_calls']==(0 if corrupt or build_only or import_error else 1),cleanup
    if not corrupt and not build_only and not import_error:
     observed=json.loads(observation.read_text());assert observed['valid'],observed
     assert bytes.fromhex(observed['recipient_hex'])==recipient.encode()
    else:assert observation.read_text()=='', 'Unexpected send'
    # Secrets are in native-owned buffers, never in journal configuration.
    log=journal.path.read_text(encoding='utf-8');assert '0123456789abcdef0123456789abcdef' not in log
    results.append(dict(passed=True,corrupt=bool(corrupt),native_error=bool(error),build_only=build_only,cleanup=True))
   finally:
    watchdog.cancel();process.terminate();process.wait(timeout=5);observation.unlink(missing_ok=True)
 results.append(resident_case(executable,image,directory))
 (directory/'results.json').write_text(json.dumps(results,indent=2),encoding='utf-8')
 print(json.dumps(dict(passed=len(results))))
if __name__=='__main__':main()
