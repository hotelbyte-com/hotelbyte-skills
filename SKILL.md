---
name: hotelbyte-travel-supply
description: Search live hotel inventory, compare transparent quotes, and create two-phase confirmed bookings through the HotelByte unified AI interface (/mcp). Use when the user asks to find hotels, check real-time rates, or book/cancel a hotel reservation.
version: 0.3.0
---

# HotelByte Travel Supply

One integration, all supplier inventory, transparent pricing. Read tools are always available; booking tools (`order.book`, `order.cancel`) require explicit confirmation and exist only when the deployment enables them (check `tools/list`).

## Connection

- Local (recommended on machines you control): `{ "mcpServers": { "hotelbyte": { "command": "hbcli", "args": ["mcp", "serve"] } } }` — no secrets in agent config.
- Hosted platforms / CI: static token via `hbcli mcp token`, then `{ "type": "http", "url": "https://api-test.hotelbyte.com/mcp", "headers": { "Authorization": "Bearer <token>" } }`.
- Platform connectors (Claude web / ChatGPT): native OAuth 2.1 — follow the 401 `resource_metadata` link.

## Two-phase booking playbook

1. `hotel.list` → candidates + min prices + `sessionId` (keep it for the whole flow).
2. `hotel.rates` → room types and rate plans; each rate carries `refundableMode` and `cancelFees` — present them to the user.
3. `hotel.check_avail` → re-verify the exact `ratePkgId`; prices can move.
4. `order.book` ONLY with `confirm: true` after the user consents to the exact price, dates, and cancellation policy. `customerReferenceNo` is your idempotency key — reuse it to retry. A 409-style duplicate warning is resolved by re-calling with `confirmDuplicate: true` and a `duplicateReason`.
5. Track async confirmation with `order.query`; cancel with `order.cancel` (also `confirm: true` only).

Never call `order.book`/`order.cancel` without an explicit user decision — the server rejects unconfirmed calls by design.

## Tool reference

| Tool | Mode | Notes |
|------|------|-------|
| `hotel.list` | read | returns `sessionId` used by the rest of the flow |
| `hotel.rates` | read | rates carry `refundableMode` + `cancelFees` |
| `hotel.check_avail` | read |  |
| `order.query` | read |  |
| `order.book` | write | requires `confirm: true` (explicit user consent); `customerReferenceNo` = idempotency key |
| `order.cancel` | write | requires `confirm: true` (explicit user consent) |

## Working with large results

`hotel.list` returns full domain objects (address, coordinates, supplier metadata). Do not echo them wholesale to the user or into your reasoning:
- Present a compact table: id, name, star, minPrice. Keep the rest in working memory.
- Narrow early: pass `hotelIds` (from a previous list) for precise follow-ups instead of re-listing the destination.
- Call `hotel.rates` only for the 1-3 hotels the user shortlists, never for the whole list.
- Page with `pageNum` when the user wants more options.

## Quote provenance & degradation

Rate data comes with a source you must surface honestly:
- **Live**: normal path — cite `evidence.traceId` when the user asks for proof.
- **Degraded**: a supplier marked as simulator/internal, or a static-package estimate — always label it ("estimated/simulated, not a live quote") before the user acts on it.
- **Error / not installed**: tool errors carry remediation text (follow it); a missing local gateway means `hbcli` is not installed — point the user to `hbcli mcp setup <client>`.

## Result envelope

Every tool returns `{ response, evidence }`: `response` mirrors the HTTP API payload; `evidence` carries `traceId` (cite it in support requests), `sessionId`, `currency`, and `generatedAt`.

## Error handling

- Tool-level errors (`isError: true`) carry remediation text — follow it instead of retrying blindly.
- Missing/invalid session: restart from `hotel.list` for a fresh `sessionId`.
- Duplicate warning on `order.book`: ask the user, then `confirmDuplicate: true` + `duplicateReason`.
- 401: token idle-expired (static keys die after the idle window) — obtain a new token via `hbcli mcp token` or re-run OAuth.
- Rates are live quotes; a changed price at `check_avail` is normal — re-confirm with the user before booking.
