# 微信智能体端

新增的 TypeScript / dsh 渠道插件。固定 dsh **0.2.1-rc.2**、Cordis **4.0.5**、Node **24.22.x**、pnpm **11.22.0**，依赖保存在 `pnpm-lock.yaml`。只通过现有桥接 HTTP 接口工作，不访问微信数据库或原生进程。

## 当前实现

默认人格已改为小鲸鱼，结合群聊与私聊场景示范、纠错和去重复规则；每条约10字拆分为多条微信消息的要求保留。参考来源与本地文件职责见[人格提示词说明](PROMPT_SOURCES.md)。

2026-10-30：新增有来源的相处偏好、纠正及未完事项记忆，调整自然参与和分条表达。机制、保留期和验收范围见[相处记忆与自然参与](SOCIAL_BEHAVIOR.md)。代码更新需重启智能体生效。
第二阶段已增加按对象/话题衰减的短期语气、自然关心冷却，以及默认关闭、逐联系人配置的定时私聊关心。私聊可用 `/bot care on|off|status` 管理本会话开关。

- 持久 Inbox、游标、业务去重、首次基线、停机补读、120 秒新鲜度、缺口暂停、有界存储和单消费者租约。
- 群聊无需 @ 或前缀；短窗口合并、独立 reply/wait/silent 判断、冷却、判断/发言限额、发送前复核。要求安静后可由管理员 `/bot resume` 恢复。
- 每群/每联系人各自的逻辑 session UUID、generation、模型/人格偏好；相同成员在其他群或私聊中无法读取本域内容。
- 提示词继承、逐会话覆盖、变量校验、快照、turn 边界更新；无效模板编辑保留上一份通过校验的版本。
- 最近200条连续消息（含bot回复、回流去重）、独立后台分段总结、分类标签索引，以及按需检索摘要→历史原文。无需向量数据库。
- 固定 Outbox、UTF-8 字素分片、稳定 request ID、异步状态跟踪；响应丢失后按原 ID 查询；unknown 不重发。桥接请求库连续性默认要求人工核对。
- 支持沙箱文件交付和指定微信联系人单次批准的宿主文件读写，详见[文件交付与沙箱外授权](FILE_ACCESS.md)。
- 一次回复可自然拆成多条微信消息，按顺序发送；整组共用逻辑回复身份，频率限制按一组计数。默认整组最多30个发送片段，相邻片段按前一条消息的字素长度间隔500–1000毫秒（500 + min(字素数, 50) × 10）；发送耗时更长时以实际完成为准，长文仍沿用附件回退。模型最终输出的messages JSON仅为内部传输，不会直接发给微信用户。
- 模型若忽略JSON协议而输出普通短文本，也按独立换行拆条；代码块、列表、引文和表格保留为一条。需要同一条消息内换行时使用显式messages数组。参与判断可将当前窗口中唯一的数字消息简写还原为完整ID，跨会话和歧义ID仍拒绝。
- `/bot help|status|new|stop|compact|model|preset|persona|resume|answer|allow|deny`。
- assistant 注册当前域渠道工具、沙箱文本工具和公网 `web_fetch` / `web_search`；显式允许附件交付后才注册 `send_artifact`。全局工具在宿主层隐藏，另有执行守卫。判断/记忆调用没有工具。
- 媒体 pending 等待、大小与 SHA256 校验、归属、缓存 TTL、引用保留；txt/md 提取；受控文本产物交付。
- 可配置人民币单日预算：按官方价记录请求用量，达到额度或无法安全预留下次调用时停止自动回复，北京时间零点恢复；账本跨重启保留。

## 本机消息观察台

已新增独立本机管理台，查看接收 → 参与判断/模型/工具 → 最终回复 → 每条发送状态，并浏览本地表情库。项目根目录双击 `start-admin.cmd`，或在本目录构建后运行 `pnpm admin`，访问 `http://127.0.0.1:8788`。页面顶部可开启或停止本项目 bot 与桥接，打开页面本身不启动服务；消息区域仍只读，不提供直接发送或重试按钮。开启服务后恢复正常自动回复；完整链路仅在操作者下次启动新版 bot 后记录，历史缺失明确标记。安全边界、API 与隔离演示见 [管理台说明](ADMIN.md)。

