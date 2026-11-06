---
c4_level: 3
module: pipeline
component: silver
entities: [DimCustomer, DimItem, DimStore, DimDate, DimPromotion, FctStoreSales]
tables: [silver.dim_customer, silver.dim_item, silver.dim_store, silver.dim_date, silver.dim_promotion, silver.fct_store_sales]
---
# Silver — Cleansed, Business-Named

| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | silver | DimCustomer · DimItem · DimStore · DimDate · DimPromotion · FctStoreSales | silver.dim_customer · silver.dim_item · silver.dim_store · silver.dim_date · silver.dim_promotion · silver.fct_store_sales |

> **C4 Level 3 — Component.** Cleansed tables with business column names and quality checks. This is where TPC-DS codes become the shared vocabulary.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCustomer` | `silver.dim_customer` | — | Customer joined to its current address; `email_address` kept here, not in gold. |
| `DimItem` | `silver.dim_item` | — | Item (product), current records only. |
| `DimStore` | `silver.dim_store` | — | Store, current records only. |
| `DimDate` | `silver.dim_date` | — | Calendar keyed by the sold-date surrogate. |
| `DimPromotion` | `silver.dim_promotion` | — | Promotion with its purpose and channels. |
| `FctStoreSales` | `silver.fct_store_sales` | — | Store-sales lines with business names; sold date resolved through the calendar. |

Each entity is one SQL file in `src/silver/`. Business keys carry `EXPECT` constraints that
drop referentially broken rows. The grain of `FctStoreSales` is one ticket line
(`ticket_number` × `item_key`).
