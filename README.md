# hotelbyte-skills — HotelByte Agent Skill（开源权威分发点）

本仓是 **HotelByte agent skill 的开源 source of truth**：用户与开源社区从这里安装、引用、fork。

```
raw 源:  https://raw.githubusercontent.com/hotelbyte-com/hotelbyte-skills/main/SKILL.md
安装:    hbcli skill install          # 默认即从本仓 raw 源拉取
镜像:    https://hotelbyte.com/skills/hotelbyte/SKILL.md
```

## 三段架构

| 段 | 仓 | 可见性 | 职责 |
|---|---|---|---|
| 渲染源 | hotel-be（`mcp/gateway` 工具契约 → `renderskill`） | 私有 | 生成 SKILL.md（`TestSkillMarkdownInSync` 防 drift） |
| **权威分发（本仓）** | hotelbyte-skills | **公开** | 发布渲染产物；外部引用/fork 的唯一指向 |
| 镜像 | hotelbyte-landing（静态文件） | 公开站点 | CDN 入口，与本仓同步 |

## 发布流程（BE skill 变更后）

```bash
# hotel-be: go run ./mcp/gateway/cmd/renderskill   # 重渲染 + drift 测试
cp hotel-be/mcp/gateway/skill/SKILL.md  ./SKILL.md # 发布到本仓（版本号在 frontmatter）
```

## 目录

- `SKILL.md` — 当前发布的 agent skill（连接 / 用法手册 / 大结果处理 / 报价来源与降级 / 工具参考 / 错误处理）
- `contracts/` — CLI 直调时代的历史参考（gotry #5），已被 MCP 工具面取代，不再维护
