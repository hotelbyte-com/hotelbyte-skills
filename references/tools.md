# Tool contracts

Rendered from the unified tool contract; regenerate with `go run ./mcp/gateway/cmd/renderskill`.

## hotel.list

- mode: read

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `checkIn` | string | yes | Check-in date in YYYY-MM-DD format |
| `checkOut` | string | yes | Check-out date in YYYY-MM-DD format |
| `countryCode` | string |  | Point of sale country code (ISO 3166-1 alpha-2, e.g. "AE") |
| `currency` | string |  | Currency for rates (ISO 4217, e.g. "AED", "USD") |
| `destinationName` | string |  | Destination city or area name (English or Arabic, e.g. "Dubai" or "دبي") |
| `hotelIds` | array |  | Specific hotel IDs to search for (as strings). If provided, destinationName is optional. |
| `maxRatesPerHotel` | integer |  | Maximum room rate packages per hotel. 0 = use server default. |
| `nationalityCode` | string |  | Booker nationality code (ISO 3166-1 alpha-2) |
| `pageNum` | integer |  | Page number (1-based) |
| `pageSize` | integer |  | Results per page |
| `residencyCode` | string |  | Booker residency code (ISO 3166-1 alpha-2) |
| `rooms` | array | yes | Room occupancy configuration. Each entry specifies adultCount and childrenAges. |
| `sortBy` | string |  | Sort order: price-asc, price-desc, rating-desc, distance-asc |

## hotel.rates

- mode: read

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `checkIn` | string | yes | Check-in date in YYYY-MM-DD format |
| `checkOut` | string | yes | Check-out date in YYYY-MM-DD format |
| `countryCode` | string |  | Point of sale country code (ISO 3166-1 alpha-2, e.g. "AE") |
| `currency` | string |  | Currency for rates (ISO 4217) |
| `hotelId` | string | yes | Hotel ID (as string) |
| `nationalityCode` | string |  | Booker nationality code (ISO 3166-1 alpha-2) |
| `residencyCode` | string |  | Booker residency code (ISO 3166-1 alpha-2) |
| `rooms` | array | yes | Room occupancy configuration, same shape as hotel.list |
| `sessionId` | string |  | Session ID from a prior hotel.list response |

## hotel.check_avail

- mode: read

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `ratePkgId` | string | yes | Rate package ID from hotel.rates response |
| `sessionId` | string | yes | Session ID from a prior hotel.list / hotel.rates response |

## order.query

- mode: read

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `customerReferenceNos` | array |  | Customer reference numbers to look up |
| `statusList` | array |  | Filter by order status: 1=confirming, 2=confirmed, 3=cancelled, 4=failed |
| `supplierReferenceNos` | array |  | Supplier reference numbers to look up |

## order.book

- mode: write
- confirm: `confirm: true` required (explicit user consent)

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `confirm` | boolean | yes | Must be true and only after the user explicitly consented to this exact booking (price, dates, cancellation policy) |
| `confirmDuplicate` | boolean |  | Set true to proceed when the server answers 409 DUPLICATE_WARNING (dedupe by customerReferenceNo) |
| `customerReferenceNo` | string | yes | Your unique idempotency reference for this order (reuse on retry) |
| `duplicateReason` | string |  | Reason recorded in the audit log when confirming a duplicate |
| `guests` | array |  | Guest details for each room. If omitted, holder info is used. |
| `holder` | object | yes | Primary booking contact (the person responsible for the reservation) |
| `ratePkgId` | string | yes | Rate package ID from hotel.rates or hotel.check_avail |
| `sessionId` | string | yes | Session ID from prior hotel.list / hotel.rates |

## order.cancel

- mode: write
- confirm: `confirm: true` required (explicit user consent)

### Arguments

| Argument | Type | Required | Notes |
|---|---|---|---|
| `confirm` | boolean | yes | Must be true and only after the user explicitly consented to cancelling this order |
| `customerReferenceNo` | string | yes | Customer reference number of the order to cancel |
| `reason` | string |  | Cancellation reason recorded in the audit log |
| `supplierReferenceNo` | string | yes | Supplier reference number of the order to cancel |

