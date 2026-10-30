import { randomUUID } from 'node:crypto';
import type { GenerateOptions, TokenUsage } from '@deepseek-ai/dsh-llm';
import type { HostInput } from '../contracts.js';
import type { Store, Row } from '../storage/database.js';
import type { Config } from '../config.js';
import { beijingDay, BudgetError, costNanos, loadPricing, NANOS_PER_CNY, nextBeijingMidnight,
  normalizeUsage, priceAt, reserveTokens, assertPricingCurrent, type PricingSnapshot } from './pricing.js';

export interface BudgetStatus {
  enabled: boolean; day: string; timeZone: 'Asia/Shanghai'; dailyLimitCny: number;
  spentCny: number; heldCny: number; remainingCny: number; requestCount: number; uncertainRequests: number;
  stopped: boolean; reason: string | null; resumesAt: string; pricingVersion: string | null;
}
export function budgetStatus(config: Config, one: (sql: string, ...args: any[]) => Row | undefined, now: number): BudgetStatus {
  const day = beijingDay(now); const limit = Math.round(config.budget.dailyLimitCny * NANOS_PER_CNY);
  const totals = one(`SELECT coalesce(sum(cost_nanos),0) spent,
    coalesce(sum(CASE WHEN state<>'settled' THEN max(reserved_nanos-cost_nanos,0) ELSE 0 END),0) held,
    count(*) requests,coalesce(sum(CASE WHEN state='uncertain' THEN 1 ELSE 0 END),0) uncertain FROM budget_requests WHERE day=?`, day)!;
  const latch = one('SELECT * FROM budget_stops WHERE day=?', day);
  const reason = totals.spent >= limit ? 'daily_budget_exhausted' : latch && latch.limit_nanos >= limit ? latch.reason : null;
  return { enabled: config.budget.enabled, day, timeZone: 'Asia/Shanghai', dailyLimitCny: config.budget.dailyLimitCny,
    spentCny: totals.spent / NANOS_PER_CNY, heldCny: totals.held / NANOS_PER_CNY,
    remainingCny: Math.max(0, limit - totals.spent - totals.held) / NANOS_PER_CNY,
    requestCount: totals.requests, uncertainRequests: totals.uncertain, stopped: config.budget.enabled && !!reason,
    reason: config.budget.enabled ? reason : null, resumesAt: beijingDay(nextBeijingMidnight(now)) + 'T00:00:00+08:00',
    pricingVersion: one('SELECT pricing_version FROM budget_requests WHERE day=? ORDER BY started DESC LIMIT 1', day)?.pricing_version ?? null };
}
export class DailyBudget {
  readonly snapshot: PricingSnapshot | undefined;
  onStop?: (status: BudgetStatus) => void;
  constructor(readonly store: Store) {
    store.db.exec(`CREATE TABLE IF NOT EXISTS budget_requests (
      id TEXT PRIMARY KEY,execution_id TEXT NOT NULL,input_id TEXT NOT NULL,purpose TEXT NOT NULL,
      provider TEXT NOT NULL,model TEXT NOT NULL,day TEXT NOT NULL,started INTEGER NOT NULL,start_seq INTEGER NOT NULL,
      state TEXT NOT NULL,reserved_nanos INTEGER NOT NULL,cost_nanos INTEGER NOT NULL DEFAULT 0,
      usage_json TEXT,pricing_json TEXT NOT NULL,pricing_version TEXT NOT NULL,ended INTEGER);
      CREATE INDEX IF NOT EXISTS budget_day ON budget_requests(day);
      CREATE INDEX IF NOT EXISTS budget_execution ON budget_requests(execution_id,start_seq);
      CREATE TABLE IF NOT EXISTS budget_stops(day TEXT PRIMARY KEY,reason TEXT NOT NULL,limit_nanos INTEGER NOT NULL,created INTEGER NOT NULL);`);
    if (store.config.budget.enabled) this.snapshot = loadPricing(store.config);
  }
  status() { return budgetStatus(this.store.config, this.store.one.bind(this.store), this.store.clock()); }
  stop(reason: string) {
    const limit = Math.round(this.store.config.budget.dailyLimitCny * NANOS_PER_CNY);
    this.store.exec('INSERT OR REPLACE INTO budget_stops VALUES(?,?,?,?)', beijingDay(this.store.clock()), reason, limit, this.store.clock());
    this.onStop?.(this.status());
  }
  reserve(input: HostInput, options: GenerateOptions, startSeq: number): string | undefined {
    if (!this.store.config.budget.enabled) return;
    let failure: string | undefined; let result: string | undefined;
    this.store.transaction(() => {
      const current = this.status();
      if (current.stopped) { failure = current.reason!; return; }
      try {
        const now = this.store.clock(); const snapshot = this.snapshot!;
        assertPricingCurrent(snapshot, now, this.store.config.budget.maxPricingAgeDays);
        const price = priceAt(snapshot, options.provider, options.model, now);
        const tokens = reserveTokens(options, price.imageMaxInputTokens);
        const reserve = costNanos(tokens, price.reserveRates);
        const remaining = Math.round(current.remainingCny * NANOS_PER_CNY);
        if (reserve > remaining) throw new BudgetError('daily_budget_insufficient_for_request');
        result = randomUUID();
        this.store.exec(`INSERT INTO budget_requests(id,execution_id,input_id,purpose,provider,model,day,started,start_seq,
          state,reserved_nanos,pricing_json,pricing_version) VALUES(?,?,?,?,?,?,?,?,?,'reserved',?,?,?)`, result,
          input.executionId, input.inputId, input.purpose, options.provider, options.model, current.day, now, startSeq,
          reserve, JSON.stringify(price), snapshot.version);
      } catch (error) { failure = error instanceof BudgetError ? error.code : 'budget_accounting_unavailable'; }
    });
    if (failure) { this.stop(failure); throw new BudgetError(failure); }
    return result;
  }
  recordUsage(id: string, usage: TokenUsage) {
    const u = normalizeUsage(usage);
    const row = this.store.one('SELECT * FROM budget_requests WHERE id=?', id);
    if (!row || row.state === 'settled') return;
    // Usage reports may be repeated/cumulative; bill the attempt once.
    const old = row.usage_json ? JSON.parse(row.usage_json) : {};
    const merged = { inputTokens: Math.max(u.inputTokens, old.inputTokens ?? 0), outputTokens: Math.max(u.outputTokens, old.outputTokens ?? 0),
      cacheReadTokens: Math.max(u.cacheReadTokens, old.cacheReadTokens ?? 0), cacheWriteTokens: Math.max(u.cacheWriteTokens, old.cacheWriteTokens ?? 0) };
    const cost = costNanos(merged, JSON.parse(row.pricing_json).rates);
    this.store.exec('UPDATE budget_requests SET cost_nanos=?,usage_json=? WHERE id=?', cost, JSON.stringify(merged), id);
    const status = this.status();
    if (status.spentCny >= status.dailyLimitCny) this.stop('daily_budget_exhausted');
  }
  finish(id: string, complete: boolean) {
    const row = this.store.one('SELECT * FROM budget_requests WHERE id=?', id);
    if (!row || row.state === 'settled') return;
    this.store.exec('UPDATE budget_requests SET state=?,ended=? WHERE id=?', complete && row.usage_json ? 'settled' : 'uncertain', this.store.clock(), id);
  }
  reconcile(executionId: string, events: readonly { type: string; seq: number; data: any }[]) {
    const rows = this.store.all('SELECT * FROM budget_requests WHERE execution_id=? ORDER BY start_seq,started', executionId);
    for (let i = 0; i < rows.length; i++) {
      const row = rows[i]!; if (row.state === 'settled') continue;
      const next = rows[i + 1]?.start_seq ?? Infinity;
      const event = events.find(e => (e.type === 'assistant/message' || e.type === 'assistant/attempt') && e.seq >= row.start_seq && e.seq < next);
      let complete = false;
      if (event) {
        for (const item of event.data.stream ?? []) if (item.type === 'chunk') {
          if (item.chunk.type === 'usage') this.recordUsage(row.id, item.chunk.usage);
          if (item.chunk.type === 'finish') complete = ['stop', 'tool-calls', 'max-tokens'].includes(item.chunk.reason.kind);
        }
        if (event.data.usage) this.recordUsage(row.id, event.data.usage);
      }
      this.finish(row.id, complete);
    }
  }
}
