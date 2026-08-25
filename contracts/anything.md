# contract: anything(状态:待上游合入)

- **现状声明(2026-08-25 终版)**:两端 PR(hotelbyte-cli#3 / hotel-be#30949)已按
  founder 判定关闭——@path 免鉴权公开面对 hotel-be 无附加值(负值:安全面+维护义务),
  服务内部本就可用。**Anything 实时链撤回**:gotry 旅行域检索改用已注解的
  hotel-list 面(contracts/hotels.md);本契约降级为历史记录,静态包兜底。
- 上游真实现面见 contracts/hotels.md;anything 合入上游前,gotry 的
  Anything 实时链路对现版 hbcli 不可用(诚实降级 [静态包:估算])。
- 输入(合入后): keywords;可选 contentType=city|hotel
- 输出: candidates[];miss 空数组
- 降级: 三值(见 SKILL.md);证据链 [实时API:hbcli-anything@ts]
- 域边界:本契约仅旅行域(城市/酒店/目的地);通用外部事实走 agent-reach(见 gotry 人格契约 14)
