import { z } from 'zod';
import { hash, type Message, type Session } from '../contracts.js';
import type { Store, Row } from '../storage/database.js';
import { MemoryFiles } from './files.js';
import { SocialMemory, socialSchema } from './social.js';

// Explicit byte allowance, not a tokenizer. UTF-8 bytes conservatively bound text tokens.
export function fitJson(items: unknown[], budget: number): unknown[] {
  const selected: unknown[] = []; let bytes = 2;
  for (const item of items) {
    const size = Buffer.byteLength(JSON.stringify(item)) + 1;
    if (bytes + size > budget) continue;
    selected.push(item); bytes += size;
  }
  return selected;
}
export const summarySchema = z.strictObject({
  title: z.string().trim().min(1).max(100), summary: z.string().trim().min(1).max(1000),
  tags: z.strictObject({
    topics: z.array(z.string().trim().min(1).max(40)).max(5),
    entities: z.array(z.string().trim().min(1).max(128)).max(5),
    states: z.array(z.string().trim().min(1).max(40)).max(4),
    aliases: z.array(z.string().trim().min(1).max(40)).max(5),
  }).refine(v => Object.values(v).flat().length >= 1 && Object.values(v).flat().length <= 10, 'one_to_ten_tags'),
  social: z.array(socialSchema).max(8).optional(),
});
export type HistoryItem = { position: number; message: Message };
// Retrieval-pressure estimate, deliberately conservative for Chinese. Not a provider tokenizer or billing counter.
export function estimateRecallTokens(text: string) {
  let ascii = 0, other = 0;
  for (const char of text) { if (char.codePointAt(0)! <= 127) ascii++; else other += char.codePointAt(0)! > 0xffff ? 4 : 2; }
  return Math.ceil(ascii / 3) + other + 8;
}
export class Memory {
  readonly files: MemoryFiles;
  readonly social: SocialMemory;
  constructor(readonly store: Store) { this.files = new MemoryFiles(store.config.root); this.social = new SocialMemory(store); }
  source(m: Message) {
    const route = hash(['wechat', m.accountKey, m.scope, m.conversationId]);
    const attachment = this.store.mediaDescriptor(route, m.messageId);
    return { messageId: m.messageId, senderId: m.senderId, timestampMs: m.timestampMs,
      speaker: m.direction === 'outgoing' ? 'assistant' : 'user', text: m.text, kind: m.kind,
      ...(attachment ? { attachment } : {}) };
  }
  rawSources(route: string, ids: string[]): Message[] {
    return ids.slice(0, 30).map(id => this.store.one('SELECT payload FROM chat_history WHERE route=? AND message_id=?', route, id))
      .filter(Boolean).map(r => JSON.parse(r!.payload));
  }
  pending(session: Session): HistoryItem[] {
    const position = Number(this.store.one('SELECT position FROM summary_checkpoints WHERE route=?', session.key)?.position ?? 0);
    return this.store.all('SELECT position,payload FROM chat_history WHERE route=? AND position>? ORDER BY position LIMIT ?',
      session.key, position, this.store.config.memory.batchMessages)
      .map(r => ({ position: Number(r.position), message: JSON.parse(r.payload) as Message }));
  }
  backlog(route: string) {
    return Number(this.store.one(`SELECT count(*) n FROM chat_history WHERE route=? AND position>coalesce(
      (SELECT position FROM summary_checkpoints WHERE route=?),0)`, route, route)!.n);
  }
  due(session: Session) {
    if (!this.store.config.memory.enabled) return false;
    const batch = this.pending(session); if (!batch.length) return false;
    const c = this.store.config.memory, now = this.store.clock(), count = this.backlog(session.key);
    const cp = this.store.one('SELECT completed FROM summary_checkpoints WHERE route=?', session.key);
    const latest = this.store.timeline(session.key, 1)[0]!;
    const elapsed = now - Number(cp?.completed ?? batch[0]!.message.timestampMs);
    return count >= c.batchMessages || elapsed >= c.lowTrafficSeconds * 1000 ||
      count >= c.minMessages && (elapsed >= c.intervalSeconds * 1000 || now - latest.message.timestampMs >= c.idleSeconds * 1000);
  }
  commitSummary(session: Session, batch: HistoryItem[], text: string, version: string) {
    const parsed = summarySchema.parse(JSON.parse(text));
    if ([...parsed.summary].length > this.store.config.memory.summaryMaxChars) throw Error('summary_too_long');
    if (!batch.length) throw Error('summary_empty_batch');
    const expected = this.pending(session).slice(0, batch.length);
    if (expected.length !== batch.length || expected.some((b, i) => b.position !== batch[i]!.position ||
        hash(b.message) !== hash(batch[i]!.message))) throw Error('summary_noncontiguous_or_foreign');
    const start = batch[0]!, end = batch[batch.length - 1]!;
    const id = hash([session.key, start.position, end.position, version]);
    const startTime = Math.min(...batch.map(b => b.message.timestampMs)), endTime = Math.max(...batch.map(b => b.message.timestampMs));
    const { social, ...summary } = parsed;
    const document = { format: 'wechat-summary-v2', id, scope: session.key, startPosition: start.position,
      endPosition: end.position, startTime, endTime, messageCount: batch.length, ...summary };
    // File first, then index + coverage atomically. An unindexed orphan is overwritten on retry.
    const path = this.files.write(session.key, startTime, id, document);
    this.store.transaction(() => {
      this.social.record(session, social ?? [], batch.map(b => b.message));
      this.store.exec('INSERT OR IGNORE INTO memory_segments VALUES(?,?,?,?,?,?,?,?,?,?,?)', id, session.key,
        start.position, end.position, startTime, endTime, parsed.title, JSON.stringify(parsed.tags), parsed.summary, path, this.store.clock());
      this.store.exec(`INSERT INTO summary_checkpoints VALUES(?,?,?) ON CONFLICT(route) DO UPDATE SET
        position=excluded.position,completed=excluded.completed`, session.key, end.position, this.store.clock());
    });
    return id;
  }
  recent(session: Session, byteBudget: number) {
    const timeline = this.store.timeline(session.key, this.store.config.runtime.recentMessages);
    const now = this.store.clock();
    const all = timeline.map((b, index) => {
      const ageSeconds = Math.max(0, Math.floor((now - b.message.timestampMs) / 1000));
      return { ...this.source(b.message), ageSeconds,
        gapSeconds: index ? Math.max(0, Math.floor((b.message.timestampMs - timeline[index - 1]!.message.timestampMs) / 1000)) : 0,
        recencyWeight: Math.max(0.01, Math.round(2 ** (-ageSeconds / 300) * 100) / 100) };
    });
    const selected: (typeof all[number] & { truncated?: boolean })[] = []; let used = 2;
    // Contiguous newest suffix; don't fill holes with unrelated older short messages.
    for (const item of [...all].reverse()) {
      if (Buffer.byteLength(JSON.stringify(item)) + used + 1 > byteBudget) {
        const available = Math.max(0, byteBudget - used - Buffer.byteLength(JSON.stringify({ ...item, text: '' })) - 128);
        let text = '', size = 0;
        for (const ch of item.text) { size += Buffer.byteLength(JSON.stringify(ch)) - 2; if (size > available) break; text += ch; }
        if (text) selected.push({ ...item, text, truncated: true });
        break;
      }
      selected.push(item); used += Buffer.byteLength(JSON.stringify(item)) + 1;
    }
    return { recent: selected.reverse(), availableMessages: all.length, includedMessages: selected.length,
      truncated: selected.length < all.length || selected.some(s => s.truncated) };
  }
  reader(session: Session, auditId: string) { return new MemoryReader(this, session, auditId); }
}

