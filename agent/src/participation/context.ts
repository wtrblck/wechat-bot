import { estimateRecallTokens } from '../memory/memory.js';

export const decisionFormatCorrection = '上次格式或引用无效。无工具；只返回action/reason/sourceMessageIds/topicId/replyToSenderId JSON，ID必须来自本窗口。';
/** A conservative local text estimate, NOT a provider tokenizer or billing counter. */
export const estimateDecisionTokens = estimateRecallTokens;
type Recent = { messageId: string; senderId: string; speaker: string; text: string; kind: string;
  attachment?: { kind?: unknown; state?: unknown; format?: unknown }; truncated?: boolean; [key: string]: unknown };
export function decisionContext(input: { recent: Recent[]; tokens: number; bytes: number; nowMs: number; stage: string;
  candidate?: string; previousWork: unknown[]; tones: unknown[]; lastReplyAt: number; incomingIds: Set<string> }) {
  const recent: Recent[] = [];
  const packet = { nowMs: input.nowMs, stage: input.stage, candidateReply: input.candidate === undefined ? undefined : '',
    candidateReplyTruncated: input.candidate === undefined ? undefined : true,
    recent, previousWork: [] as unknown[], evidenceOnly: true, tones: [] as unknown[],
    socialState: { recentBotMessages: 12, lastReplyAt: input.lastReplyAt },
    contextStats: { available: input.recent.length, included: input.recent.length, truncated: false } };
  // Reserve the actual serialized repair field before adding any optional content.
  const fits = () => {
    const text = JSON.stringify({ ...packet, formatCorrection: decisionFormatCorrection });
    return Buffer.byteLength(text) <= input.bytes && estimateDecisionTokens(text) <= input.tokens;
  };
  const project = ({ attachment, ...m }: Recent): Recent => ({ ...m,
    ...(attachment ? { attachment: { kind: attachment.kind, state: attachment.state, format: attachment.format } } : {}) });
  const all = input.recent.map(project);
  const latestIncoming = all.findLastIndex(m => input.incomingIds.has(m.messageId));
  const required = latestIncoming < 0 ? all.length - 1 : latestIncoming;
  if (required < 0) throw Error('decision_context_empty');
  // Keep identity intact. Newer bot output remains visible along with the newest inbound message.
  for (const m of all.slice(required)) recent.push({ ...m, text: '', truncated: true });
  if (!fits()) throw Error('decision_context_budget_exceeded');
  const fill = (text: string, apply: (text: string, truncated: boolean) => void) => {
    const chars = [...text]; let lo = 0, hi = chars.length;
    while (lo < hi) {
      const mid = Math.ceil((lo + hi) / 2); apply(chars.slice(0, mid).join(''), mid < chars.length);
      if (fits()) lo = mid; else hi = mid - 1;
    }
    apply(chars.slice(0, lo).join(''), lo < chars.length);
  };
  // Candidate and newest inbound get priority over older context and work previews.
  if (input.candidate !== undefined) {
    const chars = [...input.candidate];
    const preview = chars.slice(0, Math.max(32, Math.floor(input.tokens / 5))).join('');
    fill(preview, (v, cut) => { packet.candidateReply = v; packet.candidateReplyTruncated = cut || preview.length < input.candidate!.length; });
  }
  // Delivery status matters before sending even when the history is long.
  for (const item of [...input.previousWork].reverse()) {
    const { draft, draftTruncated, ...facts } = item as Record<string, unknown>;
    packet.previousWork.unshift(facts);
    if (!fits()) { packet.previousWork.shift(); break; }
    // Draft text is optional; output/submitted facts are not inferred from it.
    if (typeof draft === 'string') {
      const preview = { ...facts, draft, draftTruncated };
      packet.previousWork[0] = preview;
      if (!fits()) packet.previousWork[0] = facts;
    }
    break;
  }
  fill(all[required]!.text, (text, cut) => { recent[0]!.text = text; recent[0]!.truncated = cut || !!all[required]!.truncated; });
  for (let i = 1; i < recent.length; i++) fill(all[required + i]!.text, (text, cut) => { recent[i]!.text = text; recent[i]!.truncated = cut || !!all[required + i]!.truncated; });
  for (let i = required - 1; i >= 0; i--) {
    recent.unshift(all[i]!);
    if (!fits()) {
      recent[0] = { ...all[i]!, text: '', truncated: true };
      if (fits()) fill(all[i]!.text, (text, cut) => { recent[0]!.text = text; recent[0]!.truncated = cut || !!all[i]!.truncated; });
      else recent.shift();
      break;
    }
  }
  const ids = new Set(recent.map(m => m.messageId));
  for (const tone of input.tones) {
    const source = (tone as { sourceMessageId?: string }).sourceMessageId;
    if (source && !ids.has(source)) continue;
    // Social state is optional evidence and must not crowd out messages.
    packet.tones.push(tone); if (!fits()) { packet.tones.pop(); break; }
  }
  packet.contextStats.included = recent.length;
  packet.contextStats.truncated = recent.length < all.length || recent.some(m => m.truncated === true);
  packet.socialState.recentBotMessages = recent.slice(-12).filter(m => m.speaker === 'assistant').length;
  if (!fits()) throw Error('decision_context_budget_exceeded');
  const context = JSON.stringify(packet);
  return { context, visibleIds: ids, repairContext: JSON.stringify({ ...packet, formatCorrection: decisionFormatCorrection }) };
}
