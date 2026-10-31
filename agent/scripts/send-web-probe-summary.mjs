// One-off, user-authorized probe report. Stable IDs prevent a repeated invocation resending it.
import { readFileSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { setTimeout as delay } from 'node:timers/promises';
import { loadConfig } from '../dist/src/config.js';
import { BridgeClient } from '../dist/src/bridge/client.js';
const root = fileURLToPath(new URL('..', import.meta.url));
const config = loadConfig(resolve(root, 'config/agent.local.yaml'));
const target = JSON.parse(readFileSync(resolve(root, '../weixin-research/runs/targets.local.json'), 'utf8')).contact.wxid;
if (!config.access.direct.allow.includes(target)) throw Error('test_contact_not_allowed');
const report = JSON.parse(readFileSync(resolve(root, 'data/validation/community-web-probe-alternate.json'), 'utf8'));
if (!report.results.some(r => r.platform === 'B站' && r.sameSiteResults > 0)) throw Error('probe_results_not_verified');
const bridge = new BridgeClient(config), health = await bridge.health();
if (!health.send_ready) throw Error('bridge_not_ready');
const texts = ['搜索测试：B站摘要可查', '公开接口能查视频简介', '抖音贴吧正文暂时受限'];
const requests = [];
for (const [index, text] of texts.entries()) {
  const request_id = 'wa_webprobe_20261031_' + (index + 1);
  let state = await bridge.request(request_id);
  if (!state) {
    try { state = await bridge.send(JSON.stringify({ request_id, recipient: target, text, wait: true })); }
    catch { state = await bridge.request(request_id) ?? { state: 'unknown' }; }
  }
  for (let i = 0; i < 4 && ['queued', 'local_accepted', 'message_recorded'].includes(state.state); i++) {
    await delay(500); state = await bridge.request(request_id) ?? state;
  }
  requests.push({ request_id, text, state: state.state, deliveryVerified: state.delivery_verified === true });
  if (['unknown', 'failed'].includes(state.state)) break;
}
const path = resolve(root, 'data/validation/community-web-message-test.json');
writeFileSync(path, JSON.stringify({ testedAt: new Date().toISOString(), requests }, null, 2));
console.log(JSON.stringify({ report: path, requests }, null, 2));
