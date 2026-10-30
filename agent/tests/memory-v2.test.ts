import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, cpSync, rmSync, readFileSync, writeFileSync, mkdirSync, symlinkSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join } from 'node:path';
import { Store } from '../src/storage/database.js';
import { Memory } from '../src/memory/memory.js';
import { Engine } from '../src/engine.js';
import { Outbox } from '../src/egress/outbox.js';
import { normalize } from '../src/ingress/normalizer.js';
import { channelTools } from '../src/tools/channel-tools.js';
import type { HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';

const summary = (title = '召唤规则') => JSON.stringify({ title, summary: '群友讨论是否需要称呼机器人才能召唤，随后追问是否必须添加称呼，尚未形成新的约定。',
  tags: { topics: ['机器人召唤'], entities: ['牢大'], states: ['未解决'], aliases: ['加名字', '叫名字', '召唤'] } });
function fixture(extra: Record<string, unknown> = {}) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-memory-v2-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  let time = now;
  const c = { ...config(extra), root }, store = new Store(c, ':memory:', () => time);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const memory = new Memory(store);
  const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
  const ingest = (events: Record<string, unknown>[]) => store.ingest({ events, cursor: Number(events.at(-1)?.sequence ?? store.checkpoint().cursor), truncated: false });
  return { root, c, store, memory, session, ingest, advance: (ms: number) => time += ms,
    cleanup: () => { store.close(); rmSync(root, { recursive: true, force: true }); } };
}

test('reply contains a continuous 200-message window including bot sends, deduplicates echo and current input', async () => {
  const f = fixture();
  const bridge = new FakeBridge(); bridge.config = f.c;
  bridge.send = async body => ({ request_id: JSON.parse(body).request_id, state: 'server_confirmed', message_id: 'bot:1', delivery_verified: false });
  const host = new FakeHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  try {
    f.ingest(Array.from({ length: 200 }, (_, i) => event(i + 1, 'group-a@chatroom', i === 199 ? '现在不需要加牢大，就能直接召唤吗' : `历史${i + 1}`)));
    f.store.exec("UPDATE inbox SET state='observed'");
    f.store.prepareReply(f.session, 'earlier-reply', '可以直接和我聊天。');
    await new Outbox(f.store, bridge).tick();
    f.ingest([event(201, 'group-a@chatroom', '可以直接和我聊天。', { message_id: 'bot:1', direction: 'outgoing', sender: 'self' }),
      event(202, 'group-a@chatroom', '所以需不需要加')]);
    bridge.page = { events: [], cursor: 202, truncated: false };
    await engine.tick(); await engine.drain();
    const reply = host.calls.find(c => c.purpose === 'reply')!;
    const context = JSON.parse(reply.context);
    assert.equal(context.recent.length, 200);
    assert.equal(context.recent.filter((m: any) => m.text === '所以需不需要加').length, 1);
    assert.equal(context.recent.filter((m: any) => m.text === '可以直接和我聊天。').length, 1);
    assert.equal(context.recent.find((m: any) => m.text === '可以直接和我聊天。').speaker, 'assistant');
    assert.ok(context.recent.some((m: any) => m.text === '现在不需要加牢大，就能直接召唤吗'));
    assert.equal(context.task, undefined); assert.equal(context.memories, undefined); assert.equal(context.evidence, undefined);
    assert.equal(context.contextStats.truncated, false);
    assert.equal(f.store.one('SELECT count(*) n FROM context_audit WHERE input_id=?', reply.inputId)!.n, 1);
  } finally { await engine.close(); rmSync(f.root, { recursive: true, force: true }); }
});

test('fixed prompts do not consume the chat allowance; large history has an explicit truncation marker', async () => {
  const f = fixture({ runtime: { provider: 'mock', model: 'test', chatContextBytes: 8192 } });
  writeFileSync(join(f.root, 'prompts/personas/default.md'), '固定人格'.repeat(1000));
  const bridge = new FakeBridge(); bridge.config = f.c;
  const host = new FakeHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  try {
    bridge.page = { events: [event(1)], cursor: 1, truncated: false };
    await engine.tick(); await engine.drain();
    const reply = host.calls.find(c => c.purpose === 'reply')!;
    assert.ok(Buffer.byteLength(reply.system) > f.c.runtime.chatContextBytes);
    assert.ok(Buffer.byteLength(reply.context) < f.c.runtime.chatContextBytes);
    f.ingest([event(2, 'group-a@chatroom', '很长'.repeat(10000))]);
    const recent = f.memory.recent(f.session, 2000);
    assert.equal(recent.truncated, true); assert.equal(recent.recent.at(-1)!.truncated, true);
    assert.ok(Buffer.byteLength(JSON.stringify(recent.recent)) <= 2000);
  } finally { await engine.close(); rmSync(f.root, { recursive: true, force: true }); }
});

