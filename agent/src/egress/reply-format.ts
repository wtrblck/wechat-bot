/** A reserved standalone control token is never a public message. */
export const SILENT_REPLY = '[SILENT]';
export const replyFormatInstruction = '\n【微信回复协议】直接输出要发到微信的普通文本，不使用JSON包装。每个非空行是一条独立微信消息，空行忽略。' +
  '通常一条就够，不为凑条数拆句。旁听、等待补充或没有适合说的话时，整个输出只能是[SILENT]，不发送潜水等占位话。' +
  '不要把[SILENT]与公开回复混用。代码、诗歌、列表等必须保留内部换行的内容，通过send_text作为一条完整消息发送，或创建文件后发送；普通最终输出中的换行总是分条。' +
  '工具调用走真实工具通道，不输出工具调用文本；工具已经表达完毕且无需补充时输出[SILENT]。';

export function decodeReply(text: string): { text: string; messages: string[] } {
  const messages = text.split(/\r\n?|\n/).map(line => line.trim()).filter(line => line && line !== SILENT_REPLY);
  return { text: messages.join('\n'), messages };
}
