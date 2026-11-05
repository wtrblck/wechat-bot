// Real pinned DSH kernel + official DeepSeek adapter. No bridge or production writes.
import { DatabaseSync, backup } from 'node:sqlite';
import { readFileSync, writeFileSync, appendFileSync, mkdirSync, existsSync } from 'node:fs';
import { resolve, dirname } from 'node:path';
import { fileURLToPath, pathToFileURL } from 'node:url';
import { randomUUID, createHash } from 'node:crypto';
import { Context } from '@deepseek-ai/cordis';
import Llm, { MessageId } from '@deepseek-ai/dsh-llm';
import Agents from '@deepseek-ai/dsh-agent';
import Sessions, { SessionId } from '@deepseek-ai/dsh-session';
import SystemPrompt from '@deepseek-ai/dsh-system-prompt';
import Tools from '@deepseek-ai/dsh-tools';
import AgentLoop from '@deepseek-ai/dsh-agent-loop';
import Projections from '@deepseek-ai/dsh-session-projection';
import * as Persistence from '@deepseek-ai/dsh-session-persistence-jsonl';
import * as Checkpoint from '@deepseek-ai/dsh-session-checkpoint-policy';
import { costNanos, normalizeUsage, priceAt, loadPricing } from '../dist/src/budget/pricing.js';
import { loadConfig } from '../dist/src/config.js';

const root = fileURLToPath(new URL('..', import.meta.url));
const out = resolve(root, 'data/experiments', process.env.EXPERIMENT_NAME ?? 'persistent-session-2026-11-05');
mkdirSync(out, { recursive: true });
const config = loadConfig(resolve(root, 'config/agent.local.yaml'));
const file = name => resolve(out, name);
const json = (name, value) => writeFileSync(file(name), JSON.stringify(value, null, 2) + '\n');
const digest = value => createHash('sha256').update(JSON.stringify(value)).digest('hex');
const privateModule = async name => import(pathToFileURL(resolve(root, 'node_modules/.pnpm/node_modules/@deepseek-ai', name, 'lib/index.js')).href);

async function prepare() {
  if (existsSync(file('requests.jsonl'))) throw Error('existing_experiment_do_not_overwrite_plan');
  if (!existsSync(file('source.sqlite'))) {
    const source = new DatabaseSync(resolve(root, config.storage.file), { readOnly: true });
    try { await backup(source, file('source.sqlite')); } finally { source.close(); }
  }
  const db = new DatabaseSync(file('source.sqlite'), { readOnly: true });
  try {
    const groups = db.prepare("SELECT * FROM session_map WHERE scope='group' ORDER BY key").all();
    const plan = [];
    for (const [index, group] of groups.entries()) {
      const runs = db.prepare('SELECT * FROM runs WHERE route=? ORDER BY created,id').all(group.key);
      const history = db.prepare('SELECT * FROM chat_history WHERE route=? ORDER BY position').all(group.key)
        .map(r => ({ ...r, message: JSON.parse(r.payload) }));
      const incoming = history.filter(r => r.message.direction !== 'outgoing');
      const positions = new Map(history.map(r => [r.message.messageId, r.position]));
      let frontier = -1;
      const batches = [];
      for (const run of runs.filter(r => r.purpose === 'decision')) {
        const input = JSON.parse(run.input), packet = JSON.parse(input.context);
        const max = Math.max(-1, ...packet.recent.filter(m => m.speaker !== 'assistant').map(m => positions.get(m.messageId) ?? -1));
        const messages = incoming.filter(r => r.position > frontier && r.position <= max).map(r => r.message);
        if (!messages.length) continue;
        batches.push({ id: run.id, created: run.created, nowMs: packet.nowMs ?? run.created,
          messages: messages.map(m => ({ messageId: m.messageId, senderId: m.senderId, timestampMs: m.timestampMs, kind: m.kind, text: m.text })) });
        frontier = max;
      }
      const reply = runs.findLast(r => r.purpose === 'reply');
      const trusted = reply ? JSON.parse(reply.input).system : '';
      // Freeze historical global profile once; replace the old two-stage scheduling and memory mechanisms.
      const system = trusted.split('【bot运行机制】')[0] + '\n\n' +
        '【持续会话实验规则，优先于前面的旧调度描述】\n' +
        '本会话只属于当前一个群。全局规则和参与策略仅在会话开始设定，后续用户输入是按时间顺序追加的新增群聊消息。' +
        '每批只在本会话中自主判断是否适合发言，并直接生成回复，不再另开参与判断、回复或发送前复审会话。' +
        '保持积极且有分寸的参与：被叫到、被接话、认真求助优先回复；闲聊可自然接话，有新角度才主动插话，重复语义、别人间的安排、明确结束或要求安静时保持沉默；只有关键补充正在到来时等待。' +
        '整个输出仅为一个JSON对象 {"messages":["回复"]}，旁听或等待时输出 {"messages":[]}，不要解释判断原因。' +
        '没有记忆总结、压缩或检索；直接使用本会话累计历史。nowMs是回放时刻，按消息timestampMs理解相对时间。' +
        '这是文字聊天回放，没有任何工具可用。图片、视频、附件只有原消息文字标签，不猜测其内容；涉及实际查询或操作时如实说明能力。' +
        '旧人格示例里的工具指示仅在有真实工具时适用；本实验不执行外部操作、不修改全局人格。';
      const ids = new Set(runs.map(r => JSON.parse(r.input).executionId));
      const workCounts = new Map(db.prepare('SELECT run_id,count(*) n FROM work_results GROUP BY run_id').all().map(r => [r.run_id,r.n]));
      const budget = db.prepare('SELECT * FROM budget_requests ORDER BY started,start_seq').all().filter(r => ids.has(r.execution_id))
        .map(r => ({...r,originalToolCalls:workCounts.get(r.input_id)??0}));
      plan.push({ label: `群${index + 1}`, route: group.key, conversation: group.conversation,
        sessionId: randomUUID(), system, batches, baseline: budget,
        originalRuns: runs.map(r => ({ id: r.id, purpose: r.purpose, state: r.state, created: r.created })),
        historicalMessages: incoming.length, replayedMessages: batches.reduce((n,b) => n + b.messages.length, 0),
        notes: { excludedOriginalBotMessages: history.length-incoming.length, unreplayedIncoming: incoming.filter(r => r.position > frontier).length } });
    }
    json('plan.json', { version: 1, preparedAt: new Date().toISOString(), dshVersion: '0.2.1-rc.2', provider: config.runtime.provider, model: config.runtime.model,
      methodology: 'Frozen incoming historical stream; batches follow advancing historical decision frontiers. Original bot output replaced by experimental output. Text-only, no tools, no summaries or compaction. Existing baseline retains original tools; report separates tool-free original requests where detectable. Not a controlled quality-equivalence trial.', groups: plan });
    console.log(JSON.stringify(plan.map(g => ({ group: g.label, batches: g.batches.length, messages: g.replayedMessages, baselineRequests: g.baseline.length, notes: g.notes }))));
  } finally { db.close(); }
}

