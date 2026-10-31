# 本地动态图片原生发送修复（2026-10-31，18:02上传路径补齐）

## 最终行为

- `/send/image`保持原契约与幂等ID。bot的沙箱、冻结文件、权限、会话范围、outbox及引用计数均沿用现有流程。
- 按验证后的实际内容路由，GIF（包括单帧GIF）→本地原生表情；动画WebP/APNG→全帧GIF→本地原生表情。静态PNG/JPEG/WebP仍为图片。
- GIF不伪造URL、不依赖收藏、不修改微信收藏数据库、不以type 3或静态首帧降级。无法准备时明确失败，unknown不自动重发。

## 原生依据与回滚差异

固定DLL为4.1.15.56，SHA256 `e0428a7b691853de496532523c2c09aa095f90941c37c9f4cfb3f137f3c66556`。

恢复两次成功试发的缓存导入入口RVA **0x6978540**（成功日志中十进制110593344）。反汇编文本的`.text+0x6977540`是节内偏移，不是RVA；函数入口、磁盘字节和运行时指纹都会检查。

`local-emoticon-import*.asm`中，该函数忽略rcx，rdx借用一个pair：object+0为真实内容MD5的std::string，object+0x40为本地路径std::wstring。函数在返回前同步完成缓存处理，不持有桥接输入缓冲区。导入返回false时native_error=14，不进入send。

早期实现导入后只使用收藏资源（0x1f0控制块），只能证明已知样本可播放，不能保证新MD5上传。17:13–17:14模型实测发现新素材167/168/176/177均status=5、server_id=0。17:28仅补文件资源和长度仍不完整，17:38消息186再次失败；真正缺失的消息文件路径在18:00补齐，详见下文。

现实现先构造完整原生基础资源，再由RVA 0x22FC160的复制构造器复制成EmoticonMsgInfo文件资源；分配0x1e0、原生控制vtable=0x9431d38、对象vtable=0x9431c28，原生文件长度虚函数读取DWORD +0x1c8，填入经校验的真实字节数。构造和释放已通过真实微信“仅构造、不发送”测试，然后才发送type 47。消息字符串由微信复制，资源引用转移给消息；临时资源与结果按原生引用释放。worker每次清空任务的local标志，允许收藏/本地表情交替执行。

禁止把本地路径/MD5记录缓冲区误传给要求完整原生对象的构造器。此前崩溃实验的调用不再使用；新的emoji_local_copy明确接受已构造的原生资源，并验证对象vtable、MD5及原生控制引用。偏移来自本机固定DLL离线反汇编，函数及控制/对象vtable均有指纹。历史实验日志保留。

## 验证

- Python全套：129项通过。
- TypeScript构建及全套：139项通过。
- emoji原生夹具：9组通过，包含本地导入失败不发送、仅构造不发送、损坏拷贝拒绝、发送失败、原生资源在脚本卸载后的延迟读取、常驻worker三次混合任务与失败后恢复。
- 原有常驻发送worker夹具：同一会话8个文本/图片/文件/视频/语音任务通过，正常释放后fixture进程仍存活。
- 真实桥接按实际native kind=emoji关联消息，保留原请求kind=image；没有更改bot的请求及存储契约。

## 实机复验与证据边界

先核对旧服务：bot degraded，桥接停止；没有待发送outbox或未结束任务。使用`agent/start-bridge.ps1`正式入口启动新版桥接，原bot自动重连至running/ready，未重发旧消息。提示词支持按生成重新读取；图库note代码在bot下次正常启动时更新。

只向授权联系人wxid_u3yyhe3yrwh122发送一条既用GIF，request_id=`gifrepair_20261031_library_01`。源文件53帧、1590ms、loop=0、1,526,604字节，SHA256 `2309d05d9d26a6d80907220753cc73bce5844080382a8bf564107c40b6176d30`。

2026-10-31 16:52实际dispatch native_kind=emoji；消息165，local_type=47，server_id=`7878617555998516640`，server_confirmed。**用户在本次聊天明确确认这条新消息在接收端以微信表情形式正常播放。** 此前消息163、164也已有用户接收端确认。

发送后媒体查询仍有独立限制：XML只有MD5/type=0/len=0，现有emoji解析器返回invalid_emoji_metadata。真实微信Emoticon缓存文件存在，但采用原生封装/加密，不能直接由Pillow解码，因此没有独立获得发送后的解码帧数和时长。不能用源文件指标冒充发送后媒体指标，也不能由server_confirmed推定播放；本次播放结论来自用户实测。

本机详细结果：`runs/gif-repair/bridge-trial.json`；服务日志：`runs/bridge/bridge.jsonl`；启动日志：`../agent/data/startup/gif-repair-20261031/`。

实机复验脚本`verify_local_animation.py`默认只读源文件；显式`--execute`才发送，固定授权联系人和既用文件，单次POST且不重试。`trial_local_animation.py`现在也要求已成功准备local_emoji，默认仅构造，防止回滚后误走普通图片发送。


## 17:28新文件上传复验

