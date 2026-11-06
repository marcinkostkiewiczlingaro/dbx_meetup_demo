---
c4_level: 3
module: store_sales
component: bronze
entities: [StoreSalesRaw, StoreReturnsRaw, StoreRaw]
tables: [bronze.store_sales, bronze.store_returns, bronze.store]
---
# Bronze — Raw Ingest (Store)

| module | component | entities | tables |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | bronze | StoreSalesRaw · StoreReturnsRaw · StoreRaw | bronze.store_sales · bronze.store_returns · bronze.store |

> **C4 Level 3 — Component.** Streaming copies of the store-sales, store-returns, and store source tables, kept in the source shape for audit.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `StoreSalesRaw` | `bronze.store_sales` | — | Raw store-sales lines; the grain the sales fact stands on. |
| `StoreReturnsRaw` | `bronze.store_returns` | — | Raw store-return lines; the grain the returns fact stands on. |
| `StoreRaw` | `bronze.store` | — | Raw stores with slowly-changing history. |

Each entity is one SQL file in `src/store_sales/bronze/`. The conformed customer, item,
date, and promotion dimensions are built by the [core](../core/bronze.md) pipeline, not here.
