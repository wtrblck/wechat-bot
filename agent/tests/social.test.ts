import { test } from 'node:test';
import assert from 'node:assert/strict';
import { Store } from '../src/storage/database.js';
import { SocialMemory } from '../src/memory/social.js';
import { normalize } from '../src/ingress/normalizer.js';
import { config, event, now } from './helpers.js';

function fixture() {
  let time = now;
  const c = config({ memory: { enabled: true } });
  const store = new Store(c, ':memory:', () => time), social = new SocialMemory(store);
  const message = (n: number, text: string, extra = {}) => normalize(event(n, 'group-a@chatroom', text, extra), c)!;
  const first = message(1, '别叫我老王，叫小王就行');
  const session = store.session(first);
  const note = (sourceMessageId = first.messageId, quote = first.text) =>
    ({ kind: 'preference' as const, key: '称呼', sourceMessageId, quote });
  return { c, store, social, session, message, first, note, advance: (ms: number) => time += ms };
}

test('social notes attribute exact evidence to the actual sender; reject fabricated, outgoing and foreign sources', () => {
  const f = fixture();
  try {
    const foreign = { ...f.first, conversationId: 'group-b@chatroom' };
    f.social.record(f.session, [f.note()], [foreign]);
    f.social.record(f.session, [f.note()], [{ ...f.first, direction: 'outgoing' }]);
    f.social.record(f.session, [f.note('invented'), f.note(f.first.messageId, '我喜欢被叫老板')], [f.first]);
    assert.deepEqual(f.social.context(f.session, ['member-a']), []);
    f.social.record(f.session, [f.note(), f.note()], [f.first]);
    assert.equal(f.store.one('SELECT count(*) n FROM social_notes')!.n, 1);
    const result = f.social.context(f.session, ['member-a']);
    assert.equal(result[0]!.subjectId, 'member-a');
    assert.equal(result[0]!.quote, f.first.text);
    assert.deepEqual(f.social.context(f.session, ['member-b']), []);
    const other = f.store.session({ ...f.first, conversationId: 'group-b@chatroom' });
    assert.deepEqual(f.social.context(other, ['member-a']), []);
  } finally { f.store.close(); }
});

test('new explicit corrections supersede old ones even if summaries arrive out of order', () => {
  const f = fixture();
  try {
    const next = f.message(2, '还是叫我小李吧');
    f.social.record(f.session, [f.note(next.messageId, next.text)], [next]);
    f.social.record(f.session, [f.note()], [f.first]);
    assert.equal(f.social.context(f.session, ['member-a'])[0]!.quote, next.text);
    assert.equal(f.store.one('SELECT count(*) n FROM social_notes')!.n, 2);
  } finally { f.store.close(); }
});

test('short-lived follow-ups expire; profile context has a hard byte limit and respects memory disable', () => {
  const f = fixture();
  try {
    f.social.record(f.session, [f.note(), { ...f.note(), kind: 'open_loop', key: '面试进展' }], [f.first]);
    assert.equal(f.social.context(f.session, ['member-a']).length, 2);
    assert.deepEqual(f.social.context(f.session, ['member-a'], 10), []);
    f.advance(8 * 86400000);
    assert.equal(f.social.context(f.session, ['member-a']).length, 1);
    f.c.memory.enabled = false;
    assert.deepEqual(f.social.context(f.session, ['member-a']), []);
    f.c.memory.enabled = true;
    f.advance(23 * 86400000);
    assert.deepEqual(f.social.context(f.session, ['member-a']), []);
  } finally { f.store.close(); }
});

test('correction history is bounded and quotes remain untrusted data', () => {
  const f = fixture();
  try {
    for (let i = 1; i <= 520; i++) {
      const m = f.message(i, `偏好${i}`);
      f.social.record(f.session, [{ ...f.note(m.messageId, m.text), key: `属性${i}` }], [m]);
    }
    assert.equal(f.store.one('SELECT count(*) n FROM social_notes')!.n, 512);
    const context = f.social.context(f.session, ['member-a']);
    assert.ok(context.length <= 12);
    assert.ok(context.every(r => r.evidenceOnly === true));
  } finally { f.store.close(); }
});
