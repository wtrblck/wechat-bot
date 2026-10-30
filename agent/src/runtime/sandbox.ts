import { lstatSync, mkdirSync, realpathSync, readFileSync, writeFileSync, renameSync, unlinkSync, readdirSync } from 'node:fs';
import { resolve, relative, isAbsolute, join } from 'node:path';
import { randomUUID } from 'node:crypto';

/** Capability boundary for trusted file tools. No model-supplied absolute paths or links. */
export class Sandbox {
  readonly root: string;
  constructor(readonly agentRoot: string, readonly scope: string) {
    if (!/^[a-zA-Z0-9_-]{1,128}$/.test(scope)) throw Error('sandbox_scope_denied');
    this.root = this.walk(realpathSync(agentRoot), ['data', 'sandbox', scope], true);
  }
  private walk(base: string, parts: string[], create: boolean) {
    let current = base;
    for (const part of parts) {
      current = join(current, part);
      let info;
      try { info = lstatSync(current); } catch (error) {
        if ((error as NodeJS.ErrnoException).code !== 'ENOENT' || !create) throw error;
        mkdirSync(current); info = lstatSync(current);
      }
      if (info.isSymbolicLink() || !info.isDirectory()) throw Error('sandbox_path_denied');
      const rel = relative(base, realpathSync(current));
      if (!rel || rel.startsWith('..') || isAbsolute(rel)) throw Error('sandbox_path_denied');
    }
    return current;
  }
  path(name: string, createParents = false) {
    // Also excludes Windows ADS, devices, UNC, trailing-dot aliases and drive-relative names.
    if (name.length > 240 || !name || isAbsolute(name) || /[\\:\x00-\x1f]/.test(name)) throw Error('sandbox_path_denied');
    const parts = name.split('/');
    if (parts.some(p => !p || p === '.' || p === '..' || /[. ]$/.test(p) || /[<>"|?*]/.test(p) ||
      /^(con|prn|aux|nul|com[0-9]|lpt[0-9])(?:\.|$)/i.test(p))) throw Error('sandbox_path_denied');
    // Recheck the root as well: a host-side junction swap must not silently change the fence.
    const root = this.walk(realpathSync(this.agentRoot), ['data', 'sandbox', this.scope], false);
    const parent = this.walk(root, parts.slice(0, -1), createParents);
    const target = resolve(parent, parts.at(-1)!);
    try {
      const info = lstatSync(target);
      if (info.isSymbolicLink() || !info.isFile() || info.nlink !== 1) throw Error('sandbox_path_denied');
    } catch (error) { if ((error as NodeJS.ErrnoException).code !== 'ENOENT') throw error; }
    return target;
  }
  read(name: string, maxBytes = 65536) {
    const path = this.path(name);
    if (lstatSync(path).size > maxBytes) throw Error('sandbox_file_too_large');
    return new TextDecoder('utf-8', { fatal: true }).decode(readFileSync(path));
  }
  write(name: string, text: string) {
    if (Buffer.byteLength(text) > 65536) throw Error('sandbox_file_too_large');
    const path = this.path(name, true), temp = path + '.' + randomUUID() + '.tmp';
    try { writeFileSync(temp, text, { flag: 'wx', mode: 0o600 }); this.path(name); renameSync(temp, path); }
    finally { try { unlinkSync(temp); } catch {} }
    return { path: name, bytes: Buffer.byteLength(text) };
  }
  writeBytes(name: string, bytes: Uint8Array, maxBytes = 10 * 1024 * 1024) {
    if (bytes.byteLength > maxBytes) throw Error('sandbox_file_too_large');
    const path = this.path(name, true), temp = path + '.' + randomUUID() + '.tmp';
    try { writeFileSync(temp, bytes, { flag: 'wx', mode: 0o600 }); this.path(name); renameSync(temp, path); }
    finally { try { unlinkSync(temp); } catch {} }
    return path;
  }
  list() {
    this.walk(realpathSync(this.agentRoot), ['data', 'sandbox', this.scope], false);
    return readdirSync(this.root, { withFileTypes: true }).filter(e => !e.isSymbolicLink()).slice(0, 100)
      .map(e => ({ name: e.name, kind: e.isDirectory() ? 'directory' : 'file' }));
  }
}
