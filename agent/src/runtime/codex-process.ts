import { spawn, execFile } from 'node:child_process';
import { StringDecoder } from 'node:string_decoder';
import { resolve } from 'node:path';
import { mkdirSync } from 'node:fs';
import type { Config } from '../config.js';

export interface CodexRequest { task: string; cwd: string; files: 'sandbox' | 'any' }
export interface CodexResult { text: string; threadId?: string; usage?: Record<string, number> }
export type CodexRunner = (config: Config, request: CodexRequest, signal: AbortSignal) => Promise<CodexResult>;

export function codexEnvironment(c: Config): NodeJS.ProcessEnv {
  // Do not pass the bot's provider keys, bridge token, or nested Codex session variables.
  const env: NodeJS.ProcessEnv = {};
  const allowed = /^(path|pathext|systemroot|windir|comspec|userprofile|homedrive|homepath|home|appdata|localappdata|programfiles|programfiles\(x86\)|programdata|temp|tmp|lang|lc_all|https?_proxy|all_proxy|no_proxy|ssl_cert_file|ssl_cert_dir)$/i;
  for (const [key, value] of Object.entries(process.env)) if (allowed.test(key)) env[key] = value;
  env.CODEX_HOME = resolve(c.root, c.codex.home);
  return env;
}

export function codexArguments(c: Config, request: CodexRequest): string[] {
  const toml = JSON.stringify;
  return ['exec', '--ignore-user-config', '--strict-config', '--ephemeral', '--skip-git-repo-check', '--json', '--color', 'never',
    '--cd', request.cwd, '-c', 'forced_login_method="chatgpt"', '-c', 'cli_auth_credentials_store="file"',
    ...(request.files === 'any' ? ['--dangerously-bypass-approvals-and-sandbox'] : [
      '-c', 'approval_policy="never"', '-c', 'default_permissions="wechat-bot"',
      '-c', 'permissions.wechat-bot.filesystem={":root"="deny",":minimal"="read",' + toml(request.cwd) + '="write",' + toml(resolve(c.root, c.codex.home)) + '="deny",' + toml(resolve(c.root, c.codex.home, '.sandbox-bin')) + '="read"}',
      '-c', 'permissions.wechat-bot.network.enabled=false',
      ...(process.platform === 'win32' ? ['-c', 'windows.sandbox="elevated"'] : []),
    ]),
    '-c', 'shell_environment_policy.inherit="core"',
    ...(c.codex.model ? ['--model', c.codex.model] : []), '-'];
}

/** Parse only final assistant messages. Reasoning, command transcripts and stderr never enter chat. */
export function createCodexRunner(launch: typeof spawn = spawn): CodexRunner {
  return async (c, request, signal) => {
  signal.throwIfAborted();
  mkdirSync(resolve(c.root, c.codex.home), { recursive: true });
  return new Promise<CodexResult>((resolveResult, reject) => {
    const child = launch(c.codex.executable, codexArguments(c, request), {
      cwd: request.cwd, env: codexEnvironment(c), windowsHide: true, shell: false, stdio: ['pipe', 'pipe', 'pipe'],
    });
    const decoder = new StringDecoder('utf8');
    let pending = '', total = 0, final = '', threadId: string | undefined, usage: Record<string, number> | undefined;
    let completed = false, failure: string | undefined, stopping = false;
    const stop = (reason: string) => {
      failure ??= reason;
      if (stopping) return;
      stopping = true;
      if (process.platform === 'win32' && child.pid) execFile('taskkill', ['/PID', String(child.pid), '/T', '/F'], { windowsHide: true }, () => {});
      else child.kill('SIGKILL');
    };
    const abort = () => stop(signal.reason?.name === 'TimeoutError' ? 'codex_timeout' : 'codex_cancelled');
    const timer = setTimeout(() => stop('codex_timeout'), c.codex.timeoutSeconds * 1000);
    signal.addEventListener('abort', abort, { once: true });
    const line = (raw: string) => {
      if (!raw.trim()) return;
      let value;
      try { value = JSON.parse(raw); } catch { stop('codex_invalid_output'); return; }
      if (!value || typeof value !== 'object' || Array.isArray(value)) { stop('codex_invalid_output'); return; }
      if (value.type === 'thread.started' && typeof value.thread_id === 'string') threadId = value.thread_id.slice(0, 128);
      if (value.type === 'item.completed' && value.item?.type === 'agent_message' && typeof value.item.text === 'string') final = value.item.text;
      if (value.type === 'turn.completed') {
        completed = true;
        if (value.usage && typeof value.usage === 'object') usage = Object.fromEntries(Object.entries(value.usage)
          .filter(([key, value]) => /^[a-z_]+$/.test(key) && typeof value === 'number' && Number.isSafeInteger(value) && value >= 0)) as Record<string, number>;
      }
      if (value.type === 'turn.failed' || value.type === 'error') failure = 'codex_task_failed';
    };
    child.stdout.on('data', (chunk: Buffer) => {
      total += chunk.length;
      if (total > 4 * 1024 * 1024) { stop('codex_output_limit'); return; }
      pending += decoder.write(chunk);
      let at;
      while ((at = pending.indexOf('\n')) >= 0) { line(pending.slice(0, at)); pending = pending.slice(at + 1); }
    });
    // Diagnostic output may contain account details, paths or tokens. Drain without storing it.
    child.stderr.on('data', () => {});
    child.stdin.on('error', () => {});
    child.once('error', () => { failure = 'codex_unavailable'; });
    child.once('close', code => {
      clearTimeout(timer); signal.removeEventListener('abort', abort);
      pending += decoder.end(); if (pending) line(pending);
      if (failure || code !== 0 || !completed || !final.trim()) reject(Error(failure ?? 'codex_task_failed'));
      else resolveResult({ text: final.slice(0, 100000), threadId, usage });
    });
    child.stdin.end(request.task);
    if (signal.aborted) abort();
  });
  };
}
export const runCodex = createCodexRunner();
