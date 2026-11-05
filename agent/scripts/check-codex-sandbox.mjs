import { spawnSync } from 'node:child_process';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadConfig } from '../dist/src/config.js';
import { Sandbox } from '../dist/src/runtime/sandbox.js';
import { codexArguments, codexEnvironment } from '../dist/src/runtime/codex-process.js';

const root = fileURLToPath(new URL('../', import.meta.url));
const config = loadConfig(resolve(process.argv[2] ?? process.env.WECHAT_AGENT_CONFIG ?? resolve(root, 'config/agent.local.yaml')));
const sandbox = new Sandbox(config.root, 'codex-connection-check');
const args = codexArguments(config, { task: '', cwd: sandbox.root, files: 'sandbox' });
const overrides = [];
for (let index = 0; index < args.length; index++) if (args[index] === '-c') overrides.push('-c', args[++index]);
const probe = `const fs=require('node:fs'),path=require('node:path');
const [cwd,outside]=process.argv.slice(1);let denied=false;
try{fs.readFileSync(outside)}catch(error){if(['EACCES','EPERM'].includes(error.code))denied=true;else throw error}
if(!denied)throw Error('outside_read_was_allowed');
const target=path.join(cwd,'sandbox-probe.txt');fs.writeFileSync(target,'sandbox probe');
if(fs.readFileSync(target,'utf8')!=='sandbox probe')throw Error('workspace_write_failed');
fs.unlinkSync(target);console.log('BOT_CODEX_SANDBOX_OK');`;
const result = spawnSync(config.codex.executable, [...overrides, 'sandbox', '--permission-profile', 'wechat-bot',
  '-C', sandbox.root, '--', process.execPath, '-e', probe, sandbox.root, resolve(root, 'scripts/check-codex.mjs')],
  { cwd: sandbox.root, env: codexEnvironment(config), windowsHide: true, shell: false, encoding: 'utf8', timeout: 60000, maxBuffer: 1024 * 1024 });
console.log(result.stdout?.trim() || 'Sandbox check did not produce a success marker.');
if (result.status !== 0) { console.error(result.stderr?.trim() || result.error?.message || 'codex_sandbox_check_failed'); process.exitCode = 1; }
