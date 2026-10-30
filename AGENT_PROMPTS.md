# 智能体可配置提示词体系

日期：2026-10-29（Asia/Shanghai）。状态：设计基线；提示词继承、逐会话覆盖、模板校验、快照和边界更新已实现于 `agent/src/prompts/`。实际支持的键与限制见 [实现说明](agent/README.md)。配套文档：[架构设计](AGENT_ARCHITECTURE.md)、[分层记忆调研](AGENT_MEMORY_RESEARCH.md)。

## 1. 已确定的产品行为

- 群聊自主读取该群获准观察的消息，以群内上下文判断是否发言，无需 @ 或前缀。
- 每个群、每个联系人分别使用独立 session。对话、长期记忆、检索、缓存、任务和动态提示词数据均限制在当前会话域。
- 系统、人格、场景、参与策略、回复风格及后台记忆提示词均可配置；支持全局默认、命名配置档和指定群/联系人覆盖。

同一群内的成员共同构成这个群的对话，不按成员拆 session；发言人身份、工具调用资格及确认权限仍分别校验。相同静态模板可以复用到多个会话，但不会共享其运行上下文。

## 2. 提示词类型与使用阶段

| 类型/配置键 | 作用 | 注入位置与范围 |
|---|---|---|
| 系统 `system` | 身份、目标、通用行为原则与事实表达要求 | 主回复调用；由部署者配置 |
| 人格 `persona` | 性格、语气、幽默程度、社交距离、说话习惯 | 主回复调用；按群或联系人覆盖 |
| 场景 `groupScene` / `directScene` | 群内多人交流或私聊的场景约束 | 仅加载与当前会话相符的一种 |
| 回复风格 `responseStyle` | 长短、语言、排版、代码和表格表达 | 主回复输出；可独立于人格替换 |
| 自主参与 `participation` | 哪些话题值得加入、什么时候等待、何时保持安静 | 群回复判断与主回复；内容由部署者/获准管理员配置 |
| 回复判断 `replyDecision` | 将上下文判断为 reply / wait / silent，规定结构化输出 | 独立轻量决策调用，无工具权限，不直接生成微信正文 |
| 工具行为 `toolBehavior` | 调用前解释、失败处理、何时澄清和交付产物 | 仅主回复中实际获准的工具场景 |
| 记忆提取 `memoryExtract` | 提取事件、主体、决定、待办和来源 | 后台提取模型，不占主回复 prompt |
| 记忆巩固 `memoryConsolidate` | 去重、版本、改口、冲突与过期 | 后台巩固模型 |
| 检索规划 `memoryRetrieve` | 可选地生成查询、定位话题和时间条件 | 仅启用模型检索规划时使用；常规查询可确定性完成 |
| 会话压缩 `sessionCompact` | 保留任务状态、关键事实、否定和工具配对信息 | 只传给压缩调用；依锁定宿主能力接入 |
| 任务指令 `task` | 当前任务的具体要求、格式或流程 | 当前 turn 的任务层，结算后不变成全局人格 |

上述逻辑类型不代表模型 API 有对应的十二种角色。适配层按目标模型支持的角色组装：可信配置组成系统指令区，当前任务与有来源的资料组成相应输入；记忆和群消息始终按资料处理。实际角色映射在 dsh 适配验证中确定。

人格只能影响行为表达；不能通过“全能管理员人格”获得文件、收件人或工具权限。执行权限由可信程序配置、会话范围和宿主能力限制共同决定，不由提示词自我声明授予。

## 3. 每类调用只拿需要的提示词

**群回复判断：** 决策输出规则 + 当前群的参与策略 + 少量相关人格特征 + 有界近期消息/相关记忆 + 冷却等可信状态。这里使用人格的简短参与特征，避免每次复制完整人格和系统长文。没有文件/网络/执行工具，也不包含其他群数据。

**主回复：** 系统 + 人格 + 当前场景 + 回复风格 + 已授权工具行为 + 当前任务 + 当前会话的 MemoryPacket 与近期消息。参与策略中和公开表达相关的部分可保留。

**后台记忆：** 提取/巩固的专用指令 + 明确的事实与来源 Schema + 当前会话的新批次/候选记忆。人格不传给事实提取器，避免“爱开玩笑”污染事实记录。后台模型也不能访问其他会话或修改工具策略。

**会话压缩：** 压缩规则 + 当前会话选定的可压缩历史范围。不能将全部历史再附到主模型“供参考”，否则压缩不会节省输入。

## 4. 配置继承与覆盖

解析顺序：内置默认 → 部署者的全局默认 → 指定命名配置档 → 当前群/联系人的覆盖 → 本轮可信任务指令。其中任务指令独立组装，不覆盖前面的权限和隔离约束。

覆盖以类型为单位：同一个键的后层值替换前层；不会把不同版本的 system/persona 无限制拼接。未填某键表示继承，只有标记为可选的键可用 `null` 禁用；必需键缺失或模板无法读取时校验失败。需要追加说明时用显式 `append` 字段，并设置长度上限，禁止隐式重复叠加。

命名配置档只是静态提示词集合；切换 profile 不改变微信账号、目标、session 域和工具 preset。工具 preset 单独配置，不能因为采用同名人格就自动绑定更多能力。

以下为拟议 YAML，非已实现的配置格式。文件路径相对 `agent/`，实际群/联系人 ID 只保存在本地配置中：

