# wechat-bot 开发交接与后续工作清单

**2026-10-30 图片/文本附件接入：** 用户要求已实现：鉴权桥接获取原始字节并核对大小/SHA256，复制到逐会话sandbox/media的真实类型扩展名文件，消息上下文保存相对path和资源描述，跨轮继续引用。新增prepare_attachment/read_text_file/read_image；图片复用官方dsh-attachment-local完整解码、持久化，并以ImageBlock进入支持图片的模型。文本支持UTF-8/BOM UTF-16/GB18030、分页，不再仅内联提取TXT/MD。Flash图片预算按官方上限1024输入token/图预留、真实usage结算，5元/日不变；默认6次图片读取/轮，10MiB/单项、缓存256MiB/24小时。图片价格来源https://api-docs.deepseek.com/guides/vision/，非Flash未核对图片价格不放行。media本机和示例配置true，桥接本地配置media/download true，授权范围未扩展。77项测试通过，包含真实dsh内核+真实附件后端的图片工具往返和计费、真实本机HTTP媒体拉取、跨域/篡改/过期拒绝及退出取消。未调用真实付费模型、未发微信。细节agent/MEDIA_V2.md。**bot、桥接和Web仍保持关闭；真实媒体识别效果待显式启动后验收。**

**2026-10-30 上下文/记忆 v2：** 用户已要求并完成代码改造：固定提示词独立额度；连续最近200条（含bot出站与微信回流去重）；独立会话按10分钟/100条、静默3分钟（至少10条）、低活跃30分钟整理分段摘要，150条积压优先；摘要通常400～700字，上限1000字，topics/entities/states/aliases四类标签。模型通过memory_search→memory_read→history_read按需检索，摘要不自动注入；最多12段、原文4批×20条、工具累计15秒、8000估算token与32KiB硬上限。原memory_units保留，启动时增量重建chat_history，不自动重放消息。文件和细节见agent/MEMORY_V2.md。67项测试通过，含真实固定版本dsh的三种记忆工具往返；上次真实数据只读快照回放重建84条（27条bot）、无重复无裁剪，旧断句配对均进入新上下文。回放未调用真实模型，未发微信，未改业务库。**bot、桥接和Web按用户要求保持关闭，不要自动启动。** 新摘要质量仍需真实群聊验收。

更新日期：2026-10-29，Asia/Shanghai。工作目录：`E:/projects/wechat-bot`。

**新增工作区限制与网页工具（2026-10-29）：** 用户要求 agent 工作区限制在沙箱内，允许 fetch/search。模型 cwd、文本文件、媒体缓存和产物统一使用 `agent/data/sandbox/<scope>/`；可信文件工具拒绝穿越、Windows 别名/ADS、junction、符号及硬链接，宿主 shell/任意文件工具仍不可调用。这是工具能力围栏，不是 OS 容器；宿主配置、凭据、账本和桥接仍由可信代码访问。主回复开放 `workspace_list/read/write` 与 `web_fetch/search`，决策/记忆无工具。网页只读公网、每跳 DNS 验证及地址固定，禁止内网/本机；本机 fake-IP DNS 通过固定 TLS AliDNS 解析获取真实公网地址，未放行虚拟地址访问。搜索使用免密钥 Bing RSS 入口，有界文本和不可信资料标记。真实只读 fetch example.com HTTP 200、search 返回 5 条来源；没有付费模型调用或微信发送。当前 **56 项测试通过**；本机配置已启用，重启 agent 生效。新增依赖 ipaddr.js / turndown 已锁定。旧 workspaces/data/artifacts/data/media 不再作为模型工作区，旧产物需操作者处理，附件交付根改为 data/sandbox（本机原本未启用附件发送）。

**新增单日预算（2026-10-29）：** 用户选择 **5 元/天、北京时间零点自动恢复**，已写入 `agent/config/agent.local.yaml`。`agent/src/budget/` 保存官方 CNY 价格、按请求预留/usage 结算、SQLite 日账本和到限停服；`pnpm budget` 只读查询可与服务并行。核对的 DeepSeek 官方价见 `agent/config/pricing.deepseek.2026-10-29.json`，覆盖 Flash/V4 Pro 的峰谷价、缓存价及 2026 假日日历，默认 30 天后要求复核；未定价或缺失 usage 不视为免费。预算范围限本插件调用，SDK 实际请求（含重试）均计入；账本重启不清零，跨零点按发起日归属。预算不足以预留时会提前停止，零点恢复先跳过积压，不重新发送旧答案。新增后智能体 **47 项测试通过**（包含真实 dsh + 模拟模型的用量、拒绝调用与重试）；本轮未调用付费模型或向微信发送消息。完整语义见 `agent/README.md`。

**智能体首版已新增（2026-10-29）：** `agent/` 为 TypeScript dsh 渠道插件，依赖锁定至 dsh 0.2.1-rc.2 / Cordis 4.0.5。持久 Inbox/Outbox、首次基线与缺口暂停、独立群/联系人 session、群自主参与、提示词继承与快照、来源记忆、受控渠道工具、txt/md 媒体读取均已实现。32 项智能体测试和原有 118 项桥接测试通过；真实 dsh 内核用模拟模型验证冷恢复与取消，真实 HTTP 模拟桥接验证令牌轮换和丢响应对账，官方 profile 完成短时装载。未使用真实模型凭据、未向真实联系人发送、未做长稳。视觉/ASR、复杂文件、operator 与提醒仍待扩展。启动及限制见 [agent/README.md](agent/README.md)。特别注意桥接持久事件读取一页最多 500 条，但 cursor 可指向全局末尾；插件只提交本页实际最后序号，避免跳过补读尾部。

本文用于接续开发；它记录当前证据、实现边界和后续任务。**P5、P6、P7 的代码与短时验收已完成（2026-10-29）：新增常驻统一服务 `bridge_service.py`、常驻发送/下载 worker、SQLite 请求状态与事件池、消息 ID 关联、通用媒体输入和版本 profile。按用户明确要求，未做 10 分钟/1 小时长稳验收，因此不得声称 7×24 稳定。** P0 通用字符串与目标参数、P4 媒体接收、表情接口已有独立证据，不应从头重做。

**表情接口也已补齐（2026-10-29）：** 动态 GIF 经接收 HTTP 完整读取，240×240、22 帧、1980 ms，MD5/SHA256 与全部帧解码通过；当前账号收藏列表、预览与原生表情发送已接入。收藏表情分别发到原测试联系人和群，用户确认“两边都收到，显示正常”。详见 `weixin-research/EMOJI_API.md` 和 `EMOJI_TEST_RESULTS.json`。

**P5/P6/P7 本轮结果：** `bridge_service.py` 把接收、发送、媒体、事件读取合并为一个常驻本机服务；发送/下载各自一个常驻 Frida 会话（fixture 单会话 8 条发送、3 条下载）；请求状态机区分 `local_accepted`/`message_recorded`/`server_confirmed`/`failed`/`unknown`，同一 `request_id` 跨重启幂等；真实 filehelper 文本发送落到 `message_id=filehelper:34`、非零 `server_id`。详见 `BRIDGE_SERVICE.md`、`P5_TEST_RESULTS.json`、`P6_TEST_RESULTS.json`、`P7_TEST_RESULTS.json`。长稳验收被明确排除。

## 1. 接手目标与真实完成度

用户希望保留电脑版微信运行，通过后台 API 收发消息，不依赖鼠标、键盘、剪贴板或 UI Automation。最终目标是支持普通联系人及群聊的通用收发接口和常驻机器人服务。

**当前是“可短时运行的完整桥接原型”：收发、媒体、状态跟踪、幂等和单进程常驻服务已打通；未做长稳验收。** 不要从头重做已验证的发送/接收；也不要仅删除白名单就宣称支持普通联系人和群聊：白名单由 `policy.py` 统一管理，扩展目标必须显式配置。

