import type { DatabaseSync } from 'node:sqlite';

/** Additive, content-minimal trace. SQL triggers cover all existing state mutations. */
export function installTrace(db: DatabaseSync) {
  // SQL-native time keeps persistent triggers compatible with older/other writers.
  const timestamp = "CAST(unixepoch('subsec') * 1000 AS INTEGER)";
  db.exec(`
    CREATE TABLE IF NOT EXISTS trace_inbox(id TEXT PRIMARY KEY,created INTEGER NOT NULL);
    CREATE TABLE IF NOT EXISTS trace_sources(run_id TEXT NOT NULL,inbox_id TEXT NOT NULL,PRIMARY KEY(run_id,inbox_id));
    CREATE INDEX IF NOT EXISTS trace_sources_inbox ON trace_sources(inbox_id,run_id);
    CREATE TABLE IF NOT EXISTS trace_outputs(outbox_id TEXT PRIMARY KEY,run_id TEXT,inbox_id TEXT);
    CREATE INDEX IF NOT EXISTS trace_outputs_run ON trace_outputs(run_id);
    CREATE INDEX IF NOT EXISTS trace_outputs_inbox ON trace_outputs(inbox_id);
    CREATE TABLE IF NOT EXISTS trace_events(id INTEGER PRIMARY KEY AUTOINCREMENT,at INTEGER NOT NULL,
      phase TEXT NOT NULL,state TEXT NOT NULL,inbox_id TEXT,run_id TEXT,outbox_id TEXT,details TEXT NOT NULL DEFAULT '{}',event_key TEXT UNIQUE);
    CREATE INDEX IF NOT EXISTS trace_events_inbox ON trace_events(inbox_id,id);
    CREATE INDEX IF NOT EXISTS trace_events_run ON trace_events(run_id,id);
    CREATE INDEX IF NOT EXISTS trace_events_outbox ON trace_events(outbox_id,id);
    CREATE TRIGGER IF NOT EXISTS trace_inbox_insert AFTER INSERT ON inbox BEGIN
      INSERT OR IGNORE INTO trace_inbox VALUES(NEW.id,${timestamp});
      INSERT INTO trace_events(at,phase,state,inbox_id,details) VALUES(${timestamp},'ingress',NEW.state,NEW.id,json_object('reason',NEW.reason));
    END;
    CREATE TRIGGER IF NOT EXISTS trace_inbox_update AFTER UPDATE OF state,reason ON inbox
      WHEN OLD.state<>NEW.state OR OLD.reason IS NOT NEW.reason BEGIN
      INSERT INTO trace_events(at,phase,state,inbox_id,details) VALUES(${timestamp},'inbox',NEW.state,NEW.id,json_object('reason',NEW.reason));
    END;
    CREATE TRIGGER IF NOT EXISTS trace_run_insert AFTER INSERT ON runs BEGIN
      INSERT INTO trace_events(at,phase,state,run_id,details) VALUES(${timestamp},'model',NEW.state,NEW.id,json_object('purpose',NEW.purpose));
    END;
    CREATE TRIGGER IF NOT EXISTS trace_run_update AFTER UPDATE OF state ON runs WHEN OLD.state<>NEW.state BEGIN
      INSERT INTO trace_events(at,phase,state,run_id,details) VALUES(${timestamp},'model',NEW.state,NEW.id,json_object('purpose',NEW.purpose));
    END;
    CREATE TRIGGER IF NOT EXISTS trace_outbox_insert AFTER INSERT ON outbox BEGIN
      INSERT INTO trace_events(at,phase,state,outbox_id,details) VALUES(${timestamp},'outbox',NEW.state,NEW.id,json_object('part',NEW.part,'kind',NEW.kind));
    END;
    CREATE TRIGGER IF NOT EXISTS trace_outbox_update AFTER UPDATE OF state,submitted ON outbox
      WHEN OLD.state<>NEW.state OR OLD.submitted<>NEW.submitted BEGIN
      INSERT INTO trace_events(at,phase,state,outbox_id,details) VALUES(${timestamp},'outbox',NEW.state,NEW.id,json_object('submitted',NEW.submitted));
    END;
    INSERT OR IGNORE INTO metadata VALUES('trace_since',cast(${timestamp} AS TEXT));
  `);
}
export interface OutputOrigin { runId?: string; inboxId?: string }
export interface TraceObservation {
  phase: 'request' | 'tool'; state: string;
  details: { requestId?: string; name?: string; callId?: string; inputTokens?: number; outputTokens?: number;
    cacheReadTokens?: number; cacheWriteTokens?: number; reason?: string; code?: string };
}