/** All memory/history tools in one reply share these counters and deadline. */
export class MemoryReader {
  private elapsedMs = 0;
  private activeStart?: number;
  private bytes = 0;
  private tokens = 0;
  private segments = new Set<string>();
  private historyBatches = 0;
  private searches = 0;
  private allowed = new Map<string, Row>();
  private visited = new Set<string>();
  constructor(readonly memory: Memory, readonly session: Session, readonly auditId: string) {}
  private get c() { return this.memory.store.config.memory.retrieval; }
  private measure<T>(fn: () => T): T {
    this.activeStart = performance.now();
    let stopped: string | undefined;
    try {
      const result = fn();
      stopped = (result as { stopped?: string })?.stopped;
      return result;
    } catch (error) { stopped = error instanceof Error ? error.message : 'memory_tool_failed'; throw error; }
    finally {
      this.elapsedMs += performance.now() - this.activeStart; this.activeStart = undefined;
      this.memory.store.exec('INSERT OR REPLACE INTO context_audit VALUES(?,?,?,?)', this.auditId + ':recall', this.session.key,
        JSON.stringify({ searches: this.searches, segmentIds: [...this.segments], historyBatches: this.historyBatches,
          bytes: this.bytes, estimatedTokens: this.tokens, elapsedMs: Math.round(this.elapsedMs), stopped }), this.memory.store.clock());
    }
  }
  private begin() {
    if (this.elapsedMs + (this.activeStart === undefined ? 0 : performance.now() - this.activeStart) >= this.c.timeoutMs) throw Error('memory_time_limit');
    if (this.bytes >= this.c.maxBytes) throw Error('memory_read_limit');
    if (this.tokens >= this.c.maxTokens) throw Error('memory_token_limit');
  }
  private output(value: Record<string, unknown>) {
    this.begin();
    const serialized = JSON.stringify(value), bytes = Buffer.byteLength(serialized), tokens = estimateRecallTokens(serialized);
    if (this.bytes + bytes > this.c.maxBytes) return { stopped: 'memory_read_limit', found: false };
    if (this.tokens + tokens > this.c.maxTokens) return { stopped: 'memory_token_limit', found: false };
    this.bytes += bytes; this.tokens += tokens;
    // dsh requires lossless JSON tool values; absent optional fields must be omitted, not undefined.
    return JSON.parse(JSON.stringify({ ...value, remainingBytes: this.c.maxBytes - this.bytes,
      remainingEstimatedTokens: this.c.maxTokens - this.tokens, evidenceOnly: true })) as Record<string, any>;
  }
  search(keywords: string[], before?: number) {
    return this.measure(() => this.searchInner(keywords, before));
  }
  private searchInner(keywords: string[], before?: number) {
    this.begin(); if (++this.searches > 12) throw Error('memory_search_limit');
    const terms = [...new Set(keywords.map(k => k.trim()).filter(Boolean))];
    const cursor = before ?? Number.MAX_SAFE_INTEGER, key = JSON.stringify([terms, cursor]);
    if (this.visited.has(key)) return this.output({ stopped: 'repeated_search', matches: [] });
    this.visited.add(key);
    const clause = terms.length ? ' AND (' + terms.map(() => '(instr(lower(title),lower(?))>0 OR instr(lower(tags),lower(?))>0)').join(' OR ') + ')' : '';
    const anchor = before === undefined ? undefined : this.memory.store.one('SELECT end_time,end_position FROM memory_segments WHERE route=? AND end_position=?', this.session.key, before);
    if (before !== undefined && !anchor) throw Error('memory_cursor_denied');
    const boundary = anchor ? ' AND (end_time<? OR (end_time=? AND end_position<?))' : '';
    const anchorArgs = anchor ? [anchor.end_time, anchor.end_time, anchor.end_position] : [];
    const rows = this.memory.store.all('SELECT * FROM memory_segments WHERE route=?' + boundary + clause +
      ' ORDER BY end_time DESC,end_position DESC LIMIT ?', this.session.key, ...anchorArgs, ...terms.flatMap(t => [t, t]), this.c.pageSize + 1);
    const page = rows.slice(0, this.c.pageSize);
    for (const row of page) this.allowed.set(row.id, row);
    return this.output({ matches: page.map(r => ({ id: r.id, title: r.title, tags: JSON.parse(r.tags),
      startTime: r.start_time, endTime: r.end_time })), hasMore: rows.length > page.length,
      nextBefore: page.at(-1)?.end_position ?? null, fallbackAvailable: terms.length > 0,
      instruction: terms.length && !page.length ? '没有标签命中；可用空关键词从最近摘要向前回溯。' : undefined });
  }
  read(ids: string[]) {
    return this.measure(() => this.readInner(ids));
  }
  private readInner(ids: string[]) {
    this.begin(); const results: Record<string, unknown>[] = [];
    for (const id of [...new Set(ids)]) {
      this.begin(); const row = this.allowed.get(id);
      if (!row) throw Error('memory_segment_not_listed');
      if (!this.segments.has(id) && this.segments.size >= this.c.maxSegments) return this.output({ summaries: results, stopped: 'memory_segment_limit' });
      const document = this.memory.files.read(this.session.key, row.path);
      if (document.id !== id || document.scope !== this.session.key || document.summary !== row.summary ||
          document.startPosition !== row.start_position || document.endPosition !== row.end_position ||
          hash(document.tags) !== hash(JSON.parse(row.tags))) throw Error('memory_integrity');
      const candidate = { id, startTime: row.start_time, endTime: row.end_time, title: row.title,
        summary: row.summary, tags: JSON.parse(row.tags), historyRange: { start: row.start_position, end: row.end_position } };
      if (this.bytes + Buffer.byteLength(JSON.stringify({ summaries: [...results, candidate] })) + 128 > this.c.maxBytes)
        return this.output({ summaries: results, stopped: 'memory_read_limit' });
      if (this.tokens + estimateRecallTokens(JSON.stringify({ summaries: [...results, candidate] })) + 128 > this.c.maxTokens)
        return this.output({ summaries: results, stopped: 'memory_token_limit' });
      results.push(candidate); this.segments.add(id);
    }
    return this.output({ summaries: results, remainingSegments: this.c.maxSegments - this.segments.size });
  }
  history(segmentId: string, before?: number) {
    return this.measure(() => this.historyInner(segmentId, before));
  }
  private historyInner(segmentId: string, before?: number) {
    this.begin(); if (!this.segments.has(segmentId)) throw Error('read_summary_before_history');
    if (this.historyBatches >= this.c.maxHistoryBatches) return this.output({ messages: [], stopped: 'history_batch_limit' });
    const row = this.allowed.get(segmentId)!;
    const end = before === undefined ? row.end_position + 1 : Math.min(before, row.end_position + 1);
    const rows = this.memory.store.all('SELECT position,payload FROM chat_history WHERE route=? AND position>=? AND position<? ORDER BY position DESC LIMIT ?',
      this.session.key, row.start_position, end, this.c.historyBatchSize + 1);
    const page = rows.slice(0, this.c.historyBatchSize); this.historyBatches++;
    const messages: { position: number; [key: string]: unknown }[] = [];
    let stopped: string | undefined;
    for (const r of page) {
      const m = { position: r.position, ...this.memory.source(JSON.parse(r.payload)) };
      if (this.bytes + Buffer.byteLength(JSON.stringify({ messages: [...messages, m] })) + 256 > this.c.maxBytes) { stopped = 'memory_read_limit'; break; }
      if (this.tokens + estimateRecallTokens(JSON.stringify({ messages: [...messages, m] })) + 128 > this.c.maxTokens) { stopped = 'memory_token_limit'; break; }
      messages.push(m);
    }
    if (page.length && !messages.length) return this.output({ messages: [], stopped });
    const nextBefore = messages.at(-1)?.position ?? null, hasMore = rows.length > messages.length;
    return this.output({ messages: messages.reverse(), hasMore, nextBefore, stopped,
      unavailable: !rows.length, note: !rows.length ? '原始历史可能已超过保留期，不能据此认定没有发生。' : undefined });
  }
}
