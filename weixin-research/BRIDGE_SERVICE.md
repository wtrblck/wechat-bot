# 常驻微信端桥接服务（P5/P6/P7）

`bridge_service.py` 是当前唯一推荐的收发入口：单进程、单 HTTP 服务、单令牌，接收走无钩子数据库轮询，发送走**一个常驻 Frida 会话**中的原生 worker。P5 的请求状态与消息 ID、P6 的常驻队列与重连、P7 的通用媒体输入都在这里生效。

旧的两个短时实验入口仍然保留用于证据复现，但不再是机器人接入点：

| 入口 | 状态 |
|---|---|
| `bridge_service.py` | 常驻收发服务，默认无到期时间 |
| `send_api.py` | 短时发送实验（60 秒上限），兼容旧测试 |
| `db_receive.py` / `receive_api.py` | 短时接收实验，兼容旧证据 |

## 1. 启动

```powershell
# 只校验配置、版本与 ABI profile，不监听、不附加
py -3.14 weixin-research/bridge_service.py --check

# 常驻运行：自动查找加载 Weixin.dll 的主进程
py -3.14 weixin-research/bridge_service.py --download --emoji

# 或显式 PID（先用 doctor.py 核对）
py -3.14 weixin-research/doctor.py --pid 37416
py -3.14 weixin-research/bridge_service.py --pid 37416 --download
```

启动后写出 `runs/bridge/session.json`（URL、令牌、公开配置），日志在 `runs/bridge/bridge.jsonl`（10 MiB × 5 轮转），令牌在 `runs/bridge/token`（首次生成，icacls 尝试只授权当前用户）。服务只绑定 `127.0.0.1`，并要求 `Authorization: Bearer <token>`。

默认监听 `127.0.0.1:17870`；`--port 0` 使用随机端口，实际 URL 以 `session.json` 为准。`--seconds N` 只用于测试，默认没有到期时间。`Ctrl+C` 正常关闭并删除会话文件；令牌保留供重启后的客户端继续使用。

### 配置

环境变量：

| 变量 | 默认 | 说明 |
|---|---|---|
| `WECHAT_BOT_RECIPIENTS` | `filehelper` | 发送白名单，逗号分隔；其他目标必须显式加入 |
| `WECHAT_BOT_OBSERVE` | `filehelper` | 接收会话白名单（`*` 需配合显式会话列表） |
| `WECHAT_BOT_OBSERVE_PREFIX` | `wxbot-` | 正文匹配前缀；空字符串发布全部正文 |
| `WECHAT_BOT_OBSERVE_MODE` | `prefix` | `prefix` 或 `contains` |
| `WECHAT_BOT_CONVERSATIONS` | 观察目标 | 实际轮询的会话 ID，逗号分隔 |
| `WECHAT_BOT_MEDIA_ROOTS` | `weixin-research/fixtures` | 允许的发送媒体目录，`;` 分隔 |
| `WECHAT_BOT_MEDIA_BYTES` | 2 MiB | 单文件发送上限，最大 64 MiB |
| `WECHAT_BOT_IMAGE_FORMATS` | `png,jpeg,gif,webp` | 接受的图片输入；统一转成 PNG 再发送 |
| `WECHAT_BOT_VOICE_FORMATS` | `wav,silk` | 可加 `mp3`（需 ffmpeg） |
| `WECHAT_BOT_VIDEO_FORMATS` | `mp4` | 非 MP4 需 `WECHAT_BOT_VIDEO_CONVERT=1` |
| `WECHAT_BOT_VIDEO_CONVERT` | `0` | 用 ffmpeg 转 H.264/AAC MP4 |
| `WECHAT_BOT_HISTORY` | `0` | 首次启动是否补发历史；默认从当前末尾开始 |
| `WECHAT_BOT_SELF` | 数据库自带 | 本人 wxid，可逗号分隔多个 |
| `WECHAT_BOT_DB_DIR` / `WECHAT_DB_ACCOUNT` | 自动查找 | 微信数据根目录/账号目录 |
| `WECHAT_BOT_POLL_SECONDS` | `1.0` | 数据库轮询间隔 |
| `WECHAT_BOT_QUEUE` | `64` | 发送等待队列上限 |
| `WECHAT_BOT_SEND_TIMEOUT_MS` | `20000` | 单条原生发送超时 |
| `WECHAT_BOT_EVENT_CAPACITY` | `1024` | 内存事件缓冲 |
| `WECHAT_BOT_EVENT_LOG` | `1` | 是否写 SQLite 事件池 |
| `WECHAT_BOT_TOKEN` | 自动生成 | 覆盖令牌文件 |

也支持 `--config bridge.json`，键与上表对应，拒绝未知键；敏感值不写入日志。

## 2. 数据流

