import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadConfig } from '../dist/src/config.js';
import { Sandbox } from '../dist/src/runtime/sandbox.js';
import { runCodex } from '../dist/src/runtime/codex-process.js';

const root = fileURLToPath(new URL('../', import.meta.url));
try {
  const fullAccess = process.argv.includes('--full-access');
  const configPath = process.argv.slice(2).find(value => value !== '--full-access');
  const config = loadConfig(resolve(configPath ?? process.env.WECHAT_AGENT_CONFIG ?? resolve(root, 'config/agent.local.yaml')));
  const cwd = new Sandbox(config.root, 'codex-connection-check').root;
  const marker = fullAccess ? 'BOT_CODEX_FULL_ACCESS_OK' : 'BOT_CODEX_OK';
  const result = await runCodex(config, { cwd, files: fullAccess ? 'any' : 'sandbox',
    task: fullAccess ? 'Full access command execution check. Call the shell tool once to print BOT_CODEX_FULL_ACCESS_OK. Do not read or modify any files. After the command succeeds, reply with exactly BOT_CODEX_FULL_ACCESS_OK.' :
      'Connection check only. Do not call tools, read files, write files, or run commands. Reply with exactly BOT_CODEX_OK.' }, AbortSignal.timeout(90000));
  const ok = result.text.trim() === marker;
  console.log(JSON.stringify({ ok, result: result.text, usage: result.usage }));
  if (!ok) process.exitCode = 1;
} catch (error) {
  console.error(error instanceof Error ? error.message : 'codex_check_failed'); process.exitCode = 1;
}
