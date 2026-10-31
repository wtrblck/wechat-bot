import { z } from 'zod';
import type { Decision, Message } from '../contracts.js';
const schema = z.strictObject({ action: z.enum(['reply', 'wait', 'silent']), reason: z.string().min(1).max(160),
  sourceMessageIds: z.array(z.string()).min(1).max(30), topicId: z.string().min(1).max(128), replyToSenderId: z.string().min(1).max(128),
  tone: z.strictObject({ state: z.enum(['light', 'serious', 'quiet', 'neutral']), sourceMessageId: z.string().min(1).max(256) }).optional() });
export function parseDecision(text: string, window: Message[]): Decision {
  const value = schema.parse(JSON.parse(text));
  // Numeric shorthand is accepted only when unique in this exact supplied window.
  // Never fuzzy-match a foreign qualified ID or an ambiguous suffix.
  value.sourceMessageIds = value.sourceMessageIds.map(id => {
    if (window.some(m => m.messageId === id)) return id;
    const matches = /^\d+$/.test(id) ? window.filter(m => m.messageId.split(':').at(-1) === id) : [];
    if (matches.length !== 1) throw Error('decision_outside_conversation');
    return matches[0]!.messageId;
  });
  if (value.sourceMessageIds.some(id => !window.some(m => m.messageId === id)) ||
      !window.some(m => m.senderId === value.replyToSenderId)) throw Error('decision_outside_conversation');
  if (value.tone && !window.some(m => m.messageId === value.tone!.sourceMessageId && m.senderId === value.replyToSenderId && m.direction === 'incoming'))
    throw Error('tone_source_denied');
  return value;
}
