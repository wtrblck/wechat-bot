/** Explicit final-output envelope; legacy executions without this protocol remain untouched on recovery. */
export const replyFormatInstruction = '\n最终回复仅输出一个JSON对象，格式为{"messages":["第一条微信消息","可选的第二条"]}，不加代码围栏。' +
  '每个数组元素会成为单独一条微信消息。按语意决定一条或多条，最多30条，不为凑条数拆分，不添加无意义的空消息。' +
  'JSON只是内部传输格式，用户只看到数组中的文字；消息内的换行使用JSON转义。调用工具时正常调用工具，不把工具调用放入messages。' +
  '若直接输出普通短文本，每个独立消息用换行分开；需要在一条消息内保留多行时必须用messages数组明确表示。';

function plainReply(text: string): { text: string; messages?: string[] } {
  // Real model output may use line breaks instead of the requested envelope.
  // Preserve multiline code, lists, quotations and tables as one message.
  if (/```|^\s*(?:[-*+]\s|\d+[.)、]\s*|>|\|)/m.test(text)) return { text };
  const messages = text.split(/\r?\n/).map(s => s.trim()).filter(Boolean);
  return messages.length > 1 && messages.length <= 30 ? { text: messages.join('\n\n'), messages } : { text };
}

export function decodeReply(text: string): { text: string; messages?: string[] } | undefined {
  const raw = text.replace(/^```(?:json)?\s*\n?([\s\S]*?)\n?```$/i, '$1').trim();
  let value;
  try { value = JSON.parse(raw); }
  catch { return /^\{\s*"messages"\s*:/.test(raw) ? undefined : plainReply(text); }
  if (!value || typeof value !== 'object' || Array.isArray(value) || !Object.hasOwn(value, 'messages')) return { text };
  if (Object.keys(value).length !== 1 || !Array.isArray(value.messages) || value.messages.length < 1 || value.messages.length > 30 ||
      value.messages.some((m: unknown) => typeof m !== 'string' || !m.trim())) return;
  const messages = value.messages.map((m: string) => m.trim());
  return { text: messages.join('\n\n'), messages };
}
