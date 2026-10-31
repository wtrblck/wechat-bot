# wechat-bot

基于本机电脑版微信 4.1.15.56 的后台接口研究项目。目标是保留微信运行，通过本机接口收发消息，不使用鼠标、键盘、剪贴板或 UI Automation。

## 一键启动

先打开电脑版微信并登录，再双击项目根目录的 [start-bot.cmd](start-bot.cmd)。需要连接微信进程时会请求Windows管理员权限；脚本自动编译、校验配置、启动或复用桥接，确认收发就绪后启动bot，再等待bot自身上报就绪。已有运行实例时不会重复启动。成功后可关闭启动窗口，服务在后台继续运行；本入口不启动dsh Web。

PowerShell也可以执行 `./start-bot.ps1`；`./start-bot.ps1 -Check` 只编译和检查配置，不启动服务，`./start-bot.ps1 -Status` 只读查看状态。每次启动的日志保存至 `agent/data/startup/<时间>-<进程号>/`。失败时已启动组件会保留供诊断，重新执行会检查并复用；不会强行结束微信进程、清除锁或重发旧消息。并发启动有互斥锁，bot自身保留单消费者租约。

## 本地消息管理界面

双击根目录 [start-admin.cmd](start-admin.cmd)，编译后在 `http://127.0.0.1:8788` 提供本地消息管理台；保留启动窗口，Ctrl+C 只停止管理界面。也可执行 `./start-admin.ps1 -Port 8788`，或用 `-Check` 仅验证构建。仅打开管理台不会启动 bot；页面顶部的“开启服务 / 停止服务”按钮控制本项目 bot 与桥接，不结束微信或管理台。启动管理台会请求管理员权限以便控制后台服务；消息读取仍不获取消费者租约。

界面用于检索消息、查看接收/模型处理/工具调用摘要/最终回复/逐条发送状态及时间线，并浏览正式表情库。新链路记录需要更新后的 bot 在下次正常启动后写入；旧消息明确标为无完整追踪，不按时间猜测对应回复。`server_confirmed` 不是对方收到或已读，`unknown/needs_review` 不会被管理界面强制重发。管理端仅供本机使用，不要通过代理暴露到公网。详见 [管理界面说明](agent/ADMIN.md)。

本机已开启媒体下载和表情包下载；下载成功的PNG/JPEG/GIF/WebP表情可由bot图片工具读取，GIF按静态图片理解。

其他 agent 接续开发请先读 [完整交接与后续工作清单](E:/projects/wechat-bot/AGENT_HANDOFF.md)。

智能体端已新增 [agent/](agent/README.md)：TypeScript / dsh 插件，支持持久接入与发送、群内自主参与、逐会话隔离、分层记忆、提示词配置、受控渠道工具和按官方价格换算的单日费用上限。本机预算为 5 元/天、北京时间零点自动恢复；模型工作区限制在逐会话工具沙箱内，允许公网网页搜索与抓取。固定 dsh 0.2.1-rc.2；智能体 56 项、既有桥接此前 118 项测试通过。真实模型/微信联调和长稳尚未验收；图片理解、ASR 与 operator 工具仍待扩展。启动与能力边界见 [智能体使用说明](agent/README.md)。架构依据见 [智能体端设计](AGENT_ARCHITECTURE.md)。

设计支持群内无需 @ 的自主回复、每群/每联系人独立 session、[分层记忆](AGENT_MEMORY_RESEARCH.md)，以及按会话配置的[系统/人格等提示词](AGENT_PROMPTS.md)。

