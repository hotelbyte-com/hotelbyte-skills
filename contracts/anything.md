# contract: anything

- CLI: `hbcli search anything "<keywords>" --json`
- 上游: hotel-be `POST /api/search/anything`(@path/@auth:false 公开注解)
- 输入: keywords(空格分隔);可选 contentType=city|hotel
- 输出: candidates[](名称/类型/目的地锚点);miss 时空数组
- 降级: 未装/超时/401 → 三值语义(见 SKILL.md);gotry 侧证据链 [实时API:hbcli-anything@ts]
- 域边界:本契约仅旅行域(城市/酒店/目的地);通用外部事实走 agent-reach(见 gotry 人格契约 14)
