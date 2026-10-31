import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync, writeFileSync, mkdirSync, readFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, resolve } from 'node:path';
import { DatabaseSync } from 'node:sqlite';
import { request } from 'node:http';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { AdminReadModel } from '../src/admin/read-model.js';
import { createAdminServer } from '../src/admin/server.js';
import { createAdminDemo } from '../src/admin/demo.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';
import type { HostInput } from '../src/contracts.js';

const query={q:'',status:'',limit:50,offset:0,after:0};
function fixture() {
  const root=mkdtempSync(join(tmpdir(),'wechat-admin-test-'));
  const c=config({storage:{file:join(root,'agent.sqlite')}}),store=new Store(c,undefined,()=>now);
  const model=new AdminReadModel(c,()=>now);
  store.ingest({events:[],cursor:0,truncated:false});
  return {root,c,store,model,close:()=>{model.close();store.close();rmSync(root,{recursive:true,force:true});}};
}

test('admin persists exact input -> run -> multiple output association, excluding same-time background runs', async()=>{
  const f=fixture(),bridge=new FakeBridge(),host=new FakeHost(),engine=new Engine(f.c,f.store,bridge,host,()=>{});
  host.execute=async(input)=>({status:'completed',replies:[{id:input.executionId+':final',text:'第一条\n第二条',messages:['第一条','第二条']}]});
  try {
    f.store.ingest({events:[event(1),event(2,'contact-b')],cursor:2,truncated:false});
    await engine.pump();await engine.drain();
    const items=f.model.messages(query).items;
    assert.equal(items.length,2);
    for(const item of items) {
      const detail=f.model.detail(item.id)!;
      assert.equal(detail.runs.length,1);assert.equal(detail.outbox.length,2);
      assert.deepEqual(detail.runs[0]!.finalTexts,['第一条','第二条']);
      assert.ok(detail.outbox.every(o=>o.runId===detail.runs[0]!.id));
      assert.equal(new Set(detail.outbox.map(o=>o.id)).size,2);
      assert.ok(detail.timeline.some(e=>e.phase==='ingress'));
    }
    const run=f.store.one('SELECT * FROM runs LIMIT 1')!;
    const input={...JSON.parse(run.input),inputId:'background-summary',executionId:'background-execution',purpose:'memory'} as HostInput;
    f.store.startRun(input,[]);f.store.completeRun(input.inputId,'completed',{replies:[{text:'PRIVATE SUMMARY'}]});
    assert.equal(f.model.detail(items[0]!.id)!.runs.length,1);
    assert.ok(!JSON.stringify(f.model.detail(items[0]!.id)).includes('PRIVATE SUMMARY'));
    const before=f.model.messages(query).cursor;
    engine.outbox.stopping=false;await engine.outbox.tick();
    assert.ok(f.model.messages({...query,after:before}).items.length>0);
    assert.ok(f.model.messages(query).items.every(i=>i.status==='server_confirmed'));
    assert.ok(f.model.detail(items[0]!.id)!.outbox.every(o=>o.deliveryVerified===false));
  } finally {await host.close();f.close();}
});

test('admin waiting/silent participation is attached by source IDs and never changes decision input to dispatching', async()=>{
  const f=fixture(),host=new FakeHost(),engine=new Engine(f.c,f.store,new FakeBridge(),host,()=>{});
  try {
    host.action='wait';f.store.ingest({events:[event(1,'group-a@chatroom')],cursor:1,truncated:false});
    await engine.pump();await engine.drain();
    const waiting=f.model.messages(query).items[0]!;
    assert.equal(waiting.status,'waiting');assert.equal(f.store.one('SELECT state FROM inbox')!.state,'pending');
    assert.equal(f.model.detail(waiting.id)!.runs[0]!.purpose,'decision');
    host.action='silent';f.store.ingest({events:[event(2,'group-b@chatroom')],cursor:2,truncated:false});
    await engine.pump();await engine.drain();
    assert.equal(f.model.messages({...query,status:'silent'}).total,1);
  } finally {f.close();}
});

