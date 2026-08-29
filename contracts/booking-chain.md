# contract: booking-chain(预订链读→写,rates→check-avail→book;2026-08-30 实测对齐)

- **命令面**(staicli/hbcli master,含 hotelbyte-cli#4/#5):
  - `hbcli search hotel-rates --hotel-id <id> [--check-in --check-out --country-code --nationality-code --residency-code --room-occupancies <json>] --json` — 房型+实时价;**建后端 session**,顶层返回 `sessionId`
  - `hbcli search check-avail --rate-pkg-id <id> --json` — 下单前实时验价(库存/价格以后端为准)
  - `hbcli trade book --rate-pkg-id <id> --holder <json> --guests <json> [--customer-reference-no <ref> --callback-url <url> --confirm-duplicate --duplicate-reason <text>] --json` — 下单;`--customer-reference-no` 是幂等键(同 ref 重订复用/返回既有订单),409 DUPLICATE_WARNING 后带 `--confirm-duplicate --duplicate-reason` 二次提交
- **hotel-rates `--json` 输出形态**(2026-08-30 UAT 实测):顶层 `rooms[] / priceValidationStatus(ok|suspect) / priceValidationReason / result / clientIP / checkIn / checkOut / sessionId`;`rooms[].roomTypeId/roomTypeName{en,zh}`;`rooms[].rates[].ratePkgId`(形如 `<hotelId><HB>-…-NRF|YYYYMMDD|YYYYMMDD`)与价格对象
- **链式语义**:ratePkgId 只来自 hotel-rates 产物;check-avail/book 以其为入参;session 由 hotel-rates 建立、后端按用户上下文解析——**跨凭证不共享**(实测:沙箱账号建 session 后,换 portal token 不可见该租户报价)
- **鉴权受众(2026-08-30 实测发现,待 hotel-be 侧确认)**:
  - 种子沙箱 openapi 账号(hotelbyte_api_demo):hotel-rates 实时 OK;**check-avail 对真实 ratePkgId 返回 401 authentication denied**(疑似沙箱 scope 或该面受众限制)
  - portal 租户 token(凭据店 ticket 注入):hotel-rates 实时 OK(该租户无报价时 `priceValidationStatus=suspect, reason=detail_no_offer`,诚实空而非报错)
  - 结论:**NL booking 全链按 PRD 设计走 portal token(per-user)**;沙箱账号只覆盖到 rates 层
- **价格面红线(gotry 侧,ADR-19 同口径)**:报价/验价无静态降级 fail-closed——不可用即诚实失败,不估算房价;证据链 `[实时API:hbcli@<ts>]`(失败形态 `[实时API:hbcli@error@ts]`)
- 关联:`contracts/hotels.md`(hotel-list 面);gotry 效应 `HBCLI_HOTEL_RATES` / `HBCLI_CHECK_AVAIL`(Danceiny/gotry feat/issue-16-effect-interpreter);PRD `docs/products/gotry-a2a-nl-booking-prd.md`(hotel-be)
