---
c4_level: 3
module: core
component: gold
entities: [DimCustomer, DimItem, DimDate, DimPromotion]
tables: [gold.dim_customer, gold.dim_item, gold.dim_date, gold.dim_promotion]
---
# Gold — Conformed Dimensions

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | gold | DimCustomer · DimItem · DimDate · DimPromotion | [gold.dim_customer](../../reference/tables/gold.dim_customer.md) · [gold.dim_item](../../reference/tables/gold.dim_item.md) · [gold.dim_date](../../reference/tables/gold.dim_date.md) · [gold.dim_promotion](../../reference/tables/gold.dim_promotion.md) |

> **C4 Level 3 — Component.** The conformed dimensions, built once and read by every sales-channel pipeline. A dimension table is owned by this core pipeline; no channel rebuilds it.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCustomer` | [`gold.dim_customer`](../../reference/tables/gold.dim_customer.md) | — | Customer dimension; business-safe columns only. |
| `DimItem` | [`gold.dim_item`](../../reference/tables/gold.dim_item.md) | — | Item (product) dimension. |
| `DimDate` | [`gold.dim_date`](../../reference/tables/gold.dim_date.md) | — | Calendar dimension. |
| `DimPromotion` | [`gold.dim_promotion`](../../reference/tables/gold.dim_promotion.md) | — | Promotion dimension. |

Each entity is one SQL file in `src/core/gold/`. The store, catalog, and web gold enriched
tables read these dims across pipelines (reads across pipelines are allowed; writes are not).
These are the shared links the ontology names
([`docs/ontology/link-types.md`](../../ontology/link-types.md)).