| 功能 | 已验证内容 | 仍缺少内容 |
|---|---|---|
| 文本发送 | 文件传输助手：ASCII、87 字节中文、467 字节多行 UTF-8；普通联系人与群各一条，手机确认收到；常驻 worker 真实 filehelper 发送得到 `server_confirmed` | 微信侧文本长度上限；常驻服务下外部联系人/群未回归 |
| 图片发送 | 生成的 PNG，实际手机收到；常驻 worker 图片得到本地 ID；JPEG/GIF/WebP 转 PNG 已实现 | 转换后图片无设备收件证据；超大图/高清原图边界 |
| 文件发送 | TXT、WAV、AVI 附件，实际手机收到；任意配置目录文件已支持 | 大文件/异常文件类型的设备边界 |
| 视频发送 | H.264 MP4 原生视频，手机收到且可播放；AVI/其他容器可选 ffmpeg 转 MP4 | 转换后视频无设备收件证据 |
| 语音发送 | 原生类型 34；16 kHz 单声道 WAV 自动转 SILK；1 秒语音收到且可播放；WAV/SILK/MP3 输入归一化 | 更多极端采样率/声道组合的设备边界 |
| 收藏表情发送 | 当前账号收藏列表、鉴权预览、`/send/emoji`；类型 47，原测试联系人/群均确认收到并正常显示 | 当前收藏仅一个静态 PNG，动态收藏发送尚无实机样本；商店表情包目录 |
| 文本接收 | **无钩子本地数据库读取已验证端到端**：4 条入站标记经 `/events` 读到，联系人与群的方向/会话/发言人正确；常驻服务从当前水位开始并持久化事件池 | 历史同步/实时/重连补发的显式区分；常驻服务下外部联系人/群未回归 |
| 媒体接收 | 数据库解析四类元数据；原生异步后台下载普通图片/视频；指定联系人/群各四类入站正文经鉴权 HTTP 验收通过；常驻下载 worker 已接入 | 高清原图独立下载未验收；缺失的附件/语音仍等待微信落盘；长稳未验收 |
| 表情接收 | 类型 47 元数据白名单、完整 GIF/PNG/JPEG 正文鉴权读取；测试群动图 22 帧完整验收 | 本地 Emoticon 特殊缓存编码未解开，当前按精确消息资源取回；其他 CDN 主机需逐项验证 |
| 常驻 HTTP 服务 | `bridge_service.py`：单进程、单令牌、有界发送队列、常驻发送/下载 worker、事件池、请求状态、进程/worker/轮询监控与重连 | 未做 10 分钟/1 小时长稳；外部联系人和群在常驻服务下未回归 |
| 发送状态跟踪 | SQLite 请求状态机；本地消息库关联 `local_id`/`server_id`；失败/超时/重启分别落到 `failed`/`unknown`；`delivery_verified` 恒 false | 目标实际收件仍只能靠人工台账；媒体 `server_id` 可能晚于确认窗口 |
| 媒体发送输入 | 可配置目录；PNG/JPEG/GIF/WebP → PNG；WAV/SILK/MP3 → 16 kHz 单声道；可选其他视频 → MP4；大小/路径/文件名/并发修改校验 | 设备侧只验证过 PNG/MP4/SILK 原生路径；转换后的媒体未做实机收件 |
| 版本 profile | `versions/4.1.15.56.json` 固定 DLL/SHA/全部 RVA；未知或不匹配拒绝附加 | 新版本仍需重新逆向与逐项验证，禁止套用旧偏移 |

现有实机测试对象由用户明确选择：文件传输助手 `filehelper`、一个普通联系人、一个群。个人标识保存在 `runs/targets.local.json`（`runs/` 不进入版本控制）。收件人是从 HTTP 到原生 `+0xB0` 的显式参数，默认策略只允许 `filehelper`；其他目标必须通过 `WECHAT_BOT_RECIPIENTS` 显式加入。继续只读检查、修改代码、独立程序测试不需要重新确认；发送给其他人或群之前，需要用户提供具体测试目标并明确测试范围，不能自行挑选聊天对象。

## 2. 先读的文件

| 文件 | 内容 |
|---|---|
| [README.md](E:/projects/wechat-bot/README.md) | 当前状态、启动方式和依赖 |
| [BRIDGE_SERVICE.md](E:/projects/wechat-bot/weixin-research/BRIDGE_SERVICE.md) | **常驻服务入口、HTTP 契约、状态机、错误码、媒体输入和恢复语义** |
| [P5_TEST_RESULTS.json](E:/projects/wechat-bot/weixin-research/P5_TEST_RESULTS.json) | 请求状态、消息 ID、幂等与超时证据 |
| [P6_TEST_RESULTS.json](E:/projects/wechat-bot/weixin-research/P6_TEST_RESULTS.json) | 常驻服务、持久 worker、事件池与恢复证据（含“未做长稳”） |
| [P7_TEST_RESULTS.json](E:/projects/wechat-bot/weixin-research/P7_TEST_RESULTS.json) | 媒体输入、转换、版本 profile 与错误边界 |
| [versions/4.1.15.56.json](E:/projects/wechat-bot/weixin-research/versions/4.1.15.56.json) | 唯一允许的 ABI profile；RVA 只对固定 SHA256 有效 |
| [SEND_API.md](E:/projects/wechat-bot/weixin-research/SEND_API.md) | 旧的短时五类发送 API、RVA、ABI 和限制 |
| [REPORT.md](E:/projects/wechat-bot/weixin-research/REPORT.md) | 研究和实机试验历史；以开头及最后的语音章节为最新状态 |
| [LAYOUT.md](E:/projects/wechat-bot/weixin-research/LAYOUT.md) | 消息容器与对象布局证据 |
| [ACTIVE_TEST_RESULTS.json](E:/projects/wechat-bot/weixin-research/ACTIVE_TEST_RESULTS.json) | 主动发送逐次结果，区分本地成功与手机收件 |
| [delivery-confirmations.json](E:/projects/wechat-bot/weixin-research/delivery-confirmations.json) | 用户实际手机收件/播放确认 |
| [LIVE_TEST_RESULTS.json](E:/projects/wechat-bot/weixin-research/LIVE_TEST_RESULTS.json) | 较早的观察器及 HTTP 接收验证 |

历史报告中存在“尚未实现主动发送”“尚未支持语音”等阶段性描述，已经在后续章节更新。不要把旧结论覆盖到当前实现上，也不要删除旧失败证据。

## 3. 本机环境和已知运行约束

- Windows / PowerShell。动态工具使用 **`py -3.14`**；默认 `python` 曾指向 3.8，不适用于本项目的 Frida。
- Frida **17.24.3** 位于 `E:/projects/wechat-bot/weixin-research/deps`，由代码加入导入路径；脚本使用 QJS。
- PATH 中可用 `gcc`、`g++`、`objdump`，来自本机 MSYS2；独立测试程序用它们构建。
- 检查时目录**不是 Git 仓库**，没有发现 `AGENTS.md`。不要假设存在可回滚的提交或远程分支；大改前保留当前可用代码与证据。
- 微信入口：`E:/Tencent/Weixin/Weixin.exe`。
- 核心 DLL：`E:/Tencent/Weixin/4.1.15.56/Weixin.dll`，x64。
- 核心 SHA256：`e0428a7b691853de496532523c2c09aa095f90941c37c9f4cfb3f137f3c66556`。
- 语音编码 DLL：同目录 `VoipEngine.dll`；SHA256：`ec7cfdbc32842111be3287753832559c0403a79a3042a3a9ae57dd3908bc225c`。
- 最近核对过的主进程 PID 依次为 45820（10-28 会话，已退出）、49888（10-29 00:30 崩溃后自动重启，已退出）、**44640**（10-29 00:37 由脚本重新启动）。PID 只是线索，接手时必须用 `doctor.py --pid` 重新核对。多个 `Weixin.exe` 进程不都加载核心 DLL，不要随意结束其他实例。
- 测试目标的个人标识（自身 wxid、联系人 wxid、群显示名与待解析状态）保存在 `runs/targets.local.json`；`runs/` 不进入版本控制，不要把这些值写进受跟踪文档。
- 短时发送服务关闭后会删除令牌；新的常驻服务把令牌保存在 `runs/bridge/token`、会话文件 `runs/bridge/session.json`、日志 `runs/bridge/bridge.jsonl`。不要假设旧端口（17867/17868/17869）正在监听。
- 常驻服务对同一个 `0x4A1FD0` checkpoint 安装发送与下载两个拦截器；Frida 会改写该入口，因此 worker 的**入口字节校验跳过 checkpoint 本身**，其余函数仍逐个校验，DLL SHA256/profile 在附加前固定。不要因为看到 checkpoint 前的 `E9` 跳转就判定被篡改。
- 原生任务仍在回调中时，无法安全卸载 CModule。`WorkerSession.close()` 会拒绝并返回 false，服务进入 `blocked`；此时不要反复重建/卸载，需重启服务进程。
- 常驻服务首次启动默认从当前消息末尾开始（`WECHAT_BOT_HISTORY=0`），避免把全部历史灌给 bot；重启则从已保存水位继续补投停机期间消息。
- 事件池默认 7 天/5 万条；超出后的旧游标返回 `truncated:true`。不要把它当作无损永久消息归档。
- 某些进程查询/附加需要本机执行权限提升；不要因访问被拒绝而跳过指纹校验。
- **2026-10-29 00:30、00:33、01:18 三次真实微信退出都发生在对接收路径安装 Interceptor 钩子期间**（`0x2EBB760` 两次、`0x38E9F80` 一次），Frida 报 `process-terminated`，Windows 应用日志无崩溃记录、无 dump；发送路径同一时段稳定。原因仍未确认，不能归因于反调试，也**不能继续在用户唯一的微信会话上钩接收路径**。接收方向（P1 入站、P4 媒体接收、P2 成员身份）需要隔离环境，或改为不挂钩子的静态+夹具验证。微信每次自动重启，新主进程 PID 需重新用 `doctor.py` 核对。
- 入站路径已定位到 `0x38E9F80` 的 0x2E8 数据库记录容器（`probe_sites.py` 计数证据）；`0x2EBB760` 只承载多端同步（本人手机发出），不承载对端入站；文本工厂 `0x709160` 不参与入站。字段布局仍未解析。
- **无钩子接收已实现**：`wechat_db.py`/`db_receive.py` 直接读微信 4.x 本地 SQLCipher 库，不加载 Frida、不装钩子；真实库试读已确认联系人/群入站消息与发送者、方向正确。要求微信处于**已登录**状态。P4 已确认 `message\media_0.db` 有可用密钥；消息内容改用 Python 3.14 的 `compression.zstd` 有界解压。新增 `media_receive.py`，详见 `RECEIVE_MEDIA.md`。
- 2026-10-29 起接收侧使用环形缓冲（64 槽 × 4640 字节），事件 schema 为 `wechat-sync-ring-1` / `wechat-send-ring-1`，并带 `ring_index` 与 `capture` 诊断计数；旧 schema 仍可在 `EventStore` 中回放。