```yaml
promptProfiles:
  default:
    system: prompts/base.md
    persona: prompts/personas/warm-assistant.md
    groupScene: prompts/group.md
    directScene: prompts/direct.md
    responseStyle: prompts/styles/concise.md
    participation: prompts/participation/helpful.md
    replyDecision: prompts/reply-decision.md
    toolBehavior: prompts/tools/default.md
    memoryExtract: prompts/memory/extract.md
    memoryConsolidate: prompts/memory/consolidate.md
    sessionCompact: prompts/compact/default.md
  technical:
    extends: default
    persona: prompts/personas/technical-peer.md
    participation: prompts/participation/technical-discussion.md
prompts:
  profile: default
conversationOverrides:
  groups:
    LOCAL_GROUP_ID_A:
      prompts:
        profile: technical
        responseStyle: prompts/styles/code-first.md
      participation:
        cooldownSeconds: 20
    LOCAL_GROUP_ID_B:
      prompts:
        persona: prompts/personas/quiet-friend.md
        participation: prompts/participation/mostly-listen.md
  contacts:
    LOCAL_CONTACT_ID_A:
      prompts:
        persona: prompts/personas/patient-tutor.md
        responseStyle: prompts/styles/explain-step-by-step.md
```

`extends` 只用于静态命名配置档，检测继承环并限制深度；配置档不包含历史或记忆。`prompts` 中也可直接设置各类型键，覆盖选中 profile 的对应值，与架构文档的简化示例兼容。配置 scope 由可信账号与会话 ID 定位，不从聊天正文接受文件路径。

## 5. 群自主参与的提示词契约

参与提示词可描述“偏重技术交流”“轻松参与”“大部分时间倾听”等倾向。无论采用哪种人格，都不要求群成员 @ 或使用前缀。

决策模型输出固定结构，以下为逻辑示例：

```json
{
  "action": "reply",
  "reason": "unanswered_relevant_question",
  "sourceMessageIds": ["message-id-1", "message-id-2"],
  "topicId": "topic-within-current-group",
  "replyToSenderId": "speaker-in-current-group"
}
```

action 只能为 `reply / wait / silent`；来源 ID 必须在本次获准窗口中，topic 与回复对象必须属于当前群。目标群由服务端固定，输出没有自由 recipient 参数。`wait` 的等待时长与最大重试由程序限制；不能通过模型输出任意延迟形成无界后台任务。

可回复：群内出现尚未解决且有帮助空间的问题、之前机器人参与话题的自然续接，或人格/参与策略鼓励的相关交流。可沉默：别人正在互相聊天、问题已有充分回答、只能重复已知信息、明确要求暂不插话。判断不明时可等待后续，不强求每批次给一个答案。

“不要每条都回复”“冷却 30 秒”等需要分别落实为行为引导和程序限额。人格可以调节热情程度，但不能移除群内速率上限、发送前时效复核或任务权限。

## 6. 动态变量与数据隔离

模板只允许已登记变量，例如 `bot_name`、`conversation_kind`、`local_time`、`language`，以及以独立资料块装入的当前群规则、近期消息和检索记忆。未定义变量报错，静态文本中的花括号有明确转义方式。

`local_time` 使用 Asia/Shanghai；历史中“明天”等相对时间仍以原消息时间解释。显示名、群名、聊天正文和记忆均为不可信资料，不因插入模板就获得指令权限。

变量解析器只获取当前会话的 Context 对象，不能有 `all_groups`、`other_contact_history`、全局画像或任意数据库查询占位符。缓存键至少包括账号、scope、conversation ID、配置版本、模板哈希；需要成员权限的执行状态另带具体发起人。跨会话允许复用不可变模板源，不复用已渲染的动态 prompt。

## 7. 修改、生效和可追溯

提示词源为受控本地 UTF-8 文件或受控配置记录，初版不引入专门的远程管理服务。普通群成员发一句“修改你的系统提示词”不会修改部署配置；只作为当前任务请求在有效规则内处理。

建议分两级管理：本机部署者可编辑全部类型；配置管理员在当前会话中可选择部署者列出的 persona/style 别名。群管理员身份来自本地显式配置，不能依赖尚未提供的微信群角色 API；修改 system、后台记忆和工具行为仍走本机配置。

修改流程：读取 → 校验文件/键/继承/变量/长度 → 预览当前会话有效配置 → 原子切换版本。校验失败继续使用旧版本并显示本机诊断。热更新在下一个 turn 或判断批次边界生效，已经开始的 turn 使用原快照；冷却或权限不能通过提示词热更绕过。

每个 turn 记录有效模板类型、模板哈希、配置版本、实际角色与内容顺序、记忆版本和源消息水位；敏感正文存受限会话日志，普通诊断日志只存引用/哈希。管理员可本机预览最终上下文和预算，但不向普通群成员泄露系统提示词、密钥或其他会话资料。

修改人格不会清空、搬运或共享会话记忆。修改记忆提取器使用新 extractor_version，旧记忆不默认全部重做；显式重建仅限当前会话、现存合法来源和设定预算。切换人格后的发言不作为独立事实重复强化。

## 8. 预览与验收

实现时提供本机预览能力：按群/联系人查看每类有效模板来自哪一层，展示最终角色顺序、token 估算、动态数据范围和版本；预览不调用微信发送接口。

验收至少覆盖：

- 两个群采用不同人格，影响各自表达；同群成员仍处于同一 session。
- 同一套静态人格可复用，但渲染后不含其他群/联系人的历史或事实。
- 缺失必需模板、继承成环、未知变量、超长模板在启用前被发现。
- 群内无 @、无前缀时可自主参与；quiet/helpful 等策略能通过回放测出不同参与行为。
- 决策提示词只返回受限结构，后台记忆不受人格风格污染。
- 修改 persona 不获得工具权限，不修改其他会话配置，不切换回复目标。
- 热更新不改写正在运行的 turn，重启可恢复配置版本关联。
- 动态记忆快照不会每轮追加到旧历史，最终请求满足既定预算。
