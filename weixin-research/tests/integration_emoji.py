"""Native type-47 ownership, identity rejection and asynchronous survival."""
import contextlib,json,subprocess,sys,threading,struct
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from integration_active import build_case
from pe_image import PEImage
from policy import SendPolicy
from probe import Journal,run_probe

def main():
 directory=ROOT/'runs/fixture-emoji';directory.mkdir(parents=True,exist_ok=True)
 executable=ROOT/'tests/build/emoji-fixture.exe'
 subprocess.run(['gcc','-O0','-static-libgcc',str(ROOT/'tests/emoji_fixture.c'),'-o',str(executable)],check=True)
 image=PEImage(executable);results=[]
 for recipient,corrupt,error,build_only in [('filehelper',0,0,False),('wxid_sample_00',0,0,False),('filehelper',1,0,False),('filehelper',0,1,False),('filehelper',0,0,True)]:
  observation=directory/'observation.json'
  with subprocess.Popen([str(executable),str(observation),str(corrupt),str(error)],stdout=subprocess.PIPE,text=True) as process:
   watchdog=threading.Timer(30,process.terminate);watchdog.start()
   try:
    extra=json.loads(process.stdout.readline());data_vtable=extra.pop('emoji_control_vtable')
    offsets=json.loads(process.stdout.readline());offsets.update(extra)
    offsets['emoji_factory']=offsets['text_factory']
    config=build_case('emoji',None,recipient,offsets,image,SendPolicy(recipients=(recipient,)))
    request=config['active_experiment'];request['emoji_type']=3;request['emoji_control_vtable']=data_vtable
    fields=dict(md5='abcdef0123456789abcdef0123456789',product_id='',aes_key='0123456789abcdef0123456789abcdef',
       thumb_url='',tp_url='',auth_key='',cdn_url='http://vweixinf.tc.qq.com/test',extern_url='',extern_md5='',
       encrypt_url='http://vweixinf.tc.qq.com/test',designer_id='',activity_id='',caption='收藏表情🙂')
    request['emoji_fields']={key:list(value.encode()) for key,value in fields.items()}
    request['data_fingerprints']=[dict(rva=data_vtable,pointer_rvas=[address-image.image_base for address in struct.unpack('<QQ',image.read_rva(data_vtable,16))])]
    request['thread_source']=('#define ENABLE_EMOJI 1\n'+('#define EMOJI_BUILD_ONLY 1\n' if build_only else '')+request['thread_source'])
    config['finish_after_dispatch']=True
    with (directory/'output.log').open('a',encoding='utf-8') as output,contextlib.redirect_stdout(output):
     journal=Journal(directory);code=run_probe(process.pid,config,journal)
    result=next(row for row in journal.events if row['event']=='active_send_result')
    assert (code==0)==(not corrupt and not error),result
    cleanup=json.loads(process.stdout.readline());assert cleanup['cleanup'],cleanup
    assert cleanup['send_calls']==(0 if corrupt or build_only else 1),cleanup
    if not corrupt and not build_only:
     observed=json.loads(observation.read_text());assert observed['valid'],observed
     assert bytes.fromhex(observed['recipient_hex'])==recipient.encode()
    else:assert observation.read_text()=='', 'Unexpected send'
    # Secrets are in native-owned buffers, never in journal configuration.
    log=journal.path.read_text(encoding='utf-8');assert '0123456789abcdef0123456789abcdef' not in log
    results.append(dict(passed=True,corrupt=bool(corrupt),native_error=bool(error),build_only=build_only,cleanup=True))
   finally:
    watchdog.cancel();process.terminate();process.wait(timeout=5);observation.unlink(missing_ok=True)
 (directory/'results.json').write_text(json.dumps(results,indent=2),encoding='utf-8')
 print(json.dumps(dict(passed=len(results))))
if __name__=='__main__':main()
