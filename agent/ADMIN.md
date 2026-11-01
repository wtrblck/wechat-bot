# 本机消息管理台

观察已授权 bot 的持久处理链路：输入 → 参与判断/模型请求/工具状态 → 最终回复 → 每条 Outbox 状态。消息区域只读。顶部服务按钮可开启或停止本项目 bot 与桥接；管理台不直接发送微信或重试回复，开启后 bot 恢复自动回复。

## 关闭管理台后台

左侧“本地服务”面板内的“关闭管理台”按钮，经二次确认后仅关闭当前 Web 管理进程，不停止 bot、微信或桥接，不删除数据。页面停止轮询并保留最后显示内容；重新运行根目录 `start-admin.cmd`，再刷新浏览器即可恢复。不要与顶部“停止服务”（停止 bot/桥接）混淆；直接关浏览器标签也不会关闭后台。

`POST /api/admin/shutdown` 使用与服务控制相同的同源校验、每进程随机 token 和空 JSON 对象约束，不接受进程 ID 或命令。执行 bot 启停/预算操作时不能关闭管理台。独立嵌入 server 未提供 shutdown 回调时该接口禁用；CLI 的演示模式只关闭其隔离管理台。

## 启动与隔离演示

要求项目固定 Node 24.22.x。项目根目录可双击 `start-admin.cmd`，或执行 `start-admin.ps1`（由根启动器构建并启动管理服务）。也可在 `agent/` 运行：

```powershell
pnpm build
node dist/src/admin-cli.js config/agent.local.yaml --port 8788
# 或 pnpm admin
```

浏览器访问 **http://127.0.0.1:8788**。服务仅监听 `127.0.0.1`，不支持对外绑定参数。Ctrl+C 只关闭管理服务，不停止微信、桥接或 bot。消息查询使用独立只读 SQLite 连接，不获取 bot 消费租约，不创建或迁移业务库、不安装触发器、不读取 dsh 原始日志；独立服务状态探测仅调用本机桥接健康接口。配置只用于定位数据库/表情目录和预算设置；不会返回配置内容。

安全演示无需真实配置，不读取实际聊天：

```powershell
node dist/src/admin-cli.js --demo --port 8789
```

演示创建新的系统临时目录和合成数据库，包含多条出站成功、等待、静默、发送失败、unknown、needs_review、无 trace 历史和 HTML 文本。关闭时清理目录；意外终止可能留下 `wechat-admin-demo-*` 临时目录。演示不运行 bot、不调用模型、不连接微信，不把 mock 写进生产数据库。

**代码埋点在下次由操作者正常启动新版 bot 时生效。安装/查看管理台不会重启 bot。** 当前运行旧进程的历史没有 trace，不能用时间相邻推断链路。此次开发只用隔离 fixture 和模拟模型验证，未读取真实聊天验收、未付费调用、未发微信。

## 浏览已总结记忆

左侧“记忆”进入已保存摘要索引。可搜索标题、正文、标签或会话标识，按会话筛选，每页 50 条；按覆盖结束时间由新到旧排列。选择一条查看完整摘要、话题/人物与实体/状态/别名标签、覆盖时间和生成时间。历史位置是全局记录位置范围，不代表消息条数；手机端可用“返回记忆列表”切换。

只展示 `memory_segments` 中成功保存的摘要，不展示失败提取、原始聊天、社交笔记或模型思维链。浏览、搜索和刷新不调用模型，不产生 bot token 费用，不改变摘要或检查点；摘要可能存在遗漏或误解，并按现有保留策略清理。会话映射已清理的摘要仍可通过会话标识浏览。页面没有编辑、删除或重新总结按钮。

只读接口（沿用同源与本机访问限制）：
- `GET /api/memories?q=&route=&limit=50&offset=0`：搜索和分页；route 留空或为 64 位十六进制会话标识，limit 为 1–100。
- `GET /api/memories/conversations`：有已保存摘要的会话列表。
- `GET /api/memories/:id`：完整摘要详情；已清理或不存在返回 404。所有文本沿用凭证脱敏，HTML 仅作为文本展示，不返回记忆文件路径。

隔离演示包含 55 条合成摘要、两个会话、长正文和 HTML 文本，便于验证分页和显示；不读取真实聊天。

## 状态与证据边界

