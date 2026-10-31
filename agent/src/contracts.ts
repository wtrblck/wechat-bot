import { createHash } from 'node:crypto';
import type { DailyBudget } from './budget/daily-budget.js';
import type { ImageBlock } from '@deepseek-ai/dsh-llm';

export const hash = (value: unknown): string => createHash('sha256').update(JSON.stringify(value)).digest('hex');
export type Scope = 'direct' | 'group';
export interface Message {
  accountKey: string; bridgeEpoch: string; sequence: number; messageId: string;
  conversationId: string; senderId: string; scope: Scope;
  direction: 'incoming' | 'outgoing' | 'unknown';
  kind: 'text' | 'image' | 'file' | 'video' | 'voice' | 'emoji' | 'unsupported';
  text: string; timestampMs: number; mediaRef?: string;
}
export interface EventPage { events: Record<string, unknown>[]; cursor: number; truncated: boolean }
export interface Session { key: string; id: string; generation: number; conversation: string; scope: Scope; model: string; persona: string | null }
export interface Decision {
  action: 'reply' | 'wait' | 'silent'; reason: string; sourceMessageIds: string[];
  topicId: string; replyToSenderId: string;
  tone?: { state: 'light' | 'serious' | 'quiet' | 'neutral'; sourceMessageId: string };
}
export interface HostInput {
  proactive?: boolean;
  replyFormat?: 'messages-v1';
  inputId: string; executionId: string; session: Session; purpose: 'reply' | 'decision' | 'memory';
  system: string; context: string; provider: string; model: string;
  initiatorId?: string;
}
export interface CommittedReply { id: string; text: string; messages?: string[] }
export interface HostResult { status: 'completed' | 'cancelled' | 'failed' | 'needs_review'; replies: CommittedReply[]; failureCode?: string }
export interface WorkObservation {
  callId: string; name: string; state: 'started' | 'completed' | 'failed' | 'unknown'; arguments?: unknown; result?: unknown;
}
export interface HostAdapter {
  setWorkRecorder?(record: (input: HostInput, event: WorkObservation) => void): void;
  imageAttachment?(input: HostInput, data: Uint8Array, mediaType: ImageBlock['attachment']['mediaType'], name: string,
    signal: AbortSignal): Promise<ImageBlock['attachment']>;
  setTrace?(observe: (inputId: string, event: import('./storage/trace.js').TraceObservation, key?: string) => void): void;
  setBudget?(budget: DailyBudget): void;
  available?(provider: string): boolean;
  execute(input: HostInput, signal: AbortSignal): Promise<HostResult>;
  reconcile(input: HostInput): Promise<HostResult | undefined>;
  close(): Promise<void>;
}
export const routeKey = (account: string, scope: Scope, id: string): string => hash(['wechat', account, scope, id]);
export const requestId = (account: string, session: Session, event: string, part: number): string =>
  'wa_' + hash([account, session.id, session.generation, event, part]).slice(0, 60);
