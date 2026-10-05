- 2026-10-04: contracts/ 下线（#5）。CLI 直调时代的历史参考（anything/booking-chain/hotels，v0.3.0 口径）已被两处取代：references/tools.md（BE 渲染的全量工具契约，drift 测试锁定）与 MCP 工具面（托管网关 15 个契约工具 + `hbcli mcp serve --local` 的 portal.catalog/describe/call/presales.chat 通用四工具，任意端点另可 `hbcli api call` 透传）。contracts/ 从不进 skill install manifest（SKILL.md+scripts/+references/ 三件），下线对已安装 agent 零影响；历史版本走 git log。
v0.1.0 立档:SKILL.md + contracts(anything/hotels)+ README
- 2026-10-04: 仓转为公开的开源权威分发点；SKILL.md 同步 BE 渲染产物 v0.3.x（新增 working-with-large-results 与 quote-provenance 段）。前一日的退役指针方向已反转——退役的是 CLI 直调旧内容，不是本仓的分发地位。