test('summary timers cover count, idle, interval and low-traffic triggers', () => {
  for (const scenario of ['count', 'idle', 'interval', 'low']) {
    const f = fixture({ memory: { enabled: true } });
    try {
      const n = scenario === 'count' ? 100 : scenario === 'low' ? 1 : 10;
      f.ingest(Array.from({ length: n }, (_, i) => event(i + 1, 'group-a@chatroom')));
      assert.equal(f.memory.due(f.session), scenario === 'count');
      if (scenario === 'idle') f.advance(180000);
      if (scenario === 'interval') {
        f.advance(600000); f.ingest([event(n + 1, 'group-a@chatroom', '仍在聊天', { timestamp: (now + 600000) / 1000 })]);
      }
      if (scenario === 'low') { f.advance(1799000); assert.equal(f.memory.due(f.session), false); f.advance(1000); }
      assert.equal(f.memory.due(f.session), true);
    } finally { f.cleanup(); }
  }
});

test('summary publication is restart-readable, stores a synopsis without raw messages, and scopes retrieval', () => {
  const f = fixture({ memory: { enabled: true } });
  try {
    f.ingest([event(1, 'group-a@chatroom', '现在不需要加牢大，就能直接召唤吗'), event(2, 'group-a@chatroom', '所以需不需要加')]);
    const id = f.memory.commitSummary(f.session, f.memory.pending(f.session), summary(), 'v2');
    const row = f.store.one('SELECT * FROM memory_segments WHERE id=?', id)!;
    const file = JSON.parse(readFileSync(join(f.root, 'data/memory', f.session.key, row.path), 'utf8'));
    assert.equal(file.messages, undefined); assert.equal(file.messageCount, 2); assert.equal(file.startPosition, 1);
    const memory = new Memory(f.store), reader = memory.reader(f.session, 'read1');
    const matches = reader.search(['加名字']) as any;
    assert.equal(matches.matches[0].id, id);
    assert.throws(() => reader.history(id), /read_summary_before/);
    assert.equal((reader.read([id]) as any).summaries[0].summary, file.summary);
    const raw = reader.history(id) as any;
    assert.deepEqual(raw.messages.map((m: any) => m.text), ['现在不需要加牢大，就能直接召唤吗', '所以需不需要加']);
    const foreign = memory.reader({ ...f.session, key: 'f'.repeat(64) }, 'foreign');
    assert.equal((foreign.search([]) as any).matches.length, 0);
    assert.throws(() => foreign.read([id]), /not_listed/);
    assert.throws(() => foreign.search([], row.end_position), /cursor_denied/);
    assert.equal((reader.search(['找不到的词']) as any).matches.length, 0);
    assert.equal((reader.search([]) as any).matches[0].id, id);
  } finally { f.cleanup(); }
});

test('summary failure retains coverage and raw history through retention; invalid JSON never publishes', () => {
  const f = fixture({ memory: { enabled: true } });
  try {
    f.ingest([event(1, 'group-a@chatroom')]); const batch = f.memory.pending(f.session);
    assert.throws(() => f.memory.commitSummary(f.session, batch, '{bad', 'v2'));
    assert.equal(f.store.one('SELECT count(*) n FROM summary_checkpoints')!.n, 0);
    f.advance(8 * 86400000); f.store.exec("UPDATE inbox SET state='observed'"); f.store.sweep();
    assert.equal(f.memory.pending(f.session).length, 1);
    f.memory.commitSummary(f.session, batch, summary(), 'v2'); f.store.sweep();
    assert.equal(f.store.one('SELECT count(*) n FROM chat_history')!.n, 0);
    assert.equal(f.store.one('SELECT count(*) n FROM memory_segments')!.n, 1);
  } finally { f.cleanup(); }
});

