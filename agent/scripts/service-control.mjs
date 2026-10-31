// Fixed project lifecycle actions. No caller-supplied command, PID or path.
import { readFileSync, writeFileSync, renameSync, mkdirSync, openSync, closeSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { spawn } from 'node:child_process';
import { inspect } from './bot-status.mjs';

const root = fileURLToPath(new URL('..', import.meta.url));
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));
const alive = pid => { try { process.kill(pid, 0); return true; } catch (e) { return e.code === 'EPERM'; } };

async function stopComponent(name) {
  const folder = resolve(root, 'data/service-control');
  let identity;
  try { identity = JSON.parse(readFileSync(resolve(folder, name + '.json'), 'utf8')); }
  catch { throw Error('service_control_unavailable'); }
  if (!Number.isSafeInteger(identity.pid) || identity.pid < 1 || !/^[a-f0-9-]{32,36}$/.test(identity.token)) throw Error('invalid_service_identity');
  if (!alive(identity.pid)) return;
  const request = resolve(folder, name + '.stop.json');
  const temporary = request + '.' + process.pid + '.tmp';
  writeFileSync(temporary, JSON.stringify(identity), { mode: 0o600 });
  renameSync(temporary, request);
  const deadline = Date.now() + 45000;
  while (Date.now() < deadline) {
    if (!alive(identity.pid)) return;
    try {
      const current = JSON.parse(readFileSync(resolve(folder, name + '.json'), 'utf8'));
      if (current.token !== identity.token || current.pid !== identity.pid) return;
    } catch (error) {
      // Bridge removes this identity only AFTER workers and storage close;
      // Python/Frida interpreter teardown can outlive the logical service.
      if (error.code === 'ENOENT') return;
    }
    await delay(250);
  }
  throw Error('service_stop_timeout'); // never force-kill or stop an unrelated process
}

async function start() {
  const status = await inspect();
  if (status.agent.started && status.bridge.ready) return;
  if (status.agent.running) throw Error('stop_existing_service_first');
  const logs = resolve(root, 'data/startup', 'admin-' + Date.now());
  mkdirSync(logs, { recursive: true });
  const output = openSync(resolve(logs, 'startup.log'), 'a');
  try {
    await new Promise((resolvePromise, reject) => {
      const child = spawn('powershell.exe', ['-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', resolve(root, '../start-bot.ps1')],
        { cwd: resolve(root, '..'), windowsHide: true, stdio: ['ignore', output, output] });
      child.once('error', () => reject(Error('service_start_failed')));
      child.once('exit', code => code === 0 ? resolvePromise() : reject(Error('service_start_failed')));
    });
  } finally { closeSync(output); }
  const final = await inspect();
  if (!final.agent.started || !final.bridge.ready) throw Error('service_start_failed');
}

const action = process.argv[2];
try {
  if (process.argv.length !== 3 || !['status', 'start', 'stop', 'reset-budget'].includes(action)) throw Error('invalid_service_action');
  if (action === 'reset-budget') {
    await new Promise((resolvePromise, reject) => {
      const child = spawn(process.execPath, [resolve(root,'dist/src/cli.js'), 'budget-reset', resolve(root,'config/agent.local.yaml')],
        { cwd: root, windowsHide: true, stdio: 'ignore' });
      child.once('error', () => reject(Error('budget_reset_failed')));
      child.once('exit', code => code === 0 ? resolvePromise() : reject(Error('budget_reset_failed')));
    });
  }
  if (action === 'start') await start();
  if (action === 'stop') {
    const status = await inspect();
    if (status.agent.running) await stopComponent('bot');
    // Keep bridge alive until bot disposal and in-flight cancellation have finished.
    if ((await inspect()).bridge.reachable) await stopComponent('bridge');
  }
  console.log(JSON.stringify(await inspect()));
} catch (error) {
  console.log(JSON.stringify({ error: /^[a-z_]+$/.test(error.message) ? error.message : 'service_operation_failed' }));
  process.exitCode = 1;
}
