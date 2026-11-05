// Real official DSH/DeepSeek validation in an isolated local database; bridge sends always fail closed.
import { mkdirSync, cpSync, writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import assert from 'node:assert/strict';
import { Context } from '@deepseek-ai/cordis';
import Llm from '@deepseek-ai/dsh-llm';
import Sessions from '@deepseek-ai/dsh-session';
import Agents from '@deepseek-ai/dsh-agent';
import SystemPrompt from '@deepseek-ai/dsh-system-prompt';
import Tools from '@deepseek-ai/dsh-tools';
import AgentLoop from '@deepseek-ai/dsh-agent-loop';
import Projections from '@deepseek-ai/dsh-session-projection';
import * as Persistence from '@deepseek-ai/dsh-session-persistence-jsonl';
import * as Checkpoint from '@deepseek-ai/dsh-session-checkpoint-policy';
import { loadConfig } from '../dist/src/config.js';
import { Store } from '../dist/src/storage/database.js';
import { Engine } from '../dist/src/engine.js';
import { DshHostAdapter } from '../dist/src/runtime/host-adapter.js';

const project = fileURLToPath(new URL('..', import.meta.url));
const root = resolve(project, 'data/validation', 'continuous-session-' + Date.now());
mkdirSync(root, { recursive: true });
cpSync(resolve(project, 'prompts'), resolve(root, 'prompts'), { recursive: true });
mkdirSync(resolve(root, 'config'));
const base = loadConfig(resolve(project, 'config/agent.local.yaml'));
cpSync(resolve(project, base.budget.pricingFile), resolve(root, base.budget.pricingFile));
const config = { ...base, root, storage: { ...base.storage, file: 'data/test.sqlite' },
  participation: { ...base.participation, debounceMs: 0 },
  account: { key: 'isolated-validation', selfId: 'validation-self', bridgeEpoch: 'validation-1' },
  access: { ...base.access, owners: [], direct: { ...base.access.direct, allow: [] }, group: { ...base.access.group, allow: ['validation@chatroom'] } },
  codex: { ...base.codex, enabled: false }, externalAccess: { ...base.externalAccess, enabled: false },
  social: { ...base.social, proactive: { ...base.social.proactive, enabled: false, contacts: [] } },
  budget: { ...base.budget, enabled: true, dailyLimitCny: 1 } };
const privateModule = async name => import(pathToFileURL(resolve(project, 'node_modules/.pnpm/node_modules/@deepseek-ai', name, 'lib/index.js')).href);
const ctx = new Context(); let engine, store;
const wire = [];
try {
  await ctx.plugin(Llm); await ctx.plugin(Sessions); await ctx.plugin(Agents); await ctx.plugin(Projections);
  await ctx.plugin(SystemPrompt, { includeHarnessIdentity: false, includeRuntimeContext: false });
  await ctx.plugin(Tools, { mode: 'native' });
  await ctx.plugin(Persistence, { root: resolve(root, 'sessions'), compression: 'none' });
  await ctx.plugin(Checkpoint); await ctx.plugin(AgentLoop, { agents: [] });
  await ctx.plugin((await privateModule('dsh-credentials-local')).default, { path: 'C:/Users/Administrator/.dsh/.credentials.yaml', watch: false });
  await ctx.plugin(await privateModule('dsh-llm-deepseek-api-key'), { apiKeyEnv: 'DEEPSEEK_API_KEY' });
  ctx.on('llm/stream', async function* (options, next) {
    const request = { messages: options.messages.length, text: JSON.stringify(options.messages), usage: undefined };
    wire.push(request);
    for await (const chunk of next()) { if (chunk.type === 'usage') request.usage = chunk.usage; yield chunk; }
  });
  store = new Store(config);
  store.ingest({ events: [], cursor: 0, truncated: false });
  engine = new Engine(config, store, { send: async () => { throw Error('validation_never_sends'); } }, new DshHostAdapter(ctx, config), () => {});
  const prompts = ['这是隔离验证。请记住口令“蓝鲸123”，只回复：记住了',
    '请说出我刚才让你记住的口令，只回复口令。',
    '这条是旁听测试，现在请保持沉默，不要发送任何公开回复。',
    '请再说出那个口令，只回复口令。'];
  const outputs = [];
  for (const [i, text] of prompts.entries()) {
    if (i === 3) store.exec('UPDATE conversation_contexts SET input_tokens=13000,window_tokens=16384');
    store.ingest({ cursor: i + 1, truncated: false, events: [{ sequence: i + 1, message_id: `validation:${i + 1}`,
      conversation_id: 'validation@chatroom', sender: 'validation-user', direction: 'incoming', message_type: 'text',
      content: text, timestamp: Date.now() / 1000 }] });
    await engine.pump(); await engine.drain();
    const row = store.one("SELECT * FROM runs WHERE purpose='reply' ORDER BY created DESC,rowid DESC LIMIT 1");
    assert.ok(row, 'Reply must run'); assert.equal(row.state, 'completed');
    outputs.push({ input: JSON.parse(row.input), result: JSON.parse(row.result) });
  }
  assert.equal(outputs[0].input.executionId, outputs[1].input.executionId);
  assert.equal(outputs[1].input.executionId, outputs[2].input.executionId);
  assert.notEqual(outputs[2].input.executionId, outputs[3].input.executionId);
  assert.match(outputs[1].result.replies.map(r => r.text).join(''), /蓝鲸123/);
  assert.deepEqual(outputs[2].result.replies, []);
  assert.match(outputs[3].result.replies.map(r => r.text).join(''), /蓝鲸123/);
  assert.equal(store.one('SELECT count(*) n FROM memory_segments').n, 1);
  assert.equal(store.one("SELECT count(*) n FROM runs WHERE purpose='decision'").n, 0);
  const count = wire.length;
  await engine.host.reconcile(outputs[0].input); await engine.host.reconcile(outputs[1].input);
  assert.equal(wire.length, count, 'Historical reconciliation must not call the model.');
  const ledger = store.all('SELECT input_id,execution_id,purpose,state,cost_nanos,usage_json FROM budget_requests ORDER BY started,start_seq');
  assert.equal(ledger.length, wire.length);
  assert.ok(ledger.every(r => r.state === 'settled' && r.usage_json));
  assert.equal(new Set(ledger.filter(r => r.purpose === 'reply').map(r => r.input_id)).size, 4);
  const report = { testedAt: new Date().toISOString(), realDsh: true, realModel: config.runtime.model, messagesSent: false,
    forcedBoundary: 'Only the threshold counter was lowered to exercise rollover without buying a full context.',
    checks: { continuousIdentity: true, incrementalInput: true, remembersPriorInput: true, silentMarker: true,
      summaryHandover: true, historicalReconciliation: true, perInputBudget: true },
    costCny: ledger.reduce((n, r) => n + r.cost_nanos, 0) / 1e9, outputs, ledger, wire };
  writeFileSync(resolve(root, 'result.json'), JSON.stringify(report, null, 2) + '\n');
  console.log(JSON.stringify({ report: resolve(root, 'result.json'), checks: report.checks, requests: wire.length, costCny: report.costCny }));
} catch (error) {
  writeFileSync(resolve(root, 'failure.json'), JSON.stringify({ message: error.message, stack: error.stack }, null, 2));
  console.error(error.message); process.exitCode = 1;
} finally { if (engine) await engine.close(); else store?.close(); await ctx.fiber.dispose(); }
