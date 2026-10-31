# 主动发送 API 实验（2026-10-28）

> **2026-10-29 更新：机器人接入请使用常驻服务 [`bridge_service.py`](BRIDGE_SERVICE.md)，它把发送、接收、媒体、请求状态和常驻 worker 合并为一个进程。** 本文保留旧的短时 `send_api.py` 实验契约，用于复现历史证据；它仍有 60 秒/每进程 4 次请求的上限，不是生产入口。

2026-10-29 表情扩展：加 `--emoji` 后可列出当前账号收藏、鉴权预览，并通过 `POST /send/emoji` 发送收藏表情；原测试联系人与群均确认收到正常类型 47。完整启动方法、参数和边界见 [表情 API](EMOJI_API.md)。动态 GIF 接收已实测，当前收藏只有一个静态 PNG。

固定 Windows 微信 **4.1.15.56 x64**。已完成的测试对象均为文件传输助手 `filehelper`；全程通过后台原生调用发送，未使用鼠标、键盘、剪贴板或 UI Automation。

本轮之后文本不再是 ASCII 测试标记：正文和收件人都以 UTF-8 字节下传，由微信自己的窄字符串赋值函数复制，默认策略仍只允许 `filehelper`。

## 实机结果

| 消息 | 本机 HTTP 调用 | 手机收件证据 |
|---|---|---|
| 文本 | `/send/text` 返回成功 | 用户确认收到 `wxbot-active`；HTTP 另测 `wxbot-http` |
| PNG 图片 | `/send/image` 返回成功 | 用户确认收到蓝绿色方格测试图 |
| TXT 文件 | 原生调用成功 | 用户确认收到 `wxbot-file.txt` |
| WAV 音频附件 | `/send/file` 返回成功 | 用户确认收到 `wxbot-audio.wav` |
| AVI 视频附件 | `/send/file` 返回成功 | 用户确认收到 `wxbot-video.avi` |
| MP4 视频消息 | `/send/video` 返回成功 | 用户确认收到且可以播放 |
| AVI 视频消息 | 曾返回本地成功 | 用户确认未收到；现在拒绝此格式，改用 `/send/file` |
| 原生语音消息 | `/send/voice` 返回成功，WAV 自动转 SILK | 用户确认收到约 1 秒语音气泡，且能正常播放 |
| UTF-8 中文文本 | `/send/text` 返回 `accepted:true`、`native_error:0`，87 字节 | 用户确认收到 |
| 多行长文本 | `/send/text` 返回成功，467 字节、含空行与纯 ASCII 行 | 用户确认收到 |
| 普通联系人文本 | `/send/text`，收件人为显示名经手机标记解析出的 wxid，85 字节 | 用户确认在该联系人聊天中收到 |
| 群聊文本 | `/send/text`，收件人为解析出的 `...@chatroom`，70 字节 | 用户确认在该群中收到 |
| 普通联系人四类媒体 | `/send/image`、`/send/file`、`/send/video`、`/send/voice` 各一条，`local_status:[0,0]` | 用户确认图片、文件、视频、语音四类都收到 |
| 群聊四类媒体 | 同上，收件人为该群 `...@chatroom` | 用户确认四类都收到 |

最后三行是 2026-10-28/29 新增：文本已从不超过 15 字节的 ASCII 标记扩展到任意 UTF-8，并完成一次普通联系人的发送验证。个人测试标识只保存在 `runs/targets.local.json`（`runs/` 不进入版本控制），不写进本文档。

`accepted` 只表示原生调用返回本地成功，**不会自动设置 `delivery_verified=true`**。本轮 AVI 视频的反例说明两者必须区分。手机确认单独记录在 `delivery-confirmations.json`，逐次运行汇总在 `ACTIVE_TEST_RESULTS.json`。所有完成的主动发送实验均正常脱离，短时观察结束后微信仍在运行。

## 使用 HTTP 接口

在项目根目录 PowerShell 运行。先使用 `doctor.py --pid PID` 核对主进程；PID 会变化。

