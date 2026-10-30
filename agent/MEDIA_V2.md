# 微信图片与文本附件接入（2026-10-30）

## 数据流

微信接收 → 已授权桥接的 `/media/<id>` 与 `/content?variant=content` → 校验大小/SHA256 → 原始字节复制到 `agent/data/sandbox/<scope>/media/<资源ID>.<扩展名>` → 在消息的attachment字段中提供沙箱相对path → 模型按需调用读取工具。

不使用桥接返回的宿主path作为文件读取来源，也不把附件名称拼入磁盘路径。资源ID由会话和桥接媒体ID推导；同内容跨群使用各自副本。图像按实际字节签名识别，文件形式发送的图片也可以查看。文件内容不直接塞进文本上下文。

## 支持范围

- PNG、JPEG、GIF、WebP：普通图片和图片类型文件。GIF经图片管线读取，不声称理解全部动画。
- 常见纯文本文件：TXT、Markdown、CSV/TSV、JSON/JSONL、YAML、XML、日志、配置及代码等文本扩展名，或桥接明确声明的text MIME。UTF-8严格解码、带BOM的UTF-16LE/BE、GB18030回退；拒绝NUL/二进制控制字符。磁盘副本保持原始字节，工具读取时解码。
- PDF、Office、压缩包、音视频和其他二进制暂不解析，返回unsupported。不能把文件名当作已经理解的内容。

## 工具与上下文

`recent`中的每条消息在副本准备好后携带attachment，含messageId、state、format、path、mime、bytes和readTool。path相对当前会话沙箱，历史消息的附件关联跨执行/重启保存在message_media中，不只出现在收到附件的那一轮。

- `prepare_attachment({messageId})`：准备/重试当前会话中的已知媒体消息，不能任意指定桥接资源或宿主文件。
- `read_text_file({path,offset?,limit?})`：分页读取已登记的文本附件，默认12000字符，最多16000字符，nextOffset用于继续。拒绝越界、跨域、修改或过期的文件。
- `read_image({path})`：读取已登记的图片副本，调用dsh官方 `LocalAttachmentStore.saveImage` 完整解码、规范化和持久化，以官方ImageBlock格式返回给模型，实际查看而非仅返回路径。要求当前精确模型路由声明image输入。最多6次图片查看/回复。

附件会在接收后的轮询中后台准备（最多2个后台任务），当前批次准备先于群参与判断。相同消息的背景准备与显式准备合并，不重复下载。pending最多等待30秒，暂时失败退避60秒；退出时取消并排空准备任务。缓存过期会在上下文标为expired，允许重新准备，不把缺失资料当作已读。

## dsh与费用

专用wechat profile新增官方 `@deepseek-ai/dsh-attachment-local`，bot插件显式依赖attachments服务；无需开放宿主通用文件工具或shell。原始副本留在会话沙箱，dsh的不可变图片附件另存于专用DSH_HOME，由模型适配器读取。

本机 `deepseek-flash` 支持图片。官方视觉文档给出的单图上限为1024输入token，见 [DeepSeek Vision](https://api-docs.deepseek.com/guides/vision/)。价格快照为Flash别名增加此上限与来源。每次模型请求按所有保留图片逐张预留1024输入token，另加文本/协议预留；按真实usage结算，不另行重复计算已包含在inputTokens中的图片。无已核对图片价格上限的路由拒绝图片请求，5元/日限制继续生效。

## 本机配置与边界

本机和示例media.enabled已设true。桥接本地配置启用media和download，用于获取普通图片缺失正文；未扩大联系人/群白名单。服务保持停止，需显式启动后再进行真实微信媒体验收。

随后已按用户要求开启本机桥接emoji开关：表情包下载与图片理解链路可用，GIF仍按静态图片读取。启动入口为项目根目录start-bot.cmd，写脚本及检查不等于服务已启动。

默认单附件10 MiB、沙箱缓存256 MiB、TTL24小时。原有workspace工具仍受沙箱限制，图片读取额外要求资源登记与完整性验证。文件文字、图片内文字和附件提示都视为不可信资料，不改变权限。独立总结与参与判断无工具权限，不能仅凭路径总结图片内容。

256 MiB/24小时只约束微信原始沙箱副本。dsh持久图片附件与执行日志独立保留，以支持会话回放，不因原始缓存过期而自动删除。
