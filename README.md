# wechat-bot

Windows 本机微信机器人：Python 常驻桥接负责微信消息收发，TypeScript / dsh 智能体负责群聊参与、模型回复、记忆和工具调用。接收使用本地消息数据库，发送通过版本锁定的原生接口完成，不操作鼠标、键盘或剪贴板。

## 能力

- 每群、每联系人独立会话；群聊可无需 @ 自主参与，支持安静、停止和恢复。
- 最近200条连续消息，含bot回复；后台独立总结，按需检索摘要和历史。
- 图片、表情及文本附件理解，PNG/JPEG/GIF/WebP 图片通过模型图片工具读取。
- 一次回复最多30条，按前一条长度间隔约0.5–1秒。
- 向当前会话发送文件，保留文件名，最大10MiB。
- 沙箱外目录浏览、文件读取和写入，须指定微信联系人逐次批准。
- 网页搜索与抓取、提示词分层配置、每日模型费用上限和北京时间零点恢复。
- 持久队列、稳定请求ID、发送状态跟踪；不确定发送不会自动重试。

## 环境

| 组件 | 要求 |
|---|---|
| 系统 | Windows 10/11，微信已登录；连接微信进程需要管理员权限 |
| 微信 | 仅支持 ABI profile 对应的 **4.1.15.56** 和 DLL SHA-256 |
| Node.js | **24.22 或更新的24.x** |
| pnpm | **11.22.0** |
| Python | **3.14**，可使用 `py -3.14` |
| dsh | 锁定 **0.2.1-rc.2**，随依赖安装 |

Python 媒体依赖附带 FFmpeg。研究用原生测试程序另需 MinGW/GCC。

## 安装和首次配置

```powershell
git clone https://github.com/wtrblck/wechat-bot.git
cd wechat-bot
py -3.14 -m pip install --target weixin-research/deps -r weixin-research/requirements.txt
cd agent
pnpm install --frozen-lockfile --ignore-scripts
pnpm run setup
cd ..
```

`pnpm run setup` 交互式填写本人微信ID、数据库根目录和账号目录、允许的联系人及群、微信DLL路径，以及可选的授权联系人。它生成被 Git 忽略的本地配置、独立 dsh profile 和桥接白名单。已有配置不会覆盖。

安装时显式忽略依赖构建脚本；当前渠道不使用 dsh 的 PTY 或本地命令执行能力。该安装方式已通过完整测试，也避免 pnpm 11 在未批准可选依赖构建时退出失败。

在管理员 PowerShell 中设置模型凭据后启动：

```powershell
$env:DEEPSEEK_API_KEY = '<your-api-key>'
./start-bot.ps1 -Check
./start-bot.ps1
./start-bot.ps1 -Status  # 只读检查运行状态
```

设置好用户级环境变量并重新打开终端后，也可双击 `start-bot.cmd`。不要把密钥写入仓库。启动器先编译和校验，再启动或复用桥接和bot；日志在 `agent/data/startup/`。

默认私聊消息以 `/ai ` 开头，允许的群可自主参与。`/bot help` 查看控制命令。预算示例为每天5元；价表有时效检查，部署时须核对价表和模型设置。

## 沙箱外授权

启用外部文件工具后，指定联系人收到含来源会话、路径和用途的私聊申请；写入还列出大小、内容SHA-256和文本预览。联系人需私聊回复 `/bot allow 编号` 或 `/bot deny 编号`。批准仅限本次操作，不是目录长期授权；群内或自然语言答复不授予权限。申请和答复进入该联系人的独立会话。详见[文件交付与授权](agent/FILE_ACCESS.md)。

## 测试

```powershell
cd agent
pnpm test
cd ..
py -3.14 -m unittest discover -s weixin-research/tests -p 'test_*.py'
```

测试覆盖消息去重、会话隔离、预算、记忆、图片、分条、文件和授权。它们不等同于长期在线或所有微信版本的实机验收。

## 结构和文档

| 路径 | 内容 |
|---|---|
| `agent/src/` | 智能体、工具、记忆、预算、持久队列 |
| `agent/prompts/` | 系统、人格、参与准则、工具提示词 |
| `agent/tests/` | TypeScript测试和真实dsh内核模拟 |
| `weixin-research/` | Python桥接、C/JS原生接口、研究工具 |
| `weixin-research/tests/` | Python测试和原生测试程序源码 |
| `weixin-research/versions/` | 固定微信版本的ABI数据 |

详见[智能体](agent/README.md)、[记忆](agent/MEMORY_V2.md)、[媒体](agent/MEDIA_V2.md)、[桥接](weixin-research/BRIDGE_SERVICE.md)、[架构](AGENT_ARCHITECTURE.md)、[更新记录](CHANGELOG.md)。

## 边界和发布内容

使用前确认有权处理对应账号和聊天数据。本项目依赖特定微信版本，不附带微信安装包或DLL；版本不同必须重新验证ABI，不能猜测偏移。语音、视频、复杂Office/PDF内容未接入模型理解，GIF按静态图片读取。`server_confirmed` 不等于人工确认收件，尚未完成长期在线验收。

源码发行版排除本地账号配置、密钥、会话日志、数据库、实机收件记录和依赖缓存；示例身份均为占位值。测试媒体为合成数据。

## 许可

采用 [Apache-2.0](LICENSE)。第三方读取代码保留原许可，见 [NOTICE](NOTICE) 和[第三方说明](THIRD_PARTY_NOTICES.md)。
