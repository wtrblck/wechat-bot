import { existsSync, mkdirSync, readFileSync, writeFileSync, symlinkSync, createReadStream } from 'node:fs';
import { resolve, dirname, delimiter, isAbsolute } from 'node:path';
import { fileURLToPath } from 'node:url';
import { createHash } from 'node:crypto';
import { createInterface } from 'node:readline/promises';
import { parse, stringify } from 'yaml';
import { validateConfig } from '../dist/src/config.js';

const agentRoot = fileURLToPath(new URL('..', import.meta.url));
const ids = value => [...new Set((Array.isArray(value) ? value : String(value ?? '').split(',')).map(s => s.trim()).filter(Boolean))];

export async function createConfiguration(root, answers) {
  const agent = resolve(root, 'agent');
  const bridge = resolve(root, 'weixin-research');
  const profile = JSON.parse(readFileSync(resolve(bridge, 'versions/4.1.15.56.json'), 'utf8'));
  if (!isAbsolute(answers.dllPath ?? '') || !existsSync(answers.dllPath)) throw Error('Weixin.dll path must be an existing absolute file');
  const digest = createHash('sha256');
  for await (const chunk of createReadStream(answers.dllPath)) digest.update(chunk);
  if (digest.digest('hex') !== profile.sha256) throw Error('Weixin.dll does not match the pinned 4.1.15.56 SHA-256');
  if (!isAbsolute(answers.dbDir ?? '') || !/^[\w.-]+$/.test(answers.dbAccount ?? '')) throw Error('Database root/account is invalid');
  const contacts = ids(answers.contacts);
  if (!contacts.includes('filehelper')) contacts.unshift('filehelper');
  const groups = ids(answers.groups);
  const targets = [...contacts, ...groups];
  const config = parse(readFileSync(resolve(agent, 'config/agent.example.yaml'), 'utf8'));
  config.account.selfId = answers.selfId;
  config.access.direct.allow = contacts;
  config.access.group.allow = groups;
  config.runtime.provider = 'deepseek-official';
  config.runtime.model = 'deepseek-flash';
  config.egress = { ...config.egress, sendArtifacts: true };
  config.externalAccess = { enabled: !!answers.approver, ...(answers.approver ? { approver: answers.approver } : {}), timeoutSeconds: 90, maxFileMiB: 10 };
  validateConfig(config, agent);
  const localProfile = resolve(bridge, 'versions/4.1.15.56.local.json');
  const policy = {
    WECHAT_BOT_SELF: answers.selfId, WECHAT_DB_DIR: answers.dbDir, WECHAT_DB_ACCOUNT: answers.dbAccount,
    WECHAT_BOT_OBSERVE: targets.join(','), WECHAT_BOT_OBSERVE_PREFIX: '', WECHAT_BOT_OBSERVE_MODE: 'prefix',
    WECHAT_BOT_CONVERSATIONS: targets.join(','), WECHAT_BOT_RECIPIENTS: targets.join(','), WECHAT_BOT_HISTORY: '0',
    WECHAT_BOT_MEDIA_ROOTS: [resolve(bridge, 'fixtures'), resolve(agent, 'data/sandbox')].join(delimiter),
    WECHAT_BOT_MEDIA_BYTES: '10485760', WECHAT_BOT_PROFILE: localProfile,
  };
  const dsh = resolve(agent, 'data/dsh-home/profiles/wechat');
  const files = new Map([
    [resolve(agent, 'config/agent.local.yaml'), stringify(config)],
    [resolve(bridge, 'runs/bridge.local.json'), JSON.stringify({ db_dir: answers.dbDir, account: answers.dbAccount, conversations: targets, history: false, media: true, download: true, emoji: true }, null, 2) + '\n'],
    [resolve(bridge, 'runs/bridge-policy.local.json'), JSON.stringify(policy, null, 2) + '\n'],
    [localProfile, JSON.stringify({ ...profile, dll: answers.dllPath }, null, 2) + '\n'],
    [resolve(dsh, 'package.json'), JSON.stringify({ private: true, type: 'module', dsh: { profile: { bundles: ['@wechat-bot/dsh-channel'] } } }, null, 2) + '\n'],
    [resolve(dsh, 'cordis.patch.yml'), '- insert:\n    - id: wechat-llm-deepseek\n      name: "@deepseek-ai/dsh-llm-deepseek-api-key"\n      config:\n        apiKeyEnv: DEEPSEEK_API_KEY\n'],
  ]);
  for (const path of files.keys()) if (existsSync(path)) throw Error('Refusing to overwrite existing configuration: ' + path);
  const link = resolve(dsh, 'node_modules/@wechat-bot/dsh-channel');
  if (existsSync(link)) throw Error('Dedicated dsh profile already exists');
  for (const [path, text] of files) { mkdirSync(dirname(path), { recursive: true }); writeFileSync(path, text, { flag: 'wx', mode: 0o600 }); }
  mkdirSync(dirname(link), { recursive: true });
  symlinkSync(agent, link, process.platform === 'win32' ? 'junction' : 'dir');
  return { files: [...files.keys()], contacts: contacts.length, groups: groups.length, externalAccess: !!answers.approver };
}

async function main() {
  const rl = createInterface({ input: process.stdin, output: process.stdout });
  try {
    const ask = async (label, fallback = '') => (await rl.question(`${label}${fallback ? ` [${fallback}]` : ''}: `)).trim() || fallback;
    console.log('Local setup only. No credentials or chat messages are uploaded. Existing files are not overwritten.');
    const answers = {
      selfId: await ask('Your WeChat ID'),
      dbDir: await ask('WeChat database root', 'E:/xwechat_files'),
      dbAccount: await ask('Account directory name below the database root'),
      contacts: await ask('Allowed private contact IDs, comma separated', 'filehelper'),
      groups: await ask('Allowed group IDs ending @chatroom, comma separated'),
      approver: await ask('External-file approver ID (one allowed private contact), or blank to disable'),
      dllPath: await ask('Absolute path to the matching Weixin.dll'),
    };
    const result = await createConfiguration(resolve(agentRoot, '..'), answers);
    console.log(`Created ${result.files.length} local files. Contacts: ${result.contacts}; groups: ${result.groups}.`);
    console.log('Set DEEPSEEK_API_KEY in an Administrator PowerShell, then run ../start-bot.ps1 -Check.');
  } finally { rl.close(); }
}
if (resolve(process.argv[1] ?? '') === fileURLToPath(import.meta.url)) {
  main().catch(error => { console.error(error.message); process.exitCode = 1; });
}
