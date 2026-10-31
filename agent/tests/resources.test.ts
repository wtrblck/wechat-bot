import { test } from 'node:test';
import assert from 'node:assert/strict';
import { createHash } from 'node:crypto';
import { mkdtempSync, rmSync, writeFileSync, existsSync, cpSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, relative, isAbsolute } from 'node:path';
import { Resources } from '../src/media/resources.js';
import { Store } from '../src/storage/database.js';
import { normalize } from '../src/ingress/normalizer.js';
import { config, event, now, FakeBridge, agentRoot } from './helpers.js';
import { PromptRegistry } from '../src/prompts/registry.js';

test('media is hash checked, extracted within scope, and pending/unsupported media is never described as understood', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-media-'));
  const c = { ...config({ media: { enabled: true } }), root };
  const store = new Store(c, ':memory:', () => now); const bridge = new FakeBridge();
  const bytes = Buffer.from('受控文本内容', 'utf8');
  const mediaBridge = Object.assign(bridge, {
    mediaMetadata: async () => ({ state: 'ready', name: 'document.md', variants: { content: { size: bytes.length, mime: 'text/plain', sha256: createHash('sha256').update(bytes).digest('hex') } } }),
    mediaContent: async () => bytes,
  });
  const resources = new Resources(store, mediaBridge);
  try {
    const m = normalize(event(1, 'contact-a', '[file]', { message_type: 'file', media: { id: 'media-1' } }), c)!;
    const descriptor = await resources.describe(m, new AbortController().signal);
    assert.equal(descriptor.extractedText, undefined); assert.match(String(descriptor.path), /^media\/[a-f0-9]{64}\.md$/);
    const s = store.session(m); assert.equal(resources.read(s.key, String(descriptor.resourceId)).toString('utf8'), '受控文本内容');
    assert.equal(resources.readText(s.key, String(descriptor.path)).text, '受控文本内容');
    assert.throws(() => resources.read('different-scope', String(descriptor.resourceId)), /denied/);
    const voice = await resources.describe({ ...m, kind: 'voice', mediaRef: 'media-voice' }, new AbortController().signal);
    assert.match(String(voice.note), /ASR/);
    mediaBridge.mediaContent = async () => Buffer.from('changed');
    assert.equal((await resources.describe({ ...m, messageId: 'changed-message', mediaRef: 'changed' }, new AbortController().signal)).state, 'unavailable');
  } finally { store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
test('artifact output is idempotent, rejects mutation, and cleanup preserves referenced resources', () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-artifact-')); let time = now;
  const store = new Store({ ...config(), root }, ':memory:', () => time); const resources = new Resources(store, new FakeBridge());
  try {
    const s = store.session(normalize(event(1), store.config)!);
    const first = resources.artifact(s, 'event-1', '完整内容');
    assert.deepEqual(resources.artifact(s, 'event-1', '完整内容'), first);
    assert.throws(() => resources.artifact(s, 'event-1', '变更内容'), /artifact_conflict/);
    store.exec('UPDATE artifacts SET refs=1 WHERE id=?', first.id); time += 25 * 3600000; resources.sweep();
    assert.ok(existsSync(first.path)); store.exec('UPDATE artifacts SET refs=0 WHERE id=?', first.id); resources.sweep();
    assert.equal(existsSync(first.path), false);
  } finally { store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
test('prompt updates switch at boundaries, and invalid edits retain the last validated version', t => {
  // Template output includes local_time; crossing a clock second is not a reload.
  t.mock.timers.enable({ apis: ['Date'], now });
  const root = mkdtempSync(join(tmpdir(), 'wechat-prompt-')); const c = { ...config(), root };
  cpSync(join(agentRoot, 'prompts'), join(root, 'prompts'), { recursive: true });
  const store = new Store(c, ':memory:', () => now);
  try {
    const registry = new PromptRegistry(c); const s = store.session(normalize(event(1), c)!);
    const old = registry.snapshot(s, 'reply');
    writeFileSync(join(root, 'prompts/personas/default.md'), '使用新的表达方式。');
    const updated = registry.snapshot(s, 'reply'); assert.notEqual(old.id, updated.id); assert.match(updated.system, /新的表达方式/);
    assert.ok(!old.system.includes('新的表达方式'));
    writeFileSync(join(root, 'prompts/personas/default.md'), '{{undefined_variable}}');
    assert.equal(registry.snapshot(s, 'reply').system, updated.system); assert.equal(registry.reloadError, 'prompt_reload_rejected');
  } finally { store.close(); const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); }
});