默认策略只允许文件传输助手。要测试其他目标，必须先显式配置，不能靠省略某个过滤条件扩大范围：

```powershell
# 默认只有 filehelper；加入测试联系人 ID 时才允许向它发送
$env:WECHAT_BOT_RECIPIENTS = 'filehelper,wxid_example_contact'

# 默认只显示接口说明，不监听、不发送
py -3.14 weixin-research/send_api.py

# 显式启动；仅绑定本机，60 秒后关闭，每次服务最多执行 4 个请求
py -3.14 weixin-research/send_api.py --pid PID --serve --seconds 60
```

另一个 PowerShell 窗口用 `post_send.py` 提交请求，它从服务会话文件读取地址和令牌，正文按 UTF-8 编码，不受控制台代码页影响：

```powershell
py -3.14 weixin-research/post_send.py --kind text --recipient filehelper --text "wxbot-中文测试"
py -3.14 weixin-research/post_send.py --kind text --recipient filehelper --text-file msg.txt
```

也可以按原方式手工调用 `Invoke-RestMethod`：

```powershell
$senderSession = Get-Content .\weixin-research\runs\send-api\send-api-session.json -Raw | ConvertFrom-Json
$senderHeaders = @{ Authorization = "Bearer $($senderSession.token)" }
$senderBody = @{
    request_id = [guid]::NewGuid().ToString('N')
    recipient = 'filehelper'
    text = 'wxbot-http'
} | ConvertTo-Json
Invoke-RestMethod "$($senderSession.url)/send/text" -Method Post -Headers $senderHeaders -ContentType 'application/json' -Body $senderBody
```

| 路由 | JSON 必填字段 | 当前限制 |
|---|---|---|
| `POST /send/text` | `request_id`, `recipient`, `text` | UTF-8 正文，最多 4096 字节；允许中文、Emoji、多行；拒绝 NUL 与除 TAB/LF 外的控制字符 |
| `POST /send/image` | `request_id`, `recipient`, `path` | 项目 `fixtures` 中生成并经清单哈希校验的 PNG |
| `POST /send/file` | `request_id`, `recipient`, `path` | 同上，允许生成的 TXT/WAV/AVI/MP4 文件，最多 2 MiB |
| `POST /send/video` | `request_id`, `recipient`, `path` | 同上，仅允许已验证的 MP4 |
| `POST /send/voice` | `request_id`, `recipient`, `path` | 同上，16 kHz/单声道/16-bit PCM WAV 自动编码，或 Tencent SILK v3 |
| `POST /send/emoji` | `request_id`, `recipient`, `emoji_id` | 服务加 `--emoji` 启用；ID 必须来自当前账号收藏列表，不接受客户端地址/密钥/路径 |

`recipient` 是显式参数，会一路传到原生调用的 `+0xB0`；是否允许由发送策略统一决定，默认只允许 `filehelper`，最多 128 UTF-8 字节，未配置的目标返回 403 `recipient_not_allowed`。`path` 是现有测试文件的完整路径，例如 `E:/projects/wechat-bot/weixin-research/fixtures/wxbot-video.mp4`。图片发送与图片文件附件、视频消息与视频文件附件分别使用不同消息类型。

语音示例：把下面 JSON 以相同的令牌提交到 `POST /send/voice`。`duration_ms` 由音频内容计算，客户端不填写。

```json
{
  "request_id": "voice-test-001",
  "recipient": "filehelper",
  "path": "E:/projects/wechat-bot/weixin-research/fixtures/wxbot-voice.wav"
}
```

本轮返回 `accepted:true`、`duration_ms:1000`。这会发送原生语音气泡；`/send/file` 发送 WAV 时则是音频文件附件。语音 WAV 目前要求完整 20 ms 帧、20～60000 ms，未实现 MP3、立体声或其他采样率的自动转换。

