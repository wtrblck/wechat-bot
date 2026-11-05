# 本机 Codex CLI 接入

Bot 可把任务交给本机 Codex CLI，用 ChatGPT 账号执行，完成后自动将最终回复发回提交任务的联系人或群聊。任务、工作目录、查询和结果回传按会话隔离，不续用其他 Codex 聊天。

## 登录

本机需安装支持 `exec --json --ignore-user-config --strict-config` 和命名权限配置的 Codex CLI。本次验证版本为 `codex-cli 0.146.1`。Windows 使用可直接运行的 `codex.exe`，而非依赖 shell 的 `.cmd` 包装器。

在 `agent/` 下运行：

```powershell
npm run build
npm run codex -- login
npm run codex -- status
```

`login` 启动官方浏览器登录，用 ChatGPT 账号完成授权。无浏览器环境可用 `npm run codex -- login-device`，需要账号已允许设备代码登录。成功状态为 `Logged in using ChatGPT`。不要把密码、令牌或 `auth.json` 发给 Bot。

Bot 使用 `codex.home` 指定的独立目录，默认 `agent/data/codex-home`。登录信息由 CLI 保存和续期，不复制到 Bot 配置或微信；运行时使用同一目录，强制 ChatGPT 登录，并清除子进程中的 Bot 服务商密钥等无关环境变量。登录应在运行 Bot 的同一机器/用户环境完成。

## 微信中使用

直接发送，无需聊天模型判断：

```text
/bot codex 用 Python 写一个 CSV 去重工具，并说明用法
/bot codex status
/bot codex status <任务编号>
/bot codex cancel <任务编号>
```

也可以说“让 Codex 帮我……”，Bot 使用 `codex_submit` 提交、`codex_status` 查询。任务先返回编号，后台独立于本轮聊天运行，完成后自动回传。排队不等于完成。结果沿用 Outbox 的持久发送与去重，发送状态不代表实际收到。长结果沿用原有附件交付规则，也可通过任务编号查询。

`/bot stop` 停止本会话可取消的聊天和 Codex 工作；`/bot new` 取消旧代任务。群内取消沿用管理员权限。会话关闭、静默、权限收回、数据缺口、预算保护或 Bot 正常退出也会停止可取消的任务。已完成的文件修改不回滚。

## 文件范围

- **仅沙箱**：工作目录固定在该会话 `data/sandbox/<会话标识>`；权限配置拒绝其他文件读写，只保留 CLI 所需的最小系统运行路径。模型不能指定宿主目录。
- **任意路径**：Codex 使用完全权限模式，直接执行本机命令、联网及读写任意路径，不请求逐次批准；可在 `codex_submit` 中指定现有绝对 `cwd`。仍受运行 Bot 的 Windows 账号权限约束。
- **按任务确认**：Codex 按仅沙箱运行，不将文件任务授权扩大为命令执行授权。

仅沙箱模式拒绝命令读取 Bot 专用 Codex 登录目录，并关闭命令直接联网；CLI 连接模型的网络不受影响。Windows 受限读取依赖 `windows.sandbox="elevated"` 后端，无法建立时失败，不自动放宽权限。任意路径模式按本机操作者授权使用 `--dangerously-bypass-approvals-and-sandbox`，不依赖该 Windows 沙箱执行器。管理台收回任意路径权限、关闭会话或停止任务后，程序会请求终止运行中的 Codex 进程。

## 配置与恢复

```yaml
codex:
  enabled: true
  executable: codex
  home: data/codex-home
  # model: 可选，留空使用 CLI 默认模型
  timeoutSeconds: 1800
  maxConcurrent: 1
  maxQueued: 10
```

任务不接受任意 CLI 参数或环境变量；正文通过 stdin 传入，不拼接 shell。仅保存有界的最终回复和用量，不回传推理、命令过程或 stderr。输出流上限 4 MiB，最终回复最多 100000 字符。

队列保存在聊天数据库 `codex_tasks` 表，按聊天保留期清理。相同输入/任务/目录的重复提交返回原编号。重启后未启动的排队任务仍需通过权限检查；已运行但没有确定结果的任务标记为 `interrupted`，不自动重跑有副作用的工作。正常关闭取消未完成任务。

Codex 消耗 ChatGPT 账号的 Codex 额度，不计入 DeepSeek 人民币账本；Bot 整体预算保护暂停时也停止 Codex 工作。

## 验证

```powershell
# 最小真实连接检查：只返回 BOT_CODEX_OK，不发微信、不读写业务文件
node scripts/check-codex.mjs
# 不调用模型：验证沙箱内可读写、沙箱外测试脚本不可读
node scripts/check-codex-sandbox.mjs
# 仅在明确授权完全权限时使用：执行一次只打印固定文本的本机命令
node scripts/check-codex.mjs --full-access
```

参考：[非交互任务](https://learn.chatgpt.com/docs/non-interactive-mode)、[ChatGPT 登录](https://learn.chatgpt.com/docs/auth)、[文件权限](https://learn.chatgpt.com/docs/permissions)。

本机验证：ChatGPT 登录及最小真实任务已通过，返回 `BOT_CODEX_OK`；明确授权后的完全权限命令检查也通过，返回 `BOT_CODEX_FULL_ACCESS_OK`。仅沙箱模式的 Windows 执行器边界检查遇到 `timed out after 15000ms connecting runner pipe-out`，会影响该模式下需要本机命令/文件工具的任务；任意路径模式不依赖这个执行器。仅沙箱模式不会因此自动放宽权限。
