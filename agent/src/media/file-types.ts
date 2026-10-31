export type ImageMime = 'image/png' | 'image/jpeg' | 'image/gif' | 'image/webp';
export function videoType(bytes: Uint8Array): { mime: string; extension: string } | undefined {
  const b = Buffer.from(bytes.buffer, bytes.byteOffset, bytes.byteLength);
  if (b.subarray(4, 8).toString('ascii') === 'ftyp') return { mime: 'video/mp4', extension: 'mp4' };
  if (b.subarray(0, 4).equals(Buffer.from([0x1a, 0x45, 0xdf, 0xa3]))) return { mime: 'video/x-matroska', extension: 'mkv' };
  if (b.subarray(0, 4).toString() === 'RIFF' && b.subarray(8, 12).toString() === 'AVI ') return { mime: 'video/x-msvideo', extension: 'avi' };
  if (b.subarray(0, 3).toString() === 'FLV') return { mime: 'video/x-flv', extension: 'flv' };
  if (b.subarray(0, 4).toString() === 'OggS') return { mime: 'video/ogg', extension: 'ogv' };
  if (b.length > 188 && b[0] === 0x47 && b[188] === 0x47) return { mime: 'video/mp2t', extension: 'ts' };
  if (b.subarray(0, 4).equals(Buffer.from([0, 0, 1, 0xba])) || b.subarray(0, 4).equals(Buffer.from([0, 0, 1, 0xb3]))) return { mime: 'video/mpeg', extension: 'mpg' };
}
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
