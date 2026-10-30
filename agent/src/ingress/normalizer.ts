import type { Config } from '../config.js';
import type { Message } from '../contracts.js';

export function normalize(raw: Record<string, unknown>, c: Config): Message | undefined {
  const { sequence, message_id, conversation_id, timestamp } = raw;
  const sender = raw.sender_id ?? raw.sender;
  if (!Number.isSafeInteger(sequence) || (sequence as number) < 1 || typeof message_id !== 'string' || !message_id ||
      typeof conversation_id !== 'string' || !conversation_id || typeof sender !== 'string' || !sender ||
      typeof timestamp !== 'number' || !Number.isFinite(timestamp) || timestamp <= 0) return;
  const media = raw.media as Record<string, unknown> | undefined;
  const bridgeTypes: Record<string, Message['kind']> = {
    '文本': 'text', '图片': 'image', '语音': 'voice', '视频': 'video', '动画表情': 'emoji',
  };
  const kind = ['text', 'image', 'file', 'video', 'voice', 'emoji'].includes(String(raw.message_type))
    ? raw.message_type as Message['kind'] : bridgeTypes[String(raw.message_type)]
      ?? (raw.message_type === '文件/链接/卡片' && media?.kind === 'file' ? 'file' : 'unsupported');
  const direction = ['incoming', 'outgoing'].includes(String(raw.direction)) ? raw.direction as Message['direction'] : 'unknown';
  return { accountKey: c.account.key, bridgeEpoch: c.account.bridgeEpoch, sequence: sequence as number,
    messageId: message_id, conversationId: conversation_id, senderId: sender,
    scope: conversation_id.endsWith('@chatroom') ? 'group' : 'direct', direction, kind,
    text: typeof raw.content === 'string' ? raw.content : '', timestampMs: timestamp * 1000,
    mediaRef: typeof media?.id === 'string' ? media.id : undefined };
}
export function ignoreReason(m: Message, c: Config, now: number): string | null {
  if (!(m.scope === 'group' ? c.access.group.allow : c.access.direct.allow).includes(m.conversationId)) return 'conversation_not_allowed';
  if (m.senderId === c.account.selfId || m.direction === 'outgoing') return 'self_echo';
  if (m.direction !== 'incoming') return 'unknown_direction';
  if (m.kind === 'unsupported') return 'unsupported_type';
  if (m.timestampMs > now + 30000 || now - m.timestampMs > c.ingress.maxMessageAgeSeconds * 1000) return 'stale';
  return null;
}
