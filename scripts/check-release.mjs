import { execFileSync } from 'node:child_process';
import { readFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('..', import.meta.url));
const files = execFileSync('git', ['ls-files', '-z'], { cwd: root, encoding: 'utf8' }).split('\0').filter(Boolean);
if (!files.length) throw Error('Stage the release source before checking');
const forbiddenPath = /(?:^|\/)(?:node_modules|\.pnpm-store|runs|deps|downloads|__pycache__|\.git)\/|^agent\/(?:data|dist|workspaces)\/|\.local\.(?:ya?ml|json)$|\.(?:sqlite|db|log|exe|dll)$|(?:^|\/)\.env$/i;
const secrets = [
  /gh[pousr]_[A-Za-z0-9]{25,}/,
  /github_pat_[A-Za-z0-9_]{30,}/,
  /sk-[A-Za-z0-9]{24,}/,
  /-----BEGIN (?:RSA |EC |OPENSSH )?PRIVATE KEY-----/,
];
let failures = 0;
for (const file of files) {
  if (forbiddenPath.test(file)) { console.error('Private/generated path: ' + file); failures++; continue; }
  const text = readFileSync(resolve(root, file)).toString('utf8');
  if (secrets.some(pattern => pattern.test(text))) { console.error('Potential secret: ' + file); failures++; }
}
console.log(JSON.stringify({ checkedFiles: files.length, failures }));
if (failures) process.exitCode = 1;
