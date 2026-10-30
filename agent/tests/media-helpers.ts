import { crc32, deflateSync } from 'node:zlib';
export function pngFixture() {
  const chunk = (type: string, data: Buffer) => {
    const tag = Buffer.from(type), size = Buffer.alloc(4), crc = Buffer.alloc(4);
    size.writeUInt32BE(data.length); crc.writeUInt32BE(crc32(Buffer.concat([tag, data])));
    return Buffer.concat([size, tag, data, crc]);
  };
  const header = Buffer.alloc(13); header.writeUInt32BE(2, 0); header.writeUInt32BE(2, 4); header[8] = 8; header[9] = 2;
  return Buffer.concat([Buffer.from([137,80,78,71,13,10,26,10]), chunk('IHDR', header),
    chunk('IDAT', deflateSync(Buffer.from([0,255,0,0,0,255,0,0,0,0,255,255,255,255]))), chunk('IEND', Buffer.alloc(0))]);
}
