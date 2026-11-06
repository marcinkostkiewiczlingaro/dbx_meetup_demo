---
c4_level: 3
module: store_sales
component: silver
entities: [DimStore, FctStoreSales, FctStoreReturns]
tables: [silver.dim_store, silver.fct_store_sales, silver.fct_store_returns]
---
# Silver — Cleansed, Business-Named (Store)

| module | component | entities | tables |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | silver | DimStore · FctStoreSales · FctStoreReturns | silver.dim_store · silver.fct_store_sales · silver.fct_store_returns |

> **C4 Level 3 — Component.** Cleansed store facts and the store dimension, with business column names and quality checks.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimStore` | `silver.dim_store` | — | Store, current records only. |
| `FctStoreSales` | `silver.fct_store_sales` | — | Store-sales lines; sold date resolved through the core calendar. |
| `FctStoreReturns` | `silver.fct_store_returns` | — | Store-return lines; returned date resolved through the core calendar. |

Each entity is one SQL file in `src/store_sales/silver/`. The grain of both facts is one
line (`ticket_number` × `item_key`). The facts resolve their dates by reading the
core-owned `bronze.date_dim` (a read across pipelines).