**P5/P6/P7 最新（2026-10-29）：** 收发已整合为一个常驻服务 [`bridge_service.py`](weixin-research/bridge_service.py)：单进程、单令牌、常驻 Frida 发送/下载 worker、有界发送队列、SQLite 请求状态与事件池、进程/worker/轮询监控和自动重连。请求状态区分 `local_accepted` / `message_recorded` / `server_confirmed` / `failed` / `unknown`，`delivery_verified` 永远为 false（只有人工手机台账能声称对方收到）。文本、图片、文件、MP4、语音、收藏表情仍受显式收件人白名单约束；媒体输入支持配置目录、PNG/JPEG/GIF/WebP → PNG、任意 WAV/SILK/MP3 → 16 kHz 单声道、可选 AVI/其他视频 → MP4。**按用户要求未做 10 分钟/1 小时长稳验收。** 详见 [常驻桥接服务说明](weixin-research/BRIDGE_SERVICE.md)、[P5 结果](weixin-research/P5_TEST_RESULTS.json)、[P6 结果](weixin-research/P6_TEST_RESULTS.json)、[P7 结果](weixin-research/P7_TEST_RESULTS.json)。

**P4 媒体接收：** 后台下载已接入，联系人和群各四类入站正文共 8 项均通过鉴权 HTTP 验收；普通图片支持 wxgf/HEVC 转 PNG，视频通过大小/MD5 和全程解码；高清原图独立下载仍未验收。详见 [媒体接收说明](weixin-research/RECEIVE_MEDIA.md)。

**表情接口已补齐：** 静态表情及动态 GIF 的接收正文已通过 HTTP 验收，GIF 保留全部 22 帧；收藏列表、预览和原生表情发送已接入，原测试联系人/群均确认收到且显示正常。见 [表情 API 说明](weixin-research/EMOJI_API.md) 和 [验证记录](weixin-research/EMOJI_TEST_RESULTS.json)。

**历史能力：** 文件传输助手、一个普通联系人和一个群各完成文本 + 图片 + 文件 + MP4 视频 + 原生语音五类发送；任意 UTF-8 文本（中文、Emoji、多行，默认上限 4096 字节）；无钩子本地数据库读取联系人/群入站文本与四类媒体。接收探针路径曾伴随三次未定因微信退出，已改用数据库路径；常驻服务的长期稳定性仍未验收。

最新结果见 [实机测试记录](weixin-research/LIVE_TEST_RESULTS.json)。原 JavaScript 回调在实机测试中伴随微信退出，现默认使用原生回调。原生回调已完成多轮 45～60 秒收发观察，结束后微信仍在运行，退出原因尚未最终定位。

旧的短时发送实验仍见 [发送 API 说明](weixin-research/SEND_API.md) 和 [主动发送实机记录](weixin-research/ACTIVE_TEST_RESULTS.json)：`send_api.py` 默认 17868、60 秒关闭，支持 `/send/text|image|file|video|voice`；返回的 `accepted` 与手机实际收件分开记录。原生视频使用 MP4，AVI 可作为文件附件发送。原生语音支持 16 kHz 单声道 PCM WAV 自动编码为 SILK，以及已校验的 Tencent SILK。文本按 UTF-8 传输，中文、Emoji 与多行均可；默认策略只允许 `filehelper`，其他测试目标需用 `WECHAT_BOT_RECIPIENTS` 显式加入。**机器人接入请使用下面的常驻服务，而不是这个短时接口。**

## 常驻桥接服务（P5/P6/P7）

```powershell
# 校验 ABI profile 与配置，不监听
py -3.14 weixin-research/bridge_service.py --check

# 常驻运行（自动寻找加载 Weixin.dll 的主进程）
py -3.14 weixin-research/bridge_service.py --download --emoji

# 客户端读取 runs/bridge/session.json 里的 URL/token
```