`Process.mainModule` 在本机 Frida 环境中曾错误指向 KERNEL32。现有代码通过 OS 查询进程路径、按模块名查找 DLL；不要恢复依赖模块枚举顺序的实现。

## 4. 现有代码入口和数据流

### 4.1 主动发送

`E:/projects/wechat-bot/weixin-research/send_api.py`
→ `active_send.py:config_for`
→ `probe.py:run_probe`
→ `active_send.js`
→ `app_thread_send.c`
→ 微信原生工厂及共用发送入口。

具体文件均在 `E:/projects/wechat-bot/weixin-research/`：

| 文件 | 职责 |
|---|---|
| `active_send.py` | 准备配置、版本/入口检查、测试文件校验、语音预处理；默认不附加，`--execute` 才调用 |
| `policy.py` | 发送策略：收件人白名单、UTF-8 文本/收件人/正文/媒体上限、`PolicyError` |
| `post_send.py` | 读取服务会话文件，按 UTF-8 提交一条请求，不受控制台代码页影响 |
| `active_send.js` | 校验内存入口字节、创建 CModule、借用输入内存、安装一次性原生检查点、轮询结果 |
| `app_thread_send.c` | 微信任务线程上的一次原生调用、消息构造、引用转移和清理 |
| `active_send.c` | 已核对的智能指针释放逻辑 |
| `send_api.py` | 本机 HTTP 发送服务，五类 `/send/*` 路由 |
| `voice_codec.py` | 独立子进程中的 SILK 编码/解码、音频格式和时长验证 |
| `profile.py` / `pe_image.py` | 版本、RVA、PE 边界、函数入口和指纹验证 |
| `probe.py` / `probe.js` | 附加、脚本生命周期、事件日志、观察器基础设施 |
| `process_watch.py` | 查询进程存活/退出状态 |

当前发送服务绑定 `127.0.0.1:17868`，默认 60 秒关闭，每轮最多 4 次实际发送。请求 ID 在**当前服务进程内**防重复；忙碌请求返回 409，没有通用任务队列。每次发送重新创建一段约 15 秒的探针会话，不能当作常驻服务架构。

`POST /send/text` 必填 `request_id`、`recipient`、`text`；其他路由使用 `request_id`、`recipient`、`path`。文本按 UTF-8 传输，上限 4096 字节，允许中文、Emoji、多行，拒绝 NUL 与除 TAB/LF 外的控制字符；收件人上限 128 字节且必须出现在策略白名单中，否则 403 `recipient_not_allowed`。`/send/voice` 的时长由音频计算，客户端不能自行传时长。当前接收服务与发送服务分开，接收服务原有 `POST /send` 仍返回 501。

### 4.2 接收和发送观察

- `E:/projects/wechat-bot/weixin-research/receive_test.c`：原生同步回调，受保护读取 `0x70` 元素容器；过滤由 `filter_targets`（`\n` 分隔的会话 ID）与 `filter_prefix` 决定，默认 filehelper + `wxbot-`；命中但无槽位计入 `dropped`，未命中计入 `filtered`。
- `E:/projects/wechat-bot/weixin-research/receive_api.py`：`127.0.0.1:17867`，`GET /health`、`GET /events?after=N`，有令牌、游标、4096 键去重窗口和显式计数；观察范围来自 `ObservePolicy`（`WECHAT_BOT_OBSERVE`、`WECHAT_BOT_OBSERVE_PREFIX`）。
- `E:/projects/wechat-bot/weixin-research/send_capture.c`：只观察既有发送调用，不主动发送，不等于送达确认；使用同一套过滤与计数。
- `probe.js` 在 `finished` 与心跳事件里上报 `capture={received,dropped,filtered}`；非观察运行该字段为 `null`。
- `probe_sites.py`：一次对多个函数入口安装“只做 `lock incl`”的只读计数器，用于定位某条路径经过哪些函数（不要在接收路径长时间使用，见 §3）。
- `probe_dbsync.py`：在 `0x38E9F80` 入口只读拷贝最多 2 条 0x2E8 记录，供离线分析字段布局。
- `poll_events.py`：在 `receive_api.py` 运行期间轮询 `/events` 并保存原始响应，作为 HTTP 读取证据。
- `scan_memory.py`：只读扫描 UTF-8/UTF-16 标记并可选追踪指针，**不装钩子**；用于证明消息在内存中的形态。2026-10-29 的结果：正文存在于 protobuf/XML 缓冲区，按命中地址回溯指针找不到稳定持有者，不能据此实现通用接收。
- `wechat_db.py` / `db_receive.py`：**无钩子接收**。读取本机微信 4.x SQLCipher 数据库（vendored `vendor/wechatauto/db.py`，Apache-2.0），按 `sort_seq` 增量轮询，发送者用消息库 `Name2Id` 解析、群正文去 `wxid_member:\n` 前缀，复用 `EventStore`/`ReceiveServer` 提供 HTTP（schema `wechat-db-1`）。不加载 Frida，不装钩子。要求微信已登录，密钥缓存在 `runs/db-cache/keys.json`。

接收数据流：微信同步函数 `0x2EBB760` → 原生环形缓冲（64 槽，4096 字节正文）→ JS 轮询复制 → Python `EventStore`（有界缓冲 + 去重 + 归一化）→ HTTP 事件读取。`event_model.py` 从元素字段推导 `conversation_id`/`sender_id`/`direction`；本人 ID 只来自 `WECHAT_BOT_SELF`，未配置时方向为 `unknown`。`--state-file` 可跨重启保存游标与去重窗口，事件本身仍不持久化。

### 4.3 常驻桥接（P5/P6/P7）

`E:/projects/wechat-bot/weixin-research/bridge_service.py` 是当前唯一推荐的机器人接入点：

| 组件 | 文件 | 职责 |
|---|---|---|
| 服务主进程 | `bridge_service.py` | 单 HTTP 服务、发送队列、监督/重建、生命周期 |
| 配置 | `bridge_config.py` | 环境变量 + JSON，白名单/目录/队列/超时校验 |
| 请求状态 | `request_store.py` | SQLite、状态转移、跨重启幂等、`recover()` |
| 消息关联 | `message_tracker.py` | 发送后按 `sort_seq` 找本地行，回写 local_id/server_id；重读同一行等 server_id |
| 事件池 | `event_log.py` | 有界 SQLite 事件尾，旧游标续读/truncated |
| 发送 worker | `send_worker.py` + `send_worker.js` + `app_thread_send.c` | 一个常驻会话，`dispatch_job` 复用 job 块 |
| 下载 worker | `media_download.py:NativeDownloadWorker` + `download_worker.js/.c` | 参数化 local_id/server_id/type，不再每条重编译 |
| 会话封装 | `worker_session.py` | attach/load/inspect/start/pin、detach、拒绝卸载运行中的回调 |
| 进程发现 | `process_discovery.py` | 按加载的 `Weixin.dll` 找唯一主进程 |
| 媒体输入 | `media_input.py` | 目录/大小/格式/哈希/暂存/转换（P7） |
| 版本 | `version_profile.py` + `versions/*.json` | DLL/SHA/RVA 的唯一来源 |