成功返回 HTTP 200、`accepted:true`、`run_completed:true`、`local_status:[0,0]`、`delivery_verified:false`，以及对应日志路径。每次调用约保留 15 秒观察和清理时间。错误包括 400 参数无效、401 令牌无效、409 忙碌或请求 ID 冲突、429 本轮限额、502 原生调用或清理失败。相同请求 ID 和相同内容在**本次服务进程内**返回缓存结果，避免重发；重启服务后不保留此缓存。

服务关闭后删除令牌文件。原 `receive_api.py` 的接收端口为 17867，本发送实验端口为 17868；接收服务原有 `POST /send` 仍返回 501。两者尚未整合为常驻机器人服务。

## 调用流程与关键发现

外部 Frida 线程直接调用服务获取函数曾在地址 `0x388` 访问异常。静态代码 `0x4A1FD0` 读取线程本地任务上下文，并在空上下文上访问 `+0x388`；改到微信正常运行的任务上下文后，获取同一管理器通过。该证据支持线程上下文约束，不能推广为所有入口的完整线程契约。

当前通过一个原生 `onLeave` 观察器，在任务上下文检查函数正常返回后执行一次任务。任务状态用原子操作认领和取消；不打断任意线程，不在业务线程运行 JS，不重放捕获的对象指针。脚本在原生任务存续期间保持加载，结束后移除观察器。此方法仍是研究探针，不是已验证的通用任务调度器。

| 项目 | RVA | 用途 |
|---|---|---|
| 应用上下文 | `0x47220` | 返回拥有引用的智能指针 |
| 核心上下文 | `0x3823D0` | 获取服务容器 |
| 消息管理器 | `0x709280` | 依赖微信任务上下文 |
| 文本工厂 | `0x709160` | 使用微信自己的构造函数 |
| 图片工厂 | `0x1D81600` | 类型 3 |
| 文件工厂 | `0x2C1B980` | 类型 49、子类型 6 |
| 视频工厂 | `0x2FA7980` | 类型 43；已用 MP4 实机验证 |
| 语音工厂 | `0x6CD09B0` | 类型 34；复制 SILK 二进制数据、时长和元数据 |
| 宽字符串赋值 | `0x9B5E0` | 为原生媒体对象 `+0x120` 复制 UTF-16 完整路径 |
| 窄字符串赋值 | `0x1F9AD0` | 正文 `+0x758` 与收件人 `+0xB0` 由微信复制；容量 15 以内内联，否则分配堆内存 |
| 窄字符串增长 | `0x03E150` | 由 `0x1F9AD0` 在长度超过目标容量时调用，分配、复制并释放旧缓冲 |
| 共用发送入口 | `0x17A3B60` | 接收管理器、结果地址和消息智能指针；消耗输入引用 |
| 任务上下文检查点 | `0x4A1FD0` | 单次原生线程调用触发点 |
| ASCII 字符串析构 | `0x2010` | 清理发送结果中的字符串 |

收件人仍为原生对象 `+0xB0`，文本正文为 `+0x758`，类型为 `+0x118`。媒体路径为 **MSVC `std::wstring`**，不是 UTF-8 `std::string`。空窄字符串容量为 15，空宽字符串容量为 7；执行前逐一检查构造状态。媒体路径由微信自己的赋值函数复制，避免异步任务保留探针内存；本轮起正文和收件人也调用核对的窄字符串赋值函数 `0x1F9AD0`，复制后逐字节比对长度、内容与 0 结尾，探针缓冲不再被异步消息持有。

窄字符串赋值的 ABI 是 `(dest, source)`：源容量 `< 0x10` 时用内联数据，否则读 `+0` 指针；长度超过目标容量时调用 `0x03E150` 增长；最后 memmove 并写 0 结尾。`0x1F9AD0` 在模块内有 278 处直接调用点，是这个 `std::string` 版本的共用赋值实现。目标字符串的析构仍由 `0x2010` 完成，与赋值使用同一分配器。

共用发送结果含状态两个 DWORD、`+0x8` 的拥有型窄字符串、`+0x28` 的拥有型智能指针。原生任务复制有限错误文本后，按对应析构/引用计数规则释放这些结果和上下文引用。尚未解析服务器消息 ID，因此接口不伪造 ID。