- 一个进程、一个本机 HTTP 服务（默认 `127.0.0.1:17870`，可 `--port 0` 用随机端口）、一个 Bearer 令牌；接收与发送不再分别启动。
- 发送 worker 只 attach 一次、脚本常驻；每条消息复用原生 job 块。媒体下载 worker 同样常驻，`download_worker.c` 把 local_id/server_id/type 放进 job，不再每条重编译。
- `POST /send/*` 进入有界队列；`wait=false` 立即返回 202，`GET /request/{id}` 查状态；`GET /events?after=N` 读入站；`GET /media/{id}` 取媒体。
- 请求状态：`local_accepted` → `message_recorded` → `server_confirmed`，或 `failed`/`unknown`；超时和断线只到 `unknown`，**不自动重发**。同一 `request_id` 跨重启返回同一结果。
- 事件先入 1024 条内存窗口，再写 SQLite 事件池（默认 7 天/5 万条）；旧游标可续读，超出窗口返回 `truncated:true`。
- 媒体输入默认只允许 `fixtures/`，用 `WECHAT_BOT_MEDIA_ROOTS` 显式扩大；JPEG/GIF/WebP 转 PNG，WAV/SILK/MP3 统一为 16 kHz 单声道，MP4 直发，其他视频需 `WECHAT_BOT_VIDEO_CONVERT=1`。
- 监督线程监测微信进程、worker 和接收轮询；微信重启时重建运行时，无法安全卸载的原生回调会让服务进入 `blocked`，要求人工重启而不是冒险释放内存。
- **本轮未做 10 分钟/1 小时长稳验收**，因此不要声称已可 7×24 运行。

完整接口、状态机、错误码和安全边界见 [BRIDGE_SERVICE.md](weixin-research/BRIDGE_SERVICE.md)。

## 本轮新增

- 定位并核对微信窄字符串赋值（`0x1F9AD0`，增长函数 `0x03E150`），文本与收件人改由微信复制后逐字节校验；删除只支持 15 字节内联写入的限制。
- 新增 `policy.py` 统一收件人白名单与正文/正文长度/媒体大小上限；`recipient` 从 HTTP 贯通到原生对象 `+0xB0`。
- 新增 `post_send.py`，按 UTF-8 提交请求，避免控制台代码页影响中文。
- 38 项自动化测试、13 项自建进程真实 Frida 集成测试（含 15/16 字节边界、中文、非 BMP、2100 字节长文本、长收件人）通过。
- 实机验证 87 字节中文与 467 字节多行文本，手机确认收到。

- 无 Hook 基线与单观察点两种模式；默认只生成脚本，显式 `--observe` 才附加。
- 将 DLL SHA256 固定到已分析版本，检查 PE 函数入口、磁盘文件、实际加载路径与内存入口字节。
- 使用 Windows 查询实际进程路径，避免依赖 Frida 主模块枚举顺序。
- 每个事件即时保存为 JSONL，单次运行使用独立文件；保存脱离原因、可用的崩溃报告和最终状态。
- 目标端定时移除观察器；主机记录异常并清理会话。目标进程退出、脚本错误或清理失败均返回失败状态。
- 自建测试程序验证 Frida 调用计数、到时结束、代码字节还原及异常路径。
- 只读预检工具与 6 组静态布局证据，38 个指令片段逐一匹配原 DLL。
- 原生计数与受限消息解析、退出码采集、本机 HTTP 接收实验接口。
- 原生线程上的单次主动发送、文本/图片/文件/MP4 视频工厂、结果引用清理、鉴权 HTTP 发送接口及请求 ID 去重。

## 无钩子接收（本地消息数据库）

接收方向不再依赖 Frida 钩子：`wechat_db.py` 与 `db_receive.py` 通过本机微信 4.x 的 SQLCipher 数据库读取消息。读取器 vendored 自 Apache-2.0 的 wechatauto-replica（见 [vendor/wechatauto](weixin-research/vendor/wechatauto/)），只做只读操作：按页解密到 `runs/db-cache`，密钥缓存在 `keys.json`，缺失时从微信进程内存只读扫描，不安装任何钩子。

```powershell
$env:WECHAT_DB_DIR = 'E:\xwechat_files'
$env:WECHAT_BOT_SELF = 'wxid_yourself'
$env:WECHAT_BOT_OBSERVE = 'wxid_contact,123@chatroom'
py -3.14 weixin-research/db_receive.py --serve --seconds 60 --conversation wxid_contact --conversation 123@chatroom
```

