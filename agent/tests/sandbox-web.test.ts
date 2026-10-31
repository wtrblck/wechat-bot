import { test } from 'node:test';
import assert from 'node:assert/strict';
import { mkdtempSync, rmSync, symlinkSync, linkSync, writeFileSync, mkdirSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, relative, isAbsolute } from 'node:path';
import { Sandbox } from '../src/runtime/sandbox.js';
import { Web, publicAddress, webUrl, resolvePublicHostname, type Transport } from '../src/tools/web.js';
import { config } from './helpers.js';

const signal = () => new AbortController().signal;
function temporary() {
  const root = mkdtempSync(join(tmpdir(), 'wechat-sandbox-'));
  return { root, close: () => { const rel = relative(tmpdir(), root); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(root, { recursive: true, force: true }); } };
}
test('sandbox text files stay in their conversation and reject traversal, Windows aliases and oversized reads/writes', () => {
  const temp = temporary();
  try {
    const a = new Sandbox(temp.root, 'group-a'), b = new Sandbox(temp.root, 'group-b');
    a.write('notes/today.md', '本群资料'); assert.equal(a.read('notes/today.md'), '本群资料');
    assert.throws(() => b.read('notes/today.md'));
    for (const path of ['../group-a/notes/today.md', '/tmp/x', 'C:/secret', 'C:secret', '\\\\server\\file', 'a\\..\\x',
      'file:stream', 'CON.txt', 'NUL', 'dir./file', 'file ', 'a//b', './a']) assert.throws(() => a.write(path, 'denied'), /denied/);
    assert.throws(() => new Sandbox(temp.root, '../escape'), /denied/);
    assert.throws(() => a.write('huge.txt', '中'.repeat(30000)), /too_large/);
    writeFileSync(a.path('huge.txt'), Buffer.alloc(65537)); assert.throws(() => a.read('huge.txt'), /too_large/);
    assert.deepEqual(a.list().find(f => f.name === 'notes'), { name: 'notes', kind: 'directory' });
  } finally { temp.close(); }
});
test('sandbox refuses junction ancestors, linked files and hard links', () => {
  const temp = temporary();
  try {
    const a = new Sandbox(temp.root, 'group-a'); const outside = join(temp.root, 'outside'); mkdirSync(outside);
    writeFileSync(join(outside, 'secret.txt'), 'secret');
    symlinkSync(outside, join(a.root, 'escape'), process.platform === 'win32' ? 'junction' : 'dir');
    assert.throws(() => a.read('escape/secret.txt'), /denied/); assert.throws(() => a.write('escape/new.txt', 'no'), /denied/);
    linkSync(join(outside, 'secret.txt'), join(a.root, 'hard.txt'));
    assert.throws(() => a.read('hard.txt'), /denied/); assert.throws(() => a.write('hard.txt', 'no'), /denied/);
    const replaced = join(temp.root, 'other'); mkdirSync(replaced);
    symlinkSync(replaced, join(temp.root, 'data/sandbox/group-b'), process.platform === 'win32' ? 'junction' : 'dir');
    assert.throws(() => new Sandbox(temp.root, 'group-b'), /denied/);
  } finally { temp.close(); }
});
test('web URLs reject local files, credentials, non-web ports and private IPv4/IPv6 representations', () => {
  for (const url of ['file:///C:/secret', 'ftp://example.com/', 'http://user:pass@example.com', 'http://example.com:8080/',
    'http://localhost/', 'http://printer.local/', 'http://127.1/', 'http://2130706433/', 'http://0x7f000001/',
    'http://10.0.0.1', 'http://169.254.169.254/', 'http://100.64.0.1/', 'http://[::1]/', 'http://[::ffff:127.0.0.1]/'])
    assert.throws(() => webUrl(url));
  for (const ip of ['0.0.0.0', '192.168.1.2', '172.16.1.2', '224.1.1.1', '198.18.0.1', 'fc00::1', 'fe80::1', '64:ff9b::7f00:1']) assert.equal(publicAddress(ip), false);
  assert.equal(publicAddress('8.8.8.8'), true); assert.equal(publicAddress('2606:4700:4700::1111'), true);
  assert.equal(webUrl('https://example.com/#x').href, 'https://example.com/');
});
test('web transport validates all DNS answers, pins checked addresses and revalidates redirect targets', async () => {
  let calls = 0, lookups = 0;
  const request: Transport = async (url, pinned) => {
    calls++; assert.equal(pinned.address, '8.8.8.8');
    return { url: url.href, status: 302, location: 'http://127.0.0.1/bridge', mime: '', body: '', truncated: false };
  };
  const web = new Web(config().web, async () => { lookups++; return [{ address: '8.8.8.8', family: 4 }]; }, request);
  await assert.rejects(web.fetch('https://example.com/', signal()), /denied/); assert.equal(calls, 1); assert.equal(lookups, 1);
  const mixed = new Web(config().web, async () => [{ address: '8.8.8.8', family: 4 }, { address: '127.0.0.1', family: 4 }], request);
  await assert.rejects(mixed.fetch('https://example.com/', signal()), /private_address/); assert.equal(calls, 1);
  let hop = 0;
  const redirected = new Web(config().web, async () => [{ address: ++hop === 1 ? '8.8.8.8' : '10.0.0.1', family: 4 }], async url => {
    calls++; return { url: url.href, status: 302, location: 'https://other.example.org/', mime: '', body: '', truncated: false };
  });
  await assert.rejects(redirected.fetch('https://example.com/', signal()), /private_address/); assert.equal(calls, 2);
});
test('web cancels a stalled DNS lookup before any HTTP request starts', async () => {
  let calls = 0; const controller = new AbortController();
  const web = new Web(config().web, () => new Promise(() => {}), async () => { calls++; throw Error('unexpected'); });
  const pending = web.fetch('https://example.com', controller.signal); controller.abort();
  await assert.rejects(pending); assert.equal(calls, 0);
});
test('proxy synthetic DNS is independently resolved and never becomes a page connection exception', async () => {
  let queries = 0;
  const doh = async () => { queries++; return [{ address: '8.8.8.8', family: 4 }]; };
  const fake = async () => [{ address: '198.18.0.5', family: 4 }];
  assert.deepEqual(await resolvePublicHostname('example.com', signal(), fake, doh), [{ address: '8.8.8.8', family: 4 }]);
  assert.equal(queries, 1);
  const privateDns = async () => [{ address: '10.0.0.1', family: 4 }];
  assert.deepEqual(await resolvePublicHostname('example.com', signal(), privateDns, doh), [{ address: '10.0.0.1', family: 4 }]);
  assert.equal(queries, 1); // Private DNS is refused by the normal guard, not used as a fallback trigger.
  let connections = 0;
  const badDoh = new Web(config().web, host => resolvePublicHostname(host, signal(), fake, privateDns), async () => { connections++; throw Error('unexpected'); });
  await assert.rejects(badDoh.fetch('https://example.com', signal()), /private_address/); assert.equal(connections, 0);
});
test('web text rendering removes active HTML, caps output and labels all external content untrusted', async () => {
  const web = new Web({ ...config().web, maxOutputChars: 1000 }, async () => [{ address: '8.8.8.8', family: 4 }], async url => ({
    url: url.href, status: 200, mime: 'text/html', body: '<h1>Page title</h1><script>SECRET_SCRIPT()</script><style>HIDDEN_STYLE</style><p>' + '正文'.repeat(1000) + '</p>', truncated: false,
  }));
  const page = await web.read('https://example.com/', signal());
  assert.match(page.text, /Page title/); assert.ok(!page.text.includes('SECRET_SCRIPT') && !page.text.includes('HIDDEN_STYLE'));
  assert.equal(page.text.length, 1000); assert.equal(page.truncated, true); assert.match(page.trust, /不可信/);
});
test('search uses the bounded public transport, parses sources and reports provider failures honestly', async () => {
  const web = new Web({ ...config().web, fetch: false, maxResults: 1 }, async () => [{ address: '8.8.8.8', family: 4 }], async url => {
    assert.equal(url.hostname, 'www.bing.com'); assert.equal(url.searchParams.get('q'), '公开资料');
    return { url: url.href, status: 200, mime: 'application/rss+xml', truncated: false, body:
      '<rss><channel><item><title>Title &amp; more</title><link>https://example.com/?a=1&amp;b=2</link><description><![CDATA[<b>Snippet</b>]]></description></item>' +
      '<item><title>Second</title><link>https://example.org/</link></item></channel></rss>' };
  });
  const result = await web.search('公开资料', signal()); assert.equal(result.sources.length, 1);
  assert.equal(result.sources[0]!.title, 'Title & more'); assert.equal(result.sources[0]!.url, 'https://example.com/?a=1&b=2'); assert.match(result.sources[0]!.snippet, /Snippet/);
  await assert.rejects(web.read('https://example.com', signal()), /disabled/);
  const unavailable = new Web(config().web, web.resolve, async url => ({ url: url.href, status: 200, mime: 'text/html', body: '<h1>captcha</h1>', truncated: false }));
  await assert.rejects(unavailable.search('query', signal()), /unavailable/);
});

