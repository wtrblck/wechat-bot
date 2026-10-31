# 视频获取与理解

两条独立链路，均仅作用于当前会话。不会刷推荐流、点赞、发评论或自动分享。

## 获取视频

- `bilibili_search`：公开搜索索引，B站无结果时使用已有公开视频搜索接口。
- `fetch_bilibili_video`：BV号、av/BV视频链接、b23短链，支持`?p=2`分P。先调用原生view/playurl接口，下载普通文件或DASH音画并本地合并；兼容解析器作为备用。
- `douyin_search`：公开网页搜索索引，不声称覆盖抖音站内全部结果。
- `fetch_douyin_video`：单个视频链接、modal_id链接、v.douyin.com分享短链。详情API、公开分享页的JSON数据、yt-dlp备用解析器分层获取，不执行网页脚本。
- `fetch_video_url`：其他来源的公开HTTP/HTTPS视频**文件直链**；普通网站播放页不保证解析。也可直接接收微信视频、视频类型文件或通过external_read批准复制的本地视频。

平台解析成功后返回相对`path`、来源、标题、作者、时长等资料；这些不代表已看过视频。真实视频文件按内容哈希入库，跨会话隔离、完整性校验、过期清理，共用媒体缓存容量。平台提供且可访问的字幕会另外返回；缺字幕不阻止获取视频。

## 通用理解

- `video_probe`：本地探测时长、分辨率、有无音轨与内嵌字幕。
- `video_storyboard`：默认12格带序号、秒数的分镜，均匀覆盖时间窗口，180秒以内兼顾切镜。按真实图片附件传给当前模型，不只返回图片路径。长视频先概览。
- `video_zoom`：指定from/to（秒，最多60秒），每格提高到640×360，细看动作、切镜和屏幕文字。
- `video_transcript`：优先内嵌字幕；否则默认用本地多语言Whisper base、CPU int8识别，带时间戳；每次最多180秒，长视频可继续指定窗口。也支持管理员选择OpenAI兼容ASR端点。

支持常见MP4/MOV/3GP、MKV/WebM、AVI、FLV、Ogg、TS、MPEG容器。输入会按文件头选择固定解码器，不能把播放列表冒充视频读取本机文件。抽帧不是完整逐帧观看，快切需局部复查；ASR可能错字。无音轨、缺模型、受限/失效视频会明确返回状态。单独微信语音消息的识别不属于本次接入。

分镜与read_image/表情预览共用每轮图片额度，由现有图片附件服务和日预算统计；不假定一张分镜恒定消耗384 tokens。需要支持图片输入的当前模型。本地解码和本地ASR不调用付费模型；若主动配置外部ASR，它的费用不在DeepSeek日账本内。

## 安装与配置

在agent目录运行`powershell -File scripts/setup-video.ps1`。依赖安装到`tools/video-python`，不修改系统Python环境；模型放在`data/video-models/faster-whisper-base`，固定上游提交并校验文件摘要。运行时不自动下载模型。

`config/agent.example.yaml`提供完整video配置。必须同时开启`media.enabled`。默认文件最大128MiB、时长3600秒、媒体总缓存256MiB、单次处理90秒；仍受整轮120秒、12次工具和现有消息新鲜度限制。大文件或复杂长视频可能需缩短片段。微信桥接和external_read还受各自大小限制，发送视频仍为现有10MiB限制。

平台需要登录时，由操作者自行在本地准备Netscape格式Cookie文件：

- `config/bilibili.cookies.local.txt`
- `config/douyin.cookies.local.txt`

文件已加入忽略规则，不要把Cookie发进聊天或提交源码。本项目不会读取浏览器登录数据。Cookie过期、验证码、权限不足或地区限制不保证可获取；不绕过风控，不承诺所有公开视频都能匿名下载。

可选外部ASR配置：`video.asr.backend: endpoint`、`endpoint: http://127.0.0.1:8000/v1`、`model`和`apiKeyEnv`。仅管理员配置端点，模型不能指定端点；拒绝重定向。默认`backend: local`，`off`只关闭ASR，仍可提取内嵌字幕。

公开下载逐跳校验DNS并固定连接地址，拒绝本机/内网、任意端口、URL凭证和超限响应；Cookie不会随跨域重定向转发。FFmpeg只接触已下载的本地文件，有时限、分辨率和并发限制；临时音画流无论成功失败都会清理。主进程取消时结束处理子进程树。

## 验证

`pnpm test`当前153项通过，覆盖隔离、额度、真实解码、取消清理及DSH图片输入和预算。视频获取回归同时校验服务结果和实际工具输出的无损JSON边界，覆盖无字幕、可选字段缺失及字幕保留，避免已下载却因`undefined`字段被运行时拒绝。`py -3.14 scripts/test-video-worker.py`覆盖内嵌字幕、本地ASR、外部ASR音频与时间戳以及合并；本次未重跑Python专项。安装解码组件后才运行真实视频测试，缺本地模型会跳过本地ASR测试。

2026-10-31实测：B站公开视频`BV1d8pU6xEZX`获取3,462,920字节，合并成156.48秒、852×480且有音轨的视频；前15秒12格分镜可查看，前30秒本地ASR输出中文带时间戳片段。报告与图片在`data/validation/video-bilibili*`。

2026-10-31修复记录核验：聊天中失败的`BV1mHoXBMEf7`（《盘点KPL最常见的弹幕梗》）实际获取25,463,392字节，412.39秒、852×480、有音轨。经真实`fetch_bilibili_video`工具入口获取并通过DSH输出校验，返回path可用于`video_probe`及前15秒分镜（4格），跨会话读取被拒绝；隔离验证数据已清理，未发送微信消息。此次修复针对成功结果中的非JSON字段，不代表平台风控或无效短链已解决。

抖音官方解析器示例视频`6961737553342991651`的匿名实测被平台限制：原生详情/分享页无可用视频数据，备用解析器失败。实现已接入，**未完成登录后下载的实测**；需有效本地Cookie后重试。`node scripts/probe-video.mjs douyin URL`执行只读完整测试，不发送聊天消息。

## 参考

- https://github.com/c1overzz/dsh-bili-scroll ：B站资料获取与获取/观看分层。
- https://github.com/NEWJO123/dsh-douyin-scroll ：抖音只读获取及操作者配置Cookie。
- https://github.com/SAOS-3624/dsh-video-storyboard ：带时间戳分镜、概览后局部细看、字幕/音轨分开。
- https://github.com/yt-dlp/yt-dlp ：备用平台解析器。
- https://github.com/SYSTRAN/faster-whisper ：本地音轨转写。

本项目独立实现受控通道适配，没有加载这些项目的全局工具、定时刷流或独立付费模型调用。