- 发送者用消息库自带的 `Name2Id` 解析（上游用 `message_resource.SenderName2Id` 在本机会解析错）；群正文会去掉 `wxid_member:\n` 前缀并据此确定发言人。
- 事件 schema 为 `wechat-db-1`，`/health`、`/events?after=N` 与令牌校验和探针服务一致；`--tail N` 只打印最近消息，不启服务。
- 要求微信**已登录**：密钥存在于进程内存，数据库只反映已登录会话；未登录时服务能启动但读不到新消息。
- 消息内容用 Python 3.14 自带的 `compression.zstd` 有界解压；`media_0.db` 已有可用密钥。
- `--media` 启用四类媒体与鉴权读取；加 `--download --pid PID` 可自动下载缺失的入站普通图片/视频。只处理观察策略允许的会话，串行去重、最多两次尝试，正文实际校验通过才 ready；文件/语音读取微信已落地内容。启动方法、解码依赖和缓存契约见 [媒体接收说明](weixin-research/RECEIVE_MEDIA.md)。

## 接收 API 实验

默认只发布正文以 `wxbot-` 开头、涉及 `filehelper` 的消息。已完成一次真实的“手机发送 → 桌面同步回调 → HTTP GET /events”验证，测试文本为 `wxbot-api-1028`。

观察范围现在是显式策略，原生过滤和 HTTP 事件存储共用同一份配置：

```powershell
# 默认等价于 filehelper + wxbot- 前缀；加入测试联系人/群 ID 时才观察更多会话
$env:WECHAT_BOT_OBSERVE = 'filehelper,wxid_example_contact'
# 空前缀会发布所有正文，必须明确设置
$env:WECHAT_BOT_OBSERVE_PREFIX = ''
# 前缀匹配或包含匹配（群正文可能带发送者前缀时用 contains）
$env:WECHAT_BOT_OBSERVE_MODE = 'prefix'
# 本人账号的 wxid；配置后事件才会带 outgoing/incoming 方向
$env:WECHAT_BOT_SELF = 'wxid_yourself'
```

事件现在带 `conversation_id`、`sender_id`、`recipient_id`、`direction`。方向只按已配置的本人 ID 判定，未配置时保持 `unknown`，不做猜测。需要跨重启保持游标与去重时加 `--state-file weixin-research/runs/api/state.json`：游标和去重窗口会恢复，但事件本身不持久化，用旧游标读取会返回 `truncated:true`。

这验证的是本人手机消息的同步回流，尚未验证普通联系人、群聊、历史消息区分或长期运行。**2026-10-29 的三次微信退出都发生在对接收路径安装 Frida 钩子期间**（详见 [REPORT.md](weixin-research/REPORT.md) 末节），因此在用户唯一的微信会话上不再对接收路径挂钩；入站接收需要隔离环境或改为不挂钩子的验证方式。原生记录区现为 64 槽环形缓冲，正文 4096 字节；超出部分计入 `capture.dropped`，过滤掉的计入 `capture.filtered`。事件存储的去重窗口固定为 4096 条键（有界），`/health` 与 `GET /events` 返回 `counters`（收到、发布、重复、按前缀/目标/结构过滤、无效 ID、缓冲区淘汰）。

```powershell
# PID 必须通过 doctor.py 确认；服务和观察器均在 60 秒后关闭
py -3.14 weixin-research/receive_api.py --pid PID --seconds 60

# 在另一个 PowerShell 窗口读取本次会话信息
$sessionInfo = Get-Content .\weixin-research\runs\api\api-session.json -Raw | ConvertFrom-Json
$requestHeaders = @{ Authorization = "Bearer $($sessionInfo.token)" }
Invoke-RestMethod "$($sessionInfo.url)/health" -Headers $requestHeaders
Invoke-RestMethod "$($sessionInfo.url)/events?after=0" -Headers $requestHeaders
```

服务只绑定 `127.0.0.1`，要求本次会话令牌。`GET /events?after=N` 返回消息、后续游标、缓冲区缺口标记和计数，按消息 ID 与收发方去重。`POST /send` 返回 501 和 `send_not_implemented`，不会假装发送成功。`--expect wxbot-api-1028` 可验证指定正文是否经过真实 HTTP 路由返回；未到达时命令返回失败。

