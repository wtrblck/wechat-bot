import { lstatSync, mkdirSync, realpathSync, readFileSync, writeFileSync, renameSync, unlinkSync } from 'node:fs';
import { join } from 'node:path';
import { randomUUID } from 'node:crypto';

/** Trusted summaries are outside model-writable workspaces. No model-supplied paths. */
export class MemoryFiles {
  constructor(readonly root: string) {}
  private directory(scope: string, day: string, create: boolean) {
    if (!/^[a-f0-9]{64}$/.test(scope) || !/^\d{4}-\d{2}-\d{2}$/.test(day)) throw Error('memory_path_denied');
    let path = realpathSync(this.root);
    for (const component of ['data', 'memory', scope, day]) {
      path = join(path, component);
      try { lstatSync(path); } catch (e) {
        if ((e as NodeJS.ErrnoException).code !== 'ENOENT' || !create) throw e;
        mkdirSync(path);
      }
      const info = lstatSync(path);
      if (info.isSymbolicLink() || !info.isDirectory()) throw Error('memory_path_denied');
    }
    return path;
  }
  private file(scope: string, relative: string, create: boolean) {
    if (!/^\d{4}-\d{2}-\d{2}\/[a-f0-9]{64}\.json$/.test(relative)) throw Error('memory_path_denied');
    const [day, name] = relative.split('/'), path = join(this.directory(scope, day!, create), name!);
    try {
      const s = lstatSync(path);
      if (!s.isFile() || s.isSymbolicLink() || s.nlink !== 1 || s.size > 32768) throw Error('memory_path_denied');
    } catch (e) { if ((e as NodeJS.ErrnoException).code !== 'ENOENT') throw e; }
    return path;
  }
  write(scope: string, time: number, id: string, value: unknown) {
    const day = new Date(time).toLocaleDateString('sv-SE', { timeZone: 'Asia/Shanghai' });
    const relative = `${day}/${id}.json`, path = this.file(scope, relative, true), temp = path + '.' + randomUUID() + '.tmp';
    try {
      writeFileSync(temp, JSON.stringify(value, null, 2) + '\n', { flag: 'wx', mode: 0o600 });
      this.file(scope, relative, false); renameSync(temp, path);
    } finally { try { unlinkSync(temp); } catch {} }
    return relative;
  }
  read(scope: string, relative: string): Record<string, any> {
    return JSON.parse(readFileSync(this.file(scope, relative, false), 'utf8'));
  }
}