```
微信本地 SQLCipher 库（只读）
  → 接收线程（按会话 poll，sort_seq 水位）
  → EventStore（过滤/去重/方向）+ SQLite 事件池
  → GET /events

POST /send/* → RequestStore（SQLite，幂等）
  → 发送队列（有界）→ 常驻 send_worker（原生 checkpoint）
  → 本地消息库按 sort_seq 关联 → local_id / server_id
  → GET /request/{id}
```

- 接收、媒体解析、发送、下载各自有线程；HTTP 线程只读缓存/状态。
- 发送与下载各自一个常驻 Frida 会话，启动后不再逐条 attach/unload。
- 发送与下载各自安装一个 checkpoint 拦截器（同一地址、链式拦截），空闲时 `job.state != 0` 直接返回；有任务时才认领。
- 原生回调仍在运行时，关闭会拒绝卸载并把服务标为 `blocked`，需要重启进程，绝不冒内存释放风险。

## 3. HTTP 契约

### 通用

- 仅 `127.0.0.1`，`Host` 必须匹配监听端口，`Authorization: Bearer` 必须匹配。
- 请求体 `application/json`，上限 64 KiB。
- `request_id`：`[A-Za-z0-9_-]{1,64}`，幂等键。
- `delivery_verified` 在服务里**永远为 false**：只有人工手机确认台账（`delivery-confirmations.json`）能声称“目标收到”。

### 接收

`GET /events?after=N`：

```json
{"events":[{"sequence":21,"message_id":"filehelper:36","conversation_id":"filehelper",
  "sender":"wxid_self","direction":"outgoing","message_type":"voice",
  "content":"[voice]","media":{"kind":"voice","state":"ready","variants":{}},
  "timestamp":1793259556,"local_id":36,"server_id":"8985854293303329359"}],
 "cursor":21,"truncated":false,"counters":{}}
```

- 游标是服务内的单调序号；`truncated` 表示缺口已超出内存 + 事件池。
- 事件池默认保留 7 天/5 万条；重启后仍可读取旧游标。
- 媒体：`GET /media/{id}` 元数据，`GET /media/{id}/content?variant=content|original|thumbnail`。未就绪返回 409，过期/未知 404。
- `GET /health` 返回 `state`、`ready`、`send_ready`、`receive_ready`、进程/worker/轮询/媒体/队列/请求计数。

### 发送

`POST /send/text`

```json
{"request_id":"r-1","recipient":"filehelper","text":"任意 UTF-8","wait":true}
```

`POST /send/image|file|video|voice`

```json
{"request_id":"r-2","recipient":"filehelper","path":"E:/bots/outbox/a.jpg","wait":true}
```

`POST /send/emoji`

```json
{"request_id":"r-3","recipient":"filehelper","emoji_id":"<收藏 md5>","wait":true}
```

- `wait=true`（默认）：最多等 `send_wait_seconds`（默认 25 秒），返回 200（已本地接受或已关联）或 502（失败）；仍未结束时返回 202。
- `wait=false`：立即 202 `queued`，用 `GET /request/{id}` 跟踪。
- `POST /request/{id}/cancel`：只允许 `prepared/queued`；发送中不可取消。
- `GET /requests?since=<unix>&limit=N`：按更新时间增量列出。
- `GET /request/{id}`：状态、`accepted`、`message_id`、`local_id`、`server_id`、`native_error`、`reason`、`error_code`。

### 状态机（P5）

```
prepared → queued → sending → local_accepted → message_recorded → server_confirmed
                    ↘ failed          ↘ unknown
queued → cancelled
```

| 状态 | 含义 | 是否重试 |
|---|---|---|
| `local_accepted` | 原生 `send` 返回 `[0,0]`；不证明对方收到 | 否 |
| `message_recorded` | 本地消息库已出现该条消息及 `local_id`，`server_id` 仍为 0 | 否 |
| `server_confirmed` | 消息库已有非零 `server_id` | 否 |
| `failed` | 参数/媒体/原生调用明确失败 | 同一 request_id 返回缓存失败 |
| `unknown` | 超时、断线、服务重启或消息未在窗口内出现 | **不自动重发** |
| `cancelled` | 入队后、发送前取消 | 否 |

- 同一 `request_id` + 同一内容：永远返回首次结果（跨重启，SQLite）。
- 同一 `request_id` + 不同内容：409 `request_id_conflict`。
- 启动时把 `prepared/queued/sending` 恢复为 `unknown`，理由 `service_restart`/`never_queued`。
- 断线/超时只到 `unknown`，不会自动重发，避免重复消息。

### 错误码