数据流：`POST /send/*` → `RequestStore` → 有界队列 → `SendWorker.dispatch` → 原生 `0x17A3B60`；发送前取 `latest_sort_seq`，发送后 `MessageTracker` 读 `messages_since` 关联真实消息。接收侧仍是 `wechat_db.py` 轮询，但媒体解析/下载移到独立线程，`MediaStore` 用同一把 DB 锁避免 SQLCipher 缓存竞争。

### 4.4 测试数据和证据

- `E:/projects/wechat-bot/weixin-research/fixtures/`：生成的 PNG/TXT/WAV/AVI/MP4/SILK 及哈希清单。
- `E:/projects/wechat-bot/weixin-research/make_fixtures.py`：生成基础文件并刷新清单。
- `E:/projects/wechat-bot/weixin-research/tests/generate_video.cpp`：Windows Media Foundation 生成 H.264 MP4。
- `E:/projects/wechat-bot/weixin-research/voice_codec.py --make-fixture`：生成 1 秒双音测试音频，编码并解码验证。
- `E:/projects/wechat-bot/weixin-research/runs/active/`、`runs/send-api/`、`runs/api/`：原始 JSONL/JSON 证据。
- `E:/projects/wechat-bot/weixin-research/summarize_active_runs.py`：从实机日志及手机确认生成主动发送汇总，不将本地成功自动标成送达。

## 5. 必须保留的 ABI 与生命周期知识

### 5.1 地址只适用于当前固定版本

| 名称 | RVA |
|---|---|
| 应用上下文 | `0x47220` |
| 核心上下文 | `0x3823D0` |
| 消息管理器 | `0x709280` |
| 文本工厂 | `0x709160` |
| 图片工厂 | `0x1D81600` |
| 文件工厂 | `0x2C1B980` |
| 视频工厂 | `0x2FA7980` |
| 语音工厂 | `0x6CD09B0` |
| 宽字符串赋值 | `0x9B5E0` |
| 窄字符串赋值 | `0x1F9AD0` |
| 窄字符串增长 | `0x03E150` |
| 共用发送 | `0x17A3B60` |
| 任务上下文检查点 | `0x4A1FD0` |
| 返回结果窄字符串析构 | `0x2010` |
| 接收同步观察点 | `0x2EBB760` |
| 发送阶段观察点 | `0x1808560` |

维护源为 `weixin-research/versions/4.1.15.56.json`（`version_profile.py` 加载）、`profile.py`、`active_send.py` 和 `media_download.py`。新增函数也要复核 PE 函数入口、可执行节和内存字节；不能只改一个 SHA256 就把这些地址套到新版微信。公开参考项目的 4.1.10.27 偏移不可直接沿用。`bridge_service.py --check` 会执行 profile 校验，但不会附加进程。

### 5.2 消息对象

- 原生对象 `+0xB0`：收件人窄字符串；文本 `+0x758`：正文窄字符串；`+0x118`：消息类型。
- 窄字符串为 MSVC `std::string`，大小 32 字节，长度 `+16`、容量 `+24`，内联容量 15；长度是 **UTF-8 字节数**。
- 窄字符串赋值是 `0x1F9AD0`：`(dest, source)`，返回 dest；源容量 `< 0x10` 用内联数据，否则取 `+0` 指针；长度超过目标容量时调用 `0x03E150`（按 `max(new|0xF, capacity+capacity/2)` 增长，`0x1000` 为界切换对齐分配），最后 memmove 并写 0 结尾。模块内有 278 处调用点，析构仍由 `0x2010` 完成，与赋值同一分配器。正文 `+0x758` 与收件人 `+0xB0` 都必须走这条赋值，不能直接写字段或借用探针内存。
- 图片/文件/视频对象 `+0x120`：MSVC `std::wstring` 路径，空内联容量 7，数据为 UTF-16；不是窄字符串。
- 类型：文本 1，图片 3，文件 49/子类型 6，视频 43，语音 34。
- 语音工厂签名已核对为 `(out_pair, recipient_string, binary_string, duration_pointer, metadata_pointer)`。
- 语音二进制在 `+0x758`，毫秒时长 `+0x778`，元数据 `+0x780`；使用原调用者的常量 4、3、30000、零标志和尾部空字符串。不要把语音数据当以零结束的文本。
- 当前语音编码使用本机 SDK 导出，在独立子进程运行，不在微信业务线程编码；已有 SILK 也解码后计算实际时长，不能简单按数据包数量推算通用 SILK 时长。
- 表情消息工厂已从 `text_factory` 拆成独立的 `emoji_factory`（`0x1C12A00`）；`app_thread_send.c` 在 `kind==6` 时调用 `emoji_factory_fn`。不要再像旧版那样把 `text_factory` 覆盖成表情工厂，否则同一常驻 worker 无法同时发送文本和表情。
- 常驻 worker 复用同一个 680 字节 job 块：每条任务先写 state=3 失活，重写其余字段，最后才写 state=0 激活；原生侧 `lock cmpxchg` 只认领 0。不要把“先清零再写参数”的中间态暴露给 checkpoint。

共用发送函数签名为 `(manager, out_result, message_pair)`，会**消耗输入智能指针的一份引用**。代码发送前将原持有者置空并转移引用，避免重复释放。返回结果含两个 DWORD 状态、`+0x8` 的拥有型窄字符串和 `+0x28` 的拥有型智能指针；先复制有限元数据，再正确析构和释放。

不能将 Frida 分配、由 JS 持有的输入缓冲直接变成被微信异步消息拥有的堆内存。当前媒体路径由微信赋值函数复制，语音数据由微信工厂复制。不要手造虚表、复用已结束调用的裸指针或重放旧消息对象。

发送观察中的 R8 指向智能指针对：首指针为任务；任务 `+0x8` 是原始消息，任务 `+0x18` 是另一个数据库消息对象，布局不同。不要混读。

### 5.3 线程和历史失败

- JS Interceptor 回调曾在真实接收时伴随微信退出，原因未最终确认；不要直接归因于反调试或防护。
- 多轮原生 CModule 回调和主动调用测试正常退出，但这只是短时证据。
- 在外部 Frida 线程获取管理器，曾访问 `0x388` 异常；对应代码会读取微信线程本地任务上下文。
- 现有方案在 `0x4A1FD0` 正常返回后用原生 `onLeave` 执行一次工作，原子认领/取消，JS 仅轮询结果，脚本使用 `Script.pin()` 保持加载。
- 短时方案在 `0x4A1FD0` 正常返回后用原生 `onLeave` 执行一次工作；常驻 worker 把同一个回调保持安装，靠 job.state 认领，空闲时立即返回。它是“常驻检查点消费者”，不是通用任务调度器；仍不要用“随意中断某个线程并运行”的方式替换。
- 常驻发送与下载各有一个拦截器安装在同一 checkpoint；Frida 支持链式拦截器。worker 的入口字节校验必须跳过 checkpoint 本身（它已被 Frida 改写），其余函数仍逐个校验。
- 高层文本入口 `0x55F0380` 涉及异步回调所有权；其中回调结构是引用计数及 invoke/destroy 函数指针，不是普通 C++ 虚表。未经生命周期复核不要直接调用。
- 图片上层 `0x2C18040` 直接输入完整路径曾返回 `image not exist`；当前走已核对的工厂构造流程，不能误回退到该失败方式。文件上层 `0x2C196B0` 的额外参数也未全部命名。
- AVI 作为原生视频曾返回本地成功但手机未收到；H.264 MP4 后来确认可播放。因此 AVI 当前只走文件附件路由。

## 6. 下一步工作：按依赖顺序推进

### P0：通用字符串和目标参数，先解决中文/长文本（已完成 2026-10-28/29）

涉及 `E:/projects/wechat-bot/weixin-research/active_send.py`、`active_send.js`、`app_thread_send.c`、`send_api.py`、新增 `policy.py`/`post_send.py` 和测试夹具。

