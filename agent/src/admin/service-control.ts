import { execFile } from 'node:child_process';
import { promisify } from 'node:util';
import { resolve } from 'node:path';

export type ServiceAction = 'start' | 'stop' | 'reset-budget';
export interface ServiceControl {
  status(): Promise<Record<string, any>>;
  action(action: ServiceAction): boolean;
}

const exec = promisify(execFile);
type Run = (action: 'status' | ServiceAction) => Promise<Record<string, any>>;

export class LocalServiceControl implements ServiceControl {
  private operation: ServiceAction | null = null;
  private lastError: string | null = null;
  private pendingStatus?: Promise<Record<string, any>>;
  private readonly run: Run;
  constructor(root: string, runner?: Run) {
    this.run = runner ?? (async action => {
      const result = await exec(process.execPath, [resolve(root, 'scripts/service-control.mjs'), action],
        { windowsHide: true, timeout: 180000, maxBuffer: 65536 });
      return JSON.parse(result.stdout);
    });
  }
  async status() {
    // Concurrent tabs share a status lookup; no competing state mutations.
    const pending = this.pendingStatus ??= this.run('status');
    try { return { ...await pending, enabled: true, operation: this.operation, lastError: this.lastError }; }
    finally { if (this.pendingStatus === pending) this.pendingStatus = undefined; }
  }
  action(action: ServiceAction) {
    if (this.operation) return false;
    this.operation = action;
    this.lastError = null;
    void this.run(action).catch(() => { this.lastError = action === 'reset-budget' ? 'budget_reset_failed' : action === 'start' ? 'service_start_failed' : 'service_stop_failed'; })
      .finally(() => { this.operation = null; });
    return true;
  }
}
