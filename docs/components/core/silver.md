---
c4_level: 3
module: core
component: silver
entities: [DimCustomer, DimItem, DimDate, DimPromotion]
tables: [silver.dim_customer, silver.dim_item, silver.dim_date, silver.dim_promotion]
---
# Silver — Cleansed, Business-Named (Core Dimensions)

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | silver | DimCustomer · DimItem · DimDate · DimPromotion | silver.dim_customer · silver.dim_item · silver.dim_date · silver.dim_promotion |

> **C4 Level 3 — Component.** Cleansed conformed dimensions with business column names and quality checks. This is where TPC-DS codes become the shared vocabulary every channel reads.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCustomer` | `silver.dim_customer` | — | Customer joined to its current address; `email_address` kept here, not in gold. |
| `DimItem` | `silver.dim_item` | — | Item (product), current records only. |
| `DimDate` | `silver.dim_date` | — | Calendar keyed by the sold-date surrogate. |
| `DimPromotion` | `silver.dim_promotion` | — | Promotion with its purpose and channels. |

Each entity is one SQL file in `src/core/silver/`. Business keys carry `EXPECT` constraints
that drop referentially broken rows. These are the conformed dimensions: one definition,
read by the store, catalog, and web domains.