- [x] 将“测试策略”和“真实发送参数”分离：新增 `policy.py`，收件人是显式参数，白名单默认只有 `filehelper`，`WECHAT_BOT_RECIPIENTS` 才能扩大。
- [x] 定位并复核窄字符串赋值 `0x1F9AD0` 与增长函数 `0x03E150`，用它们替换 `inline_string()`；见 `LAYOUT.md` 与 `REPORT.md`。
- [x] 支持 UTF-8 中文、Emoji、多行、超过 15 字节的正文；正文和收件人按 UTF-8 字节下传，长度按字节计，拒绝 NUL 与除 TAB/LF 外的控制字符。
- [x] 将 HTTP JSON 正文上限从 4096 提高到 65536（`receive_api.py:ReceiveServer` 可通过参数覆盖），与文本契约对齐。
- [x] 发送前由微信自己的赋值函数复制，复制后再逐字节比对长度、内容和 0 结尾；异步消息不持有 JS/探针缓冲。
- [x] 检查五类收件人路径：语音仍由工厂复制收件人，其余四种改用同一赋值函数。

**验收结果：** 独立程序通过 13 项真实 Frida 调用测试，覆盖 15/16 字节边界、中文、非 BMP、多行、2100 字节长文本、49 字节长收件人、五类发送与释放计数；文件传输助手实机发送 87 字节中文与 467 字节多行文本，用户手机确认两条都收到（`delivery-confirmations.json`、`ACTIVE_TEST_RESULTS.json`）。Emoji 与长收件人目前只有独立程序证据，尚未实机发送。

### P1：普通联系人，建立真正双向收发基线

- [x] 向用户获取一个明确的测试联系人 ID/测试账号，优先使用已知测试 ID；如需联系人解析，新增经过验证的只读解析能力，名称重复时返回歧义，不猜目标。**联系人与群都已用手机标记解析并各完成一次文本发送验证；ID 在 `runs/targets.local.json`。**
- [x] 将 `recipient` 参数穿过 HTTP → Python → JS → C，不在中间重新写回 `filehelper`（P0 已完成，含 403 策略拒绝与原生 `+0xB0` 逐字节校验）。
- [x] 调整接收过滤为可配置的测试目标，先做窄范围观察，不直接发布所有历史聊天（`ObservePolicy` + 原生 `filter_targets`/`filter_prefix`，默认仍是 filehelper + `wxbot-`；解析时用通配目标 + 专用前缀；支持 `prefix`/`contains` 两种模式）。
- [x] 验证本人/对方身份、真正入站与本机发出、自手机回流、历史同步、重连补发之间的区别。**无钩子数据库路径已验证端到端**：4 条入站标记经 `/events` 读到，`conversation_id`/`sender`/`direction` 正确，微信未加载 Frida、未装钩子（证据 `runs/db-receive/inbound-evidence.json`）。接收钩子路径仍禁止使用（§3）。
- [x] 双方分别发送唯一标记，核对原生事件、HTTP 读取、目标设备实际收件；随后验证图片、文件、视频、语音。**普通联系人与群各完成文本 + 图片 + 文件 + MP4 视频 + 原生语音五类，均已确认收到；真正入站仍未做。**

**验收：** 至少一个普通联系人的五类发送收到，文本真正入站可经 HTTP 读取；方向和会话 ID 正确，测试对象明确，没有跨会话误投或错误去重。**已达成的部分：五类发送均确认收到；入站 4 条经无钩子数据库服务从 `/events` 读到，方向与会话 ID 正确。历史同步/重连补发未单独验证。**

### P2：群聊基础消息与成员身份

- [x] 获取用户指定的测试群 ID：已用手机标记解析，并完成文本 + 图片 + 文件 + MP4 视频 + 原生语音五类发送，用户确认群内收到。群会话 ID 与真实发言成员 ID 已区分：数据库里 `conversation_id=49089537476@chatroom`，成员分别是 `wxid_wwa94t9dh8n522`（EIPSY）与 `wxid_u3yyhe3yrwh122`（能源城大天使）。
- [x] 先验证群内普通文本的发送、接收和方向，再扩展其他四类发送。**发送侧五类已完成；无钩子数据库路径已读到两个成员的群文本，`conversation_id` 与 `sender_id` 正确。**
- [ ] 实测当前版本的群发言成员来源及群内容结构；不要直接套用旧版本固定前缀、字段或按冒号拆正文。
- [ ] 单独核对 `@` 的成员 ID 参数、显示文本和对应原生字段；验证普通 `@`，有需要再实现 `@所有人` 等权限相关特性。
- [ ] 验证多成员同样正文、自己消息回流、群系统/成员变化事件的区分和去重。

**验收：** 指定群收到五类主动消息；至少两个成员的文本入站能正确识别 `conversation_id` 和 `sender_id`；普通群消息可先完成，`@` 未验证时不要宣称已支持。

### P3：通用接收结构与持续事件队列

当前原生接收字段：RCX 为向量，步长 `0x70`；元素 `+0x8` 发件人包装、`+0x18` 收件人包装、`+0x20` 内容包装；`+0x14` 类型、`+0x48` 时间、`+0x50` 64 位消息 ID。包装 `+0x8` 指向窄字符串。具体证据仍需按目标场景核对。

- [x] 设计统一事件：稳定事件游标、会话 ID、真实发件人、收件目标、类型、方向、时间、消息 ID、内容/媒体状态；保留需要的原始字段而不猜语义。**`event_model.py` 已提供 conversation/sender/recipient/direction，方向需显式配置本人 ID；媒体状态仍缺。**
- [ ] 替换原生记录区。目前一轮最多 16 条、每次回调只看前 8 个元素、正文 512 字节、ID 128 字节；它不是可循环消费的持久队列。**已改为 64 槽环形缓冲、4096 字节正文、32 元素/回调；常驻服务不再走这条路径，改用数据库轮询 + `event_log.py` 持久化。**
- [ ] 原生回调只进行有限复制、受保护读取和入队，不做网络、磁盘、编解码或 JS 工作；为多生产者、消费者、容量与溢出建立明确协议。
- [x] 显式报告丢弃/截断和计数：原生 `dropped`/`filtered` 与 `capture` 事件、`EventStore.counters`、`/health` 和 `/events` 均已返回；`evicted` 与 `truncated` 并列。
- [x] 重启后的游标与去重行为已定义：短时服务用 `--state-file` 保存 `sequence`/去重窗口；常驻服务另有 `event_log.py`（SQLite，默认 7 天/5 万条），旧游标可续读，超出返回 `truncated`。短时 `receive_api.py` 仍默认不持久化事件本身。
- [x] 接收过滤改为策略驱动（默认 filehelper + `wxbot-`），避免写死单一目标。
- [ ] 区分实时消息、历史同步及本人回流，避免机器人自循环；去重不应仅以正文为键。
- [x] 消息 ID 用字符串返回：数据库路径的 `message_id`/`server_id` 均是字符串；常驻服务不再依赖 JS 的 64 位整数。

**验收：** 独立程序构造大批量、长文本、无效指针、并发生产和溢出；实机超过旧 16 条上限持续收件，无静默丢失，截断/丢弃有指标，内存有界。

### P4：图片、文件、视频、语音接收

**2026-10-29 最终实现及实测：** `db_receive.py --media --download --pid PID` 已接入 `media_download.py` 的串行原生异步下载。联系人与群各四类真正入站正文共 8 项，全部经鉴权 HTTP 取回。两边普通图片为 wxgf/HEVC，19092 字节源数据按 `hevc_mid_size` 校验后转为 500×606 PNG；两边视频为 1391209 字节，XML MD5 与全程解码通过；附件 6105424 字节且 MD5 一致；语音实际解码为 3380/2300 ms WAV。**P4 默认正文验收完成；高清原图独立下载未宣称通过。**

说明与契约：`weixin-research/RECEIVE_MEDIA.md`。最终入站正文证据：`runs/p4/download-complete/evidence.json`；初次网络下载：`runs/p4/native-async/`；生产队列复验：`runs/p4/service-download/`（复用此前入站消息，属于缓存命中，不能说成新消息网络下载）。初轮 `runs/p4/received/evidence.json` 和历史缓存验证均保留。证据含隐私，不提交；汇总为 `P4_TEST_RESULTS.json`。

