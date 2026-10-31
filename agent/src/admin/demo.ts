import { mkdtempSync, mkdirSync, writeFileSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { validateConfig } from '../config.js';
import { Store } from '../storage/database.js';
import type { HostInput, Message } from '../contracts.js';

/** Synthetic only; never loads local config, bridge credentials, or a real chat DB. */
export function createAdminDemo() {
  const root=mkdtempSync(join(tmpdir(),'wechat-admin-demo-'));
  const config=validateConfig({account:{key:'demo',selfId:'demo-bot',bridgeEpoch:'demo-epoch'},bridge:{sessionFile:'never-used.json'},
    access:{direct:{allow:['demo-friend']},group:{allow:['demo-group@chatroom']}},runtime:{provider:'demo',model:'fixture-model'},
    memory:{enabled:false},budget:{enabled:false},stickers:{enabled:true,directory:'stickers'}},root);
  const now=Date.now(); let clock=now-100000;
  const store=new Store(config,undefined,()=>clock);
  try {
    store.ingest({events:[],cursor:0,truncated:false});
    const labels=['帮我查一下明天的天气','群里这段讨论先等等','大家先聊，我安静听着','这条发送失败了','发出状态暂时无法确认','旧版本历史消息','<img src=x onerror=alert(1)> 只是聊天文本','模型执行中断，需要人工核对'];
    labels.forEach((text,index)=>{
      const sequence=index+1;clock+=8000;
      const conversation=sequence===2||sequence===3?'demo-group@chatroom':'demo-friend';
      store.ingest({cursor:sequence,truncated:false,events:[{sequence,message_id:'demo:'+sequence,conversation_id:conversation,sender:'demo-user',direction:'incoming',message_type:'text',content:text,timestamp:clock/1000}]});
      const row=store.one('SELECT * FROM inbox WHERE sequence=?',sequence)!;
      if(sequence===6) { store.exec('DELETE FROM trace_inbox WHERE id=?',row.id);store.exec('DELETE FROM trace_events WHERE inbox_id=?',row.id);return; }
      if(sequence===2||sequence===3) {
        store.traceInput([row.id],sequence===2?'waiting':'silent',sequence===2?'participation_wait':'participation_silent');
        if(sequence===3)store.exec("UPDATE inbox SET state='observed' WHERE id=?",row.id);return;
      }
      const session=store.session(JSON.parse(row.payload) as Message);
      const input:HostInput={inputId:'demo-run-'+sequence,executionId:'demo-execution-'+sequence,session,purpose:'reply',system:'fixture-only',context:'{}',provider:'demo',model:'fixture-model'};
      store.startRun(input,[row.id]);clock+=300;
      store.traceRun(input.inputId,{phase:'request',state:'started',details:{requestId:'demo-request-'+sequence}});
      if(sequence===1){store.traceRun(input.inputId,{phase:'tool',state:'started',details:{callId:'demo-tool',name:'web_search'}});clock+=600;
        store.traceRun(input.inputId,{phase:'tool',state:'completed',details:{callId:'demo-tool',name:'web_search'}});}
      clock+=500;
      store.traceRun(input.inputId,{phase:'request',state:'usage',details:{requestId:'demo-request-'+sequence,inputTokens:520,outputTokens:48,cacheReadTokens:120,cacheWriteTokens:0}});
      const texts=sequence===1?['查到了，明天有小雨。','出门记得带伞。']:sequence===7?['<script>window.demoInjected=true</script>','HTML只应作为文本显示。']:['这是一条演示回复。'];
      const result={status:sequence===8?'needs_review':'completed',replies:[{id:'demo-reply-'+sequence,text:texts.join('\n'),messages:texts}]};
      if(sequence!==8)store.prepareMessages(session,'demo-reply-'+sequence,texts,{runId:input.inputId});
      store.completeRun(input.inputId,result.status,result);clock+=300;
      for(const o of store.all('SELECT id FROM outbox WHERE reply=?','demo-reply-'+sequence)) {
        store.exec("UPDATE outbox SET submitted=1,state='sending' WHERE id=?",o.id);clock+=450;
        store.exec('UPDATE outbox SET state=?,result=? WHERE id=?',sequence===4?'failed':sequence===5?'unknown':'server_confirmed',JSON.stringify(sequence===4?{code:'bridge_rejected'}:{}),o.id);
      }
    });
    store.exec("INSERT OR REPLACE INTO metadata VALUES('runtime_status',?)",JSON.stringify({state:'stopped',updated:now,diagnostics:['demo_fixture_no_bot']}));
    mkdirSync(join(root,'stickers'));
    writeFileSync(join(root,'stickers','演示像素.png'),Buffer.from('iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAusB9Wl6K1sAAAAASUVORK5CYII=','base64'));
  } finally {store.close();}
  return {config,cleanup:()=>rmSync(root,{recursive:true,force:true})};
}
