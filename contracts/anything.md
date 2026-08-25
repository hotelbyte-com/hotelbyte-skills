# contract: anything(状态:待上游合入)

- **现状声明(2026-08-25 更新)**:两端 PR 已开——
  - hotelbyte-cli#3(gotry/search-anything 分支,cherry-pick 到 v0.3.0 master 零冲突)
  - hotel-be#30949(gotry/anything-openapi 分支,@path 注解 cherry-pick 到 master)
  合入前,当前上游 CLI(v0.3.0+,fb7d44b)无此命令;gotry 实时链路以静态包兜底。
- 上游真实现面见 contracts/hotels.md;anything 合入上游前,gotry 的
  Anything 实时链路对现版 hbcli 不可用(诚实降级 [静态包:估算])。
- 输入(合入后): keywords;可选 contentType=city|hotel
- 输出: candidates[];miss 空数组
- 降级: 三值(见 SKILL.md);证据链 [实时API:hbcli-anything@ts]
- 域边界:本契约仅旅行域(城市/酒店/目的地);通用外部事实走 agent-reach(见 gotry 人格契约 14)
