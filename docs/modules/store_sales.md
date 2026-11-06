---
c4_level: 2
type: container
module: store_sales
database: bronze / silver / gold
entry_point: resources/store_sales_pipeline.yml
---
# Store Sales — Channel Domain

↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [store_sales](./store_sales.md) | `bronze` · `silver` · `gold` | [store_sales_pipeline.yml](../../resources/store_sales_pipeline.yml) |

> **C4 Level 2 — Container.** The store sales-channel domain: the store-sales and store-returns facts, the store dimension, the wide enriched table, and the governed Metric View.

The store domain builds its facts and the store dimension, then reads the conformed core
dims (customer, item, date, promotion) to widen the fact into `gold.store_sales_enriched`.
The Metric View and Genie read that one table. `Net Sales` and `Quantity Sold` mean the same
here as in the catalog and web domains.

```mermaid
C4Component
  title Store-Sales Domain — Flow

  System_Ext(src, "TPC-DS source", "${source_schema}: store_sales, store_returns, store")
  ComponentDb(core, "Core gold dims", "Conformed", "customer, item, date, promotion")

  Container_Boundary(pipe, "Store-Sales Pipeline") {
    ComponentDb(bronze, "Bronze", "Raw ingest", "store_sales, store_returns, store.")
    ComponentDb(silver, "Silver", "Cleansed", "Facts and dim_store with business names.")
    ComponentDb(gold, "Gold", "Star + wide", "Facts, dim_store, store_sales_enriched.")
    Component(metric, "store_sales_metrics", "Metric View", "Named measures on the wide table.")
  }

  Rel(src, bronze, "STREAM")
  Rel(bronze, silver, "Clean, rename")
  Rel(silver, gold, "Conform, widen")
  Rel(core, gold, "Read dims")
  Rel(gold, metric, "Source")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

## Components

| Component | What it builds |
|---|---|
| [bronze](../components/store_sales/bronze.md) | Raw streaming copies of the store-sales, store-returns, and store tables. |
| [silver](../components/store_sales/silver.md) | Cleansed store-sales and store-returns facts and the store dimension. |
| [gold](../components/store_sales/gold.md) | The star schema and the wide `store_sales_enriched` table. |
| [metrics](../components/store_sales/metrics.md) | The governed store-sales Metric View. |