- [x] 逐类核对当前版本数据库元数据、媒体标识和本地内容位置；元数据有界解压、XML 字段白名单、资源 protobuf 字段解析。耗时处理在接收轮询侧执行，尚不是 P6 独立持久任务队列。
- [x] 图片：缩略图/普通正文/本地原图分开；V2 解密、普通 wxgf/HEVC 转 PNG、联系人和群入站正文均通过。转码数据不冒用原始 JPEG MD5；独立高清下载未验收。
- [x] 文件：显示名与实际保存名分别解析，按资源库精确定位，大小和 MD5 校验；联系人/群真正入站文件均经 HTTP 取回。
- [x] 视频：提取精确路径、封面、时长，原生后台下载；联系人和群入站 MP4 的大小/MD5、HTTP SHA256 与全程解码通过。
- [x] 语音：按媒体库自身 Name2Id、local_id、create_time 取得完整 SILK，复用独立解码器生成 WAV；联系人/群真正入站的 SILK/WAV 均经 HTTP 取回，实际解码时长与 XML 声明值分别保留。
- [x] 原生异步下载调用、消息所有权、原生 future 轮询与释放已实现。独立夹具覆盖成功、原生错误、超时卸载后任务继续、身份不符拒绝执行，共 4 项通过。
- [x] 鉴权媒体 ID、pending/ready/failed、变体、64 MiB 单项、128 项/256 MiB 缓存、1 小时 TTL 和退出清理。下载串行队列限 32 项、128 项状态、最多两次尝试与 30 秒退避；原生成功仍须验证正文后才 ready。

生产链为 `0x4A1FD0` 既有应用任务检查点 → `0x17B9B90` 按本地消息查询 → `0xA85BA0` 微信自有副本 → `0x1813980` 异步下载（普通图参数 2、视频 32），见 `download_async.c/js`。不在检查点等待网络，不钩接收路径。失败研究文件保留：`0x1820E90` 是跨设备请求；`download_resource.c` 不适用于普通图/视频；`download_message.c` 同步等待曾卡住原生任务与卸载，已撤销并清理旧实例，禁止加入服务。用户授权过重启，当前新实例已验证存活；不要重做失败同步试验。

**验收：** 用户指定测试联系人/群分别发四种媒体，HTTP 能读到对应事件及真实内容；图片能打开，附件内容/哈希一致，视频和语音可播放，未下载完成时状态准确。

**表情接口（2026-10-29 最终）：** `emoji_media.py` + `db_receive.py --media --download` 已识别 type 47 并屏蔽私有 XML；静态 PNG/JPEG 和新入站 GIF 共 3 种资源均经 HTTP 验收。GIF 为 328367 字节、240×240、22 帧、1980 ms，保留完整原始动画。资源按消息 AES-128-CBC（IV=key，PKCS7）解密，大小/MD5 与所有帧校验通过。下载限定已验证腾讯主机、8 MiB、10 秒；解码独立进程限 12 秒、500 帧与像素总量。当前仍在接收轮询线程取回表情，耗时任务可能延迟新消息轮询。

发送服务加 `--emoji --db-dir ... --account ...` 后提供 `GET /emoji/favorites`、鉴权预览与 `POST /send/emoji`，按收藏 ID 重新核验当前收藏成员身份。原生消息工厂 `0x1C12A00`、资源构造 `0x20A2800`、发送入口 `0x17A3B60`；通过已核对的原生分配/控制块布局持有资源，所有字符串由微信复制，vtable 以相对模块指针核验。两个原测试目标均获得类型 47、服务器消息 ID，并获用户收件确认。当前收藏只有一个静态 PNG，所以动态收藏发送未做实机验收。5 项表情原生所有权夹具覆盖卸载后延迟读取与异常清理，全部引用释放。

详见 `weixin-research/EMOJI_API.md` 和 `EMOJI_TEST_RESULTS.json`；密钥、签名地址和实际图片仅在 `runs/emoji/` 私有证据，日志只留参数整体 SHA256。本地 `cache/月份/Emoticon/MD5前两位/MD5` 的特殊缓存编码尚未解开。长期调度、重连仍属 P6，不要为了该功能钩接收路径。

### P5：发送消息 ID 与自动状态跟踪（已完成 2026-10-29，长稳除外）

- [x] 保留 `accepted` 与“目标收到”分离：`delivery_verified` 在所有路径恒为 false，人工手机台账仍唯一权威。
- [x] 共用发送返回对象按既有边界只复制 DWORD 状态和诊断字符串，随后释放拥有型字符串/智能指针；没有新增裸指针保存。
- [x] 不依赖返回对象里的 ID（它只是诊断文本）：发送前记录 `sort_seq`，发送后由 `message_tracker.py` 读本地消息库关联真实 `local_id`/`server_id`。真实文本得到 `message_id=filehelper:37`、`server_id=2789436282422745060`；收藏表情得到 `filehelper:38`、`server_id=795560054143058110`；图片得到本地 ID 后由 tracker 重读同一行补 `server_id`。
- [x] 请求状态：`prepared/queued/sending/local_accepted/message_recorded/server_confirmed/failed/unknown/cancelled`；超时/断线/重启只到 `unknown`，从不自动重发。
- [x] 请求与消息关联、跨重启幂等：SQLite 按 `request_id + fingerprint` 返回首次结果；启动时把 `prepared/queued/sending` 恢复为 `unknown`；重复请求不会产生第二条消息。
- [x] 新增 9 项服务测试 + 7 项请求/跟踪测试；真实 filehelper 文本、图片、收藏表情各一条走通。

**验收状态：** 本地成功、服务器确认、原生失败、超时/未知、崩溃恢复均有明确状态；重复请求幂等；没有确认信号不返回已送达。目标设备实际收件仍需人工台账。

### P6：统一常驻收发服务与稳定调度（代码完成，长稳验收排除）

- [x] 收发整合为 `bridge_service.py`：一个进程、一个 HTTP 服务、一个令牌、一个发送队列；接收、媒体、发送、下载各自线程。
- [x] 发送与下载各自一个常驻 Frida 会话，checkpoint 拦截器只装一次；每条消息不再 attach/unload。fixture 单会话 8 条发送、3 条下载全部成功并正常关闭。
- [x] `profile.make_config(resident=True)` + `probe.js` 的 `resident/quiet` 去掉服务路径上的 60 秒定时器；旧 `send_api.py` 保持短时实验语义。
- [x] 发送队列有界（默认 64）、背压 429、排队取消、单条超时 20 秒、请求状态查询；原生业务线程只做一次 job，不做网络/磁盘/编解码。
- [x] 生命周期：关闭时先停线程再停 worker；原生回调仍在运行时拒绝卸载并进入 `blocked`；`Script.pin` 不再被当作取消/卸载竞态已解决。
- [x] 监督线程监测进程存活、worker 存活、接收轮询间隔；微信重启/worker 掉线时重建运行时，跟踪中的请求标 `unknown`（`reconnect_lost_tracking`）；版本/SHA/profile 不符进入 `blocked`。
- [x] `/health` 返回 `state/ready/send_ready/receive_ready`、进程、worker、轮询、媒体、队列、请求计数；明确不是长期稳定性或送达保证。
- [x] 保持 127.0.0.1 与 Bearer；令牌文件、日志轮转、事件池/请求库/媒体缓存、关闭清理均已实现。
- [x] 新增 SQLite 事件池（默认 7 天/5 万条），旧游标可续读或返回 `truncated`。

**验收状态：** 未执行 10 分钟 → 1 小时 → 更长的稳定性验收（按用户要求排除）。短时证据：服务 40–45 秒 `ready`、发送/接收就绪、双 worker 存活、干净关闭、checkpoint 原始字节恢复；fixture 证明单会话多任务。不得据此外推 7×24。

### P7：通用媒体输入、工程化与交付（已完成实现；转换类未做设备验收）

- [x] 分离“生成夹具”与“业务输入”：`WECHAT_BOT_MEDIA_ROOTS` 显式配置目录，默认仍只有 `fixtures/`；`wxbot-*` 保留 manifest 哈希校验，业务文件不需要。
- [x] 中文/空格/长文件名、文件不存在、符号链接、目录、空文件、超限、控制字符路径、格式损坏、转换超时都有稳定错误码；读取后复制到私有 staging 并按内容哈希发送，避免并发修改。
- [x] 图片扩展：PNG 直发，JPEG/GIF/WebP 用 Pillow 取首帧转 PNG；5000 万像素上限。视频：MP4 直发，其他容器可选 ffmpeg 转 H.264/AAC MP4；AVI 原生视频失败证据仍保留。
- [x] 语音：8/16/24/32-bit、单/双声道、8–48 kHz 统一转 16 kHz 单声道 16-bit，20 ms 对齐；SILK 容器校验；MP3 可选 ffmpeg。编码仍在独立子进程，实际时长重新计算。
- [x] 配置/依赖/启动入口写入 `BRIDGE_SERVICE.md` 与 README；Python 3.14、Frida 17.24.3、bundled ffmpeg/Pillow 版本说明。
- [x] 日志、令牌、事件/请求库、媒体缓存、staging 全部在 `runs/`（已 gitignore）；`active-send.generated.js` 仍不入库，服务不写含正文的生成脚本。
- [x] 版本 profile：`versions/4.1.15.56.json` + `version_profile.py` 成为 DLL/SHA/RVA 唯一来源；未知/缺字段/空 section 拒绝，`WECHAT_BOT_PROFILE` 可显式切换。
- [x] 功能矩阵、HTTP 样例、状态/错误码、P5/P6/P7 证据文件齐备；README 与本文同步更新。

