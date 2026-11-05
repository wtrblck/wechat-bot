import { spawn } from 'node:child_process';
import { mkdirSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { loadConfig } from './config.js';
import { codexEnvironment } from './runtime/codex-process.js';

const root = fileURLToPath(new URL('../../', import.meta.url));
try {
  const [action, configPath, ...extra] = process.argv.slice(2);
  if (!['login', 'login-device', 'status'].includes(action ?? '') || extra.length) throw Error('invalid_arguments');
  const c = loadConfig(resolve(configPath ?? process.env.WECHAT_AGENT_CONFIG ?? resolve(root, 'config/agent.local.yaml')));
  mkdirSync(resolve(c.root, c.codex.home), { recursive: true });
  console.log(action !== 'status' ? '请在官方页面用 ChatGPT 账号完成授权；不要把密码或令牌发给 Bot。' : '正在检查 Bot 专用 Codex 的 ChatGPT 登录状态。');
  const child = spawn(c.codex.executable, ['-c', 'forced_login_method="chatgpt"', '-c', 'cli_auth_credentials_store="file"',
    'login', ...(action === 'login-device' ? ['--device-auth'] : action === 'status' ? ['status'] : [])],
    { cwd: c.root, env: codexEnvironment(c), shell: false, windowsHide: true, stdio: 'inherit' });
  child.on('error', () => { console.error('无法启动 Codex CLI，请检查安装及 executable 配置。'); process.exitCode = 1; });
  child.on('exit', code => { process.exitCode = code ?? 1; });
} catch {
  console.error('用法：npm run codex -- login|login-device|status [配置文件路径]'); process.exitCode = 1;
}