test('admin read-only historical DB is not migrated; absent DB is not created',()=>{
  const root=mkdtempSync(join(tmpdir(),'wechat-admin-legacy-')),file=join(root,'old.sqlite'),c=config({storage:{file}});
  const model=new AdminReadModel(c);
  try {
    assert.deepEqual(model.messages(query).items,[]);
    const db=new DatabaseSync(file);
    db.exec('CREATE TABLE inbox(id TEXT PRIMARY KEY,sequence INTEGER,conversation TEXT,sender TEXT,payload TEXT,state TEXT,reason TEXT,created INTEGER)');
    db.prepare('INSERT INTO inbox VALUES(?,?,?,?,?,?,?,?)').run('a'.repeat(64),1,'demo','demo',JSON.stringify({text:'historical'}),'completed',null,now);
    db.close();
    const before=readFileSync(file);
    const item=model.messages(query).items[0]!;
    assert.equal(item.status,'legacy_unknown');assert.equal(item.traceAvailable,false);
    assert.deepEqual(model.detail(item.id)!.runs,[]);assert.equal(model.overview().trace.enabled,false);
    assert.throws(()=>model.all('CREATE TABLE forbidden(id INTEGER)'),/readonly|read-only/i);
    model.close();assert.deepEqual(readFileSync(file),before);
    const check=new DatabaseSync(file,{readOnly:true});assert.equal(check.prepare("SELECT count(*) n FROM sqlite_master WHERE name LIKE 'trace_%'").get()!.n,0);check.close();
  } finally {model.close();rmSync(root,{recursive:true,force:true});}
});

test('admin trace triggers work from a separate plain SQLite writer with no connection UDF',()=>{
  const f=fixture();
  try {
    f.store.ingest({events:[event(1)],cursor:1,truncated:false});
    const writer=new DatabaseSync(resolve(f.c.root,f.c.storage.file));
    try {writer.exec("UPDATE inbox SET state='failed'");}finally{writer.close();}
    const item=f.model.messages(query).items[0]!;
    assert.equal(item.status,'failed');assert.ok(f.model.detail(item.id)!.timeline.some(e=>e.state==='failed'));
  } finally{f.close();}
});

test('admin API projects text safely, strips secrets/raw tools/prompts, and preserves unknown semantics',()=>{
  const demo=createAdminDemo(),model=new AdminReadModel(demo.config);
  try {
    const list=model.messages(query);
    assert.equal(list.total,8);assert.ok(list.items.some(m=>m.status==='needs_review'));
    const unknown=list.items.find(m=>m.status==='unknown')!;assert.equal(model.detail(unknown.id)!.outbox[0]!.deliveryVerified,false);
    const html=list.items.find(m=>m.sequence===7)!;
    const db=new DatabaseSync(resolve(demo.config.root,demo.config.storage.file));
    try {
      const run=db.prepare('SELECT * FROM runs WHERE id=?').get('demo-run-7')!;
      const result=JSON.parse(String(run.result));result.replies[0].messages.push('api_key=SUPERSECRET_VALUE sk-abcdefghijk');
      db.prepare('UPDATE runs SET result=? WHERE id=?').run(JSON.stringify(result),String(run.id));
      db.prepare('INSERT INTO trace_events(at,phase,state,run_id,details) VALUES(?,?,?,?,?)').run(now,'tool','completed',String(run.id),JSON.stringify({name:'<img src=x onerror=alert(1)>',callId:'safe',args:{secret:'TOOL_SECRET'},result:'RAW_RESULT',thinking:'PRIVATE_THINKING'}));
      const payload=JSON.parse(String(db.prepare('SELECT payload FROM inbox WHERE id=?').get(html.id)!.payload));payload.text+=' Bearer abcdefghijk';
      db.prepare('UPDATE inbox SET payload=? WHERE id=?').run(JSON.stringify(payload),html.id);
    } finally {db.close();}
    const detail=JSON.stringify(model.detail(html.id));
    assert.ok(detail.includes('<script>'));assert.ok(detail.includes('[REDACTED]'));
    for(const secret of ['SUPERSECRET_VALUE','sk-abcdefghijk','Bearer abcdefghijk','TOOL_SECRET','RAW_RESULT','PRIVATE_THINKING','fixture-only'])assert.ok(!detail.includes(secret),secret);
    assert.equal(model.messages({...query,q:html.id}).total,1);
    assert.equal(model.messages({...query,limit:2,offset:2}).items.length,2);
    assert.equal(model.messages({...query,status:'unknown'}).total,1);
  } finally {model.close();demo.cleanup();}
});

