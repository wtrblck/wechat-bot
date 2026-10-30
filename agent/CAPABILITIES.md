# 固定宿主适配验证

验证日期：2026-10-29（Asia/Shanghai）。Node 24.22.1、dsh 0.2.1-rc.2、Cordis 4.0.5。实际签名依据安装后的官方包，不将设计中的内部方法名冒充 SDK。

| 设计语义 | 使用的公开接口 | 验证/恢复行为 |
|---|---|---|
| 创建/恢复 | `ctx.agents.create` / `resume`，`SessionId` | 真实内核创建、关闭、重新加载、恢复同一执行 ID |
| 输入关联 | `agent.followup`，`MessageId(inputId)` | 持久 `user/message.data.id` 对账；未结算日志不再注入 |
| 输入接纳但未形成用户事件 | 只读 `sessionPersistence.stat/open/read` | 无法证明结算时进入 needs_review，不调用 resume 驱动待处理输入 |
| 公开最终回复 | 持久 `assistant/message` 与 completed `turn/end` | 取最终文本块；失败尝试、推理、工具结果和中断文本不公开 |
| 可靠提交 | `agent.whenIdle` + `ctx.sessions.flush` | 空闲之后明确 flush，再读取持久日志；不把事件通知当磁盘提交 |
| 稳定事件 ID | execution session ID + 持久事件 seq | 用于 Outbox 幂等投影和稳定 request ID |
| 取消 | `agent.cancel`、`whenIdle`、handle.dispose | 真实流式模拟模型取消测试；结算边界后释放 handle |
| 有界历史 | 每次完成后轮换 execution session | 逻辑 UUID/generation 保留；当前域外部记忆继续，旧动态快照不会累计进新请求 |
| 提示词 | scoped `systemPrompt.section(complete)` | 可信模板独立系统区，资料进入用户输入；不直接编辑宿主历史 |
| 工具隔离 | scoped native presentation、`restrict({allow:[]})`、scoped register + guard | 主回复只有渠道、沙箱文本和公网网页工具；决策/记忆没有工具，无 shell/任意宿主文件 |
| 沙箱工作区 | 会话 cwd + 可信工具逐级路径检查 | `data/sandbox/<scope>`；拒绝穿越、Windows ADS/设备、junction、符号及硬链接；不是 OS 容器 |
| 网页搜索/抓取 | 受限 GET + 全 DNS 校验 + 固定地址连接 + 逐跳校验 | 内网/本机拒绝；代理 fake-IP 独立 HTTPS 解析；有界纯文本；实际只读抓取/搜索已验通 |
| 问答 | 当前域 `ask_user` + 编号交互库 | 同会话同 generation 同发起人单次回答；重启失效 |
| 外部操作确认 | 绑定参数哈希、发起人、generation 的原子记录 | allow/deny 已实现；首版没有可执行的 operator 外部工具 |
| 单日费用控制 | 真实 `llm/stream` 调用前预留，usage 入账，持久流日志对账 | 主回复/判断/记忆/重试分别计费；缺失 usage 保留预留；到限停服，上海零点恢复 |

`agent/tests/dsh.test.ts` 仅为契约测试装配内核。部署入口始终为官方 `dsh --profile wechat`，加载 `cordis.patch.yml`，不另写生产 Cordis 启动器。

目前没有真实模型端质量/费用评测、视觉/ASR 集成、微信设备收件验收或长稳证据。
