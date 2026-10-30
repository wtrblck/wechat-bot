// Offline validation: reads a consistent snapshot, never opens the live DB for writing or calls a model/bridge.
import { DatabaseSync, backup } from 'node:sqlite';
import { mkdtempSync, rmSync, mkdirSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { resolve, join, relative, isAbsolute } from 'node:path';
import { loadConfig } from '../dist/src/config.js';
import { Store } from '../dist/src/storage/database.js';
import { Memory } from '../dist/src/memory/memory.js';
import { PromptRegistry } from '../dist/src/prompts/registry.js';

const config = loadConfig(resolve('config/agent.local.yaml'));
const temp = mkdtempSync(join(tmpdir(), 'wechat-context-replay-'));
let store;
try {
  const source = new DatabaseSync(resolve(config.root, config.storage.file), { readOnly: true });
  try { await backup(source, join(temp, 'replay.sqlite')); } finally { source.close(); }
  store = new Store(config, join(temp, 'replay.sqlite'));
  const memory = new Memory(store), prompts = new PromptRegistry(config);
  const groups = store.all("SELECT * FROM session_map WHERE scope='group'").map(session => {
    const recent = memory.recent(session, config.runtime.chatContextBytes - 2048);
    const old = store.all("SELECT input FROM runs WHERE route=? AND purpose='reply' ORDER BY created", session.key)
      .map(r => JSON.parse(r.input)).filter(i => i.context).map(i => JSON.parse(i.context));
    const ids = recent.recent.map(m => m.messageId);
    const lostFollowup = '所以需不需要加';
    const pairIncluded = recent.recent.some(m => m.text === '现在不需要加牢大，就能直接召唤吗') &&
      recent.recent.some(m => m.text === lostFollowup);
    return { scope: session.key, legacyReplyRuns: old.length,
      legacyRepliesWithMemories: old.filter(c => c.evidence?.memories?.length).length,
      legacyRepliesWithBotHistory: old.filter(c => c.evidence?.previousReplies?.length).length,
      rebuiltHistory: store.one('SELECT count(*) n FROM chat_history WHERE route=?', session.key).n,
      newWindowMessages: recent.includedMessages, newWindowBotMessages: recent.recent.filter(m => m.speaker === 'assistant').length,
      uniqueMessageIds: new Set(ids).size === ids.length, previouslyDisconnectedPairIncluded: pairIncluded,
      windowTruncated: recent.truncated, newWindowBytes: Buffer.byteLength(JSON.stringify(recent.recent)),
      fixedPromptBytes: Buffer.byteLength(prompts.snapshot(session, 'reply').system),
      chatAllowanceBytes: config.runtime.chatContextBytes, summaryBacklog: memory.backlog(session.key) };
  });
  const report = { checkedAt: new Date().toISOString(), mode: 'offline-readonly-source-snapshot',
    paidModelCalls: 0, messagesSent: 0, productionDatabaseModified: false, groups };
  const directory = resolve(config.root, 'data/validation'); mkdirSync(directory, { recursive: true });
  writeFileSync(join(directory, 'memory-v2-replay.json'), JSON.stringify(report, null, 2) + '\n');
  console.log(JSON.stringify(report, null, 2));
} finally {
  store?.close();
  const rel = relative(tmpdir(), temp);
  if (!rel || rel.startsWith('..') || isAbsolute(rel)) throw Error('cleanup_path_denied');
  rmSync(temp, { recursive: true, force: true });
}