- `received`：已持久接收，尚未执行；`processing`：模型或控制处理已开始。
- `waiting`：明确等待参与判断、安静/冷却条件；`silent`：仅观察/决定不回复；`ignored`：基线、过期、非授权等过滤。`reason` 是安全机器码，不是模型思维链。
- `completed`：模型/控制处理完成，不保证有输出，更不等于送达。
- `prepared` / `queued` / `sending`：准备、排队、发送中。
- `local_accepted` / `message_recorded` / `server_confirmed`：桥接各级确认；**都不是目标实际收件证明**。`deliveryVerified` 恒为 `false`。
- `unknown`：结果不确定，保留原 request ID，不重发；`needs_review`：需人工核对；`failed` / `cancelled`：失败/取消。
- `legacy_unknown`：接收时没有完整 trace。详情不猜测 runs/outbox，明确提示缺失。旧记录不会伪造阶段时间。

列表显示整条链路的保守聚合状态，详细的多条发送情况应以右侧各条 Outbox 为准。消息 ID、内部 inbox ID、run ID、execution ID、reply ID、request ID 都保留各自身份。群合并输入允许多条输入关联同一 run。决策 runs 有准确 source IDs，但不把决策 JSON 当聊天最终回复；后台 memory/主动关心没有收到某条输入，不按时间强挂到它上面。工具发出的问题、文件、图片、表情以及外部批准通知用显式 run ID 关联。

运行概况是 bot 最近持久心跳，不是主动探测。超过 30 秒或消费租约缺失/过期时 `stale:true`；`stopped` 且 stale 是正常关闭后的快照，不是运行中。预算是本地账本估算，不是服务商余额或最终账单。API 可用不代表 bot/桥接健康。

## API 契约

消息和图库 API 为只读 GET（HEAD 也支持），另有两个固定的服务控制 POST；时间戳为 Unix **毫秒**，未知值为 `null` 或可选字段缺失。错误响应是 `{ "error": "机器码" }`，不返回异常文本/路径/栈。常见错误：`host_denied`、`origin_denied`（403）、`read_only`（405）、`invalid_query` / `path_denied`（400）、`not_found`（404）、`temporarily_unavailable`（503）。

### `GET /api/overview`

- `now`
- `runtime`: `{state, updated, stale, diagnostics: string[]}`；诊断是安全码数组，不含凭据/路径。
- `checkpoint`: `{cursor, baseline, paused}`
- `counts`: `{inbox: {状态:数量}, outbox: {状态:数量}, traced, legacy}`
- `budget`: `{enabled, day, timeZone, dailyLimitCny, spentCny, heldCny, remainingCny, requestCount, uncertainRequests, stopped, reason, resumesAt, pricingVersion}`
- `trace`: `{enabled, since, note}`

### `GET /api/messages?q=&status=&limit=50&offset=0&after=0`

`q` 最多 200 字符，按输入正文/消息信息、内部 ID、会话和发言人搜索。SQL 参数绑定，搜索 `%`、引号等不是 SQL 表达式。`status` 为上述聚合状态；`limit` 为 1–100，`offset` 为 0–1000000。

返回 `{items, total, limit, offset, cursor}`，按输入 sequence 倒序。每项：

```text
{id, messageId, sequence, conversationId, senderId, scope, kind, text,
 receivedAt, messageAt, status, reason, traceAvailable, updatedAt, runCount, outboxCount}
```

`scope` 是 `direct` / `group` / `unknown`。未授权输入不存正文/身份，API也不补齐。`after` 是前次返回的 trace 事件序号：仅查询之后有相关阶段变化的输入。客户端可增量合并；分页、过滤状态变化、保留期删除和旧进程写入不是完整变更订阅，仍应定期全量刷新当前页。首版前端正常 2 秒轮询当前页，后台降低频率。SQL 先筛选/分页，无逐条消息 N+1 查询；大历史关键词搜索仍为有界留存库内扫描，不是全文检索服务。

### `GET /api/messages/:id`

`:id` 为 64 位十六进制内部 inbox ID。返回：

