> ⚠️ **RETIRED (2026-10-03)** — superseded by the MCP-era skill.
> Source of truth: hotel-be tool contract → https://hotelbyte.com/skills/hotelbyte/SKILL.md
> Install: `hbcli skill install`. Kept for historical reference (gotry #5 era); no longer maintained.

---
name: hotelbyte-skills
version: 0.1.0
description: "酒店域与目的地检索能力(hotelbyte CLI 封装):Anything 通用旅行域搜索(城市/酒店/目的地)、酒店实时/静态库存。经 hbcli → hotel-be 开放能力。"
when_to_use: |
  ## 触发场景

  - 目的地调研:城市/区域的候选酒店、目录检索(Anything)
  - 酒店库存:指定目的地+日期的酒店列表(实时优先,静态包降级)
  - 明确**不**覆盖:通用网页/社媒/行情(走 agent-reach)、公司差旅订单(走宿主内部 skill)

  ## 调用形态(契约摘要,详见 contracts/)

  - hbcli search anything "<keywords>" --json   # Anything 旅行域检索
  - hbcli search hotels <destination> [--check-in --check-out --adults]

  ## 降级语义(三值,与 gotry L4 契约一致)

  - hbcli 未装 → not-installed(给安装指引,不阻塞)
  - 超时/网络 → error(降级到静态包时证据链标 [静态包:估算])
  - 命中 → found,证据链标 [实时API:hbcli@<ts>]