function http(port:number,path:string,headers:Record<string,string>={},method='GET',body='') {
  return new Promise<{status:number;headers:Record<string,unknown>;body:string}>((resolve,reject)=>{
    const req=request({hostname:'127.0.0.1',port,path,method,headers},res=>{let body='';res.setEncoding('utf8');res.on('data',part=>body+=part);res.on('end',()=>resolve({status:res.statusCode!,headers:res.headers,body}));});
    req.on('error',reject);req.end(body);
  });
}
test('admin loopback HTTP enforces Host/same-origin/read-only/static allowlist and bounded query/image IDs',async()=>{
  const demo=createAdminDemo(),{server}=createAdminServer(demo.config,{staticRoot:join(agentRoot,'admin-ui')});
  await new Promise<void>(resolve=>server.listen(0,'127.0.0.1',resolve));const port=(server.address() as {port:number}).port;
  try {
    assert.equal((await http(port,'/')).status,200);
    assert.equal((await http(port,'/api/overview')).status,200);
    assert.equal((await http(port,'/api/overview',{host:'evil.example:'+port})).status,403);
    assert.equal((await http(port,'/api/messages',{origin:'https://evil.example'})).status,403);
    assert.equal((await http(port,'/api/messages',{'sec-fetch-site':'cross-site'})).status,403);
    assert.equal((await http(port,'/api/messages',{referer:'http://localhost:9999/'})).status,403);
    assert.equal((await http(port,'/api/messages',{},'POST')).status,405);
    assert.equal((await http(port,'/%2e%2e/config/agent.local.yaml')).status,400);
    assert.equal((await http(port,'/DESIGN.md')).status,404);
    assert.equal((await http(port,'/config/agent.local.yaml')).status,404);
    assert.equal((await http(port,'/api/messages?limit=100000')).status,400);
    assert.equal((await http(port,'/api/messages?q=%27%20OR%201%3D1')).status,200);
    const response=await http(port,'/api/stickers'),stickers=JSON.parse(response.body);
    assert.equal(stickers.items.length,1);assert.ok(!response.body.includes('directory'));assert.ok(!response.body.includes(demo.config.root));
    const image=await http(port,stickers.items[0].imageUrl);assert.equal(image.status,200);assert.equal(image.headers['content-type'],'image/png');
    assert.equal((await http(port,'/api/stickers/'+ 'f'.repeat(64)+'/image')).status,404);
    assert.equal(response.headers['access-control-allow-origin'],undefined);
    assert.match(String(response.headers['content-security-policy']),/frame-ancestors 'none'/);
  } finally {await new Promise<void>(resolve=>server.close(()=>resolve()));demo.cleanup();}
});

test('service buttons require same-origin POST and per-server capability; arbitrary actions and arguments never execute', async()=>{
  const demo=createAdminDemo();const actions:string[]=[];let busy=false;
  const {server}=createAdminServer(demo.config,{staticRoot:join(agentRoot,'admin-ui'),services:{
    status:async()=>({enabled:true,agent:{running:false},bridge:{reachable:false}}),
    action:action=>{if(busy)return false;actions.push(action);busy=true;return true;}
  }});
  await new Promise<void>(done=>server.listen(0,'127.0.0.1',done));const port=(server.address() as {port:number}).port;
  const origin=`http://127.0.0.1:${port}`;
  try {
    const state=JSON.parse((await http(port,'/api/services')).body);
    const headers={origin,'content-type':'application/json','x-service-token':state.token};
    assert.equal((await http(port,'/api/services/start',{},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/start',{...headers,origin:'https://evil.example'},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/start',{...headers,'x-service-token':'f'.repeat(64)},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/start',{...headers,'x-service-token':'é'.repeat(64)},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/start',{...headers,'content-type':'text/plain'},'POST','{}')).status,415);
    assert.equal((await http(port,'/api/services/start',headers,'POST','{"pid":1}')).status,400);
    assert.equal((await http(port,'/api/services/start',headers,'POST','[]')).status,400);
    assert.equal((await http(port,'/api/services/kill',headers,'POST','{}')).status,405);
    assert.equal(actions.length,0);
    assert.equal((await http(port,'/api/services/start',headers,'POST','{}')).status,202);
    assert.equal((await http(port,'/api/services/stop',headers,'POST','{}')).status,409);
    assert.deepEqual(actions,['start']);
    busy=false;
    assert.equal((await http(port,'/api/services/stop',headers,'POST','{}')).status,202);
    assert.deepEqual(actions,['start','stop']);
    assert.equal((await http(port,'/api/services/reset-budget',{},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/reset-budget',{...headers,origin:'https://evil.example'},'POST','{}')).status,403);
    assert.equal((await http(port,'/api/services/reset-budget',headers,'POST','{"limit":1000}')).status,400);
    assert.equal((await http(port,'/api/services/reset-budget',headers,'POST','{}')).status,409);
    busy=false;
    assert.equal((await http(port,'/api/services/reset-budget',headers,'POST','{}')).status,202);
    assert.deepEqual(actions,['start','stop','reset-budget']);
    assert.equal((await http(port,'/api/messages')).status,200);
  } finally {await new Promise<void>(done=>server.close(()=>done()));demo.cleanup();}
});
