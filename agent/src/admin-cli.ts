import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { loadConfig } from './config.js';
import { createAdminServer } from './admin/server.js';
import { createAdminDemo } from './admin/demo.js';
import { LocalServiceControl } from './admin/service-control.js';

const root=fileURLToPath(new URL('../../',import.meta.url));
try {
  const args=process.argv.slice(2),demo=args.includes('--demo'),portAt=args.indexOf('--port');
  const port=portAt<0?8788:Number(args[portAt+1]);
  if(!Number.isInteger(port)||port<1024||port>65535)throw Error('invalid_port');
  const rest=args.filter((_,i)=>i!==portAt&&i!==portAt+1||portAt<0).filter(a=>a!=='--demo');
  if(rest.length>1||rest.some(a=>a.startsWith('--'))||demo&&rest.length)throw Error('invalid_arguments');
  const fixture=demo?createAdminDemo():undefined;
  const config=fixture?.config??loadConfig(resolve(rest[0]??process.env.WECHAT_AGENT_CONFIG??resolve(root,'config/agent.local.yaml')));
  const {server}=createAdminServer(config,{staticRoot:resolve(root,'admin-ui'),services:demo?undefined:new LocalServiceControl(config.root)});
  let closing=false;
  const close=()=>{if(closing)return;closing=true;server.close(()=>{fixture?.cleanup();});server.closeIdleConnections();};
  server.on('error',()=>{console.error('管理服务无法监听，请检查端口。');fixture?.cleanup();process.exitCode=1;});
  server.listen(port,'127.0.0.1',()=>console.log(`本地${demo?'隔离演示':''}管理台 http://127.0.0.1:${port} （${demo?'服务控制已禁用':'可通过按钮开启、停止bot与桥接'}）`));
  process.once('SIGINT',close);process.once('SIGTERM',close);
} catch {
  console.error('管理台启动失败。用法：node dist/src/admin-cli.js [config/agent.local.yaml] [--port 8788]，或 --demo --port 8789。');
  process.exitCode=1;
}
