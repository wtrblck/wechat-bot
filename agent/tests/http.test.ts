import { test } from 'node:test';
import assert from 'node:assert/strict';
import { createServer } from 'node:http';
import { mkdtempSync, rmSync, writeFileSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { join, relative, isAbsolute } from 'node:path';
import { once } from 'node:events';
import { BridgeClient } from '../src/bridge/client.js';
import { Store } from '../src/storage/database.js';
import { Engine } from '../src/engine.js';
import { config, event, now, FakeHost, FakeBridge } from './helpers.js';

test('real HTTP bridge contract: rotating discovery token, persistent input, async send and lost-response reconciliation', async () => {
  const directory = mkdtempSync(join(tmpdir(), 'wechat-http-'));
  const state = new FakeBridge(); let token = 'token-one'; let destroyFirst = true;
  const server = createServer(async (req, res) => {
    if (req.headers.authorization !== 'Bearer ' + token) { res.writeHead(401); res.end('{}'); return; }
    res.setHeader('Content-Type', 'application/json');
    const url = new URL(req.url!, 'http://127.0.0.1');
    if (url.pathname === '/health') res.end(JSON.stringify(await state.health()));
    else if (url.pathname === '/events') res.end(JSON.stringify(await state.events(Number(url.searchParams.get('after')))));
    else if (url.pathname.startsWith('/request/')) {
      const result = await state.request(url.pathname.split('/').pop()!); if (!result) res.writeHead(404); res.end(JSON.stringify(result ?? { error: 'request_not_found' }));
    } else if (url.pathname === '/send/text') {
      let body = ''; for await (const part of req) body += part;
      const result = await state.send(body);
      if (destroyFirst) { destroyFirst = false; req.socket.destroy(); } else res.end(JSON.stringify(result));
    } else { res.writeHead(404); res.end('{}'); }
  });
  server.listen(0, '127.0.0.1'); await once(server, 'listening');
  const address = server.address(); assert.ok(address && typeof address !== 'string');
  const file = join(directory, 'session.json'); const session = { url: `http://127.0.0.1:${address.port}`, token };
  writeFileSync(file, JSON.stringify(session));
  const c = config({ bridge: { sessionFile: file, timeoutMs: 1000 } });
  const store = new Store(c, ':memory:', () => now); const host = new FakeHost(); const client = new BridgeClient(c);
  const engine = new Engine(c, store, client, host, () => {});
  try {
    await engine.tick(); // Baseline empty event source.
    state.page = { cursor: 1, events: [event(1)], truncated: false };
    await engine.tick(); await engine.drain();
    token = 'token-two'; writeFileSync(file, JSON.stringify({ ...session, token }));
    // Socket destruction may also invalidate an idle pooled connection. Poll the durable outcome,
    // rather than assuming reconciliation takes exactly two transport attempts under parallel tests.
    for (let attempt = 0; attempt < 6; attempt++) {
      await engine.tick(); await engine.drain();
      if (store.one('SELECT state FROM outbox')?.state === 'server_confirmed') break;
    }
    assert.equal(host.calls.length, 1); assert.equal(state.posts.length, 1);
    assert.equal(store.one('SELECT state FROM outbox')!.state, 'server_confirmed');
    assert.ok(!host.calls[0]!.context.includes(token));
  } finally {
    await engine.close(); server.closeAllConnections(); await new Promise<void>(resolve => server.close(() => resolve()));
    const rel = relative(tmpdir(), directory); assert.ok(rel && !rel.startsWith('..') && !isAbsolute(rel)); rmSync(directory, { recursive: true, force: true });
  }
});
