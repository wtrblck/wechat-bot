import { closeSync, existsSync, fstatSync, lstatSync, openSync, opendirSync, readSync, realpathSync } from 'node:fs';
import { isAbsolute, join, parse, relative, resolve } from 'node:path';
import { hash } from '../contracts.js';
import type { Config } from '../config.js';
import { imageType } from './file-types.js';

type Entry = { emoji_id: string; caption: string; mime: string; bytes: number; name: string; stamp: string };
const extensions = /\.(png|jpe?g|gif|webp)$/i;
const identity = (s: NonNullable<ReturnType<typeof lstatSync>>) => `${s.dev}:${s.ino}:${s.size}:${s.mtimeMs}:${s.ctimeMs}`;

/** Read-only, operator-selected library. The model receives IDs, never arbitrary host paths. */
export class StickerLibrary {
  private listed = new Map<string, Entry>();
  private frozen = new Map<string, Buffer>();
  private frozenBytes = 0;
  constructor(readonly config: Config) {}
  private path(name = '') {
    const root = resolve(this.config.root, this.config.stickers.directory);
    if (/^[\\/]{2}/.test(root) || /[\x00-\x1f]/.test(root) || root.slice(parse(root).root.length).includes(':')) throw Error('sticker_directory_denied');
    if (name && (isAbsolute(name) || name.split('/').some(p => !p || p === '.' || p === '..' || /[\\:\x00-\x1f<>"|?*]|[. ]$/.test(p)))) throw Error('sticker_path_denied');
    const target = name ? resolve(root, ...name.split('/')) : root;
    let current = parse(target).root;
    for (const part of relative(current, target).split(/[\\/]/).filter(Boolean)) {
      current = join(current, part);
      const info = lstatSync(current);
      if (info.isSymbolicLink() || info.isFile() && info.nlink !== 1) throw Error('sticker_path_denied');
    }
    const canonical = realpathSync(target), rel = relative(realpathSync(root), canonical);
    if (rel.startsWith('..') || isAbsolute(rel)) throw Error('sticker_path_denied');
    return canonical;
  }
  list(offset = 0, limit = 30, query = '') {
    if (!this.config.stickers.enabled) throw Error('stickers_disabled');
    const configured = resolve(this.config.root, this.config.stickers.directory);
    if (!existsSync(configured)) return { items: [], total: 0, offset, limit, truncated: false, note: '表情包目录不存在或尚未放入图片。' };
    const root = this.path(), pending = [''], entries: Entry[] = [];
    let visited = 0, truncated = false;
    while (pending.length && !truncated) {
      const dirName = pending.shift()!, directory = opendirSync(dirName ? this.path(dirName) : root);
      try {
        let item;
        while ((item = directory.readSync())) {
          if (++visited > this.config.stickers.maxFiles) { truncated = true; break; }
          const name = dirName ? dirName + '/' + item.name : item.name;
          if (item.isSymbolicLink()) continue;
          if (item.isDirectory()) { if (name.split('/').length < 3) pending.push(name); continue; }
          if (!item.isFile() || !extensions.test(item.name)) continue;
          try {
            const path = this.path(name), stat = lstatSync(path);
            if (!stat.size || stat.size > this.config.stickers.maxFileMiB * 1024 * 1024) continue;
            const fd = openSync(path, 'r');
            let image;
            try {
              if (identity(fstatSync(fd)) !== identity(stat)) continue;
              const header = Buffer.alloc(16); const n = readSync(fd, header, 0, 16, 0); image = imageType(header.subarray(0, n));
            } finally { closeSync(fd); }
            if (!image) continue;
            const stamp = identity(stat), emoji_id = hash(['local-sticker', name, stamp]);
            entries.push({ emoji_id, caption: name.replace(extensions, '').slice(0, 240), mime: image.mime, bytes: stat.size, name, stamp });
          } catch { /* Ignore inaccessible, linked, or concurrently removed entries. */ }
        }
      } finally { directory.closeSync(); }
    }
    const terms = query.trim().toLocaleLowerCase();
    const matches = entries.filter(e => !terms || e.caption.toLocaleLowerCase().includes(terms)).sort((a, b) => a.name.localeCompare(b.name, 'zh-CN'));
    const page = matches.slice(offset, offset + limit);
    for (const e of page) this.listed.set(e.emoji_id, e);
    return { items: page.map(({ stamp, ...e }) => e), total: matches.length, offset, limit, truncated,
      note: '来源为bot配置的本地目录。名称仅为标签；需要理解图片时先预览。GIF及动画WebP由桥接按原生表情发送；能力不可用会失败。预览只代表静态画面。' };
  }
  read(id: string) {
    if (!this.config.stickers.enabled) throw Error('stickers_disabled');
    const entry = this.listed.get(id);
    if (!entry) throw Error('sticker_not_listed');
    const pinned = this.frozen.get(id);
    if (pinned) return { entry, bytes: pinned };
    const path = this.path(entry.name), stat = lstatSync(path);
    if (identity(stat) !== entry.stamp || stat.size > this.config.stickers.maxFileMiB * 1024 * 1024) throw Error('sticker_changed_list_again');
    const fd = openSync(path, 'r');
    let bytes: Buffer;
    try {
      if (identity(fstatSync(fd)) !== entry.stamp) throw Error('sticker_changed_list_again');
      bytes = Buffer.alloc(stat.size);
      let offset = 0;
      while (offset < bytes.length) { const n = readSync(fd, bytes, offset, bytes.length - offset, offset); if (!n) break; offset += n; }
      if (offset !== bytes.length || identity(fstatSync(fd)) !== entry.stamp) throw Error('sticker_changed_list_again');
    } finally { closeSync(fd); }
    if (imageType(bytes)?.mime !== entry.mime) throw Error('sticker_changed_list_again');
    if (this.frozenBytes + bytes.length > 64 * 1024 * 1024) throw Error('sticker_turn_cache_limit');
    this.frozen.set(id, bytes); this.frozenBytes += bytes.length;
    return { entry, bytes };
  }
}
