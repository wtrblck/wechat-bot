# 收藏表情发送与动态表情接收

适配 Windows 微信 4.1.15.56 x64。2026-10-29 实测：测试群收到的 GIF 为 240×240、22 帧、一轮 1980 ms，原始文件 328367 字节，经 HTTP 取回后 MD5 和全部帧解码通过。当前账号收藏的一个表情已作为原生类型 47 分别发到原测试联系人和群，用户确认“两边都收到，显示正常”。没有使用鼠标、键盘、剪贴板或 UI Automation。

## 接收

沿用数据库接收服务与观察策略，启用下载：

```powershell
$env:WECHAT_DB_DIR = 'E:\xwechat_files'
$env:WECHAT_BOT_SELF = 'wxid_yourself'
$env:WECHAT_BOT_OBSERVE = 'wxid_test_contact,123@chatroom'
$env:WECHAT_BOT_OBSERVE_PREFIX = ''
py -3.14 weixin-research/doctor.py --pid PID
py -3.14 weixin-research/db_receive.py --serve --media --download --pid PID --seconds 60 `
  --account YOUR_ACCOUNT_DIRECTORY `
  --conversation wxid_test_contact --conversation 123@chatroom
```

type 47 事件的 `content` 为 `[emoji]`、`media.kind` 为 `emoji`。只发布 MD5、声明大小/尺寸和表情包标识；不发布含签名地址、AES 密钥的 XML。媒体 ID、鉴权、缓存与 `/media/ID/content` 复用现有协议。

完整下载、大小/MD5 校验和全部图片帧解码通过后才变为 ready。GIF/APNG/WebP 动画保留原始字节，不转成首帧或 PNG；变体描述中提供 `frames`、`animated`、`duration_ms`、`width`、`height`，时长表示动画一轮。未启用 `--download` 时表情保持 pending，原因 `emoji_download_disabled`，正文返回 409。

网络失败至少等待 30 秒后重试，每个媒体项最多两次尝试；耗尽后 failed。格式、身份或哈希无效直接失败。`media.download` 提供 `requesting`、`retry_wait`、`completed`、`failed` 和 `attempts`，不含资源地址或密钥。

私有资源参数按会话、local_id、create_time、server_id、local_type 从精确消息行重新读取。下载只允许已验证的腾讯主机 `vweixinf.tc.qq.com`、`wxapp.tc.qq.com`，保留消息声明的 HTTP/HTTPS 协议，禁止重定向、用户信息、显式端口及控制字符；不关闭 HTTPS 证书校验。单资源最多 8 MiB，网络超时 10 秒，独立解码进程最多 12 秒、500 帧、单帧 1600 万像素/累计 1 亿像素、一轮最多 120 秒。

表情下载/解码在接收轮询线程执行，每轮仍最多四项；下载期间本机 HTTP 线程可以继续查询 pending 状态，但新消息轮询可能延后。这尚不是 P6 的长期独立调度器。账号本地 Emoticon 缓存的特殊编码未解开，当前从精确消息的原始资源恢复正文。

## 收藏列表和发送

发送服务需要显式开启收藏目录，账号目录应对应当前登录账号。收件人仍由原有白名单控制：

```powershell
$env:WECHAT_BOT_RECIPIENTS = 'filehelper,wxid_test_contact,123@chatroom'
py -3.14 weixin-research/send_api.py --pid PID --serve --emoji --seconds 60 `
  --db-dir E:\xwechat_files --account YOUR_ACCOUNT_DIRECTORY
```

服务仍绑定 `127.0.0.1:17868`，会话令牌位于 `runs/send-api/send-api-session.json`，关闭时删除。没有 `--emoji` 时表情路由返回 503，原有五类发送不受影响。

| 路由 | 作用 |
|---|---|
| `GET /emoji/favorites?offset=0&limit=100` | 收藏目录，单页 1～128 项；返回 `items`、`total`、`offset`、`limit` |
| `GET /emoji/favorites/ID/content` | 收藏预览原始文件，保留动画；需要同一令牌 |
| `POST /send/emoji` | 发送指定收藏表情，必填 `request_id`、`recipient`、`emoji_id` |

列表每项含稳定的 `emoji_id`（资源 MD5）、`caption`、`product_id`、`preview_url`。只读取 `kFavEmoticonOrderTable` 中当前存在的收藏，发送时再次联结 `kNonStoreEmoticonTable` 验证；不是收藏的 ID 会被拒绝。接口不接受路径、任意图片、XML、下载地址、密钥或原生偏移。

```powershell
$emojiSession = Get-Content .\weixin-research\runs\send-api\send-api-session.json -Raw | ConvertFrom-Json
$emojiHeaders = @{ Authorization = "Bearer $($emojiSession.token)" }
$favorites = Invoke-RestMethod "$($emojiSession.url)/emoji/favorites" -Headers $emojiHeaders
$favorites.items
# 从列表/预览选定 ID 后发送；同一个 request_id 可用于安全重试同一请求。
py -3.14 weixin-research/post_send.py --kind emoji --recipient wxid_test_contact --emoji-id SELECTED_ID
```

请求例：

```json
{
  "request_id": "favorite-emoji-001",
  "recipient": "filehelper",
  "emoji_id": "ID_FROM_FAVORITE_CATALOG"
}
```

收件人未允许返回 403；字段无效、表情未收藏、源格式不支持返回 400；并发忙碌/请求 ID 冲突为 409；原生错误为 502。成功返回 HTTP 200、`kind:emoji`、`accepted:true`、`local_status:[0,0]`。相同 ID/内容在本次服务进程内返回缓存，不重复发送。`delivery_verified` 仍为 false；手机确认记录在独立台账，不把本地接受等同于实际送达。

## 原生调用与证据

固定指纹调用链沿用应用任务检查点 `0x4A1FD0` 与发送入口 `0x17A3B60`。消息工厂为 `0x1C12A00`，类型为 47；收藏数据库记录按本版本真实布局构建借用输入，由原生 `0x20A2800` 复制成微信拥有的资源对象。控制块完全复现已核对的原生分配布局（`0x1F0`，对象 +16，原生控制 vtable `0x908AA98`，强/弱引用初值 1）；vtable 指针以相对模块地址校验，适应 ASLR。资源所有权转入消息 `+0x758`，收件人仍由微信自己的字符串赋值函数复制。结果和消息由原有引用释放流程清理，任务结束移除检查点。

密钥/签名地址只存在于私有输入和原生拥有的字符串中；日志将 `emoji_fields` 替换为整体 SHA256，表情的原生错误正文也不公开。CLI 离线准备模式的含私有参数脚本仅写入 `runs/emoji-send/`，不要共享该目录。

验证结果：84 项单元/HTTP 测试、13 项原发送夹具、17 项观察器夹具、4 项异步下载夹具，以及 5 项表情原生所有权夹具通过。表情夹具覆盖脚本卸载后延迟读取自有字符串、长收件人、身份复制错误拒绝发送、原生失败和仅构造释放；每项引用清零。实机另做了仅构造/释放检查，再通过真实 HTTP 向两个原测试目标各发一次，并核对类型 47、服务器消息 ID 和用户收件确认。

汇总见 `EMOJI_TEST_RESULTS.json`，原始证据在本机 `runs/emoji/`。当前收藏只有一个静态 PNG，因此动态 GIF 已做真实接收验收，动态收藏发送尚无真实收藏样本；原生发送不将表情改发为图片消息。商店表情包目录与长期常驻仍不在本次范围。
