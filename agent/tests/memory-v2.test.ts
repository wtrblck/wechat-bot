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
import { hash, type HostInput } from '../src/contracts.js';
import { config, event, now, FakeBridge, FakeHost, agentRoot } from './helpers.js';

const summary = (title = '召唤规则') => JSON.stringify({ title, summary: '群友讨论是否需要称呼机器人才能召唤，随后追问是否必须添加称呼，尚未形成新的约定。',
  tags: { topics: ['机器人召唤'], entities: ['牢大'], states: ['未解决'], aliases: ['加名字', '叫名字', '召唤'] } });

function fixture(extra: Record<string, unknown> = {}, durable = false) {
  const root = mkdtempSync(join(tmpdir(), 'wechat-memory-v2-'));
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  let time = now;
  const c = { ...config(extra), root }, clock = () => time, file = durable ? join(root, 'retry.sqlite') : ':memory:', store = new Store(c, file, clock);
  store.ingest({ events: [], cursor: 0, truncated: false });
  const memory = new Memory(store);
  const session = store.session(normalize(event(1, 'group-a@chatroom'), c)!);
  const ingest = (events: Record<string, unknown>[]) => store.ingest({ events, cursor: Number(events.at(-1)?.sequence ?? store.checkpoint().cursor), truncated: false });
  return { root, c, store, memory, session, ingest, file, clock, advance: (ms: number) => time += ms,
    cleanup: () => { store.close(); rmSync(root, { recursive: true, force: true }); } };
}


test('fixed initial prompts have their own allowance while new message packets remain bounded', async () => {
  const f = fixture({ runtime: { provider: 'mock', model: 'test', chatContextBytes: 8192 } });
  // Leave room under the fixed system ceiling for the mandatory runtime contract.
  writeFileSync(join(f.root, 'prompts/personas/default.md'), '固定人格'.repeat(400));
  const bridge = new FakeBridge(); bridge.config = f.c;
  const host = new FakeHost(), engine = new Engine(f.c, f.store, bridge, host, () => {});
  try {
    bridge.page = { events: [event(1)], cursor: 1, truncated: false };
    await engine.tick(); await engine.drain();
    const reply = host.calls.find(c => c.purpose === 'reply')!;
    assert.ok(Buffer.byteLength(reply.system) > f.c.runtime.chatContextBytes);
    assert.ok(Buffer.byteLength(reply.context) < f.c.runtime.chatContextBytes);
  } finally { await engine.close(); rmSync(f.root, { recursive: true, force: true }); }
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