图片上层入口 `0x2C18040` 和文件上层入口 `0x2C196B0` 均已静态定位。直接把完整文件路径交给前者，实机返回 `image not exist`，不是成功发送。其路径预处理经过应用目录解析；当前实现依据同一入口中已核对的对象构造流程，使用完整 UTF-16 路径调用共用发送入口。文件上层入口的额外字符串参数尚未全部命名，没有以猜测的参数调用该入口。

原生语音构造调用链已复核：`0x5E09640` → `0x6CD0550` → `0x6CD09B0` → `0x6CD1BD0`。依据原调用者的常量 4、3、30000、零标志及空字符串组装元数据，由微信自己的工厂复制数据；SILK 二进制字符串在对象 `+0x758`，毫秒时长在 `+0x778`，元数据在 `+0x780`。构造后设置类型 34，通过已验证的共用发送入口发送。未手工伪造虚表或复用聊天对象指针。

`voice_codec.py` 在独立 Python 子进程中调用本机安装的 `VoipEngine.dll` 的 `SKP_Silk_SDK_*` 导出，固定该 DLL SHA256 为 `ec7cfdbc32842111be3287753832559c0403a79a3042a3a9ae57dd3908bc225c`。无需下载或注入第三方编码器。1 秒测试音频生成 50 个数据包、2379 字节 SILK，解码得到 16000 个样本；用户确认手机播放正常。

编码使用 Tencent SILK v3 容器，带 `02 23 21 53 49 4c 4b 5f 56 33` 头和小端包长度；格式对照见 [SILK SDK 编码封装源码](https://github.com/laysent/silk-sdk/blob/master/api/Encoder.c)。WAV 编码后校验解码样本数；已有 SILK 也先在独立进程中解码，以实际解码样本数计算时长。编码/解码子进程有 20 秒超时、文件大小与时长限制。日志只保存语音大小和 SHA256，不记录语音字节。

## 测试与复现

38 项自动化测试通过，包含测试数据范围、哈希、媒体类型、WAV/SILK 格式、时长、编码超时、UTF-8 文本边界（15/16 字节、中文、非 BMP、超限、NUL/控制字符）、收件人策略与透传、JSON 正文上限。另有 13 项自建 x64 程序上的真实 Frida 调用测试，覆盖 context、六种文本（含 2100 字节长文本与 49 字节长收件人）、图片、文件、视频、语音；验证实际调用、原生回调执行、只调用一次、宽字符串、二进制语音复制、时长/元数据、结果文本复制、窄字符串逐字节复制及所有测试智能指针/结果字符串释放。这些测试不附加微信，不能代替实机验证。

```powershell
py -3.14 -m unittest discover -s weixin-research/tests -p 'test_*.py'
py -3.14 weixin-research/tests/integration_active.py
py -3.14 weixin-research/summarize_active_runs.py

# 生成非私人测试数据（PNG、TXT、WAV、AVI）
py -3.14 weixin-research/make_fixtures.py

# 用本机 SILK 编码器生成并解码验证短测试语音，再刷新清单
py -3.14 weixin-research/voice_codec.py --make-fixture
py -3.14 weixin-research/make_fixtures.py

# 用 Windows Media Foundation 生成 H.264 MP4，再刷新清单
New-Item -ItemType Directory -Force weixin-research/tests/build | Out-Null
g++ -O2 -municode weixin-research/tests/generate_video.cpp -o weixin-research/tests/build/generate-video.exe -lole32 -lmfreadwrite -lmfplat -lmfuuid
weixin-research/tests/build/generate-video.exe E:/projects/wechat-bot/weixin-research/fixtures/wxbot-video.mp4
py -3.14 weixin-research/make_fixtures.py
```

仍未验证普通联系人、群聊、重连、并发吞吐量、长期稳定性或任意音视频格式；4096 字节是本项目策略上限，不是微信已验证的文本上限。文本接收仍只发布 `wxbot-` 前缀且涉及 `filehelper` 的消息。当前主动 API 保持上述实验范围。
