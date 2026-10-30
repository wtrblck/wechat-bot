# P4：无钩子媒体接收

更新：2026-10-29。适配并实测的桌面版本为 4.1.15.56。

表情接收现已接入同一媒体接口：`--media --download` 识别 type 47、返回 `media.kind=emoji`，保留完整 GIF/PNG/JPEG 原始文件；实测动态 GIF 22 帧、1980 ms，哈希和所有帧解码通过。收藏目录、预览及原生发送见 [表情 API](EMOJI_API.md)。

`db_receive.py --media` 提供本地媒体解析和鉴权读取；加 `--download --pid PID` 后，缺失的入站普通图片和视频由串行队列调用微信原生异步下载。没有接收路径钩子、UI 操作或主动发送。**指定联系人和群各四类真正入站正文均已通过 HTTP 验收，P4 的默认正文范围完成。** 图片提供普通正文；独立高清/原图下载尚未验收。

## 启动与观察范围

```powershell
$env:WECHAT_DB_DIR = 'E:\xwechat_files'
$env:WECHAT_BOT_SELF = 'wxid_yourself'
$env:WECHAT_BOT_OBSERVE = 'wxid_test_contact,123@chatroom'
# 媒体没有 wxbot- 正文。显式清空前缀，并保留指定会话限制。
$env:WECHAT_BOT_OBSERVE_PREFIX = ''
py -3.14 weixin-research/db_receive.py --serve --media --seconds 60 `
  --conversation wxid_test_contact --conversation 123@chatroom

# 安装特殊图片解码依赖（项目目录内，不修改系统 Python）
py -3.14 -m pip install --target weixin-research/deps -r weixin-research/requirements-media.txt
# 先用 doctor.py --pid PID 核对主进程；启用后台下载
py -3.14 weixin-research/db_receive.py --serve --media --download --pid PID --seconds 60 `
  --conversation wxid_test_contact --conversation 123@chatroom
```

要求电脑版已登录；Python 3.14 的 `compression.zstd` 用于有界解压消息 XML，图片解码使用 Pillow，AES 使用已有的 cryptography。语音复用固定指纹的本机 VoipEngine.dll 独立解码进程。图片参数优先使用数据库读取器得到的账号配置；也可用 `--image-keys PATH` 指定本地 JSON（`aes_key` 为 16 字节 ASCII 字符串，`xor_key` 为 0..255）。不要把参数放进源码、共享日志或 HTTP 响应。

只为已经通过观察策略、去重并进入 EventStore 的消息创建媒体 ID。启动时的既有消息不会自动回放；游标/去重窗口与现有接收服务共用。媒体事件的 `content` 是 `[image]`、`[video]`、`[voice]`、`[emoji]` 或附件名称，不发布含 CDN 参数和密钥的 XML。

## HTTP 契约

端口默认 `127.0.0.1:17869`；`Host` 和 `Authorization: Bearer TOKEN` 校验与 `/events` 相同。会话文件在 `runs/db-receive/db-session.json`，退出时删除。

| 请求 | 返回 |
|---|---|
| `GET /events?after=N` | 原事件及 `media`；`server_id` 用字符串返回 |
| `GET /media/ID` | 最新媒体状态和可用变体，JSON |
| `GET /media/ID/content` | 默认正文，二进制 |
| `GET /media/ID/content?variant=thumbnail` | 缩略图/封面（如已存在） |
| `GET /media/ID/content?variant=original` | 原图/原始视频（如已存在） |
| `GET /media/ID/content?variant=silk` | 原生语音 SILK（如已取得） |

`media` 包含 `id`、`url`、`kind`、`state`、`reason`、`variants`，以及已核实的文件名、预期大小/MD5、声明时长。每个变体含 `url`、`mime`、`size`、`sha256`。语音 `duration_ms` 来自实际解码，`declared_duration_ms` 保留消息 XML 的值。启用下载时，图片/视频还可带 `download: {state, attempts, native_status}`。