## 单日费用额度

本机已按用户选择设为 **5 元/天，Asia/Shanghai 零点自动恢复**。在 `config/agent.local.yaml` 修改：

```yaml
budget:
  enabled: true
  dailyLimitCny: 5
  timeZone: Asia/Shanghai
  resumeAtMidnight: true
  pricingFile: config/pricing.deepseek.2026-10-29.json
  maxPricingAgeDays: 30
```

在 `agent/` 中运行 `pnpm budget` 查看当天已计费、仍被预留/待核对的金额、余额、停止原因和恢复时间。该命令只读账本，可以在服务运行时使用。修改 YAML 后需重启智能体，账本不会因重启或 `/bot new` 清零。

默认官方价表于 **2026-10-29** 核对，单位为人民币/百万 tokens：

| 模型/时段 | 缓存命中输入 | 未命中输入 | 输出 |
|---|---:|---:|---:|
| Flash 高峰 | 0.04 | 2 | 8 |
| Flash 空闲 | 0.02 | 1 | 4 |
| V4 Pro 高峰 | 0.30 | 9 | 27 |
| V4 Pro 空闲 | 0.15 | 4.5 | 13.5 |

依据 [DeepSeek 官方人民币价格](https://api-docs.deepseek.com/zh-cn/quick_start/pricing/)。按北京时间周一至周五 09:00–12:00、14:00–18:00 判定高峰，排除 [国务院公布的 2026 年节假日安排](https://www.gov.cn/zhengce/zhengceku/202511/content_7047091.htm)；周末及其他时段为空闲。旧 Flash 模型别名按官方 Flash 价格计费。快照保存来源和核对日期；超过 `maxPricingAgeDays`、缺少年度假日日历或模型官方价时阻止付费调用，需核对官方变更并更新价格文件。不会把未定价模型当成免费模型。

统计范围是**此微信插件**发起的主回复、参与判断、记忆提取和每次重试，不包括相同 API Key 被其他应用使用的费用。SDK 的未命中输入、缓存读取、缓存写入分别归类；思考 token 已包含在输出中，不能重复加计。赠送余额和账户优惠不抵减这里按官方标价计算的预算。

每次真实模型请求发出前，在 SQLite 事务中按文本请求的 UTF-8 字节上界、协议余量、最大输出 token 和高峰费率预留费用；收到完整用量后按该请求发起时段的官方价结算并释放余量。金额保存为整数纳元，避免逐请求取整到分。余额不足以覆盖预留时可能提前停止，即使显示的已结算金额尚不足 5 元。

取消、网络断线或崩溃没有可靠最终 usage 时保留剩余预留，标为待核对，不按零费用放行。可从宿主持久流日志恢复的 usage 按原请求去重对账。跨零点完成的请求归入发起日期。预算是本地按量估算控制，服务端最终账单仍为准；客户端无法撤销已经被服务端接受的请求。

到限后停止拉取、模型任务、后台记忆和新发送，取消活跃任务及可取消的排队输出；微信和桥接进程保持运行。未提交回复不会在次日补发，恢复时重新建立基线，跳过停止期间积压。真实事件缺口仍需人工处理。进程需保持运行，零点后才能自动恢复；若已退出，则下次启动按新一天额度检查。

## 工作区沙箱和网页访问

本机配置已启用：

```yaml
sandbox:
  directory: data/sandbox
web:
  fetch: true
  search: true
  timeoutMs: 15000
  maxResponseBytes: 1048576
  maxOutputChars: 12000
  maxResults: 5
```

执行会话的 cwd 固定在 `agent/data/sandbox/<会话哈希>/`，群和联系人各自隔离。`workspace_list` 列出顶层文件，`workspace_read` / `workspace_write` 仅操作该目录中的相对路径 UTF-8 文本（单文件最多 64 KiB）。文件路径逐级检查，拒绝目录穿越、绝对路径、Windows 设备名/ADS、符号链接、junction 和硬链接；模型没有 shell、脚本执行、任意宿主文件或权限升级工具。媒体缓存和文本产物也写入对应会话沙箱。

这是**可信工具实施的文件访问围栏**，不是操作系统容器或对整个 Node 进程的隔离。宿主代码仍需读取配置/凭据、操作账本并连接微信桥接，但模型没有这些文件和接口的访问能力。对抗性的本机进程更换目录仍有文件检查到系统调用之间的竞争窗口；不要给该进程安装不可信的宿主插件。旧版 `workspaces/`、`data/artifacts/`、`data/media/` 不再作为模型工作区读取；旧未交付产物需操作者处理。

`web_fetch` 只读公网 HTTP/HTTPS 页面（默认端口），不运行网页脚本，不带浏览器 Cookie 或宿主凭据，不下载二进制；每跳重定向重新检查 URL 和全部 DNS 结果，并把连接固定到通过检查的地址，拒绝本机、内网、云元数据和保留地址。默认一次最多 1 MiB、返回最多 12000 字符、15 秒超时。Clash 等代理返回 198.18/15 虚拟地址时，使用固定且校验 TLS 的 [AliDNS HTTPS 解析接口](https://static-aliyun-doc.oss-cn-hangzhou.aliyuncs.com/download%2Fpdf%2F171662%2FAPI_Reference_intl_en-US.pdf) 重新获取真实公网地址后再连接；该兼容路径只向解析服务发送目标域名，不向网页连接开放虚拟或内网地址。

`web_search` 使用 Bing 公开 RSS 搜索入口，不需额外 API Key，默认返回最多 5 个标题、链接和摘要。入口受搜索服务的可用性与限流影响，遇到验证页或错误如实返回不可用。两项网页工具只供主回复使用，可分别关闭；网页和搜索结果标为不可信资料，提示词要求忽略其中指令并引用来源链接。没有另接收费搜索 API；返回文本参与后续模型调用的 token 仍计入每日 5 元预算。YAML 修改后重启智能体生效。
遇到不明网络梗时主动查抖音、B站、贴吧等公开语境；site限定会核对结果域名，B站无匹配时可回退到公开视频元数据检索。各站可读范围与实测限制见[社区搜索](COMMUNITY_SEARCH.md)。

## 启动

在本目录的 PowerShell 中执行：

```powershell
pnpm install --frozen-lockfile --ignore-scripts
pnpm build
Copy-Item config/agent.example.yaml config/agent.local.yaml
# 编辑 agent.local.yaml：selfId、provider/model，以及具体获准联系人/群
pnpm check
pnpm diagnose
node dist/src/cli.js init-profile
$env:DSH_HOME = Join-Path (Get-Location) 'data/dsh-home'
$env:WECHAT_AGENT_CONFIG = Join-Path (Get-Location) 'config/agent.local.yaml'
```

`init-profile` 仅在项目 `data/` 内创建专用官方 dsh profile，并连接本地已构建插件；不会覆盖已有 profile 文件。

在 `data/dsh-home/profiles/wechat/cordis.patch.yml` 中挂载所选模型的官方 dsh adapter。可复制 `cordis.patch.example.yml`，它示范从环境读取凭据的 DeepSeek adapter；**选择 dsh 不限定模型厂商**。插件配置中的 provider 必须对应 adapter 注册的路由，模型名必须对该服务有效。凭据不进入微信配置、模型输入或普通诊断。

```powershell
# 检查正式启动器组装的插件树，不运行模型、不发送消息
pnpm exec dsh --profile wechat --dump-config
# 桥接应已启动；按实际配置使用授权目标
pnpm exec dsh --profile wechat
```

桥接仍用项目原来的 `weixin-research/bridge_service.py` 启动。群自主参与要求目标同时处于桥接轮询列表、观察白名单和发送白名单中，并将该获准范围的 `WECHAT_BOT_OBSERVE_PREFIX` 显式设为空。`diagnose` 输出这些配置差异，不发送测试消息。插件不能扩大桥接授权。

配置中的相对路径以 `agent/` 为基准。真实账号 ID、联系人和群只保存在 `*.local.yaml`。首次启动会读至事件池空页建立基线，再处理新消息；不要为了 filehelper 测试关闭 outgoing/本人过滤。

## 恢复和本机操作

```powershell
# 停止插件后读取状态；单消费者锁会拒绝与运行实例抢占
node dist/src/cli.js status config/agent.local.yaml
# 明确放弃缺口前的自动处理，重新追至空页后恢复
node dist/src/cli.js baseline config/agent.local.yaml
# 预览某群有效提示词；不调用模型、不发送消息
node dist/src/cli.js preview config/agent.local.yaml group 'YOUR_GROUP_ID@chatroom'
```

`unknown`、`needs_review` 保留原请求 ID，暂停相应会话自动执行，需先核对桥接请求记录和本地库。当前没有“强制重发”命令。`bridge.requestStoreContinuity: confirmed` 仅可在操作者已确认桥接请求库未重建时启用：已提交请求查不到后才允许用原 ID/原正文再提交。

更换账号或重建事件源需配置新的 `bridgeEpoch` 和新的 `storage.file`；旧库身份不符会拒绝启动。普通桥接重启不更换 epoch。发现游标倒退或 `truncated` 会持久暂停；桥接暂未提供稳定事件池/请求库 generation，无法自动识别所有替换。

宿主输入与插件库之间没有跨库事务。执行中崩溃后先只读持久宿主日志：已提交的私聊输出可重建；未结算输入、被打断的控制命令或待复核群输出进入 `needs_review`，不会再次注入。提问/确认在重启时失效。

## 上下文与提示词

逻辑 session UUID 在本地持久恢复。为保证旧动态记忆不会越积越长，每次结算后使用新的 **dsh execution session**，只携带当前会话的有预算资料；执行 ID 单独保存在 `runs`，重启读取原执行日志对账。这是设计文档允许的受控 execution generation 方案。不会直接修改宿主内部历史数组。

`/bot new` 切换逻辑 generation，保留当前域内的记忆；`/bot compact` 说明当前受预算约束的上下文方式，不伪称调用了另一个摘要压缩器。模型/人格切换在下一轮生效；人格不改变工具许可。群重置和设置仅允许配置的 owner 或 `conversationOverrides.groups.<群ID>.administrators`。

可配置的参数由 `src/config.ts` 的严格 schema 定义；未知键和占位身份会失败。`promptProfiles`、`extends`、`conversationOverrides.groups/contacts` 沿用项目提示词设计。每轮保存实际模板哈希、内容顺序、配置版本与来源域。模板中的 `{{bot_name}}`、`{{conversation_kind}}`、`{{language}}`、`{{local_time}}` 可用，时间为 Asia/Shanghai；`\{{` 表示字面花括号。

2026-10-30 起，记忆采用分时段摘要；具体触发、文件格式、检索工具、迁移及额度见 [记忆与上下文 v2](MEMORY_V2.md)。固定提示词不扣聊天资料额度，仍正常计入模型实际窗口与费用。群判断默认每分钟最多6个新批次，发言最多2次，冷却30秒。**模型摘要质量及自主参与准确率仍需真实群聊评估**。

## 媒体、产物和数据

2026-10-31：本机及示例配置已启用 `media.enabled`。普通图片、文本附件及图片类型文件通过鉴权桥接复制到逐会话沙箱，原始字节与SHA256核对；上下文附沙箱相对路径，模型按需使用 `read_text_file` / `read_image` 阅读，准备中或过期时可调用 `prepare_attachment`。图片复用dsh官方附件存储与解码，以真实图片块进入支持图片的模型；图片输入仍计入每日预算。默认图片/文本单项10 MiB、缓存256 MiB、TTL24小时、每轮最多查看6张，详情见 [媒体接入](MEDIA_V2.md)。视频获取与理解已独立接入：B站、抖音链接获取；任意来源的受支持视频文件可探测、分镜、局部细看及提取字幕/本地转写音轨，视频输入默认最大128 MiB。B站完整实测通过，抖音匿名实测受限、待有效本地Cookie验证，详见[视频接入](VIDEO.md)。单独语音消息和复杂文档解析仍未接入。

媒体及附件发送需 `egress.sendArtifacts: true`。`send_file({path})` 发送普通文件，`send_image({path})` 发送微信图片（PNG/JPEG/GIF/WebP），`send_video({path})` 发送MP4视频；path只接受当前会话沙箱相对路径，最多10 MiB。文件发送前固定副本，并要求 **agent/data/sandbox** 处于桥接 `WECHAT_BOT_MEDIA_ROOTS` 白名单。宿主文件须先经 `external_read` 批准并复制进沙箱。

表情包改从 `stickers.directory` 配置目录选取，本机为 `data/stickers`（相对agent目录）。`list_emojis({offset?,limit?,query?})` 按文件名标签列出/搜索，`preview_emoji({emoji_id})` 预览，`send_emoji({emoji_id})` 复制固定图片到当前会话沙箱后，通过 `/send/image` 发送；不读取账号收藏，也不要求桥接开启收藏表情发送。GIF原字节保留，动态WebP在桥接侧转GIF；接收端实际动画显示仍待实机验收。预览与 `read_image` 共用每轮查看额度，只按静态画面理解。目录、配置和限制见[本地表情包](STICKERS.md)。所有发送的目标固定为当前会话，通过持久队列去重并确认状态；`queued`仅代表入队。`create_text_artifact/send_artifact` 继续支持文本产物交付。超出内联分片限制的回复生成 txt；未授权交付时只发一条说明。普通回复默认不逐 token 发送。

编号问答已接入宿主渠道工具。操作确认记录和 allow/deny 身份校验已实现；首版没有 operator 外部工作工具，因此不会因 allow 记录自动执行任何外部动作。复杂文档提取、ASR、operator、提醒和向量检索仍为后续扩展；本机只读管理台见 [ADMIN.md](ADMIN.md)。

SQLite 中普通输入与派生记忆默认保留 7 天，已结算 runs/outbox 的正文按期清理，未决输入与请求身份保留以便核对。**dsh 的 JSONL 执行日志单独保存在专用 DSH_HOME/sessions，目前需操作者另行管理保留期**；不能把 SQLite 的 7 天设置理解为所有宿主日志都已删除。数据目录保存真实聊天，部署时应仅授权本机操作者访问。

## 验证

2026-10-30：当前77项通过，新增连续200条/分段记忆及图片/文本附件完整链路。真实固定版本dsh内核配合模拟模型验证图片块确实进入后续请求、图片计费和记忆工具往返；本机HTTP模拟桥接验证字节复制。没有为这些验证调用真实付费模型或发送微信消息，实际图片识别质量仍待启动验收。

```powershell
pnpm test
# 项目根目录执行，既有桥接回归
py -3.14 -m unittest discover -s weixin-research/tests -p 'test_*.py' -q
```

2026-10-29：智能体 **56 项通过**；既有桥接此前 **118 项通过**。测试包含真实固定版本 dsh 内核 + 模拟模型的冷恢复、取消、计费与重试，真实本机 HTTP 模拟桥接，令牌轮换、POST 响应丢失、首次基线、分页游标、缺口、隔离、群合并与发送前撤销、提示词热更、媒体、交互、官方价格时段、并发预算预留及跨日恢复，以及沙箱路径/链接拒绝、公网 DNS/重定向边界、代理 DNS 兼容、工具往返后的计费。另已实际只读抓取 example.com（HTTP 200）和检索公开 DeepSeek API 文档（5 条来源），没有调用模型或发送微信消息。

官方 `dsh --profile wechat` 已完成短时装载检查；仅连接不存在的模拟会话文件并产生本机连接诊断。**没有使用真实模型凭据、没有向真实联系人发送消息、没有做长稳验收。** 测试不能证明群参与质量、实际收件或 7×24 稳定。
