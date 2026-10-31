import { readFileSync, realpathSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { parse } from 'yaml';
import { fileURLToPath } from 'node:url';
import { z } from 'zod';

const id = z.string().min(1).max(128).refine(v => !/REPLACE|LOCAL_|\s|[\x00-\x1f]/.test(v), '请填写真实的本机身份或别名');
const int = (min: number, max: number, fallback: number) => z.number().int().min(min).max(max).default(fallback);
const prompts = z.strictObject({
  profile: z.string().optional(), system: z.string().optional(), persona: z.string().nullable().optional(),
  groupScene: z.string().optional(), directScene: z.string().optional(), responseStyle: z.string().optional(),
  participation: z.string().optional(), replyDecision: z.string().optional(), toolBehavior: z.string().nullable().optional(),
  memoryExtract: z.string().optional(), memoryConsolidate: z.string().optional(), sessionCompact: z.string().optional(),
  append: z.string().max(2000).optional(),
});
const participation = z.strictObject({
  debounceMs: int(0, 60000, 500), maxBatchWaitMs: int(100, 60000, 2000), cooldownSeconds: int(0, 3600, 2),
  maxRepliesPerMinute: int(1, 10, 8), maxWaitRetries: int(0, 3, 1), decisionContextTokens: int(256, 8192, 2000),
  maxDecisionsPerMinute: int(1, 60, 30),
});
const override = z.strictObject({ prompts: prompts.optional(), directTrigger: z.enum(['prefix', 'all']).optional(),
  administrators: z.array(id).default([]), participation: participation.partial().optional() });
export const ConfigSchema = z.strictObject({
  account: z.strictObject({ key: id, selfId: id, bridgeEpoch: id }),
  bridge: z.strictObject({ sessionFile: z.string(), pollMs: int(100, 30000, 1000), timeoutMs: int(100, 120000, 10000),
    requestStoreContinuity: z.enum(['manual', 'confirmed']).default('manual') }),
  storage: z.strictObject({ file: z.string().default('data/agent.sqlite'), retentionDays: int(1, 30, 7),
    maxInbox: int(100, 100000, 10000), maxInboxBytes: int(65536, 1073741824, 33554432) }).default({ file: 'data/agent.sqlite', retentionDays: 7, maxInbox: 10000, maxInboxBytes: 33554432 }),
  ingress: z.strictObject({ firstStart: z.literal('baseline').default('baseline'), maxMessageAgeSeconds: int(1, 600, 120),
    onGap: z.literal('pause').default('pause') }).default({ firstStart: 'baseline', maxMessageAgeSeconds: 120, onGap: 'pause' }),
  access: z.strictObject({ owners: z.array(id).default([]), prefix: z.string().min(1).default('/ai '),
    direct: z.strictObject({ mode: z.literal('allowlist').default('allowlist'), allow: z.array(id).default([]), trigger: z.enum(['prefix', 'all']).default('prefix') }),
    group: z.strictObject({ mode: z.literal('allowlist').default('allowlist'), allow: z.array(id).default([]),
      memberMode: z.literal('all_in_allowed_group').default('all_in_allowed_group'), sessionScope: z.literal('group').default('group'), trigger: z.literal('autonomous').default('autonomous') }) }),
  participation: participation.default({ debounceMs: 500, maxBatchWaitMs: 2000, cooldownSeconds: 2, maxRepliesPerMinute: 8, maxWaitRetries: 1, decisionContextTokens: 2000, maxDecisionsPerMinute: 30 }),
  sessions: z.strictObject({ isolation: z.literal('conversation'), crossSessionMemory: z.literal(false) }).default({ isolation: 'conversation', crossSessionMemory: false }),
  social: z.strictObject({ enabled: z.boolean().default(true), toneMinutes: int(1, 120, 30), careCooldownHours: int(1, 168, 24),
    proactive: z.strictObject({ enabled: z.boolean().default(false), contacts: z.array(id).max(100).default([]),
      maxPerContactPerDay: int(1, 3, 1), minIdleMinutes: int(1, 1440, 30),
      quietStartHour: int(0, 23, 22), quietEndHour: int(0, 23, 9),
    }).prefault({}),
  }).prefault({}),
  prompts: prompts.default({ profile: 'default' }),
  promptProfiles: z.record(z.string(), prompts.extend({ extends: z.string().optional() })).default({}),
  conversationOverrides: z.strictObject({ groups: z.record(z.string(), override).default({}), contacts: z.record(z.string(), override).default({}) }).default({ groups: {}, contacts: {} }),
  runtime: z.strictObject({ engine: z.literal('dsh').default('dsh'), provider: id, model: id,
    models: z.record(z.string(), z.strictObject({ provider: id, model: id })).default({}), preset: z.literal('assistant').default('assistant'),
    maxConcurrentRuns: int(1, 4, 2), perSessionQueue: int(1, 100, 10), globalQueue: int(1, 1000, 100),
    turnTimeoutSeconds: int(1, 600, 120), maxToolSteps: z.literal(12).default(12), idleEvictMinutes: int(1, 120, 30),
    // Legacy knobs remain readable for existing local configs; new chat allowance is independent of prompts.
    contextTokens: int(512, 32000, 6000), memoryTokens: int(128, 8192, 1500),
    recentMessages: z.literal(200).default(200), chatContextBytes: int(8192, 1048576, 196608) }),
  egress: z.strictObject({ streaming: z.literal(false).default(false), chunkBytes: int(128, 3800, 3800), maxInlineParts: int(1, 30, 30), sendArtifacts: z.boolean().default(false) }).default({ streaming: false, chunkBytes: 3800, maxInlineParts: 30, sendArtifacts: false }),
  media: z.strictObject({ enabled: z.boolean().default(false), maxInputMiB: int(1, 10, 10), cacheMiB: int(10, 1024, 256),
    ttlHours: int(1, 168, 24), maxImagesPerReply: int(1, 12, 6),
  }).prefault({}),
  sandbox: z.strictObject({ directory: z.literal('data/sandbox').default('data/sandbox') }).default({ directory: 'data/sandbox' }),
  video: z.strictObject({ enabled: z.boolean().default(true), python: z.string().default('py'),
    maxInputMiB: int(10, 512, 128), maxDurationSeconds: int(10, 14400, 3600),
    timeoutSeconds: int(10, 240, 90), frames: int(4, 16, 12),
    bilibili: z.boolean().default(true), douyin: z.boolean().default(true),
    bilibiliCookies: z.string().default('config/bilibili.cookies.local.txt'),
    douyinCookies: z.string().default('config/douyin.cookies.local.txt'),
    asr: z.strictObject({ backend: z.enum(['local', 'endpoint', 'off']).default('local'),
      localModel: z.string().default('data/video-models/faster-whisper-base'),
      endpoint: z.string().url().optional(), model: z.string().default('whisper-1'),
      apiKeyEnv: z.string().regex(/^[A-Z][A-Z0-9_]*$/).default('VIDEO_ASR_API_KEY'),
      maxSeconds: int(10, 600, 180),
    }).prefault({}),
  }).prefault({}),
  stickers: z.strictObject({ enabled: z.boolean().default(true), directory: z.string().trim().min(1).max(1024).default('data/stickers'),
    maxFiles: int(1, 2000, 512), maxFileMiB: int(1, 10, 10),
  }).prefault({}),
  externalAccess: z.strictObject({ enabled: z.boolean().default(false), approver: id.optional(),
    timeoutSeconds: int(10, 300, 120), maxFileMiB: int(1, 10, 10),
  }).prefault({}),
  web: z.strictObject({ fetch: z.boolean().default(true), search: z.boolean().default(true),
    timeoutMs: int(1000, 30000, 15000), maxResponseBytes: int(1024, 2097152, 1048576),
    maxOutputChars: int(1000, 20000, 12000), maxResults: int(1, 8, 5),
  }).default({ fetch: true, search: true, timeoutMs: 15000, maxResponseBytes: 1048576, maxOutputChars: 12000, maxResults: 5 }),
  memory: z.strictObject({ enabled: z.boolean().default(true), batchMessages: int(2, 100, 100), idleSeconds: int(1, 600, 180),
    intervalSeconds: int(60, 3600, 600), lowTrafficSeconds: int(60, 86400, 1800), minMessages: int(1, 100, 10),
    priorityMessages: int(100, 200, 150), maxCallsPerHour: int(1, 120, 60),
    summaryMaxChars: int(200, 1000, 1000), inputBytes: int(8192, 262144, 65536),
    retrieval: z.strictObject({ pageSize: int(1, 6, 3), maxSegments: int(1, 30, 12),
      maxHistoryBatches: int(1, 8, 4), historyBatchSize: int(1, 50, 20),
      timeoutMs: int(1000, 60000, 15000), maxBytes: int(1024, 131072, 32768), maxTokens: int(256, 32000, 8000),
    }).prefault({}),
  }).prefault({}),
  budget: z.strictObject({ enabled: z.boolean().default(false), dailyLimitCny: z.number().min(0.000001).max(1000000).default(5),
    timeZone: z.literal('Asia/Shanghai').default('Asia/Shanghai'), resumeAtMidnight: z.literal(true).default(true),
    pricingFile: z.string().default('config/pricing.deepseek.2026-10-29.json'), maxPricingAgeDays: int(1, 90, 30),
  }).default({ enabled: false, dailyLimitCny: 5, timeZone: 'Asia/Shanghai', resumeAtMidnight: true,
    pricingFile: 'config/pricing.deepseek.2026-10-29.json', maxPricingAgeDays: 30 }),
  interactions: z.strictObject({ timeoutSeconds: int(10, 900, 300) }).default({ timeoutSeconds: 300 }),
});
export type Config = z.infer<typeof ConfigSchema> & { root: string; version: string };
export function loadConfig(path: string): Config {
  const root = fileURLToPath(new URL('../..', import.meta.url));
  return validateConfig(parse(readFileSync(path, 'utf8')), root);
}
export function validateConfig(data: unknown, root: string): Config {
  const value = ConfigSchema.parse(data);
  if (value.participation.maxBatchWaitMs < value.participation.debounceMs) throw Error('maxBatchWaitMs 小于 debounceMs');
  if (value.memory.priorityMessages < value.memory.batchMessages) throw Error('summary_priority_below_batch');
  if (value.access.group.allow.some(v => !v.endsWith('@chatroom'))) throw Error('群 ID 必须以 @chatroom 结尾');
  if (value.access.direct.allow.some(v => v.endsWith('@chatroom'))) throw Error('私聊白名单不能包含群');
  if (value.social.proactive.contacts.some(v => !value.access.direct.allow.includes(v) || v === value.account.selfId)) throw Error('proactive_contact_not_allowed');
  if (value.externalAccess.enabled && (!value.externalAccess.approver || !value.access.direct.allow.includes(value.externalAccess.approver) || value.externalAccess.approver === value.account.selfId)) throw Error('external_approver_not_allowed');
  return { ...value, root: realpathSync(root), version: JSON.stringify(value) };
}
export function conversationConfig(c: Config, scope: 'group' | 'direct', conversation: string) {
  return (scope === 'group' ? c.conversationOverrides.groups : c.conversationOverrides.contacts)[conversation];
}
