export type ImageMime = 'image/png' | 'image/jpeg' | 'image/gif' | 'image/webp';
export function imageType(bytes: Uint8Array): { mime: ImageMime; extension: string } | undefined {
  const b = Buffer.from(bytes);
  if (b.length >= 8 && b.subarray(0, 8).equals(Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]))) return { mime: 'image/png', extension: 'png' };
  if (b.length >= 3 && b[0] === 255 && b[1] === 216 && b[2] === 255) return { mime: 'image/jpeg', extension: 'jpg' };
  if (['GIF87a', 'GIF89a'].includes(b.subarray(0, 6).toString('ascii'))) return { mime: 'image/gif', extension: 'gif' };
  if (b.subarray(0, 4).toString('ascii') === 'RIFF' && b.subarray(8, 12).toString('ascii') === 'WEBP') return { mime: 'image/webp', extension: 'webp' };
}
const textExtensions = new Set('txt md markdown csv tsv log json jsonl yaml yml xml html htm css js mjs cjs ts tsx jsx py c cpp h rs go java sql sh ps1 bat ini cfg conf toml'.split(' '));
export function textExtension(name: string, mime: string) {
  const extension = /\.([a-z0-9]+)$/i.exec(name)?.[1]?.toLowerCase();
  if (extension && textExtensions.has(extension)) return extension;
  if (/^text\//i.test(mime) || /^application\/(json|xml|yaml)(;|$)/i.test(mime)) return 'txt';
}
export function decodeText(bytes: Uint8Array): { text: string; encoding: string } {
  let encoding: string, text: string;
  if (bytes[0] === 255 && bytes[1] === 254) encoding = 'utf-16le';
  else if (bytes[0] === 254 && bytes[1] === 255) encoding = 'utf-16be';
  else encoding = 'utf-8';
  try { text = new TextDecoder(encoding, { fatal: true }).decode(bytes); }
  catch {
    if (encoding !== 'utf-8') throw Error('attachment_text_encoding_invalid');
    encoding = 'gb18030';
    try { text = new TextDecoder(encoding, { fatal: true }).decode(bytes); } catch { throw Error('attachment_text_encoding_invalid'); }
  }
  if (/[\x00-\x08\x0e-\x1f\x7f]/.test(text)) throw Error('attachment_binary_not_text');
  return { text, encoding };
}
