import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, mkdirSync, writeFileSync, readFileSync, cpSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, relative, isAbsolute } from 'node:path';
import { createHash } from 'node:crypto';
import { fileURLToPath } from 'node:url';
import { parse } from 'yaml';
import { createConfiguration } from '../scripts/setup.mjs';

test('first-run setup produces matching local scopes and env-only model adapter without overwriting configuration', async () => {
  const root = mkdtempSync(join(tmpdir(), 'wechat-setup-'));
  try {
    mkdirSync(join(root, 'agent/config'), { recursive: true });
    cpSync(fileURLToPath(new URL('../config/agent.example.yaml', import.meta.url)), join(root, 'agent/config/agent.example.yaml'));
    mkdirSync(join(root, 'weixin-research/versions'), { recursive: true });
    const dllPath = join(root, 'Weixin.dll'); writeFileSync(dllPath, 'test-only pinned image');
    const profile = { version: '4.1.15.56', sha256: createHash('sha256').update('test-only pinned image').digest('hex') };
    writeFileSync(join(root, 'weixin-research/versions/4.1.15.56.json'), JSON.stringify(profile));
    const answers = { selfId: 'wxid_sample_self', dbDir: root, dbAccount: 'sample_account', contacts: 'sample_contact', groups: '12345678901@chatroom', approver: 'sample_contact', dllPath };
    await createConfiguration(root, answers);
    const policy = JSON.parse(readFileSync(join(root, 'weixin-research/runs/bridge-policy.local.json')));
    const c = parse(readFileSync(join(root, 'agent/config/agent.local.yaml'), 'utf8'));
    assert.deepEqual(policy.WECHAT_BOT_RECIPIENTS.split(','), [...c.access.direct.allow, ...c.access.group.allow]);
    assert.equal(policy.WECHAT_BOT_OBSERVE_PREFIX, '');
    assert.equal(c.externalAccess.approver, 'sample_contact');
    assert.equal(c.externalAccess.timeoutSeconds, 90);
    assert.equal(c.runtime.provider, 'deepseek-official');
    assert.ok(readFileSync(join(root, 'agent/data/dsh-home/profiles/wechat/cordis.patch.yml'), 'utf8').includes('apiKeyEnv: DEEPSEEK_API_KEY'));
    await assert.rejects(createConfiguration(root, answers), /overwrite/);
    await assert.rejects(createConfiguration(root, { ...answers, approver: 'stranger' }), /external_approver_not_allowed/);
  } finally {
    const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel));
    rmSync(root, { recursive: true, force: true });
  }
});
