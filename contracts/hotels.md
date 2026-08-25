# contract: hotels

- CLI: `hbcli search hotels <destination> [--check-in YYYY-MM-DD --check-out YYYY-MM-DD --adults N]`
- 输出: 酒店列表(名称/价格区间/数据源标记)
- 降级: hbcli 不可用 → gotry 静态包 data/hotels_2026.json,证据链标 [静态包:估算]
