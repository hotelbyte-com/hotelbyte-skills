# hotelbyte-skills（已退役 / Retired）

> **2026-10-03 起，本仓进入维护性退役**。Agent skill 的单一事实源与分发点已迁移：

| 关注点 | 现在去哪 |
|---|---|
| **事实源** | hotel-be 工具契约（`mcp/gateway/Contract()` → `renderskill` 渲染，`TestSkillMarkdownInSync` 防 drift） |
| **分发** | https://hotelbyte.com/skills/hotelbyte/SKILL.md（landing 静态文件） |
| **安装** | `hbcli skill install`（写入 `~/.claude/skills/hotelbyte/`） |
| **接入** | MCP `/mcp` 工具面（`hbcli mcp setup <client>`），不再是 CLI 直调命令面 |

本仓有价值的内容已收编进新事实源：

- **降级三值语义**（found / error / not-installed）与证据链标注（`[实时API:…]` / `[静态包:估算]`）→ SKILL.md 的 *Quote provenance & degradation* 段（live / degraded / error，MCP 语境通用化）。
- 触发场景描述 → 新 SKILL.md 的 frontmatter `description`。

`contracts/`（CLI 直调命令面）保留作历史参考，不再维护——上游命令面已由 MCP 工具面取代。若 gotry 宿主仍在消费本仓 SKILL.md，请尽快切换到上述分发点。
