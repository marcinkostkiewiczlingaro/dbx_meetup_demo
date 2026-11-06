---
c4_level: 3
module: pipeline
component: gold
entities: [FctStoreSales, DimCustomer, DimItem, DimStore, DimDate, DimPromotion, StoreSalesEnriched]
tables: [gold.fct_store_sales, gold.dim_customer, gold.dim_item, gold.dim_store, gold.dim_date, gold.dim_promotion, gold.store_sales_enriched]
---
# Gold — Star Schema and Consumption Table

| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | gold | FctStoreSales · DimCustomer · DimItem · DimStore · DimDate · DimPromotion · StoreSalesEnriched | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) · [gold.store_sales_enriched](../../reference/tables/gold.store_sales_enriched.md) |

> **C4 Level 3 — Component.** The conformed star schema (one fact, five dimensions) plus the wide `store_sales_enriched` table the semantic layer reads.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctStoreSales` | [`gold.fct_store_sales`](../../reference/tables/gold.fct_store_sales.md) | — | Conformed fact. Grain: one ticket line. |
| `DimCustomer` | [`gold.dim_customer`](../../reference/tables/gold.dim_customer.md) | — | Customer dimension; business-safe columns only. |
| `DimItem` | [`gold.dim_item`](../../reference/tables/gold.dim_item.md) | — | Item (product) dimension. |
| `DimStore` | [`gold.dim_store`](../../reference/tables/gold.dim_store.md) | — | Store dimension. |
| `DimDate` | [`gold.dim_date`](../../reference/tables/gold.dim_date.md) | — | Calendar dimension. |
| `DimPromotion` | [`gold.dim_promotion`](../../reference/tables/gold.dim_promotion.md) | — | Promotion dimension. |
| `StoreSalesEnriched` | [`gold.store_sales_enriched`](../../reference/tables/gold.store_sales_enriched.md) | — | Fact widened with descriptive columns; read by the Metric View and Genie with no joins. |

```mermaid
C4Component
  title Gold Star Schema — Components

  ContainerDb(fct, "gold.fct_store_sales", "Fact", "One row per ticket line. Measures: net sales, quantity, net profit.")
  ContainerDb(dimc, "gold.dim_customer", "Dimension", "One row per customer.")
  ContainerDb(dimi, "gold.dim_item", "Dimension", "One row per item (product).")
  ContainerDb(dims, "gold.dim_store", "Dimension", "One row per store.")
  ContainerDb(dimd, "gold.dim_date", "Dimension", "One row per calendar day.")
  ContainerDb(dimp, "gold.dim_promotion", "Dimension", "One row per promotion.")

  Rel(fct, dimc, "customer_key")
  Rel(fct, dimi, "item_key")
  Rel(fct, dims, "store_key")
  Rel(fct, dimd, "date_key")
  Rel(fct, dimp, "promo_key")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

Each entity is one SQL file in `src/gold/`. The star is the modeling source;
`store_sales_enriched` is the consumption table built from it. The foreign keys here are the
links the ontology names ([`docs/ontology/link-types.md`](../../ontology/link-types.md)).
