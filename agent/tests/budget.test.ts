import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, relative, isAbsolute } from 'node:path';
import { spawnSync } from 'node:child_process';
import type { GenerateOptions } from '@deepseek-ai/dsh-llm';
import { AttachmentId } from '@deepseek-ai/dsh-attachment';
import { DailyBudget } from '../src/budget/daily-budget.js';
import { beijingDay, costNanos, loadPricing, nextBeijingMidnight, priceAt, reserveTokens, NANOS_PER_CNY } from '../src/budget/pricing.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { normalize } from '../src/ingress/normalizer.js';
import type { HostInput } from '../src/contracts.js';
import { config, event, FakeBridge, FakeHost, agentRoot } from './helpers.js';

const when = (time: string) => Date.parse(time + '+08:00');
const peak = when('2026-10-29T10:00:00');
function cfg(limit = 5) { return config({ budget: { enabled: true, dailyLimitCny: limit } }); }
const options: GenerateOptions = { provider: 'deepseek-official', model: 'deepseek-flash', maxTokens: 4096,
  messages: [{ role: 'user', content: [{ type: 'text', text: '测试输入' }] }] };
test('vision reserves the verified per-image input bound and refuses an unpriced image route', () => {
  const attachment = { attachmentId: AttachmentId('a'.repeat(64)), mediaType: 'image/png' as const, bytes: 123, width: 2, height: 2 };
  const imageOptions: GenerateOptions = { ...options, messages: [{ role: 'user',
    content: [{ type: 'image', attachment }] }] };
  const base = Buffer.byteLength(JSON.stringify(imageOptions)) + 4096;
  assert.equal(reserveTokens(imageOptions, 1024).inputTokens, base + 1024);
  assert.throws(() => reserveTokens(imageOptions), /image_price_missing/);
  const store = new Store(cfg(), ':memory:', () => peak), budget = new DailyBudget(store);
  try { assert.ok(budget.reserve(input(), imageOptions, 1)); assert.equal(budget.status().requestCount, 1); }
  finally { store.close(); }
});
function input(executionId = 'exec-1'): HostInput {
  return { inputId: 'input-' + executionId, executionId, purpose: 'reply', provider: 'deepseek-official', model: 'deepseek-flash', system: '', context: '',
    session: { key: 'scope', id: 'session', generation: 1, conversation: 'contact-a', scope: 'direct', model: 'default', persona: null } };
}
function cleanup(root: string) {
  const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel));
  rmSync(root, { recursive: true, force: true });
}
test('official CNY prices respect Beijing weekday boundaries, weekends and published holidays', () => {
  const p = loadPricing(cfg());
  const band = (time: string) => priceAt(p, 'deepseek-official', 'deepseek-flash', when(time)).band;
  assert.equal(band('2026-10-29T08:59:59'), 'offPeak'); assert.equal(band('2026-10-29T09:00:00'), 'peak');
  assert.equal(band('2026-10-29T12:00:00'), 'offPeak'); assert.equal(band('2026-10-29T14:00:00'), 'peak');
  assert.equal(band('2026-10-29T18:00:00'), 'offPeak'); assert.equal(band('2026-10-31T10:00:00'), 'offPeak');
  assert.equal(band('2026-10-05T10:00:00'), 'offPeak'); assert.equal(band('2026-10-10T10:00:00'), 'offPeak');
  assert.deepEqual(priceAt(p, 'deepseek-official', 'deepseek-flash', peak).rates, { cacheHitInput: .04, cacheMissInput: 2, output: 8 });
  assert.equal(priceAt(p, 'deepseek-official', 'deepseek-v4-flash-vision-exp', peak).rates.output, 8);
  assert.equal(priceAt(p, 'deepseek-official', 'deepseek-v4-pro', peak).rates.output, 27);
  assert.throws(() => priceAt(p, 'deepseek-official', 'deepseek-flash', when('2027-01-04T10:00:00')), /calendar_missing/);
});
test('disjoint cache usage, cache writes and reasoning are not double counted; sub-cent precision is retained', () => {
  const rates = priceAt(loadPricing(cfg()), options.provider, options.model, peak).rates;
  assert.equal(costNanos({ inputTokens: 1000000, cacheReadTokens: 500000, outputTokens: 250000, reasoningTokens: 200000 }, rates), 4_020_000_000);
  assert.equal(costNanos({ inputTokens: 0, cacheReadTokens: 1, outputTokens: 0 }, rates), 40);
  assert.equal(costNanos({ inputTokens: 0, cacheWriteTokens: 100000, outputTokens: 0 }, rates), .2 * NANOS_PER_CNY);
  assert.throws(() => costNanos({ inputTokens: -1, outputTokens: 1 }, rates), /invalid_budget_accounting/);
});
test('concurrent reservations cannot collectively exceed the remaining daily ceiling', async () => {
  const rates = priceAt(loadPricing(cfg()), options.provider, options.model, peak).reserveRates;
  const reservation = costNanos(reserveTokens(options), rates);
  const store = new Store(cfg(reservation * 1.5 / NANOS_PER_CNY), ':memory:', () => peak); const budget = new DailyBudget(store);
  try {
    const results = await Promise.allSettled([Promise.resolve().then(() => budget.reserve(input('one'), options, 1)),
      Promise.resolve().then(() => budget.reserve(input('two'), options, 1))]);
    assert.equal(results.filter(r => r.status === 'fulfilled').length, 1);
    assert.equal(store.one('SELECT count(*) n FROM budget_requests')!.n, 1);
    assert.ok(budget.status().heldCny <= budget.status().dailyLimitCny);
    assert.equal(budget.status().reason, 'daily_budget_insufficient_for_request');
  } finally { store.close(); }
});
test('cumulative/repeated usage settles once and releases only the unused reservation', () => {
  const store = new Store(cfg(), ':memory:', () => peak); const budget = new DailyBudget(store);
  try {
    const id = budget.reserve(input(), options, 1)!;
    budget.recordUsage(id, { inputTokens: 100, cacheReadTokens: 1000, outputTokens: 0 });
    budget.recordUsage(id, { inputTokens: 0, cacheReadTokens: 0, outputTokens: 50 });
    budget.recordUsage(id, { inputTokens: 100, cacheReadTokens: 1000, outputTokens: 50 });
    budget.finish(id, true); const before = budget.status();
    budget.recordUsage(id, { inputTokens: 100, cacheReadTokens: 1000, outputTokens: 50 }); budget.finish(id, true);
    assert.deepEqual(budget.status(), before); assert.equal(before.spentCny, .00064); assert.equal(before.heldCny, 0);
  } finally { store.close(); }
});
test('actual reported spending at the ceiling persists a stop before another request can start', () => {
  const upper = reserveTokens(options);
  const price = priceAt(loadPricing(cfg()), options.provider, options.model, peak).reserveRates;
  const ceiling = costNanos(upper, price) / NANOS_PER_CNY;
  const store = new Store(cfg(ceiling), ':memory:', () => peak); const budget = new DailyBudget(store); let stops = 0;
  budget.onStop = () => stops++;
  try {
    const id = budget.reserve(input(), options, 1)!; budget.recordUsage(id, upper); budget.finish(id, true);
    assert.equal(budget.status().spentCny, ceiling); assert.equal(budget.status().reason, 'daily_budget_exhausted');
    assert.equal(stops, 1); assert.throws(() => budget.reserve(input('next'), options, 2), /daily_budget_exhausted/);
    assert.equal(budget.status().requestCount, 1);
  } finally { store.close(); }
});
test('late settlement keeps a request on its Beijing start day while the new day has an independent budget', () => {
  let time = when('2026-10-29T23:59:59'); const store = new Store(cfg(), ':memory:', () => time); const budget = new DailyBudget(store);
  try {
    const id = budget.reserve(input(), options, 1)!; time = nextBeijingMidnight(time);
    budget.recordUsage(id, { inputTokens: 1000, outputTokens: 100 }); budget.finish(id, true);
    assert.equal(budget.status().spentCny, 0); assert.equal(budget.status().day, '2026-10-30');
    assert.equal(store.one('SELECT day FROM budget_requests WHERE id=?', id)!.day, '2026-10-29');
    assert.equal(store.one('SELECT cost_nanos FROM budget_requests WHERE id=?', id)!.cost_nanos, 1_400_000);
  } finally { store.close(); }
});
test('aborted/missing usage retains held budget, and retries create separately billed requests', () => {
  const store = new Store(cfg(), ':memory:', () => peak); const budget = new DailyBudget(store);
  try {
    const first = budget.reserve(input(), options, 1)!; budget.finish(first, true);
    assert.ok(budget.status().heldCny > 0); assert.equal(budget.status().uncertainRequests, 1);
    const second = budget.reserve(input(), options, 2)!;
    budget.recordUsage(second, { inputTokens: 100, outputTokens: 10 }); budget.finish(second, false);
    assert.equal(budget.status().requestCount, 2); assert.equal(budget.status().uncertainRequests, 2);
    assert.ok(budget.status().heldCny > 0); assert.ok(budget.status().spentCny > 0);
  } finally { store.close(); }
});
test('durable stream recovery reconstructs billing idempotently after a crash window', () => {
  const store = new Store(cfg(), ':memory:', () => peak); const budget = new DailyBudget(store);
  try {
    budget.reserve(input(), options, 5);
    const events = [{ type: 'assistant/attempt', seq: 5, data: { stream: [
      { type: 'chunk', chunk: { type: 'usage', usage: { inputTokens: 1000, outputTokens: 100 } } },
      { type: 'chunk', chunk: { type: 'finish', reason: { kind: 'stop' } } },
    ] } }];
    budget.reconcile('exec-1', events); const first = budget.status(); budget.reconcile('exec-1', events);
    assert.deepEqual(budget.status(), first); assert.equal(first.spentCny, .0028); assert.equal(first.heldCny, 0);
  } finally { store.close(); }
});
test('restart preserves spend and stop latch; Beijing midnight opens a fresh day without deleting history', () => {
  const directory = mkdtempSync(join(tmpdir(), 'wechat-budget-')); const file = join(directory, 'agent.sqlite'); let time = peak;
  const c = cfg(.000001); let store = new Store(c, file, () => time);
  try {
    let budget = new DailyBudget(store); assert.throws(() => budget.reserve(input(), options, 1), /insufficient/);
    store.close(); store = new Store(c, file, () => time); budget = new DailyBudget(store);
    assert.equal(budget.status().stopped, true);
    time = nextBeijingMidnight(time);
    assert.equal(beijingDay(time), '2026-10-30'); assert.equal(budget.status().stopped, false);
    assert.equal(budget.status().spentCny, 0); assert.equal(store.one('SELECT count(*) n FROM budget_stops')!.n, 1);
  } finally { store.close(); cleanup(directory); }
});
test('unknown/stale prices and unsupported content fail closed before an API request can start', () => {
  for (const [time, model, expected] of [[peak, 'unknown-model', /price_missing/],
    [when('2026-11-30T10:00:00'), 'deepseek-flash', /snapshot_stale/]] as const) {
    const store = new Store(cfg(), ':memory:', () => time); const budget = new DailyBudget(store);
    try { assert.throws(() => budget.reserve(input(), { ...options, model }, 1), expected);
      assert.equal(budget.status().stopped, true); assert.equal(budget.status().requestCount, 0);
    } finally { store.close(); }
  }
  assert.throws(() => reserveTokens({ ...options, maxTokens: undefined }), /output_token_limit_required/);
});
test('engine stops intake, cancels unsubmitted replies, and rebaselines before midnight recovery', async () => {
  const c = cfg(); let time = when('2026-10-29T23:59:59');
  const store = new Store(c, ':memory:', () => time); const bridge = new FakeBridge(); const host = new FakeHost();
  const engine = new Engine(c, store, bridge, host, () => {});
  store.ingest({ cursor: 0, events: [], truncated: false });
  const old = event(1, 'contact-a', '/ai yesterday', { timestamp: time / 1000 });
  store.ingest({ cursor: 1, events: [old], truncated: false });
  const session = store.session(normalize(old, c)!); store.prepareReply(session, 'old-answer', '昨天的待发回复');
  try {
    engine.budget.stop('daily_budget_exhausted'); await engine.tick(); await engine.drain();
    assert.equal(engine.state, 'budget_exhausted'); assert.equal(host.calls.length, 0); assert.equal(bridge.posts.length, 0);
    assert.equal(store.one('SELECT state FROM outbox')!.state, 'cancelled');
    time = nextBeijingMidnight(time); store.exec('UPDATE consumer_lock SET expires=?', time + 30000);
    bridge.page = { cursor: 2, events: [event(2, 'contact-a', '/ai 停止期间的消息', { timestamp: time / 1000 - 1 })], truncated: false };
    await engine.tick(); await engine.tick(); assert.equal(host.calls.length, 0);
    bridge.page = { cursor: 3, events: [event(3, 'contact-a', '/ai 新一天', { timestamp: time / 1000 })], truncated: false };
    await engine.tick(); await engine.drain(); assert.equal(host.calls.length, 1);
  } finally { await engine.close(); }
});
test('budget CLI can read the persistent ledger while the active consumer holds its lease', () => {
  const directory = mkdtempSync(join(tmpdir(), 'wechat-budget-cli-')); const file = join(directory, 'agent.sqlite');
  const c = config({ storage: { file }, budget: { enabled: true } }); const store = new Store(c, file, () => peak);
  const budget = new DailyBudget(store);
  try {
    budget.reserve(input(), options, 1);
    const { root, version, ...plain } = c; const configFile = join(directory, 'agent.yaml'); writeFileSync(configFile, JSON.stringify(plain));
    const result = spawnSync(process.execPath, [join(agentRoot, 'dist/src/cli.js'), 'budget', configFile], {
      encoding: 'utf8', cwd: agentRoot, env: { ...process.env, WECHAT_AGENT_CONFIG: configFile },
    });
    // The CLI uses the actual calendar date, so only require a valid readable report.
    assert.equal(result.status, 0, result.stderr); assert.equal(JSON.parse(result.stdout).dailyLimitCny, 5);
  } finally { store.close(); cleanup(directory); }
});
