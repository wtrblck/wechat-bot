/** Execution time excludes bounded waits for a human to authorize the task. */
export class TaskDeadline {
  private controller = new AbortController();
  readonly signal = this.controller.signal;
  private timer?: ReturnType<typeof setTimeout>;
  private started = performance.now();
  private pauses = 0;
  constructor(private remaining: number) { this.arm(); }
  private arm() {
    this.started = performance.now();
    this.timer = setTimeout(() => this.controller.abort(new DOMException('Task execution timed out', 'TimeoutError')), Math.max(0, this.remaining));
    this.timer.unref();
  }
  pause() {
    if (!this.pauses++) {
      if (this.timer) clearTimeout(this.timer);
      this.remaining -= performance.now() - this.started;
    }
    let released = false;
    return () => {
      if (released) return;
      released = true;
      if (--this.pauses === 0 && !this.signal.aborted) this.arm();
    };
  }
  dispose() { if (this.timer) clearTimeout(this.timer); }
}
