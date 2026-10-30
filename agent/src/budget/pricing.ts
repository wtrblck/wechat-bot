import { readFileSync, realpathSync } from 'node:fs';
import { isAbsolute, relative, resolve } from 'node:path';
import { z } from 'zod';
import type { GenerateOptions, TokenUsage, ImageBlock } from '@deepseek-ai/dsh-llm';
import type { Config } from '../config.js';

export const NANOS_PER_CNY = 1_000_000_000;
const date = z.string().regex(/^\d{4}-\d{2}-\d{2}$/);
const rate = z.number().nonnegative().max(1000000).refine(n => Math.abs(n * 1000 - Math.round(n * 1000)) < 0.000001);
const rates = z.strictObject({ cacheHitInput: rate, cacheMissInput: rate, output: rate });
const schema = z.strictObject({ version: z.string().min(1), verifiedOn: date, currency: z.literal('CNY'),
  source: z.literal('https://api-docs.deepseek.com/zh-cn/quick_start/pricing/'), calendarSource: z.string().url(),
  calendarYears: z.array(z.number().int()), holidayRanges: z.array(z.tuple([date, date])),
  models: z.array(z.strictObject({ provider: z.string(), names: z.array(z.string()).min(1), peak: rates, offPeak: rates,
    imageMaxInputTokens: z.number().int().positive().max(1000000).optional(),
    visionSource: z.literal('https://api-docs.deepseek.com/guides/vision/').optional(),
  }).refine(m => m.imageMaxInputTokens === undefined || m.visionSource !== undefined, 'vision_price_source_required')).min(1),
});
export type Rates = z.infer<typeof rates>;
export type PricingSnapshot = z.infer<typeof schema>;
export class BudgetError extends Error {
  constructor(readonly code: string) { super(code); }
}
// No dependency on the host operating system's timezone.
export function beijingDay(time: number) { return new Date(time + 8 * 3600000).toISOString().slice(0, 10); }
export function nextBeijingMidnight(time: number) { return Date.parse(beijingDay(time) + 'T00:00:00+08:00') + 86400000; }
export function safeInteger(n: number) {
  if (!Number.isSafeInteger(n) || n < 0) throw new BudgetError('invalid_budget_accounting'); return n;
}
export function loadPricing(config: Config): PricingSnapshot {
  const file = realpathSync(resolve(config.root, config.budget.pricingFile));
  const rel = relative(config.root, file);
  if (rel.startsWith('..') || isAbsolute(rel)) throw new BudgetError('pricing_path_outside_agent');
  return schema.parse(JSON.parse(readFileSync(file, 'utf8')));
}
export function priceAt(snapshot: PricingSnapshot, provider: string, model: string, time: number) {
  const entry = snapshot.models.find(m => m.provider === provider && m.names.includes(model));
  if (!entry) throw new BudgetError('official_model_price_missing');
  const day = beijingDay(time); const local = new Date(time + 8 * 3600000);
  if (!snapshot.calendarYears.includes(local.getUTCFullYear())) throw new BudgetError('pricing_calendar_missing');
  const weekday = local.getUTCDay(); const hour = local.getUTCHours();
  const holiday = snapshot.holidayRanges.some(([start, end]) => day >= start && day <= end);
  const peak = weekday >= 1 && weekday <= 5 && !holiday && (hour >= 9 && hour < 12 || hour >= 14 && hour < 18);
  return { version: snapshot.version, source: snapshot.source, band: peak ? 'peak' : 'offPeak',
    rates: peak ? entry.peak : entry.offPeak, reserveRates: entry.peak, imageMaxInputTokens: entry.imageMaxInputTokens };
}
export function assertPricingCurrent(snapshot: PricingSnapshot, now: number, maxAgeDays: number) {
  const age = (Date.parse(beijingDay(now)) - Date.parse(snapshot.verifiedOn)) / 86400000;
  if (age < 0 || age > maxAgeDays) throw new BudgetError('official_pricing_snapshot_stale');
}
export function normalizeUsage(usage: TokenUsage): Required<Pick<TokenUsage, 'inputTokens' | 'outputTokens' | 'cacheReadTokens' | 'cacheWriteTokens'>> {
  const result = { inputTokens: safeInteger(usage.inputTokens), outputTokens: safeInteger(usage.outputTokens),
    cacheReadTokens: safeInteger(usage.cacheReadTokens ?? 0), cacheWriteTokens: safeInteger(usage.cacheWriteTokens ?? 0) };
  if (usage.totalTokens !== undefined && usage.totalTokens < result.inputTokens + result.outputTokens + result.cacheReadTokens + result.cacheWriteTokens)
    throw new BudgetError('invalid_budget_accounting');
  return result;
}
export function costNanos(usage: TokenUsage, price: Rates) {
  const u = normalizeUsage(usage);
  // Dsh counts uncached input separately. Reasoning is already part of output.
  return safeInteger((u.inputTokens + u.cacheWriteTokens) * Math.round(price.cacheMissInput * 1000) +
    u.cacheReadTokens * Math.round(price.cacheHitInput * 1000) + u.outputTokens * Math.round(price.output * 1000));
}
export function reserveTokens(options: GenerateOptions, imageMaxInputTokens?: number) {
  if (!Number.isSafeInteger(options.maxTokens) || options.maxTokens! < 1) throw new BudgetError('output_token_limit_required');
  const blocks = options.messages.flatMap(m => m.content);
  if (blocks.some(b => !['text', 'reasoning', 'tool-call', 'image'].includes(b.type)))
    throw new BudgetError('unpriced_request_content');
  const images = blocks.filter((b): b is ImageBlock => b.type === 'image' && !b.offloaded);
  if (images.length && (!Number.isSafeInteger(imageMaxInputTokens) || imageMaxInputTokens! < 1)) throw new BudgetError('image_price_missing');
  for (const b of images) {
    const a = b.attachment;
    if (!a || !['image/png','image/jpeg','image/gif','image/webp'].includes(a.mediaType) ||
        !Number.isSafeInteger(a.bytes) || a.bytes < 1 || !Number.isSafeInteger(a.width) || a.width < 1 ||
        !Number.isSafeInteger(a.height) || a.height < 1) throw new BudgetError('invalid_image_reference');
  }
  // UTF-8 byte upper bound plus protocol/adapter framing headroom. No cache discount reserved.
  return { inputTokens: safeInteger(Buffer.byteLength(JSON.stringify(options)) + 4096 + images.length * (imageMaxInputTokens ?? 0)), outputTokens: options.maxTokens! };
}
