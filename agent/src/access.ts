import { readFileSync, writeFileSync, renameSync, unlinkSync, mkdirSync, lstatSync } from 'node:fs';
import { dirname, resolve } from 'node:path';
import { randomUUID } from 'node:crypto';
import { z } from 'zod';
import type { Config } from './config.js';

export const conversationId = z.string().trim().min(1).max(128).regex(/^[^\s\x00-\x1f]+$/);
export const accessPolicy = z.strictObject({ enabled: z.boolean(), files: z.enum(['sandbox', 'any', 'approval']) });
export const accessUpdate = accessPolicy.extend({ conversation: conversationId });
type Policy = z.infer<typeof accessPolicy>;
const document = z.strictObject({ account: z.string(), entries: z.record(conversationId, accessPolicy) });
const file = (c: Config) => resolve(c.root, c.storage.file) + '.access.json';

// Separate from the chat DB: admin writes never migrate historical chat storage.
// Read afresh at authorization boundaries so separate admin/bot processes agree.
export function accessEntries(c: Config): Record<string, Policy> {
  try {
    const path = file(c), stat = lstatSync(path);
    if (!stat.isFile() || stat.isSymbolicLink() || stat.nlink !== 1 || stat.size > 2 * 1024 * 1024) throw Error('access_policy_invalid');
    const value = document.parse(JSON.parse(readFileSync(path, 'utf8')));
    if (value.account !== c.account.key) throw Error('access_account_mismatch');
    return value.entries;
  } catch (error) {
    if ((error as NodeJS.ErrnoException).code === 'ENOENT') return {};
    throw Error('access_policy_unavailable');
  }
}
export function conversationAccess(c: Config, conversation: string): Policy {
  const entries = accessEntries(c);
  if (Object.hasOwn(entries, conversation)) return entries[conversation]!;
  return { enabled: (conversation.endsWith('@chatroom') ? c.access.group.allow : c.access.direct.allow).includes(conversation),
    files: c.externalAccess.enabled ? 'approval' : 'sandbox' };
}
export function conversationEnabled(c: Config, conversation: string): boolean {
  try { return conversation !== c.account.selfId && conversationAccess(c, conversation).enabled; } catch { return false; }
}
export function saveConversationAccess(c: Config, input: unknown) {
  const { conversation, ...policy } = accessUpdate.parse(input);
  if (conversation === c.account.selfId || policy.files === 'approval' && !c.externalAccess.enabled) throw Error('invalid_access_policy');
  const entries = accessEntries(c);
  Object.defineProperty(entries, conversation, { value: policy, enumerable: true, configurable: true, writable: true });
  if (Object.keys(entries).length > 10000) throw Error('access_policy_limit');
  const path = file(c), temp = path + '.' + randomUUID() + '.tmp';
  mkdirSync(dirname(path), { recursive: true });
  try {
    writeFileSync(temp, JSON.stringify({ account: c.account.key, entries }), { flag: 'wx', mode: 0o600 });
    renameSync(temp, path);
  } finally { try { unlinkSync(temp); } catch {} }
  return { conversation, ...policy };
}