**验收状态：** 媒体输入与转换有 8 项自动化测试；视频/MP3 转换本地通过，但转换后的媒体没有设备收件证据；PNG/MP4/SILK 原生路径沿用既有实机证据。新环境按文档可完成配置与诊断。

## 7. 需要一起修改的限制位置

以下路径都以 `E:/projects/wechat-bot/weixin-research/` 为根；扩展目标/正文/文件时逐一审查：

| 位置 | 现有限制 |
|---|---|
| `bridge_config.py` | 常驻服务端口/队列/超时/会话/媒体开关；未列出的 JSON 键拒绝 |
| `request_store.py` | 状态转移、终态、保留天数；非法转移抛错，不自动重发 |
| `media_input.py` | 媒体根目录、单文件上限、格式白名单、staging TTL、像素/时长边界 |
| `version_profile.py` | DLL/SHA/全部 RVA 的单一来源；未知版本拒绝 |
| `send_worker.js` / `download_worker.js` | 每会话一个 job，忙时拒绝；checkpoint 本身跳过入口字节校验，其他函数仍校验 |
| `policy.py` | 所有层共享的收件人白名单与字节上限；默认仍只有 `filehelper` |
| `send_api.py` | 路由字段白名单、请求限额、当前进程内防重；收件人与文本策略检查 |
| `active_send.py` | fixture 根目录/哈希/媒体上限、PNG/MP4 格式；收件人与 UTF-8 文本 |
| `active_send.js` | 字节数组校验、`stringFromBytes`、单次任务 |
| `app_thread_send.c` | `assign_narrow`/`verify_narrow`、各类型工厂、引用转移 |
| `receive_test.c` | 过滤来自 `filter_targets`/`filter_prefix`（默认 filehelper + `wxbot-`）；8/16/512/128 上限仍在；`dropped`/`filtered` 原子计数 |
| `send_capture.c` | 同一套过滤与计数；只观察既有发送调用 |
| `receive_api.py:EventStore` | 有界缓冲（默认 128）+ 4096 键去重窗口 + 显式计数；重启后的游标/去重行为未定义 |
| `receive_api.py:ReceiveServer` | 被发送服务复用的 Host/令牌；正文上限改为 `policy.JSON_BODY_BYTES` |
| `voice_codec.py:fixture_bytes` | 独立子进程内再次校验 fixture 路径和哈希、音频格式/时长 |
| `tests/active_fixture.c` 等 | 夹具按字节回显并核对释放计数；接收侧仍预期固定标记，业务通用化时同步扩展 |

不要为了通过测试只删过滤；先定义配置和新的接口契约，再同时修改各层。测试策略可以继续默认受限，生产逻辑则不应散落这些固定值。

## 8. 已执行验证与接手命令

本轮最终结果：**118 项自动化测试、17 项观察器夹具、13 项主动调用夹具、4 项异步下载生命周期夹具、5 项表情所有权夹具、8 项常驻发送 worker 任务、3 项常驻下载 worker 任务通过**。各项分别运行；P4 另有联系人/群各四类真正入站正文、表情 GIF 接收、收藏表情双目标发送的实机验收；P5/P6 另有真实 filehelper 文本/图片发送与 40–45 秒常驻服务运行证据。**未执行 10 分钟/1 小时长稳验收，短时通过不代表 7×24 能力。**

在 `E:/projects/wechat-bot` 的 PowerShell 中：

```powershell
# 只读，不附加微信
py -3.14 weixin-research/doctor.py

# 单元与 HTTP 边界测试，不附加微信；语音验证可能在独立进程加载本机编码 DLL
py -3.14 -m unittest discover -s weixin-research/tests -p 'test_*.py' -q

# 自建进程上的真实 Frida 调用，不附加微信
py -3.14 weixin-research/tests/integration_active.py
py -3.14 weixin-research/tests/integration_probe.py
py -3.14 weixin-research/tests/integration_download_async.py
py -3.14 weixin-research/tests/integration_emoji.py
py -3.14 weixin-research/tests/integration_send_worker.py
py -3.14 weixin-research/tests/integration_download_worker.py

# 常驻服务：只校验配置，不监听、不附加
py -3.14 weixin-research/bridge_service.py --check

# 常驻服务实际运行（先用 doctor.py 核对 PID）
py -3.14 weixin-research/bridge_service.py --pid PID --download

# 重建证据汇总，不发送消息
py -3.14 weixin-research/summarize_active_runs.py

# 仅显示服务说明与当前策略，不监听、不发送
py -3.14 weixin-research/send_api.py
```

需要实际测试时，先核对选定 PID：

```powershell
py -3.14 weixin-research/doctor.py --pid PID
```

服务启动后，用 `post_send.py` 提交 UTF-8 请求（读取服务写出的会话文件，避免控制台代码页破坏中文）：

```powershell
py -3.14 weixin-research/post_send.py --kind text --recipient filehelper --text-file msg.txt
```

之后按 `E:/projects/wechat-bot/weixin-research/SEND_API.md` 显式执行。`--serve`、`--execute`、`--observe` 和服务内 `--smoke` 可能启动真实观察或发送，交接本身不要求重复执行已完成的实机测试。

## 9. 新 agent 的首个可执行迭代

P0、P4、P5、P6、P7 的代码与短时验收已完成；长稳验收被明确排除。下一步：

1. 阅读本文、`BRIDGE_SERVICE.md`、版本 profile 和相关代码；只读确认版本/进程，运行 `doctor.py`、118 项单元测试与各集成脚本。
2. **常驻服务回归**：用新的测试联系人/群在 `bridge_service.py` 下重跑五类发送与入站读取，核对请求状态、`server_id`、`/events` 和媒体 ID；不要复用旧 `send_api.py` 的短时结论。
3. **原图/高清下载**：P4 只验收普通正文；独立高清原图下载、缺失附件/语音主动下载仍未宣称支持。不要重做已撤销的同步等待或回到接收路径钩子（§3）。
4. **历史/实时/本人回流**：常驻服务默认跳过首次历史，重启从水位补投；仍需显式验证历史同步、重连补发和自手机回流的区分。
5. **长稳（被排除）**：若将来要做，按 10 分钟 → 1 小时 → 更长逐步验证，并记录内存/CPU/队列/回调；当前不得声称已通过。
6. 新版本微信：新建 `versions/<版本>.json`，重新核对 SHA/RVA/入口字节，逐项实机验证；禁止沿用 4.1.15.56 偏移。
7. 按 P3～P7 持续更新功能矩阵和原始证据。不要同时大改 ABI、接收布局和常驻生命周期后才首次验证。

### 本轮已知问题与注意事项

- 集成测试的父进程在同步 `dispatch()` 中阻塞，无法同时排空子进程 stdout；观察行超过管道容量会死锁。夹具已改为把观察写入文件，新增测试脚本不要回到大段 stdout。
- `probe.py` 已把控制台输出设为 `errors='backslashreplace'`，日志文件仍是 UTF-8；用 PowerShell 读取 `runs/*.jsonl` 时要显式 `-Encoding UTF8`，否则中文显示为乱码。
- `active-send.generated.js` 现在包含正文 UTF-8 字节；仍不进入版本控制，也不要提交真实会话内容。

如确实安排多 agent：共享目标/字符串 ABI 与事件 schema 先由一个负责人确定，再拆分通用发送、文本/群接收、媒体接收、常驻服务/测试。多人同时修改 `app_thread_send.c`、`active_send.js`、`probe.py` 和接收记录布局容易互相覆盖，应明确文件归属和集成顺序。