| HTTP | `error` | 触发 |
|---|---|---|
| 400 | `valid_request_id_required` / `valid_recipient_required` / `unexpected_or_missing_fields` / `invalid_wait` | 请求形状 |
| 400 | `invalid_text` / `text_too_long` / `recipient_too_long` | 文本策略 |
| 400 | `media_not_found` / `invalid_media_path` / `media_empty` / `image_format_unsupported` / `image_decode_failed` / `audio_format_unsupported` / `audio_sample_rate_unsupported` / `audio_duration_out_of_range` / `video_format_unsupported` / `media_conversion_failed` | 媒体输入 |
| 403 | `recipient_not_allowed` | 不在 `WECHAT_BOT_RECIPIENTS` |
| 404 | `not_found` / `request_not_found` / `media_not_found` | 路由/ID |
| 409 | `request_id_conflict` / `request_not_cancellable` / `sender_busy` | 幂等冲突/取消 |
| 413 | `media_too_large` | 超过 `WECHAT_BOT_MEDIA_BYTES` |
| 429 | `queue_full` | 发送队列已满 |
| 502 | `native_send_failed` | 原生发送明确失败 |
| 503 | `worker_unavailable` / `emoji_catalog_disabled` | 运行时不可用/未启用 |
| 409 | `media_not_ready` | 媒体正文尚未就绪 |

## 4. 媒体输入（P7）

- 只接受 `WECHAT_BOT_MEDIA_ROOTS` 内的普通文件；符号链接、目录、空文件、控制字符路径、超限文件都拒绝。
- 生成夹具（`fixtures/wxbot-*`）仍按 `manifest.json` 校验哈希，防止证据被替换；业务目录不需要 manifest。
- 读取后立即复制到 `runs/media-staging/<uuid>/`，按内容哈希发送，避免校验与发送之间被并发改写。staging 由维护线程按 1 小时 TTL 清理（媒体上传可能异步读取文件，不能立即删除）。
- 图片：`/send/image`契约保持不变。PNG/GIF保留原始字节；静态JPEG/WebP转PNG，动态WebP/APNG转多帧GIF。桥接准备后将GIF路由为emoji，调用固定DLL的本地缓存导入入口RVA `0x6978540`，再复制为原生本地文件表情资源（EmoticonMsgInfo，包含真实文件长度与上传行为）并发送type 47；不写收藏数据库，不伪造CDN URL/AES字段。导入函数只同步借用MD5与宽字符路径，消息资源由微信分配、复制和持有引用；不使用把记录缓冲区误传给原生对象构造器的崩溃实验调用。调用前校验DLL SHA256、函数入口与字节指纹。能力不可用明确失败，导入失败返回native_error=14，不降级type 3；unknown请求不自动重发。消息关联使用准备后的实际emoji类型，日志同时记录请求kind和native_kind。
- 动画输入：Pillow验证全部帧；最多500帧、总计1亿帧像素和120秒，单帧仍受5000万像素限制，转换后继续检查媒体大小。原字节保留与接收端播放分别验收。2026-10-31消息163、164为type 47且有服务器ID，用户已确认两条均以微信表情形式正常播放；XML中的type=0、len=0不应单独解释为播放失败。server_confirmed本身仍不等于接收端播放证明。
- 语音：WAV 支持 8/16/24/32-bit、单/双声道、8–48 kHz，统一转 16 kHz 单声道 16-bit，再交给 SILK 编码器；SILK 校验容器；MP3 需 ffmpeg。
- 视频：MP4 直接发送；其他容器需 `WECHAT_BOT_VIDEO_CONVERT=1`，用 ffmpeg 转 H.264/AAC MP4 并检查 `ftyp`。
- 单文件上限默认 2 MiB（`WECHAT_BOT_MEDIA_BYTES` 可调，最大 64 MiB）；发送上限与接收 64 MiB 上限相互独立。

## 5. 常驻与恢复（P6）

- 常驻发送 worker：启动时校验 DLL SHA256、ABI profile、函数入口；之后每条消息复用同一 job 块/会话。
- 常驻下载 worker：`download_worker.c` 把 local_id/create_time/server_id/type 放进 job，不再每条重编译；原生 future 只轮询，不阻塞业务线程。
- 监督线程每 3 秒检查：进程存活、模块/worker 存活、最后一次接收轮询时间。进程重启或 worker 掉线时重建运行时；旧运行时关闭前会把仍在跟踪的请求标为 `unknown`（`reconnect_lost_tracking`）。
- 版本不符（SHA/profile/入口）→ `blocked`，不再尝试附加。
- 原生回调卡住 → `blocked`，不卸载脚本，要求人工重启服务。
- 关闭顺序：停止接收/媒体/跟踪线程 → 停下载队列 → 停 worker → 保存水位/事件池 → 关 HTTP。若线程残留，不删除仍被使用的媒体缓存。
- `/health` 的 `ready` 只代表当前进程的观测/发送前提成立，不是长期稳定性或送达保证。