- `message`：同列表项。
- `runs[]`：`{id, executionId, purpose, provider, model, state, startedAt, endedAt, sourceIds, finalTexts, usage, tools}`。
- `finalTexts`：仅 `purpose=reply` 的最终提交文本/拆分消息。不会返回 system/context、提示词、推理内容或决策/记忆正文。
- `usage[]`：每个模型请求最近一次报告 `{requestId, at, inputTokens, outputTokens, cacheReadTokens?, cacheWriteTokens?}`。模型重试和工具往返独立 request ID；没有报告就是未记录，不以 0 或估算冒充。
- `tools[]`：`{callId, name, state, startedAt, endedAt, code}`；仅名称和 started/completed/failed，callId 为本地观测调用标识。**不记录原始参数、返回值、网页正文、附件内容、推理或错误堆栈。**
- `outbox[]`：`{id, runId, replyId, part, kind, text, state, submitted, createdAt, updatedAt, error, deliveryVerified:false}`。媒体不返回宿主路径或原始 body。
- `timeline[]`：`{id, at, phase, state, inboxId, runId, outboxId, details}`，phase 为 ingress/inbox/participation/model/request/tool/outbox，按持久事件 ID 排序。details 仅白名单 `reason,purpose,part,kind,submitted,requestId,name,callId,inputTokens,outputTokens,cacheReadTokens,cacheWriteTokens,code`。
- `traceAvailable`、`note`。无 trace 历史 runs/outbox/timeline 为空，并明确缺失，不是“没有发生”。

### `GET /api/stickers?q=&limit=50&offset=0`

返回 `{enabled, items:[{id, caption, mime, bytes, imageUrl}], total, limit, offset, truncated, note}`。只扫描配置的本地表情库，沿用已有 StickerLibrary 的文件数量/大小、实际类型与路径/链接检查，不连接微信收藏、不修改资源。API不返回宿主绝对路径。

`GET /api/stickers/:id/image` 仅接受实际列出的 64 位图片 ID，并重新列出/检查当前文件，不接受文件名或任意 path。响应 PNG/JPEG/GIF/WebP 原始字节，GIF可以播放；前端列表使用静态首帧，预览才播放。文件改变后旧 ID 失效，应刷新列表。禁止 SVG/HTML、链接文件和目录穿越。没有独立缩略图服务。

## 安全与隐私

- 只监听 IPv4 loopback；校验准确端口的 Host（`127.0.0.1` 或 `localhost`）、Origin、Referer、Sec-Fetch-Site，不开启 CORS。拒绝跨站页面请求和 DNS rebinding Host；禁用嵌入与表单提交，严格同源 CSP。
- 静态资源仅 `/`、`index.html`、`app.js`、`styles.css` 白名单；不公开源码、DESIGN.md、配置、日志、数据库或目录列表。管理API无任意文件读取、停止进程、quiet、重发或发送端点。
- 数据库 `readOnly:true` 加 `PRAGMA query_only=ON`；业务迁移和租约不在管理进程执行。旧数据库无需新增 trace 表即可读取，缺失数据库只显示空状态，不创建。
- 响应只投影必要字段；常见 API key/Bearer/password/secret/cookie 形状做掩码。但**任意人写在聊天里的未知秘密无法可靠自动识别**，正文仍是私人数据。请只由可信本机操作者使用，勿截图外传。
- loopback 不是本机用户认证。本机其他程序/同机用户仍可能请求该服务；不要做端口转发、反向代理或公开共享。需要多用户或远程访问应先设计身份鉴权，不要移除 Host/Origin 校验。
- 所有聊天/模型/工具名称当不可信文本，前端用 textContent 展示，不解析 HTML；CSP提供额外防护。图片只允许既有校验后的栅格格式。

## 持久性、升级和限制

新版 Store 在取得正常消费者租约后添加 `trace_inbox`、`trace_sources`、`trace_outputs`、`trace_events` 和索引/状态触发器，不改原有表列序和发送状态机。输入/run/outbox状态变更同数据库事务写 trace；输出关联与 prepare 同事务提交。显式来源关联，不通过时间或同会话相邻匹配。触发器使用 SQL 原生毫秒时钟，无连接私有 UDF，其他写连接不会遇到 `no such function`。

仍须按原来单消费者规则升级，不并行运行新旧 bot。旧写程序即使可写状态也不会生成新代码的显式 run/output 关联，不能把混合写入视为完整 trace。推荐正常停旧实例，再由操作者启动新版；页面不会自动重启服务，只有明确点击按钮才操作。管理服务可以与任一版本的 bot 并行只读。

Trace跟随现有 SQLite 留存：已结算内容按 retentionDays 清理，未决/不确定链路保留用于核对。不能把 SQLite 留存理解为清理了独立 dsh 日志。开始埋点之前的历史不补伪 trace。模型 usage/tool为尽力记录；异常时不影响模型行为，崩溃可能留下 started 或缺失终点，不补假完成。HTTP读取和多条数据库查询不是跨表快照事务，轮询中可能短暂看到阶段正在落盘，下次会收敛。