test('community site queries discard unrelated RSS hits and select matching results before applying the result cap', async () => {
  const web = new Web({ ...config().web, maxResults: 1 }, async () => [{ address: '8.8.8.8', family: 4 }], async url => ({
    url: url.href, status: 200, mime: 'application/rss+xml', truncated: false, body: '<rss><channel>' +
      '<item><title>无关结果</title><link>https://example.com/</link></item>' +
      '<item><title>伪装域名</title><link>https://bilibili.com.example.org/</link></item>' +
      '<item><title>梗的介绍</title><link>https://www.bilibili.com/opus/123</link></item></channel></rss>',
  }));
  const result = await web.search('红温 site:bilibili.com', signal());
  assert.equal(result.sources.length, 1); assert.equal(result.sources[0]!.title, '梗的介绍');
  assert.deepEqual(result.siteFilters, ['bilibili.com']);
  const missing = await web.search('红温 site:douyin.com', signal());
  assert.deepEqual(missing.sources, []); assert.match(missing.note!, /没有返回属于指定站点/);
});

test('Bilibili public metadata fallback is bounded, keeps canonical video links and never claims video viewing', async () => {
  const calls: string[] = [];
  const web = new Web(config().web, async () => [{ address: '8.8.8.8', family: 4 }], async url => {
    calls.push(url.hostname);
    if (url.hostname === 'www.bing.com') return { url: url.href, status: 200, mime: 'application/rss+xml', truncated: false, body: '<rss><channel></channel></rss>' };
    assert.equal(url.hostname, 'api.bilibili.com'); assert.equal(url.searchParams.get('keyword'), '红温 是什么梗');
    return { url: url.href, status: 200, mime: 'application/json', truncated: false, body: JSON.stringify({ code: 0, data: { result: [
      { bvid: 'BV1fsxY6sEwK', title: '<em>红温</em>梗介绍', author: '作者', description: '公开视频简介', arcurl: 'http://127.0.0.1/' },
      { bvid: '../invalid', title: '无效结果' },
    ] } }) };
  });
  const result = await web.search('红温 是什么梗 site:bilibili.com', signal());
  assert.deepEqual(calls, ['www.bing.com', 'api.bilibili.com']);
  assert.equal(result.sources.length, 1); assert.equal(result.sources[0]!.url, 'https://www.bilibili.com/video/BV1fsxY6sEwK');
  assert.equal(result.sources[0]!.title, '红温梗介绍'); assert.match(result.note!, /没有观看视频/);
});