- `pending`：消息已收到，正文尚未取得或校验未通过；缩略图可能已可读取。不会因缩略图存在就标成完整内容可用。
- `ready`：正文或原始内容已解析；默认 `/content` 可读。图片经过实际图片解码；文件/视频存在 XML MD5 时校验，普通正文也校验声明大小；语音校验 SILK 包并独立解码 WAV。
- `failed`：元数据/编码不支持或处理失败；公开错误不包含源数据库路径、SQL 或解码日志。

状态更新不生成新的消息游标；客户端在 `pending` 时轮询 `/media/ID`。事件缓冲中的状态也会在接收循环内更新。未准备好的正文返回 HTTP 409，过期/未知 ID 返回 404，未鉴权返回 401。所有内容返回 `no-store`、`nosniff` 和 `attachment`，不以附件原名映射文件系统路径。

## 已验证的关联方式

- 资源库 `MessageResourceInfo` 通过自身 `ChatName2Id.rowid`、会话名、消息 local_id、create_time 和完整 local_type 联合查询；不混用消息库与资源库的数字 ID。
- 图片/视频的资源文件标识来自 `packed_info` 的 protobuf 字段 `2 -> 1`。图片目录为 `msg/attach/MD5(conversation)/月份/Img/`；普通图、`_h` 原图、`_t` 缩略图分别处理。消息 XML 的 MD5 与资源文件名不相同。
- 群图片可能没有资源库记录。此时按会话、local_id、create_time、server_id 和 local_type 精确读取消息库的 `packed_info_data`，使用字段 `3 -> 4`；不搜索目录猜文件。
- 文件落盘名来自 `MessageResourceDetail.packed_info` 的 `1 -> 2`，支持微信保存时的 `(1)` 等重命名。不会按显示名搜索并任取同名文件。
- 视频在 `msg/video/月份/标识.mp4`，原始版本为 `_raw.mp4`，封面为 `_thumb.jpg`；时长声明取 `playlength` 秒。
- 语音按各 `media_N.db` 自己的 `Name2Id`、local_id 和 create_time 查询 `VoiceInfo.voice_data`；只接受实际有效的 Tencent SILK，不人为补头。
- V1/V2 图片分段按真实 PKCS7 密文长度处理，保留明文中段并解 XOR 尾段；缺参数保持 pending。格式与参数派生参照 [ChatTrace v0.5.0 的作者记录](https://github.com/qiaodogbear/ChatTrace/releases/tag/v0.5.0)，本机已独立验证恢复的普通 PNG MD5 与消息一致。
- 微信普通图片可能是 `wxgf` 包装的 HEVC。先核对解密数据与 XML `hevc_mid_size`，再用独立 FFmpeg 进程转为 PNG，并实际解码。变体记录 `transcoded_from=image/wxgf`、`source_size`、`source_sha256`；`size/sha256` 对应 HTTP 返回的 PNG。XML 的原始 JPEG 大小/MD5 不适用于 HEVC 和转码 PNG，不能宣称两者哈希一致。解码器单次限时 15 秒；依赖为 [imageio-ffmpeg 0.6.0](https://pypi.org/project/imageio-ffmpeg/0.6.0/)。

## 后台下载契约

`media_download.py` 只接收观察策略已允许、方向明确为 incoming、具有完整消息身份的 pending 图片/视频。server_id 始终以十进制字符串进入配置，再生成精确的原生 uint64 常量，避免 JavaScript 大整数截断。单项仍限 64 MiB。

固定版本调用链为：原生应用任务检查点 `0x4A1FD0` → 按会话/local_id/时间查询 `0x17B9B90` → 再核对 server_id/类型/会话 → 微信自有消息副本 `0xA85BA0` → 异步下载 `0x1813980`。普通图片参数为 2、视频为 32。每次调用核验 DLL 文件哈希、加载模块和函数入口字节；接收路径不安装钩子。

下载期间由微信原生任务持有消息和异步结果的引用，脚本只轮询结果，禁止在检查点等待网络。10 秒内未完成返回 `download_pending`，释放本次持有的结果引用；微信自己的任务可继续运行。独立夹具验证了任务在脚本卸载后完成且引用清零。`native_completed` 仅表示原生结果为 `[0,0]`；只有接收循环重新读取并验证正文后，媒体才会变为 ready。未取得正文时 `/content` 继续返回 409。

队列最多 32 项等待/执行、128 项状态历史，一次执行一项，同一精确消息去重；失败或仍无正文时至少间隔 30 秒重试，最多两次，之后 `exhausted`。公开状态不带原生异常日志和磁盘路径。退出取消等待任务，等待当前原生请求安全结束，不强制卸载正在运行的回调。

目前仅图片/视频需要的原生下载已接入。文件和语音读取微信已经落地的正文；缺失时保持 pending。原图/原始视频只读取已在本地存在的版本，未宣称独立高清下载完成。每次任务仍短时附加/卸载；长期调度、退出重连和异常任务恢复属于 P6。

## 容量与生命周期

单内容上限 64 MiB；语音原数据上限 2 MiB、实际解码不超过 60 秒；元数据解压后上限 1 MiB；图片最多 5000 万像素。每会话最多保留 128 个媒体项、256 MiB 缓存，TTL 为注册后 1 小时。超限按最早注册项淘汰，包括 pending；正文不完整、MD5 不符保持 pending，继续等待本地文件更新。

缓存位于 `runs/media-cache/随机会话目录/`，ID 只在当前服务有效。正常关闭删除该会话的缓存；异常退出残留只在后续启用媒体服务时清理超过 1 小时且符合生成命名规则的目录，活跃会话每轮刷新目录时间。每轮最多处理 4 个媒体任务；数据库查询、文件读取、图片解密和独立语音解码由接收循环执行，HTTP 请求只读取状态/缓存。大量语音仍可能延长轮询间隔，尚不代表 P6 的独立常驻任务调度器。

## 验证与证据

```powershell
# 自动化边界测试；不操作真实微信
py -3.14 -m unittest discover -s weixin-research/tests -p test_media_receive.py -v
# 在服务运行且有消息时，通过 HTTP 取回内容并检查；不会发送任何消息
py -3.14 weixin-research/check_received_media.py
```

检查器默认仅检查 `incoming`，把事件、SHA256/适用的 XML MD5 校验、图片解码和 WAV 实际时长保存到证据目录；视频由 FFmpeg 全程解码，再用 OpenCV 取尺寸/时长。输出媒体保存在同目录作为本地验收证据，**这份证据不是服务缓存，不会由缓存 TTL 删除**。不要提交或共享真实聊天内容。`--include-outgoing` 必须显式使用。

本轮最终证据在 `runs/p4/download-complete/evidence.json`，汇总见 `P4_TEST_RESULTS.json`：此前真正收到的联系人/群各四类消息，重新读取原数据库行，经完整生产下载队列及鉴权 HTTP 验证，8 项全部 ready。两边图片由 19092 字节 HEVC 普通正文转为 500×606 PNG；两边视频 1391209 字节且 XML MD5 一致，全程解码通过；附件 6105424 字节且 MD5 一致；两段语音实际解码 3380/2300 ms。网络初次取回证据在 `runs/p4/native-async/`；生产队列复验为缓存命中，不能混称新消息网络下载。临时 HTTP 服务、令牌和会话缓存已清理，微信保持运行。

74 项自动化测试、13 项主动发送夹具、17 项观察器夹具、4 项异步下载生命周期夹具通过。下载夹具命令：`py -3.14 weixin-research/tests/integration_download_async.py`。

失败研究证据仍保留：`0x1820E90` 是跨设备下载请求，返回成功不代表本地正文下载；`download_resource.c` 的资源接口不适用于普通图片/视频；`download_message.c` 调用的同步等待包装曾阻塞原生任务与脚本卸载，已撤销并清理旧实例，禁止在服务中使用。生产入口仅使用 `download_async.c/js`。
