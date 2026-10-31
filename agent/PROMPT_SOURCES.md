# 默认小鲸鱼人格：来源与适配

2026-10-30。按用户要求替换旧默认人格，主体参考 Derpyu520 的小鲸鱼角色卡，补充群聊/私聊互动细则。当前文件为针对本项目重新组织的适配版本，场景示例重新编写，不作为真实聊天或经历注入。

## 来源

- [Derpyu520/qq-bridge：小鲸鱼角色卡](https://github.com/Derpyu520/qq-bridge/blob/main/roles/%E5%B0%8F%E9%B2%B8%E9%B1%BC.md)：主要角色方向，鲸鱼形象、嘴硬与认真之间的反差、短消息和场景示范结构。
- [SugarMGP/MumuBot：群聊模板](https://github.com/SugarMGP/MumuBot/blob/main/config/persona_group.prompt)：参考多人对话归属、话题转换和处理纠正的行为细节。
- [SugarMGP/MumuBot：私聊模板](https://github.com/SugarMGP/MumuBot/blob/main/config/persona_private.prompt)：参考一对一连续对话、结束话题与关系分寸。
- [SillyTavern：Character Design](https://github.com/SillyTavern/SillyTavern-Docs/blob/main/Usage/Characters/characterdesign.md)：参考将角色描述和示例对话分别组织的思路。

## 本地文件职责

- prompts/personas/default.md：角色、性格、表达反差与虚构场景示范。
- prompts/participation/helpful.md、prompts/reply-decision.md：新名字与别名、参与和旁听判断。
- prompts/group.md、prompts/direct.md：分别处理多人和一对一互动。
- prompts/styles/default.md：单条约10字的明确拆分要求、完整内容和格式例外。
- prompts/base.md、prompts/tools/default.md：当前人格来源、记忆与短期语气、实际工具和权限。

历史聊天不清空，但旧角色台词和记忆中的自我介绍不能覆盖本轮可信人格。后台总结继续不带人格，避免角色设定污染事实。

## 适配取舍

角色形象不等于官方身份、实际模型厂商或现实身体。认真求助时正常核实和协助；闲聊中的嘴硬、装傻不扩展成胡编事实或虚报完成。原项目的工具名、跨会话查询、动作接口和延时唤醒没有直接搬入，本项目只使用实际提供的工具与隔离范围。

每条约10字限制的是消息气泡，不是整次回答；使用messages数组分条，必要内容不删减，链接/代码等不硬切。假想场景只是语气参考，模型无需每次复述固定台词。

本机当前配置使用default人格，未设置群/联系人提示词覆盖。提示词文件支持后续轮次热更新；bot_name变量的默认值也改为小鲸鱼，已运行进程需重启才能使用更新后的代码常量。本轮不重启、不调用付费模型、不发送微信消息，实际聊天自然程度仍需后续验证。