function summarize() {
  const plan = JSON.parse(readFileSync(file('plan.json'), 'utf8'));
  const requests = existsSync(file('requests.jsonl')) ? readFileSync(file('requests.jsonl'), 'utf8').trim().split('\n').filter(Boolean).map(JSON.parse) : [];
  const turns = existsSync(file('turns.jsonl')) ? readFileSync(file('turns.jsonl'), 'utf8').trim().split('\n').filter(Boolean).map(JSON.parse) : [];
  const rates = { cacheHitInput: .02, cacheMissInput: 1, output: 4 };
  const sum = rows => rows.reduce((a,r) => {
    const u = r.usage ?? (r.usage_json ? JSON.parse(r.usage_json) : undefined);
    a.requests++; if (!u) { a.missingUsage++; return a; }
    const n = normalizeUsage(u); a.uncachedInput += n.inputTokens+n.cacheWriteTokens; a.cachedInput += n.cacheReadTokens;
    a.output += n.outputTokens; a.normalizedCny += costNanos(u,rates)/1e9;
    a.actualRateCny += (r.costNanos ?? r.cost_nanos ?? 0)/1e9; return a;
  }, { requests: 0, missingUsage: 0, uncachedInput: 0, cachedInput: 0, output: 0, normalizedCny: 0, actualRateCny: 0 });
  const groups = plan.groups.map(g => {
    const completed = turns.filter(t => t.route === g.route && t.status === 'completed');
    const through = completed.length ? g.batches.findIndex(b => b.id === completed.at(-1).batchId) : -1;
    const cutoff = through < 0 ? -1 : (through+1 < g.batches.length ? g.batches[through+1].created-1 : Infinity);
    const partial = g.baseline.filter(r => r.started <= cutoff);
    return { label: g.label, plannedBatches: g.batches.length, completedBatches: completed.length,
      replayedMessages: completed.reduce((n,t) => n+t.messageCount,0),
      replies: completed.filter(t => t.replyMessages > 0).length, invalidOutputs: completed.filter(t => !t.validOutput).length,
      sessionId: g.sessionId, baselineMatchedChat: sum(partial.filter(r => r.purpose !== 'memory')),
      baselineMatchedMemory: sum(partial.filter(r => r.purpose === 'memory')),
      baselineFullChat: sum(g.baseline.filter(r => r.purpose !== 'memory')),
      baselineFullMemory: sum(g.baseline.filter(r => r.purpose === 'memory')),
      baselineFullChatWithoutToolRuns: sum(g.baseline.filter(r => r.purpose !== 'memory' && !r.originalToolCalls)),
      baselineFullChatWithToolRuns: sum(g.baseline.filter(r => r.purpose !== 'memory' && r.originalToolCalls)),
      candidate: sum(requests.filter(r => r.route === g.route)),
      baselineByPurpose: Object.fromEntries(['decision','reply','memory'].map(p => [p,sum(partial.filter(r => r.purpose === p))])) };
  });
  const report = { updatedAt: new Date().toISOString(), complete: groups.every(g => g.completedBatches === g.plannedBatches),
    model: plan.model, dshVersion: plan.dshVersion, methodology: plan.methodology, normalizedRatesCnyPerMillion: rates,
    important: ['inputTokens in DSH exclude cacheReadTokens: total input = uncached + cached.', 'A persistent DSH session still sends accumulated history to the provider; incremental followup is not incremental provider billing.', 'Original historical bot replies are excluded; human reactions remain fixed, so behavior is counterfactual.', 'Candidate has no tools; baseline includes original tool overhead. This is a practical text-replay comparison, not isolated topology-only savings.', 'Memory cost is reported separately, never counted as a direct chat topology saving.', 'Costs are computed from provider usage and the stored rate table, not a provider invoice.'], groups };
  json('report.json', report); console.log(JSON.stringify(report, null, 2)); return report;
}

