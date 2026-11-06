---
c4_level: 3
module: pipeline
component: bronze
entities: [StoreSalesRaw, CustomerRaw, ItemRaw, DateRaw, StoreRaw, PromotionRaw]
tables: [bronze.store_sales, bronze.customer, bronze.customer_address, bronze.item, bronze.date_dim, bronze.store, bronze.promotion]
---
# Bronze — Raw Ingest

| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | bronze | StoreSalesRaw · CustomerRaw · ItemRaw · DateRaw · StoreRaw · PromotionRaw | bronze.store_sales · bronze.customer · bronze.item · bronze.date_dim · bronze.store · bronze.promotion |

> **C4 Level 3 — Component.** Streaming copies of the TPC-DS source tables, one per source, kept in the source shape for audit. The source schema is the `${source_schema}` pipeline configuration.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `StoreSalesRaw` | `bronze.store_sales` | — | Raw store-sales lines; the grain the whole model stands on. |
| `CustomerRaw` | `bronze.customer`, `bronze.customer_address` | — | Raw customers and their addresses, joined in silver. |
| `ItemRaw` | `bronze.item` | — | Raw items (products) with slowly-changing history. |
| `DateRaw` | `bronze.date_dim` | — | Raw calendar; resolves the sold-date surrogate to a real date. |
| `StoreRaw` | `bronze.store` | — | Raw stores with slowly-changing history. |
| `PromotionRaw` | `bronze.promotion` | — | Raw promotions a store-sales line may be attributed to. |

Each entity is one SQL file in `src/bronze/`. Bronze does no renaming or typing; it reads
`FROM STREAM ${source_schema}.<table>`, so the same pipeline can target the 1 GB `sf1`
sample or the 1 TB `sf1000` sample.
