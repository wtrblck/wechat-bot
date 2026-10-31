import { constants, openSync, closeSync, fstatSync, readSync, readFileSync, lstatSync, realpathSync, readdirSync, writeFileSync, renameSync, unlinkSync } from 'node:fs';
import { isAbsolute, resolve, parse, join, dirname, basename } from 'node:path';
import { randomUUID, createHash } from 'node:crypto';
import { setTimeout as delay } from 'node:timers/promises';
import { hash, type HostInput } from '../contracts.js';
import type { Engine } from '../engine.js';
import { Sandbox } from './sandbox.js';

/** Explicit single-operation approval, never an ambient host-filesystem grant. */
export class ExternalFiles {
  constructor(readonly engine: Engine, readonly input: HostInput, readonly signal: AbortSignal) {}
  private unchanged() {
    this.signal.throwIfAborted();
    if (this.engine.store.one('SELECT generation FROM session_map WHERE key=?', this.input.session.key)?.generation !== this.input.session.generation) throw Error('session_generation_changed');
  }
  private target(path: string, allowRoot = false) {
    if (!isAbsolute(path) || path.length > 1024 || /[\x00-\x1f]/.test(path) || /^[/\\]{2}/.test(path)) throw Error('external_path_denied');
    const root = parse(path).root;
    const rest = path.slice(root.length);
    if (!rest && allowRoot) return resolve(path);
    if (rest.split(/[/\\]/).some(p => !p || p === '.' || p === '..' || /[. ]$|[<>:"|?*]/.test(p) || /^(con|prn|aux|nul|com[0-9]|lpt[0-9])(?:\.|$)/i.test(p))) throw Error('external_path_denied');
    if (!rest) throw Error('external_path_denied');
    return resolve(path);
  }
  private checked(path: string, missing = false) {
    const root = parse(path).root;
    let current = root;
    for (const part of path.slice(root.length).split(/[/\\]/)) {
      current = join(current, part);
      try {
        const s = lstatSync(current);
        if (s.isSymbolicLink() || (!s.isFile() && !s.isDirectory()) || (s.isFile() && s.nlink !== 1) ||
          realpathSync(current).toLowerCase() !== resolve(current).toLowerCase()) throw Error('external_link_denied');
        if (current !== path && !s.isDirectory()) throw Error('external_parent_not_directory');
      } catch (error) {
        if (missing && current === path && (error as NodeJS.ErrnoException).code === 'ENOENT') return;
        throw error;
      }
    }
  }
  private async approve(operation: Record<string, unknown>, reason: string) {
    this.unchanged();
    const { store, config, interactions } = this.engine;
    const approver = config.externalAccess.approver;
    if (!config.externalAccess.enabled || !approver) throw Error('external_access_disabled');
    const contact = store.session({ accountKey: config.account.key, bridgeEpoch: config.account.bridgeEpoch,
      sequence: 0, messageId: 'approval-contact', conversationId: approver, senderId: approver,
      scope: 'direct', direction: 'incoming', kind: 'text', text: '', timestampMs: store.clock() });
    const payload = { originRoute: this.input.session.key, originGeneration: this.input.session.generation,
      inputId: this.input.inputId, operation, reason };
    const id = interactions.create(contact, approver, 'approval', payload);
    const expires = store.clock() + config.externalAccess.timeoutSeconds * 1000;
    store.exec('UPDATE interactions SET expires=? WHERE id=?', expires, id);
    const text = `沙箱外文件操作申请 ${id}\n来源：${this.input.session.scope} ${this.input.session.conversation}\n操作：${JSON.stringify(operation)}\n用途（模型说明）：${JSON.stringify(reason)}\n仅批准本次指定操作，写入会替换目标文件；不允许执行命令。请在${config.externalAccess.timeoutSeconds}秒内私聊回复 /bot allow ${id} 或 /bot deny ${id}。`;
    store.prepareReply(contact, 'command:external-approval:' + id, text, { runId: this.input.inputId });
    try {
      while (true) {
        this.unchanged();
        if (store.one('SELECT generation FROM session_map WHERE key=?', contact.key)?.generation !== contact.generation) throw Error('external_approver_session_changed');
        const row = store.one('SELECT * FROM interactions WHERE id=?', id);
        if (!row || row.expires <= store.clock()) throw Error('external_approval_expired');
        if (row.state === 'answered' && row.answer === 'allow' && row.parameter_hash === hash(payload)) {
          this.unchanged();
          store.exec("UPDATE interactions SET state='consumed' WHERE id=? AND state='answered' AND answer='allow'", id);
          this.audit(id, { status: 'approved', operation });
          return id;
        }
        if (row.state !== 'pending') throw Error('external_approval_' + row.state);
        await delay(200, undefined, { signal: this.signal });
      }
    } finally {
      store.exec("UPDATE interactions SET state='invalidated' WHERE id=? AND state IN ('pending','answered')", id);
      // Unsent permission prompts are no longer actionable after cancellation/expiry.
      store.exec("UPDATE outbox SET state='cancelled' WHERE reply=? AND submitted=0 AND state='prepared'", 'command:external-approval:' + id);
    }
  }
  private audit(id: string, result: Record<string, unknown>) {
    this.engine.store.exec('INSERT OR REPLACE INTO metadata VALUES(?,?)', 'external_operation:' + id,
      JSON.stringify({ at: this.engine.store.clock(), ...result }));
  }
  async list(path: string, reason: string) {
    path = this.target(path, true);
    const approvalId = await this.approve({ kind: 'list_directory', path, limit: 100 }, reason);
    this.unchanged();
    this.checked(path);
    const files = readdirSync(path, { withFileTypes: true }).slice(0, 100).map(e => ({ name: e.name, kind: e.isSymbolicLink() ? 'link' : e.isDirectory() ? 'directory' : 'file' }));
    this.audit(approvalId, { status: 'completed', kind: 'list_directory', path });
    return { approvalId, path, files, limit: 100 };
  }
  async read(path: string, reason: string) {
    path = this.target(path);
    const maxBytes = this.engine.config.externalAccess.maxFileMiB * 1024 * 1024;
    const approvalId = await this.approve({ kind: 'read_file', path, maxBytes, destinationSession: this.input.session.conversation }, reason);
    this.unchanged();
    this.checked(path);
    const fd = openSync(path, constants.O_RDONLY | (constants.O_NOFOLLOW ?? 0));
    let bytes: Buffer;
    try {
      const stat = fstatSync(fd);
      if (!stat.isFile() || stat.nlink !== 1 || stat.size > maxBytes) throw Error('external_file_invalid_or_too_large');
      bytes = Buffer.alloc(stat.size);
      // Bound allocation and reads even if another writer grows the file.
      this.unchanged(); this.checked(path);
      let offset = 0;
      while (offset < bytes.length) { const n = readSync(fd, bytes, offset, bytes.length - offset, offset); if (!n) break; offset += n; }
      bytes = bytes.subarray(0, offset);
    } finally { closeSync(fd); }
    const name = basename(path);
    const rel = 'external/' + approvalId + '/' + name;
    new Sandbox(this.engine.config.root, this.input.session.key).writeBytes(rel, bytes, maxBytes);
    let text: string | undefined;
    if (bytes.length <= 65536) { try { text = new TextDecoder('utf-8', { fatal: true }).decode(bytes); } catch {} }
    this.audit(approvalId, { status: 'completed', kind: 'read_file', path, bytes: bytes.length, hash: createHash('sha256').update(bytes).digest('hex') });
    return { approvalId, path: rel, bytes: bytes.length, ...(text !== undefined ? { text } : {}) };
  }
  async write(path: string, sourcePath: string, reason: string) {
    path = this.target(path);
    const sandbox = new Sandbox(this.engine.config.root, this.input.session.key);
    const source = sandbox.path(sourcePath);
    const size = lstatSync(source).size;
    if (size > this.engine.config.externalAccess.maxFileMiB * 1024 * 1024) throw Error('external_file_too_large');
    const bytes = readFileSync(source);
    const contentHash = createHash('sha256').update(bytes).digest('hex');
    let preview = '(binary file)';
    try { preview = new TextDecoder('utf-8', { fatal: true }).decode(bytes).slice(0, 1000); } catch {}
    const approvalId = await this.approve({ kind: 'write_file', path, bytes: bytes.length, contentHash, sourcePath, preview }, reason);
    this.unchanged();
    this.checked(path, true);
    const temp = join(dirname(path), '.wechat-approved-' + randomUUID() + '.tmp');
    try {
      writeFileSync(temp, bytes, { flag: 'wx', mode: 0o600 });
      this.unchanged(); this.checked(path, true); this.checked(temp);
      renameSync(temp, path);
    } finally { try { unlinkSync(temp); } catch {} }
    this.audit(approvalId, { status: 'completed', kind: 'write_file', path, bytes: bytes.length, contentHash });
    return { approvalId, path, bytes: bytes.length, contentHash };
  }
}
