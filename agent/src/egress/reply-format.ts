/** Explicit final-output envelope; legacy executions without this protocol remain untouched on recovery. */
export const replyFormatInstruction = '\n最终回复的整个输出必须是一个可完整解析的JSON对象，且顶层只能有messages这一个字段，格式为{"messages":["第一条微信消息","可选的第二条"]}。' +
  '一次回复只能创建一个顶层对象和一个messages数组。开场、正文、可复制话术、链接及补充说明都按顺序放入同一个数组；不要每写完一段就关闭对象再输出另一个对象。' +
  '禁止连续或换行输出多个JSON对象，禁止JSON对象之外的普通文字、解释、标题和代码围栏。' +
  '每个数组元素会成为单独一条微信消息。按语意决定一条或多条，最多30条，不为凑条数拆分，不添加无意义的空消息。' +
  'JSON只是内部传输格式，用户只看到数组中的文字；消息内的换行使用JSON转义。调用工具时正常调用工具，不把工具调用放入messages。' +
  '合并示例：{"messages":["开场说明","正文内容","补充说明"]}，不是三个分别包含messages的对象。示例仅说明结构，不照抄内容。' +
  '输出前自行检查：整个输出只有一个顶层对象；所有消息都在同一个数组中；每项是非空字符串；引号、反斜杠和换行已正确转义。只输出最终对象，不输出检查过程。';

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
