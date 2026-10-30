export function present(text: string): string {
  return text.replace(/\r\n?/g, '\n').replace(/^```[^\n]*\n|^```\s*$/gm, '').replace(/^\|?\s*:?-{3,}.*\|.*$/gm, '')
    .replace(/^\|(.+)\|\s*$/gm, (_, row: string) => row.split('|').map(x => x.trim()).join('；')).trim();
}
export function chunkText(input: string, maxBytes = 3800, maxParts = 30): string[] {
  const text = present(input);
  if (/[\x00-\x08\x0b-\x1f\x7f]/.test(text)) throw Error('invalid_text');
  if (!text) return [];
  const budget = maxBytes - 32;
  const segmenter = new Intl.Segmenter('zh', { granularity: 'grapheme' });
  const chunks: string[] = [];
  let current = '';
  for (const { segment } of segmenter.segment(text)) {
    if (Buffer.byteLength(segment) > budget) throw Error('grapheme_too_large');
    if (Buffer.byteLength(current + segment) > budget) {
      const paragraph = current.lastIndexOf('\n\n'); const line = current.lastIndexOf('\n');
      const boundary = paragraph >= 0 ? paragraph + 2 : line >= 0 ? line + 1 : 0;
      if (boundary && Buffer.byteLength(current.slice(0, boundary)) >= budget / 3) {
        chunks.push(current.slice(0, boundary)); current = current.slice(boundary);
      } else { chunks.push(current); current = ''; }
      if (Buffer.byteLength(current + segment) > budget) { chunks.push(current); current = ''; }
    }
    current += segment;
  }
  if (current) chunks.push(current);
  if (chunks.length > maxParts) throw Error('reply_requires_artifact');
  return chunks.map((s, i) => chunks.length > 1 ? `(${i + 1}/${chunks.length}) ${s}` : s);
}
