// Read-only public probes using the exact tools available to the bot. No model calls or message sends.
import { mkdirSync, writeFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { resolve } from 'node:path';
import { loadConfig } from '../dist/src/config.js';
import { Web } from '../dist/src/tools/web.js';
const root = fileURLToPath(new URL('..', import.meta.url));
const config = loadConfig(resolve(root, 'config/agent.local.yaml'));
const web = new Web(config.web);
if (process.argv.includes('--pages')) {
  const urls = [
    { platform: 'B站文章', url: 'https://www.bilibili.com/opus/719899418782859320' },
    { platform: 'B站公开检索', url: 'https://api.bilibili.com/x/web-interface/search/type?search_type=video&keyword=' + encodeURIComponent('电子榨菜') },
    { platform: '贴吧公开检索', url: 'https://tieba.baidu.com/f/search/res?ie=utf-8&qw=' + encodeURIComponent('电子榨菜') },
    { platform: '抖音公开检索', url: 'https://www.douyin.com/search/' + encodeURIComponent('电子榨菜') },
    { platform: '中文Bing RSS', url: 'https://cn.bing.com/search?format=rss&mkt=zh-CN&setlang=zh-hans&q=' + encodeURIComponent('电子榨菜 是什么梗 site:bilibili.com') },
  ];
  const results = await Promise.all(urls.map(async item => {
    try { const p = await web.read(item.url, AbortSignal.timeout(config.web.timeoutMs)); return { ...item, status: p.status, chars: p.text.length, sample: p.text.slice(0, 2200) }; }
    catch (error) { return { ...item, error: error.message }; }
  }));
  const directory = resolve(root, 'data/validation'); mkdirSync(directory, { recursive: true });
  const report = resolve(directory, 'community-web-pages.json');
  writeFileSync(report, JSON.stringify({ testedAt: new Date().toISOString(), results }, null, 2));
  console.log(JSON.stringify({ report, results }, null, 2));
  process.exit(0);
}
const probes = process.argv.includes('--alternate') ? [
  { platform: '抖音', domain: 'douyin.com', query: 'site:douyin.com 电子榨菜' },
  { platform: 'B站', domain: 'bilibili.com', query: '电子榨菜 是什么梗 site:bilibili.com' },
  { platform: '贴吧', domain: 'tieba.baidu.com', query: 'site:tieba.baidu.com 抽象 梗' },
] : [
  { platform: '抖音', domain: 'douyin.com', query: '电子榨菜 是什么梗 site:douyin.com' },
  { platform: 'B站', domain: 'bilibili.com', query: '红温 是什么梗 site:bilibili.com' },
  { platform: '贴吧', domain: 'tieba.baidu.com', query: '典孝急 是什么梗 site:tieba.baidu.com' },
];
const results = await Promise.all(probes.map(async probe => {
  const item = { ...probe };
  try {
    const search = await web.search(probe.query, AbortSignal.timeout(config.web.timeoutMs));
    item.sources = search.sources;
    const source = search.sources.find(s => { const host = new URL(s.url).hostname; return host === probe.domain || host.endsWith('.' + probe.domain); });
    item.sameSiteResults = search.sources.filter(s => { const host = new URL(s.url).hostname; return host === probe.domain || host.endsWith('.' + probe.domain); }).length;
    if (source) {
      try {
        const page = await web.read(source.url, AbortSignal.timeout(config.web.timeoutMs));
        item.page = { url: page.url, status: page.status, chars: page.text.length, truncated: page.truncated, sample: page.text.slice(0, 1800) };
      } catch (error) { item.fetchError = error.message; }
    }
  } catch (error) { item.searchError = error.message; }
  return item;
}));
const directory = resolve(root, 'data/validation'); mkdirSync(directory, { recursive: true });
const report = resolve(directory, process.argv.includes('--alternate') ? 'community-web-probe-alternate.json' : 'community-web-probe.json');
writeFileSync(report, JSON.stringify({ testedAt: new Date().toISOString(), modelCalled: false, messagesSent: false, results }, null, 2));
console.log(JSON.stringify({ report, results }, null, 2));
