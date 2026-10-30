# Developer handoff

This public source tree contains the runnable bridge/agent, tests and version
research tools. Private deployment notes and real conversation evidence are not
distributed.

- Read README.md for first-run setup and supported versions.
- Agent entry point: agent/src/index.ts; orchestration: engine.ts.
- Persistent queue/history: agent/src/storage/database.ts.
- File tools: channel-tools.ts and runtime/external-files.ts. Never bypass the
  designated contact's single-use approval for host filesystem access.
- Media/attachments: media/resources.ts and runtime/host-adapter.ts.
- Memory: agent/src/memory; docs: MEMORY_V2.md and FILE_ACCESS.md.
- Bridge: weixin-research/bridge_service.py; deployment policy is generated in
  ignored runs/ files, never added to version control.
- Pin and verify Weixin.dll SHA-256 before native calls. Different versions need
  independently verified ABI data. Never guess offsets or replay unknown sends.
- Preserve UTF-8 BOM on .ps1 launchers for Windows PowerShell 5 compatibility.
- Run pnpm test in agent/ and Python unittest discovery before changes ship.
- Keep local credentials, chat databases, sessions, media and logs out of Git.

The release has no default approver or permission to contact anyone. Configure
real targets locally using pnpm run setup. Long-term online reliability has not been
established by the unit tests.