**2026-10-30 启动入口与表情开关：** 本地emoji=true，根目录start-bot.cmd/start-bot.ps1已实现：权限提升、编译/配置检查、先桥接就绪后bot、隐藏后台进程、重复实例/并发启动保护、逐次日志。-Check只编译/校验，-Status只读。新增runtime_status由Engine上报state/pid/owner/时间，只读helper核对新鲜且匹配的消费者租约才报告ready。78项测试通过，PowerShell7及WindowsPowerShell5语法、实际-Check/-Status检查通过。此次没有启动服务，bot/桥接/Web仍关闭。真实UAC和完整启动链路待显式运行，不要因脚本已创建而声称正在运行。

**2026-10-30 多条消息回复：** 用户要求一次回复可发多条，已调整风格/参与准则并加messages-v1结构化最终输出协议。主回复解析为一个逻辑回复中的多个messages，Store原子展开为有序Outbox片段，共用reply身份、稳定request_id和原频控；失败首条会取消后续，unknown仍阻断。默认整组最多6发送片段，超长仍附件回退。旧执行无replyFormat标志保持旧投影，decision/memory JSON不拆；真实dsh内核模拟模型与冷恢复已验证。83项测试通过，bot/桥接仍关闭。

**2026-10-30 启动脚本兼容修复：** 用户在Windows PowerShell5遇到node -e内层引号丢失，误报Node版本不符。已改用node --version配合PowerShell Version解析，并为根启动器及两个agent子脚本统一UTF-8 BOM，修复PS5中文解码导致的语法错误。此次实际用powershell.exe与pwsh.exe分别运行完整-Check均通过（非仅语法检查），PS5 -Status也通过，服务仍停止。后续编辑这三个PS1须保留BOM。

**2026-10-30 已修复真实启动超时并恢复运行：** 用户实际启动后bridge ready但bot degraded，诊断autonomous_group_requires_empty_observe_prefix；实际桥接prefix=wxbot-。根因为WindowsPowerShell5/.NET Framework通过SetEnvironmentVariable设置空字符串会删除变量。新增weixin-research/run_bridge.py在运行服务的同一Python解释器内读取/校验local policy JSON并赋值os.environ，start-bridge.ps1改调用此入口，严格保留显式空前缀且不扩大白名单；新增3项回归，全桥接121项通过，PS5 -Check实际前缀为空、emoji/download=true。启动器遇到该配置冲突会直接解释原因，避免笼统等90秒。此次用户已有bot PID81956保持运行，旧bridge通过正常Ctrl+C退出，再用修复的PS5脚本启动bridge；实机health已确认bridge ready、prefix为空、bot running/ready、diagnostics空。启动器实际重复启动验证可识别已运行实例。**现在bot和桥接在运行；Web状态未改动。**

**2026-10-30 修复真实分条/表情失败：** 用户实测发现模型输出普通两行文本（未按messages协议），兼容分支合成一条；已增加普通短文本按行拆分，代码/列表/引文/表格不拆，显式messages中的内嵌换行不拆。另表情20663368641@chatroom:1290已在沙箱ready，但参与模型把完整来源ID简写为1288/1289/1290而导致校验失败；现仅对本窗口中唯一数字后缀做规范化，外群完整ID及歧义拒绝，并保存规范ID、补充原样复制ID提示。run_failed新增安全错误码定位。86项测试通过。用本次真实记录离线验证回复变2条、参与decision通过且实际73391字节PNG通过dsh完整解码，没有补发旧消息。已正常停止旧bot并用正式启动脚本重启，新bot PID68084，bridge复用且ready，当前bot ready/running。已请用户发新测试以确认实际微信发条及看图调用，不要把离线验证当成新消息已实机通过。

**2026-10-30 实机验收与参与格式防护：** 用户新发测试后，表情1292的回复10854d8d-45a7-40df-8c1f-2ad201115dd7已真实调用read_image两次，两个tool/result均包含图片且isError=false；同一回复part0/1分别得到原生消息1293/1294及微信server_confirmed，确认真实分条和看图链路成立。另首条文字1291遇参与模型伪造XML工具调用（判断阶段无工具），已剥离判断上下文附件path/readTool/note，只保留类型与状态，并增加一次有稳定身份、计费和范围校验的格式修复，仍不接受跨域引用。88项测试通过，已再次正常重启加载，沿用现有桥接。此前失败旧消息未补发。


**2026-10-30 11:58 - 30-message limit and pacing:** User requested up to 30 messages, 0.5-1s length-based intervals. Updated reply prompt, envelope/plain-line decoder, default/max egress.maxInlineParts and default chunker limit to 30. Pacing = 500 + min(previous grapheme count,50)*10 ms; persisted before POST for restart/lost-response safety, scoped to the same logical reply. Rechecks cancellation after wait; per-route tick exclusion; progress refreshes runtime status. All 90 tests pass, including 30 ordered messages, emoji length, lost response/restart pacing and cancellation during wait. Gracefully stopped old bot81200; cancelled only expired review execution5626dc5f-a848-4c50-a8ba-9ae6a725c131 and its inbox sources, preserving original result and audit data/startup/recovery/format-limit-1793332626756.json. No old replies resent. Official startup reused bridge and started bot83508; both ready, agent running, diagnostics empty. Logs: agent/data/startup/20261030-115707-67260. New pacing tested with fake bridge; fresh live-chat validation pending. User custom prompt untouched.


**2026-10-30 File sending and per-operation host access:** Added FILE_ACCESS.md, send_file for any current-sandbox file (10MiB, same conversation only, immutable outgoing copy, stable dedup), outgoing file names in chat_history, and external_list/read/write guarded by a one-use approval in the configured private contact session. Contact was resolved exactly in cached contact DB and matches existing allowed contact (see local config; no new recipients). Private /bot allow ID or /bot deny ID only; origin/generation/contact/generation/deadline/operation/hash binding, consumed once. Write snapshots exact bytes before asking and shows SHA256, size, preview; read copies only after approval into current sandbox, imported images can use read_image. Cancellation/expiry/denial/reset/restart do not grant ambient access. No shell/delete/move tools. Config externalAccess enabled locally, timeout90s, max10MiB; egress.sendArtifacts true. Bridge local policy MEDIA_ROOTS adds agent/data/sandbox (retains fixtures), MEDIA_BYTES10485760; host roots remain closed. Tools default prompt updated without altering user style/persona prompts. Entire 96-test suite passed; after extra post-approval reset guard, all6 focused tests passed again, including approver reset. Gracefully restarted bridge and bot via official launcher, health ready/running and diagnostics empty, no review blockers. Live config/health verified file size/root/auth switches. A final bot-only restart loads the additional reset guard. No real WeChat permission request or file was sent for testing; fake bridge tests cover approval command ingress, private history, wrong sender/scope, timeout, links, snapshot mutation and delivery queue.


**2026-10-30 Public source export:** User explicitly requested a new public GitHub repo wtrblck/wechat-bot. Authenticated using existing Windows Git Credential Manager, without exposing/saving tokens. Release checkout lives at E:/projects/wechat-bot/release/wechat-bot, remote https://github.com/wtrblck/wechat-bot.git, main branch. Original live deployment was not moved or restarted. Export excludes all local configs/credentials/runs/data/DBs/real test receipts and anonymizes identities. 257 source/docs/test files, Apache-2.0 with vendored notices; added first-run setup, README and GitHub Windows CI. Fresh JS/Python dependency installs succeeded. 97 agent/setup tests passed; 123 bridge tests passed even with WeChat DLL deliberately absent. Production ABI guards unchanged; portable native fixtures added only in exported tests. Initial v0.1.0 CI exposed optional pnpm build approval; v0.1.1 adds --ignore-scripts; v0.1.2 isolates old unit tests from host DLL/codec and adds negative guard tests. Tags pushed; v0.1.2 release draft/source archive/checksums prepared pending final hosted CI validation. Source modifications for packaging are in the export checkout, not the running original tree. For future updates, review/copy relevant original changes to the public checkout and re-run privacy checks before pushing. Never copy original AGENT_HANDOFF.md, local account configs or runtime data into the public repository.

**Public release completed:** Final main/tag commit73c9241, version v0.1.3. GitHub Windows CI succeeded for main run41033583611 and tag run41033583385. 97 agent/setup tests and 124 bridge tests pass. Additional actual packaging bug fixed only in export: emoji_media.py now adds project-local deps to sys.path so isolated inspector children can find Pillow; regression runs child Python with -S. Source archive257 files excludes private/generated paths; release v0.1.3 and SHA256SUMS published at https://github.com/wtrblck/wechat-bot/releases/tag/v0.1.3. Initial publicv0.1.0 marked superseded; prior public tags retained, no force-push. Local public checkout E:/projects/wechat-bot/release/wechat-bot is clean and tracks origin/main. Original runtime remained in its original path.
