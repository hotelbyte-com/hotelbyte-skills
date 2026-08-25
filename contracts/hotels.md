# contract: hotels(对齐上游 v0.3.0+ 实况)

- **当前上游命令面**(fb7d44b,staicli/hbcli v0.3.0 命令树扁平化后):
  - `hbcli search hotel-list --destination-name <name> [--page-num --page-size --max-rates-per-hotel --sort-by price-asc|price-desc|rating-desc --room-occupancies <json>] --json` — 目的地酒店+房价(实时)
  - `hbcli search destinations --json` — 目的地区域清单
  - `hbcli search hotel-detail / hotel-rates / check-avail / hotels-metadata` — 详情/房价/实时可订/元数据
  - 全局:`--env dev|uat|prod`(默认 uat)、`--json` 结构化输出(agent 消费)
- 参数映射(模型面 camelCase):destination / checkIn / checkOut / adults ↔ CLI --destination-name / 日期经 --room-occupancies JSON / --adultCount
- 降级:hbcli 不可用/超时 → gotry 静态包 data/hotels_2026.json,证据链 [静态包:估算]
