# contract: anything(状态:待上游合入)

- **现状声明(2026-08-25 巡检)**:`search anything` 子命令存在于 gotry 侧分支
  (hotelbyte-cli commit 43236a0,detached,未合上游;hotel-be 侧 /api/search/anything
  注解 c38ff65d1 在 tmp/m1-rebase 待 merge)。**当前上游 CLI(v0.3.0+,fb7d44b)
  无此命令**——命令树已扁平化为 hotel-list/hotel-rates/destinations 等。
- 上游真实现面见 contracts/hotels.md;anything 合入上游前,gotry 的
  Anything 实时链路对现版 hbcli 不可用(诚实降级 [静态包:估算])。
- 输入(合入后): keywords;可选 contentType=city|hotel
- 输出: candidates[];miss 空数组
- 降级: 三值(见 SKILL.md);证据链 [实时API:hbcli-anything@ts]
- 域边界:本契约仅旅行域(城市/酒店/目的地);通用外部事实走 agent-reach(见 gotry 人格契约 14)
