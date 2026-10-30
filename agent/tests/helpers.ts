import { fileURLToPath } from 'node:url';
import type { Config } from '../src/config.js';
import { validateConfig } from '../src/config.js';
import type { Bridge } from '../src/bridge/client.js';
import type { EventPage, HostAdapter, HostInput, HostResult } from '../src/contracts.js';
export const root = fileURLToPath(new URL('../..', import.meta.url));
// Compiled tests are in dist/tests, so the agent root is one level above dist.
export const agentRoot = fileURLToPath(new URL('../..', import.meta.url));
export function config(extra: Record<string, unknown> = {}): Config {
  return validateConfig({ account: { key: 'test-account', selfId: 'self', bridgeEpoch: 'test-source' },
    bridge: { sessionFile: 'unused.json' }, access: { owners: ['owner'], direct: { allow: ['contact-a', 'contact-b'] }, group: { allow: ['group-a@chatroom', 'group-b@chatroom'] } },
    runtime: { provider: 'mock', model: 'test-model' }, memory: { enabled: false },
    participation: { debounceMs: 0, maxBatchWaitMs: 100 }, ...extra }, agentRoot);
}
export function event(sequence: number, conversation = 'contact-a', text = '/ai 你好', extra: Record<string, unknown> = {}) {
  return { sequence, message_id: `${conversation}:${sequence}`, conversation_id: conversation, sender: 'member-a',
    direction: 'incoming', message_type: 'text', content: text, timestamp: 1793270000, ...extra };
}
export const now = 1793270000000;
export class FakeBridge implements Bridge {
  page: EventPage = { cursor: 0, events: [], truncated: false };
  requests = new Map<string, Record<string, any>>();
  posts: string[] = [];
  lostResponse = false;
  nextState = 'server_confirmed';
  config = config();
  async health() { return { state: 'ready', send_ready: true, receive_ready: true, config: {
    conversations: [...this.config.access.direct.allow, ...this.config.access.group.allow],
    observe: { targets: [...this.config.access.direct.allow, ...this.config.access.group.allow], prefix: '' },
    send: { recipients: [...this.config.access.direct.allow, ...this.config.access.group.allow], text_bytes: 4096 },
  } }; }
  async events(after: number) { return { ...this.page, events: this.page.events.filter(e => Number(e.sequence) > after) }; }
  async request(id: string) { return this.requests.get(id); }
  async send(body: string) {
    this.posts.push(body); const data = JSON.parse(body);
    const result = { request_id: data.request_id, state: this.nextState, delivery_verified: false };
    this.requests.set(data.request_id, result);
    if (this.lostResponse) { this.lostResponse = false; throw Error('lost_response'); }
    return result;
  }
  async cancel(id: string) { const record = this.requests.get(id); if (record?.state === 'queued') record.state = 'cancelled'; }
}
export class FakeHost implements HostAdapter {
  calls: HostInput[] = [];
  records = new Map<string, HostResult>();
  hook?: (input: HostInput) => Promise<void>;
  action = 'reply';
  async execute(input: HostInput, signal: AbortSignal): Promise<HostResult> {
    this.calls.push(input); await this.hook?.(input);
    let text = '测试回复 👨‍👩‍👧‍👦';
    if (input.purpose === 'decision') {
      const context = JSON.parse(input.context); const m = context.recent[context.recent.length - 1];
      text = JSON.stringify({ action: this.action, reason: 'unanswered_question', sourceMessageIds: [m.messageId], topicId: 'topic', replyToSenderId: m.senderId });
    }
    const result: HostResult = { status: signal.aborted ? 'cancelled' : 'completed', replies: [{ id: input.executionId + ':reply', text }] };
    this.records.set(input.inputId, result); return result;
  }
  async reconcile(input: HostInput) { return this.records.get(input.inputId); }
  async close() {}
}