不包含真实收件确认、token 流逐字显示、模型质量评价、后台摘要独立列表、任意媒体/附件预览、远程鉴权或任意写控制。后台 summary 不会被当作输入的聊天回复。未完成真实微信端到端或长稳验收，不能据此宣称实际送达或 7×24 稳定。

## 测试

```powershell
pnpm test
```

`tests/admin.test.ts` 使用临时合成SQLite和本机随机端口：精确来源/并发会话/多条出站关联、后台summary隔离、waiting/silent、增量游标、旧库只读字节不变、不创建缺失库、跨连接触发器、SQL分页搜索、unknown语义、HTML文本/密钥掩码/原始工具与推理排除、Host/Origin/Referer/Fetch-Site、POST拒绝、路径穿越和静态白名单、图片ID与实际MIME。`tests/dsh.test.ts` 使用固定真实dsh内核+模拟模型验证逐请求usage和工具开始/完成的持久观测，无真实模型网络。


## 开启与停止服务（2026-10-31）

根目录 `start-admin.cmd` / `start-admin.ps1` 以管理员身份运行管理服务。打开它只启动管理台；顶部显示机器人与桥接的实际状态，提供“开启服务”“停止服务”，操作中禁用两个按钮，防止重复点击。

- 开启：调用既有 `start-bot.ps1`，保留编译、配置检查、启动互斥、单消费者租约与就绪检查。日志位于 `agent/data/startup/admin-<时间>/startup.log` 及正式启动器生成的日志目录。
- 停止：先请求 bot 的正常退出，等待现有 Engine/host 清理和租约释放，再请求桥接正常关闭原生 workers 和事件存储。不会结束微信或管理台，不强制终止超时服务，不清除数据库锁。旧版本没有控制描述时明确失败，不能据任意 PID 杀进程。
- 停止请求绑定本次进程的随机 generation token 和 PID，文件仅位于本项目 `data/service-control`。过期文件不能结束下次启动的服务。描述文件在实际退出后删除；关闭管理台不停止 bot。
- `GET /api/services`：实时 agent/bridge 状态、operation、lastError，以及仅用于本次管理服务的防跨站 token；演示模式返回 `enabled:false`，不能控制生产服务。
- `POST /api/services/start`、`POST /api/services/stop`：仅接受同源 Origin、`Content-Type: application/json`、`X-Service-Token`及空对象`{}`；202表示操作已接纳，409表示已有操作进行中。拒绝路径、命令、PID等额外参数。token不写入URL。其他消息/图库接口仍拒绝POST。

本机其他受信程序仍可读取这个loopback管理服务，服务控制不是多用户认证。Host/Origin/Referer/Fetch-Site及随机token防止普通恶意网页发起控制；不要公开端口。构建和自动测试覆盖同源限制、token、参数拒绝、重复操作、失败传播、过期generation和替代进程保护。

### 今日额度重置与预算暂停

预算暂停表示进程已经启动、模型调用暂停，管理台显示“已启动 · 预算暂停”，启动入口返回成功，不再误报通用启动失败。机器人仍等到原定北京时间零点恢复，除非操作者手动重置。

顶部“重置今日可用额度”按钮只在每日预算不足时启用；使用同样的同源、随机token、空JSON和操作串行保护，调用POST /api/services/reset-budget。点击后把今天可用额度恢复为配置值（如5元），保留所有费用、预留和待核算请求，因而今日累计花费可能超过原每日上限。当天有效累计上限及重置次数会显示在本地服务预算详情中；重置记录以budget_reset_audit元数据持久保存，不清空账单。

重置不能修复未知价格或其他计费配置错误，正常未暂停时重复请求拒绝。有效额度只作用于当天，次日仍使用原dailyLimitCny配置。运行中的新版bot自动经过基线恢复，不补发预算暂停期间的消息；服务已停止时重置不会自行启动服务。模型没有额度重置工具权限，后台不会自动重置。未对本机真实预算执行测试重置。

验证：TypeScript构建及151项测试通过，覆盖保留费用与未核算金额、重复重置拒绝、跨日恢复、实时恢复不重放旧消息，以及管理API的同源/token/参数/并发限制。本机确认按钮可用且resetCount仍为0。
