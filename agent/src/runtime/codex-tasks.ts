import { lstatSync, realpathSync } from 'node:fs';
import { isAbsolute } from 'node:path';
import { hash, type HostInput, type Session } from '../contracts.js';
import { conversationAccess, conversationEnabled } from '../access.js';
import type { Store, Row } from '../storage/database.js';
import { Sandbox } from './sandbox.js';
import { runCodex, type CodexRunner } from './codex-process.js';
import { safeText } from '../admin/read-model.js';

const errors: Record<string, string> = {
  codex_unavailable: '找不到本机 Codex CLI，请检查安装及配置的 executable。',
  codex_timeout: '任务超时，已请求停止。',
  codex_task_failed: 'Codex 执行失败。请在本机运行 npm run codex -- status 检查 ChatGPT 登录，并检查 CLI 权限配置。',
  codex_invalid_output: 'Codex 输出格式无法识别，请检查 CLI 版本。',
  codex_output_limit: '任务输出超过限制，已请求停止。',
};

export class CodexTasks {
  private active = new Map<string, { controller: AbortController; task: Promise<void> }>();
  private stopping = false;
  private monitor?: ReturnType<typeof setInterval>;
  constructor(readonly store: Store, readonly allowed: () => boolean,
    readonly deliver: (session: Session, id: string, text: string, runId?: string) => void,
    readonly runner: CodexRunner = runCodex) {
    store.db.exec(`CREATE TABLE IF NOT EXISTS codex_tasks(
      id TEXT PRIMARY KEY,route TEXT NOT NULL,generation INTEGER NOT NULL,session TEXT NOT NULL,run_id TEXT,
      task TEXT NOT NULL,cwd TEXT NOT NULL,files TEXT NOT NULL,state TEXT NOT NULL,result TEXT,error TEXT,
      created INTEGER NOT NULL,updated INTEGER NOT NULL,notified INTEGER NOT NULL DEFAULT 0);
      CREATE INDEX IF NOT EXISTS codex_tasks_route ON codex_tasks(route,created);`);
    store.exec("UPDATE codex_tasks SET state='interrupted',error='codex_interrupted',updated=? WHERE state='running'", store.clock());
  }
  private valid(row: Row): boolean {
    const c = this.store.config, session = this.store.one('SELECT generation,quiet FROM session_map WHERE key=?', row.route);
    const policy = conversationAccess(c, (JSON.parse(row.session) as Session).conversation);
    if (!c.codex.enabled || !this.allowed() || !session || session.generation !== row.generation || session.quiet) return false;
    if (row.state === 'queued' && this.store.clock() - row.created > c.codex.timeoutSeconds * 1000) return false;
    if (!conversationEnabled(c, (JSON.parse(row.session) as Session).conversation)) return false;
    if (row.files === 'any' && policy.files !== 'any') return false;
    if (row.files === 'sandbox') new Sandbox(c.root, row.route); // Recheck root for a junction swap.
    return true;
  }
  submit(input: HostInput, task: string, cwd?: string) {
    const c = this.store.config;
    if (!c.codex.enabled || this.stopping) throw Error('codex_disabled');
    if (input.purpose !== 'reply' || input.proactive || !task.trim() || task.length > 16000) throw Error('codex_task_invalid');
    const policy = conversationAccess(c, input.session.conversation);
    const files = policy.files === 'any' ? 'any' : 'sandbox';
    let directory = new Sandbox(c.root, input.session.key).root;
    if (cwd !== undefined) {
      if (files !== 'any' || !isAbsolute(cwd) || cwd.length > 1024 || /^[/\\]{2}|[\x00-\x1f]/.test(cwd)) throw Error('codex_cwd_denied');
      if (!lstatSync(cwd).isDirectory() || lstatSync(cwd).isSymbolicLink()) throw Error('codex_cwd_denied');
      directory = realpathSync(cwd);
      if (/^[/\\]{2}/.test(directory)) throw Error('codex_cwd_denied');
    }
    const id = hash(['codex', input.session.key, input.session.generation, input.inputId, task, directory]);
    const candidate = { route: input.session.key, generation: input.session.generation, session: JSON.stringify(input.session), files };
    if (!this.valid(candidate)) throw Error('codex_not_allowed');
    const existing = this.store.one('SELECT * FROM codex_tasks WHERE id=?', id);
    if (existing) return this.project(existing);
    const pending = this.store.one("SELECT count(*) n FROM codex_tasks WHERE state IN ('queued','running')")!.n;
    if (pending >= c.codex.maxQueued + c.codex.maxConcurrent) throw Error('codex_queue_full');
    this.store.exec('INSERT INTO codex_tasks(id,route,generation,session,run_id,task,cwd,files,state,created,updated) VALUES(?,?,?,?,?,?,?,?,?,?,?)',
      id, input.session.key, input.session.generation, JSON.stringify(input.session), input.inputId, task, directory, files, 'queued', this.store.clock(), this.store.clock());
    return this.project(this.store.one('SELECT * FROM codex_tasks WHERE id=?', id)!);
  }
  private project(row: Row) {
    const result = row.result ? JSON.parse(row.result) : undefined;
    return { id: row.id, state: row.state, createdAt: row.created, updatedAt: row.updated,
      ...(result ? { text: safeText(result.text, 100000), usage: result.usage } : {}),
      ...(row.error ? { error: row.error } : {}) };
  }
  status(session: Session, id: string): ReturnType<CodexTasks['project']>;
  status(session: Session, id?: string): ReturnType<CodexTasks['project']> | { items: ReturnType<CodexTasks['project']>[] };
  status(session: Session, id?: string) {
    if (id) {
      const row = this.store.one('SELECT * FROM codex_tasks WHERE id=? AND route=? AND generation=?', id, session.key, session.generation);
      if (!row) throw Error('codex_task_not_found');
      return this.project(row);
    }
    return { items: this.store.all('SELECT * FROM codex_tasks WHERE route=? AND generation=? ORDER BY created DESC,rowid DESC LIMIT 10', session.key, session.generation).map(row => this.project(row)) };
  }
  cancel(session: Session, id?: string) {
    if (id) this.status(session, id);
    for (const row of this.store.all('SELECT * FROM codex_tasks WHERE route=? AND generation=?', session.key, session.generation)) {
      if (id && row.id !== id) continue;
      if (['queued', 'running'].includes(row.state)) this.cancelRow(row);
      else this.store.exec('UPDATE codex_tasks SET notified=1 WHERE id=?', row.id);
      this.store.exec("UPDATE outbox SET state='cancelled' WHERE reply=? AND submitted=0 AND state='prepared'", 'command:codex-result:' + row.id);
    }
    return { cancelled: true };
  }
  private cancelRow(row: Row) {
    this.store.exec("UPDATE codex_tasks SET state='cancelled',error='codex_cancelled',updated=?,notified=1 WHERE id=?", this.store.clock(), row.id);
    this.active.get(row.id)?.controller.abort();
  }
  reconcile() {
    for (const row of this.store.all("SELECT * FROM codex_tasks WHERE state IN ('queued','running')")) {
      let valid = false;
      try { valid = this.valid(row); } catch { /* Invalid permission file fails closed. */ }
      if (!valid) this.cancelRow(row);
    }
  }
  tick() {
    if (this.stopping) return;
    this.reconcile();
    if (!this.allowed()) return;
    for (const row of this.store.all("SELECT * FROM codex_tasks WHERE state IN ('completed','failed','interrupted') AND notified=0 ORDER BY created,rowid")) {
      let valid = false;
      try { valid = this.valid(row); } catch {}
      if (valid) {
        const session = JSON.parse(row.session) as Session;
        const text = row.state === 'completed' ? safeText(JSON.parse(row.result).text, 100000) : row.state === 'interrupted' ?
          'Bot 重启时任务仍在执行，结果未知。为避免重复修改文件，没有自动重跑；请核对本机文件后重新提交。' : errors[row.error] ?? 'Codex 执行失败，请检查本机登录及权限。';
        // Outbox commits its own transaction; its stable reply ID makes this retry-safe
        // even if the process stops after preparing output but before marking notified.
        this.deliver(session, 'command:codex-result:' + row.id, `Codex 任务 ${row.id}\n${text}`, row.run_id ?? undefined);
        this.store.exec('UPDATE codex_tasks SET notified=1 WHERE id=?', row.id);
      } else this.store.exec('UPDATE codex_tasks SET notified=1 WHERE id=?', row.id);
    }
    const c = this.store.config;
    for (const row of this.store.all("SELECT * FROM codex_tasks WHERE state='queued' ORDER BY created,rowid")) {
      if (this.active.size >= c.codex.maxConcurrent) break;
      const controller = new AbortController();
      this.store.exec("UPDATE codex_tasks SET state='running',updated=? WHERE id=?", this.store.clock(), row.id);
      const task = Promise.resolve().then(() => this.runner(c, { task: row.task, cwd: row.cwd, files: row.files }, controller.signal))
        .then(result => {
          let valid = false; try { valid = this.valid(row); } catch {}
          if (controller.signal.aborted || !valid) { this.cancelRow(row); return; }
          this.store.exec("UPDATE codex_tasks SET state='completed',result=?,updated=? WHERE id=? AND state='running'", JSON.stringify({ text: safeText(result.text, 100000), usage: result.usage }), this.store.clock(), row.id);
        }, error => {
          this.store.exec("UPDATE codex_tasks SET state='failed',error=?,updated=? WHERE id=? AND state='running'", errors[error?.message] ? error.message : 'codex_task_failed', this.store.clock(), row.id);
        }).finally(() => {
          this.active.delete(row.id);
          if (!this.active.size && this.monitor) { clearInterval(this.monitor); this.monitor = undefined; }
        });
      this.active.set(row.id, { controller, task });
      this.monitor ??= setInterval(() => {
        try { this.reconcile(); } catch { for (const active of this.active.values()) active.controller.abort(); }
      }, 500);
    }
    this.store.exec('DELETE FROM codex_tasks WHERE notified=1 AND updated<?', this.store.clock() - c.storage.retentionDays * 86400000);
  }
  async drain() { await Promise.all([...this.active.values()].map(value => value.task)); }
  async close() {
    this.stopping = true;
    if (this.monitor) { clearInterval(this.monitor); this.monitor = undefined; }
    for (const row of this.store.all("SELECT * FROM codex_tasks WHERE state IN ('queued','running')")) this.cancelRow(row);
    await this.drain();
  }
}