async function run() {
  const plan = JSON.parse(readFileSync(file('plan.json'), 'utf8'));
  const ctx = new Context();
  const pricing = loadPricing(config);
  let active;
  let spent = existsSync(file('requests.jsonl')) ? readFileSync(file('requests.jsonl'),'utf8').trim().split('\n').filter(Boolean).map(JSON.parse).reduce((n,r)=>n+(r.costNanos??0),0) : 0;
  const limit = Number(process.env.EXPERIMENT_LIMIT_CNY ?? 5)*1e9;
  const maxBatches = Number(process.env.EXPERIMENT_MAX_BATCHES ?? Infinity);
  await ctx.plugin(Llm); await ctx.plugin(Sessions); await ctx.plugin(Agents); await ctx.plugin(Projections);
  await ctx.plugin(SystemPrompt, { includeHarnessIdentity: false, includeRuntimeContext: false });
  await ctx.plugin(Tools, { mode: 'native' });
  await ctx.plugin(Persistence, { root: file('sessions'), compression: 'none' });
  await ctx.plugin(Checkpoint); await ctx.plugin(AgentLoop, { agents: [] });
  await ctx.plugin((await privateModule('dsh-credentials-local')).default, { path: 'C:/Users/Administrator/.dsh/.credentials.yaml', watch: false });
  await ctx.plugin(await privateModule('dsh-llm-deepseek-api-key'), { apiKeyEnv: 'DEEPSEEK_API_KEY' });
  const retries = new Map();
  ctx.on('agent/request-error', async (payload,next) => {
    const key=active?.batchId,attempt=retries.get(key)??0;
    if(key&&attempt<2&&['TRANSPORT','RATE_LIMIT','TIMEOUT','CONNECTION','OVERLOADED'].includes(payload.error?.code??payload.failure?.code)){
      retries.set(key,attempt+1);await new Promise(resolve=>setTimeout(resolve,3000));return {kind:'retry'};
    }
    return next();
  });
  ctx.on('llm/stream', async function* (options, next) {
    if (!active) throw Error('unowned_request');
    if (spent + (Buffer.byteLength(JSON.stringify(options))*2000 + 4096*8000) > limit) throw Error('experiment_budget_limit');
    const request = { id: randomUUID(), route: active.route, batchId: active.batchId, started: Date.now(),
      sessionId: active.sessionId, wireMessages: options.messages.length, wireBytes: Buffer.byteLength(JSON.stringify(options.messages)),
      wireHash: digest(options.messages), systemMessages: options.messages.filter(m=>m.role==='system').length, tools: options.tools?.length??0,
      maxTokens: options.maxTokens, reasoningEffort: options.reasoningEffort };
    const price = priceAt(pricing,config.runtime.provider,config.runtime.model,request.started);
    let usage;
    try {
      for await (const chunk of next()) {
        if (chunk.type === 'usage') usage = { ...usage, ...chunk.usage };
        if (chunk.type === 'finish') request.finish = chunk.reason;
        yield chunk;
      }
    } finally {
      request.ended = Date.now(); request.usage = usage; request.price = price;
      request.costNanos = usage ? costNanos(usage,price.rates) : undefined;
      spent += request.costNanos??0;
      appendFileSync(file('requests.jsonl'),JSON.stringify(request)+'\n');
      if (!usage) console.log(JSON.stringify({event:'missing_usage',batch:active.batchId,finish:request.finish}));
    }
  });
  let count = 0;
  try {
    for (const group of plan.groups) {
      const prior = existsSync(file('turns.jsonl')) ? readFileSync(file('turns.jsonl'),'utf8').trim().split('\n').filter(Boolean).map(JSON.parse).filter(t=>t.route===group.route) : [];
      if(prior.some(t=>t.status!=='completed'&&!['TRANSPORT','RATE_LIMIT','TIMEOUT','CONNECTION','OVERLOADED'].includes(t.endReason?.error?.code))) throw Error('failed_turn_requires_review');
      const done = new Set(prior.filter(t=>t.status==='completed').map(t=>t.batchId));
      if(group.batches.every(b=>done.has(b.id))) continue;
      const continuing = !!(await ctx.sessionPersistence.stat(SessionId(group.sessionId)));
      const handle = await ctx.agents[continuing ? 'resume' : 'create']({ ...(continuing ? { resumeSessionId: SessionId(group.sessionId) } : { sessionId: SessionId(group.sessionId), meta: { cwd: out } }),
        agentOptions: { provider: config.runtime.provider, model: config.runtime.model, maxTokens: 4096 },
        setup: async a => {
          a.tools.restrict({allow:[]});
          a.systemPrompt.section({name:'experiment:fixed',order:0,text:group.system,complete:true,interpolate:false});
          a.on('system-prompt/assemble',async (_x,_y,next)=>{const s=await next();return {...s,contexts:[],tools:[]};});
        } });
      try {
        for(const batch of group.batches) {
          if(done.has(batch.id)) continue;
          if(count++ >= maxBatches) return;
          active={route:group.route,batchId:batch.id,sessionId:group.sessionId};
          const recovery=prior.some(t=>t.batchId===batch.id&&t.status!=='completed');
          const inputId=(recovery?'recovery-':'experiment-')+batch.id;
          const start=Date.now();
          const timer=setTimeout(()=>handle.agent.cancel({kind:'user'}),600000);
          try {
            handle.agent.followup({id:MessageId(inputId),role:'user',source:{kind:'user'},content:[{type:'text',text:recovery?'上一次请求因连接失败没有完成，请继续处理已经在本会话中的上一批新增群聊消息。':JSON.stringify({nowMs:batch.nowMs,messages:batch.messages})}]});
            await handle.agent.whenIdle();
            if(!await ctx.sessions.flush(handle.agent.session)) throw Error('session_not_flushed');
            const reader=await ctx.sessionPersistence.open(SessionId(group.sessionId),'read');
            let events;try{events=(await reader.read()).events;}finally{await reader.close();}
            const inputEvent=events.findLast(e=>e.type==='user/message'&&e.data.id===inputId);
            const end=events.findLast(e=>e.type==='turn/end');
            const message=events.findLast(e=>e.type==='assistant/message'&&e.seq>(inputEvent?.seq??Infinity));
            const text=message?.data.message.content.filter(b=>b.type==='text').map(b=>b.text).join('\n')??'';
            let decoded;try{decoded=JSON.parse(text);}catch{}
            const valid=decoded&&Object.keys(decoded).length===1&&Array.isArray(decoded.messages)&&decoded.messages.every(m=>typeof m==='string'&&m.trim());
            const status=end?.seq>inputEvent?.seq&&end.data.reason.kind==='completed'?'completed':'failed';
            const turn={...active,inputId,recovery,started:start,ended:Date.now(),status,endReason:end?.data.reason,messageCount:batch.messages.length,text,validOutput:!!valid,replyMessages:valid?decoded.messages.length:0};
            appendFileSync(file('turns.jsonl'),JSON.stringify(turn)+'\n');
            console.log(JSON.stringify({event:'turn',group:group.label,batch:done.size+1,total:group.batches.length,status,valid:!!valid,spentCny:spent/1e9}));
            done.add(batch.id);
            summarizeQuiet();
            if(status!=='completed') throw Error('real_dsh_turn_failed');
          } finally {clearTimeout(timer);}
        }
      } finally {await handle.dispose();}
    }
  } finally { await ctx.fiber.dispose(); summarizeQuiet(); }
}
function summarizeQuiet(){const log=console.log;console.log=()=>{};try{summarize();}finally{console.log=log;}}
const action=process.argv[2]??'report';
try {if(action==='prepare')await prepare();else if(action==='run')await run();else if(action==='report')summarize();else throw Error('unknown_action');}
catch(error){json('failure.json',{at:new Date().toISOString(),code:error.code,name:error.name,message:error.message});console.error(error.message);process.exitCode=1;}