## 6. 依赖与运行环境

- Windows x64；动态工具使用 `py -3.14`（本机默认 `python` 是 3.8，不适用）。
- Frida 17.24.3 位于 `weixin-research/deps`；脚本使用 QJS 运行时。
- Pillow 用于图片校验/转换；`imageio_ffmpeg`（bundled ffmpeg 7.1）用于 wxgf 解码、MP3 和视频转换；缺少 ffmpeg 时相关格式返回 `media_converter_unavailable`。
- 本机 `VoipEngine.dll` 用于 SILK 编码/解码，SHA256 固定；编码在独立子进程。
- 版本 profile 固定 DLL 路径与 SHA256；换机器需同步修改 `versions/*.json` 的 `dll` 并重新核对。

## 7. 已验证范围

| 能力 | 实现 | 证据等级 |
|---|---|---|
| 文本发送（UTF-8/中文/Emoji/多行，≤4096B） | 常驻 worker，`local_accepted`/`server_confirmed` | 真实 filehelper 收件路径 + 手机历史证据 |
| 图片/文件/MP4/语音发送 | 常驻 worker + 媒体输入策略 | 原生 PNG/MP4/SILK 路径有设备证据；转换格式仅本地 |
| 收藏表情发送 | `emoji_media` + 常驻 worker | 旧 P4 实机双目标；本轮未重跑 |
| 入站文本/媒体 | DB 轮询 + `MediaStore` + HTTP | P4 联系人/群四类正文；本轮只读 |
| 请求状态/消息 ID | SQLite + 本地库关联 | 真实文本 `server_confirmed`；图片 `message_recorded` |
| 事件续读 | SQLite 事件池 | 单测覆盖旧游标/truncated |
| 常驻 worker | 单会话多任务 | fixture 8 发送 / 3 下载，进程存活 |
| 自动重连/阻塞语义 | 监督线程 + `WorkerSession` | 单测覆盖替换；真实微信重启未演练 |
| 媒体输入转换 | 可配置根/格式/大小/哈希 | 8 项单测；视频/MP3 转换通过 |
| 版本 profile | JSON + SHA 校验 | 单测覆盖缺字段/空 section；真实 DLL 校验 |

- 118 项自动化测试（含请求状态机、事件池、媒体输入、配置、服务 HTTP）。
- 常驻发送 worker：单会话 8 个任务（4 种文本含 2012 字节、图片、文件、视频、语音），退出后 fixture 进程仍存活。
- 常驻下载 worker：单会话 3 个任务（2 成功、1 身份不符拒绝），引用释放，进程仍存活。
- 真实账号：常驻服务 40 秒运行（发送 + 下载 worker 同时存活），收发就绪；一条文本经 `/send/text` 到 filehelper，状态 `server_confirmed`，`message_id=filehelper:37`、非零 `server_id=2789436282422745060`、`delivery_verified=false`；另一次 `--emoji` 运行经 `/send/emoji` 得到 `filehelper:38`、`server_id=795560054143058110`；此前一条文本和一条图片分别得到 `server_confirmed`/`message_recorded`；关闭后 checkpoint 入口字节恢复。
- **未做**：文档要求的 10 分钟/1 小时/更长运行验收；真实外部联系人和群在常驻服务下的回归；原图独立下载；动态收藏表情发送；多账号。



2026-10-31 17:28历史资源补齐（首次上传结论已由下方18:02记录修正）：原收藏资源的长度getter固定为0，新文件资源经0x22FC160复制完整基础资源、使用0x9431d38控制表及0x9431c28对象表，并设置原生长度字段+0x1c8；此前失败的两张GIF获得新消息183/184与非零服务器ID。关联增加emoji MD5，status=5转failed；server_id一直未确认则转unknown，重启只恢复准确消息行的观察，不重发。详见LOCAL_ANIMATION_REPAIR.md。

2026-10-31 18:02修正上述17:28结论：资源和长度仍不足以触发首次上传。EmoticonMessageHandler的0x5AF3320在message+0x768上传数据为空时，要求message+0x120的本地wstring路径非空，才调用0x3A2520读取上传文件。local_emoji现用已有wide_assign复制安全staging路径，常驻worker也填充该路径；不只导入展示缓存。补路径前失败的诊断GIF修复后获得消息193；另一个全新哈希首次发送获得194，均type 47/非零服务器ID，且用户确认两张接收端表情正常播放。原生只读记录证明调用来自该处理器读取分支0x5AF373F。未匹配消息的确认扫描重读原始发送watermark，并禁止一个消息ID匹配多个请求；137项Python、142项TypeScript及9组原生表情夹具通过。详见LOCAL_ANIMATION_REPAIR.md。