等待输出 `started` 后再从手机发送验证消息。测试结束记录保存在 `weixin-research/runs/api/last-api-result.json`，会话令牌文件随服务关闭删除。

## 使用

以下命令在项目根目录的 PowerShell 中执行。本机 `python` 指向 Python 3.8，动态测试请使用已安装的 `py -3.14`。Frida 17.24.3 依赖位于 `weixin-research/deps`。

```powershell
# 只读检查磁盘版本和全部候选函数入口，不附加进程
py -3.14 weixin-research/doctor.py

# 生成无 Hook 基线脚本，不附加进程
py -3.14 weixin-research/probe.py --baseline --prepare-only

# 生成单观察点脚本，不附加进程
py -3.14 weixin-research/probe.py --site sync_database_candidate --prepare-only

# 复核静态布局证据，不加载 DLL
py -3.14 weixin-research/verify_layout.py

# 自动化测试（118 项），不操作微信
py -3.14 -m unittest discover -s weixin-research/tests -p 'test_*.py' -v

# 自建进程上的真实 Frida 集成测试，需要 PATH 中的 gcc
py -3.14 weixin-research/tests/integration_probe.py
py -3.14 weixin-research/tests/integration_active.py
py -3.14 weixin-research/tests/integration_emoji.py
py -3.14 weixin-research/tests/integration_download_async.py
py -3.14 weixin-research/tests/integration_send_worker.py
py -3.14 weixin-research/tests/integration_download_worker.py

# 常驻服务：只校验配置（不监听、不附加）
py -3.14 weixin-research/bridge_service.py --check

# 常驻服务：先用 doctor.py 核对 PID，再启动
py -3.14 weixin-research/bridge_service.py --pid PID --download

# 旧短时发送服务：向已 --serve 的实例提交一条 UTF-8 文本
py -3.14 weixin-research/post_send.py --kind text --recipient filehelper --text-file msg.txt
```

### 微信进程诊断

`Get-Process Weixin` 可以列出进程 ID，但多个同名进程中只有主进程加载核心 DLL。对选定 PID 执行 `doctor.py --pid PID`，通过 `process_modules` 检查确认。进程 ID 会变化，不能使用报告中的旧值。

在可恢复的隔离测试环境中，先运行 `probe.py --observe --pid PID --baseline --seconds 10`，基线通过后再用 `--site` 逐一观察。不能同时选择多个点。基线也会加载 Frida 运行时，并不等同于纯只读检查。

某些运行权限下可能无法查询微信模块；预检会报告访问被拒绝。这不代表版本不匹配，也不应通过跳过校验继续。

### 输出

- `weixin-research/runs/*.jsonl`：逐事件记录，含 UTC 时间与单调计时。
- 同名 `.json`：运行结果和完整事件，`completed` 仅代表该次诊断正常完成。
- `weixin-research/runs/fixture/integration-results.json`：独立进程测试结果。
- `weixin-research/layout-evidence.json`：可重复复核的静态证据。
- 原 `runtime-probe.json`：保留此前微信退出的记录，不被新运行覆盖。

调用次数不是消息数；测试程序正常不代表微信稳定。任何预检的 `observation_ready` 只表示进程与版本满足观察前提，`send_ready` / `receive_ready` 仍为 false。

## 后续开发

1. 在常驻服务下回归新的联系人和群，核对请求状态、`server_id`、`/events` 与媒体 ID。
2. 高清原图独立下载、历史/实时/重连补发的显式区分。
3. 长稳验收（10 分钟 → 1 小时 → 更长）；本轮按用户要求未做，不得声称已通过。
4. 新版本微信：新建 `versions/<版本>.json` 并重新核对全部 RVA/入口字节。

详细记录见 [研究报告](weixin-research/REPORT.md)、[布局记录](weixin-research/LAYOUT.md) 和 [常驻桥接说明](weixin-research/BRIDGE_SERVICE.md)。


