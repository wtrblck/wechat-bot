import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, readFileSync, writeFileSync, existsSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { setTimeout as delay } from 'node:timers/promises';
import { LocalServiceControl } from '../src/admin/service-control.js';
import { installServiceStop } from '../src/runtime/service-lifecycle.js';

test('service controller serializes actions and exposes asynchronous failures without running a second start', async()=>{
  let release!:()=>void;const gate=new Promise<void>(done=>release=done);const calls:string[]=[];
  const controller=new LocalServiceControl('unused',async action=>{
    calls.push(action);if(action==='start'){await gate;throw Error('private failure');}
    return {agent:{running:false},bridge:{reachable:false}};
  });
  assert.equal(controller.action('start'),true);
  assert.equal(controller.action('start'),false);
  assert.equal(controller.action('stop'),false);
  assert.equal((await controller.status()).operation,'start');
  release();await delay(0);
  const status=await controller.status();assert.equal(status.operation,null);assert.equal(status.lastError,'service_start_failed');
  assert.ok(!JSON.stringify(status).includes('private failure'));
  assert.equal(calls.filter(c=>c==='start').length,1);
  assert.equal(controller.action('stop'),true);await delay(0);
  assert.equal((await controller.status()).lastError,null);
});

test('normal bot stop requires the current process generation and fires once; cleanup preserves a replacement', async()=>{
  const root=mkdtempSync(join(tmpdir(),'wechat-service-stop-'));let stopped=0;
  const watcher=installServiceStop(root,()=>{stopped++;},10);
  const descriptor=join(root,'data/service-control/bot.json'),request=join(root,'data/service-control/bot.stop.json');
  try {
    const identity=JSON.parse(readFileSync(descriptor,'utf8'));
    for(const value of [{...identity,pid:identity.pid+1},{...identity,token:'stale'},{}]){
      writeFileSync(request,JSON.stringify(value));await delay(35);assert.equal(stopped,0);
    }
    writeFileSync(request,JSON.stringify(identity));await delay(35);assert.equal(stopped,1);assert.equal(existsSync(request),false);
    writeFileSync(request,JSON.stringify(identity));await delay(35);assert.equal(stopped,1);
    writeFileSync(descriptor,JSON.stringify({...identity,token:'replacement'}));
    watcher.cleanup();assert.equal(existsSync(descriptor),true);
  } finally {watcher.cleanup();rmSync(root,{recursive:true,force:true});}
});
