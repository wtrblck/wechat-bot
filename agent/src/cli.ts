import { existsSync, mkdirSync, readFileSync, writeFileSync, symlinkSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadConfig } from './config.js';
import { PromptRegistry } from './prompts/registry.js';
import { BridgeClient, policyDiagnostics } from './bridge/client.js';
import { Store } from './storage/database.js';
import { hash } from './contracts.js';
import { DatabaseSync } from 'node:sqlite';
import { budgetStatus } from './budget/daily-budget.js';
import { loadPricing, priceAt, assertPricingCurrent } from './budget/pricing.js';

const root = fileURLToPath(new URL('../..', import.meta.url));
const command = process.argv[2] ?? 'check';
const configFile = resolve(process.env.WECHAT_AGENT_CONFIG ?? process.argv[3] ?? resolve(root, 'config/agent.local.yaml'));
try {
  if (command === 'init-profile') {
    const directory = resolve(root, 'data/dsh-home/profiles/wechat');
    mkdirSync(resolve(directory, 'node_modules/@wechat-bot'), { recursive: true });
    const link = resolve(directory, 'node_modules/@wechat-bot/dsh-channel');
    if (!existsSync(link)) symlinkSync(root, link, process.platform === 'win32' ? 'junction' : 'dir');
    const manifest = resolve(directory, 'package.json');
    if (!existsSync(manifest)) writeFileSync(manifest, JSON.stringify({ private: true, type: 'module',
      dsh: { profile: { bundles: ['@wechat-bot/dsh-channel'] } } }, null, 2));
    const patch = resolve(directory, 'cordis.patch.yml');
    if (!existsSync(patch)) writeFileSync(patch, '[]\n');
    console.log('已建立本项目专用 dsh profile：' + directory);
  } else {
    const config = loadConfig(configFile);
    const prompts = new PromptRegistry(config);
    if (config.budget.enabled && command === 'check') {
      const pricing = loadPricing(config);
      assertPricingCurrent(pricing, Date.now(), config.budget.maxPricingAgeDays);
      priceAt(pricing, config.runtime.provider, config.runtime.model, Date.now());
    }
    if (command === 'check') console.log(JSON.stringify({ ok: true, engine: 'dsh', dshVersion: '0.2.1-rc.2', configVersion: hash(config.version),
      contacts: config.access.direct.allow.length, groups: config.access.group.allow.length,
      dailyLimitCny: config.budget.enabled ? config.budget.dailyLimitCny : null }));
    else if (command === 'diagnose') {
      const health = await new BridgeClient(config).health();
      console.log(JSON.stringify({ state: health.state, sendReady: health.send_ready, receiveReady: health.receive_ready,
        issues: policyDiagnostics(config, health) }, null, 2));
    } else if (command === 'budget') {
      // Read-only access works while the service owns the normal consumer lease.
      const file = resolve(config.root, config.storage.file);
      const db = existsSync(file) ? new DatabaseSync(file, { readOnly: true }) : undefined;
      try {
        const exists = !!db?.prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='budget_requests'").get();
        const one = (sql: string, ...args: any[]) => exists ? db!.prepare(sql).get(...args) : sql.includes('sum(cost_nanos)') ?
          { spent: 0, held: 0, requests: 0, uncertain: 0 } : undefined;
        console.log(JSON.stringify(budgetStatus(config, one, Date.now()), null, 2));
      } finally { db?.close(); }
    } else if (command === 'preview') {
      const scope = process.argv[4] === 'group' ? 'group' : 'direct';
      const conversation = process.argv[5] ?? '';
      console.log(JSON.stringify(prompts.snapshot({ key: hash(['preview', scope, conversation]), id: 'preview', generation: 1,
        scope, conversation, model: 'default', persona: null }, 'reply'), null, 2));
    } else if (command === 'baseline' || command === 'status') {
      const store = new Store(config);
      try {
        if (command === 'baseline') store.acceptBaseline();
        console.log(JSON.stringify({ checkpoint: store.checkpoint(), inbox: store.all('SELECT state,count(*) count FROM inbox GROUP BY state'),
          outbox: store.all('SELECT state,count(*) count FROM outbox GROUP BY state'), reviews: store.one("SELECT count(*) count FROM runs WHERE state='needs_review'") }, null, 2));
      } finally { store.close(); }
    } else throw Error('unknown_command');
  }
} catch (error) {
  // Zod errors can include invalid config values; only display validation paths.
  const issues = (error as { issues?: { path: string[] }[] }).issues;
  console.error(JSON.stringify({ ok: false, error: issues ? '配置字段无效：' + issues.map(i => i.path.join('.')).join(', ') :
    error instanceof Error && /^[a-z_]+(:[a-z_]+)?$/.test(error.message) ? error.message : '检查失败，请核对配置、模板文件和本机桥接状态。' }));
  process.exitCode = 1;
}