- 先仅构造并释放文件资源：phase=6，无发送，微信仍存活；再通过正式常驻桥接POST /send/image发送。
- 使用模型此前失败的相同冻结文件：20帧/1000ms/47,869字节，SHA256=1ff2ea88825a5b2c4424511a8d47e96123801598959d8d3f570a86687d0041c2 → 新请求gifupload_20261031_small_01，消息183，type 47，server_id=8767961314516626941。
- 40帧/2000ms/885,455字节，SHA256=1cd9a10b0db8fda12668bda309738c3525e277c9fcb8f4baaf2b8b90f778fbd9 → 新请求gifupload_20261031_large_01，消息184，type 47，server_id=5869855329442871159。
- 这两次是显式授权复验的新请求，不重新投递旧请求；只发送到wxid_u3yyhe3yrwh122。接收端播放需用户确认，不能仅凭server_confirmed推定。
- 新增emoji MD5关联，避免同会话连续表情串单；发送记录status=5且无服务器ID会转failed/native_message_failed，确认超时转unknown。
- 重启后按准确conversation/local_id/message_id恢复追踪，不重新发送。旧167/168/176/177已由真实行状态核实失败，再通过正常Outbox状态同步释放资源；维护路径禁止任何send调用，实测sendAttempts=0。
- 自动化：Python135项、TypeScript142项通过，原生emoji夹具9组与通用常驻worker回归通过。

详细证据位于runs/gif-upload-fix/：trial-failed-small.json、trial-failed-large.json、outbox-reconciliation.json和固定DLL离线反汇编。

## 18:02修复首次上传及漏确认

17:28的两次成功不足以证明首次上传可用。17:38消息186失败，而187实际已有服务器ID却漏确认；本次分别处理这两个问题。

原生链路证据来自固定DLL离线分析：消息处理器注册处0x39C0BA0通过0x38D5570构造EmoticonMessageHandler，对象vtable为0x96DFCB8，其+0x78方法为0x5AF3320。该方法在上传数据pair（message+0x768）为空时检查message+0x130，即message+0x120处wstring的长度；路径非空才在0x5AF373A调用0x3A2520读取本地文件，再构造原生上传数据。旧代码只导入展示缓存并填表情资源，消息文件路径一直为空，因而未向处理器提供首次上传所需的原文件。

修复为：本地GIF在应用线程使用已有wide_assign原生函数，将经过全帧验证并冻结在staging中的路径复制进消息+0x120；常驻worker同时为local_emoji填充wide_path。收藏表情不填文件路径。没有新增未确认ABI的原生调用，没有伪造URL、写收藏库、转静态图或修改MD5。原生消息拥有路径副本，staging保留1小时以支持异步读取。真实微信仅构造/释放测试phase=6通过，微信仍存活；原生夹具增加卸载后检查消息路径与长度、收藏/本地任务交替时路径隔离。

复验只向授权联系人wxid_u3yyhe3yrwh122发送，均使用新请求ID，不重放旧消息：

- 消息191：原186的完全相同文件，在补路径前的新请求成功；仅说明重复素材可成功。
- 消息192：从186的GIF加入诊断注释生成全新实际内容哈希，20帧/1000ms/loop=0/639885字节，SHA256=ef03fc5fc6608f1dabfec43ccbbc1109db43e92043a2eee0d031e138382a238d；补路径前首次发送失败，无服务器ID。
- 消息193：相同192文件，补路径后新请求gifpathfix_20261031_cold186_01成功，type 47，server_id=1457539989539052620。
- 消息194：另一份新的实际内容哈希，画面/帧时长/循环相同，SHA256=a14f144c6d3c0e8092613d5a23256e1d8f8a783e840b733fc8a0d9713d1ad68e；首次发送新请求gifpathfix_20261031_fresh_01成功，type 47，server_id=3794140457485566759。只读原生观察同时捕获上传文件读取，调用返回位置RVA=0x5AF373F，正好对应上述表情处理器读取分支。
- **用户在本次聊天明确确认消息193、194两张均以微信表情形式正常播放。** 本次接收端播放证据来自该确认。媒体查询仍有invalid_emoji_metadata限制，未以源文件帧数代替发送后独立解码结果。

漏确认修复：追踪未匹配的消息时，从发送前的原始watermark重读最多1000条记录，避免较新的文字先可见后跳过延迟写入的表情行；每个真实message_id只能被一个请求占用，防止相同MD5并发串单。已只读核实187的conversation/local_id/MD5/server_id，并把其原请求同步为server_confirmed，发送次数为0。

验证：Python137项通过；TypeScript构建及142项通过；原生emoji夹具9组通过。首次TypeScript运行受C盘TEMP写满影响，迁移本项目临时目录至E盘后完整重跑通过。正式桥接启动入口同样使用项目runs/runtime-temp，未清理其他用户文件。

证据：runs/gif-upload-fix/upload-path-evidence.json、gifpathfix_20261031_fresh_01.json、trial-cold-186.json；原生只读记录diagnostics/20261031T100143Z-f3dec780.jsonl。观察脚本observe_emoji_upload.py默认仅观察，不发送；仅记录本项目staging文件读取的固定标签和调用位置。