test('retrieval pages newest first, observes segment/history caps, and keeps waiting time out of tool allowance', async () => {
  const f = fixture({ memory: { enabled: true, retrieval: { pageSize: 3, maxSegments: 2, maxHistoryBatches: 1, historyBatchSize: 1, timeoutMs: 1000, maxBytes: 64000 } } });
  try {
    for (let i = 1; i <= 4; i++) {
      f.ingest([event(i, 'group-a@chatroom', `原文${i}`, { timestamp: now / 1000 + i })]);
      f.memory.commitSummary(f.session, f.memory.pending(f.session), summary(`段${i}`), 'v2');
    }
    const reader = f.memory.reader(f.session, 'cap'), page = reader.search([]) as any;
    assert.deepEqual(page.matches.map((m: any) => m.title), ['段4', '段3', '段2']); assert.equal(page.hasMore, true);
    assert.equal((reader.search([], page.nextBefore) as any).matches[0].title, '段1');
    await new Promise(r => setTimeout(r, 1050));
    const read = reader.read(page.matches.map((m: any) => m.id)) as any;
    assert.equal(read.summaries.length, 2); assert.equal(read.stopped, 'memory_segment_limit');
    assert.equal((reader.history(page.matches[0].id) as any).messages.length, 1);
    assert.equal((reader.history(page.matches[1].id) as any).stopped, 'history_batch_limit');
  } finally { f.cleanup(); }
});

test('summary files reject links and corrupted data, and retrieval shares one byte allowance', () => {
  const f = fixture({ memory: { enabled: true, retrieval: { maxBytes: 1024 } } });
  try {
    f.ingest([event(1, 'group-a@chatroom')]);
    const document = JSON.parse(summary()); document.summary = '一段很长的聊天总结。'.repeat(50);
    const id = f.memory.commitSummary(f.session, f.memory.pending(f.session), JSON.stringify(document), 'v2');
    const reader = f.memory.reader(f.session, 'bytes'); reader.search([]);
    assert.equal((reader.read([id]) as any).stopped, 'memory_read_limit');
    const row = f.store.one('SELECT * FROM memory_segments')!;
    writeFileSync(join(f.root, 'data/memory', f.session.key, row.path), '{}');
    const other = new Memory(f.store).reader(f.session, 'corrupt'); other.search([]);
    assert.throws(() => other.read([id]), /integrity/);
    assert.throws(() => f.memory.files.read(f.session.key, '../../secret'), /path_denied/);
    const linked = 'f'.repeat(64), outside = join(f.root, 'elsewhere'); mkdirSync(outside);
    symlinkSync(outside, join(f.root, 'data/memory', linked), process.platform === 'win32' ? 'junction' : 'dir');
    assert.throws(() => f.memory.files.write(linked, now, 'a'.repeat(64), {}), /path_denied/);
  } finally { f.cleanup(); }
});

test('background summary uses an independent execution while reply generation remains available; invalid output retries after backoff', async () => {
  const f = fixture({ memory: { enabled: true, batchMessages: 2, minMessages: 1 }, runtime: { provider: 'mock', model: 'test', maxConcurrentRuns: 2 } });
  const bridge = new FakeBridge(); bridge.config = f.c;
  class SummaryHost extends FakeHost {
    valid = false;
    override async execute(input: HostInput, signal: AbortSignal) {
      const result = await super.execute(input, signal);
      if (input.purpose === 'memory' && this.valid) result.replies[0]!.text = summary();
      return result;
    }
  }
  const host = new SummaryHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  try {
    bridge.page = { cursor: 2, truncated: false, events: [event(1, 'group-a@chatroom'), event(2, 'group-a@chatroom')] };
    await engine.tick(); await engine.drain(); await engine.memoryTick(); await engine.drain();
    assert.equal(f.store.one('SELECT count(*) n FROM summary_checkpoints')!.n, 0);
    const before = host.calls.filter(i => i.purpose === 'memory').length;
    await engine.memoryTick(); await engine.drain();
    assert.equal(host.calls.filter(i => i.purpose === 'memory').length, before);
    host.valid = true; f.advance(61000);
    await engine.memoryTick(); await engine.drain();
    assert.equal(f.store.one('SELECT count(*) n FROM memory_segments')!.n, 1);
    const memoryInput = host.calls.findLast(i => i.purpose === 'memory')!, replyInput = host.calls.find(i => i.purpose === 'reply')!;
    assert.notEqual(memoryInput.executionId, replyInput.executionId);
    assert.ok(!memoryInput.system.includes('姓名叫“牢大”'));
    assert.equal(JSON.parse(memoryInput.context).messages.length, 2);
    const tools = channelTools(engine, replyInput, new AbortController().signal);
    assert.ok(tools.some(t => t.name === 'memory_search')); assert.ok(tools.some(t => t.name === 'history_read'));
  } finally { await engine.close(); rmSync(f.root, { recursive: true, force: true }); }
});
