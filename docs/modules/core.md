---
c4_level: 2
type: container
module: core
database: bronze / silver / gold
entry_point: resources/core_pipeline.yml
---
# Core — Conformed Dimensions

↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [core](./core.md) | `bronze` · `silver` · `gold` | [core_pipeline.yml](../../resources/core_pipeline.yml) |

> **C4 Level 2 — Container.** The Lakeflow Declarative Pipeline that builds the conformed dimensions once — customer, item, date, promotion — read by every sales-channel domain.

Core is the shared semantic foundation under the three sales channels. It builds the
dimensions once, through bronze, silver, and gold, and the store, catalog, and web pipelines
read its gold dims. A dimension table is owned by this one pipeline; no channel rebuilds it.

```mermaid
C4Component
  title Core Dimensions — Flow

  System_Ext(src, "TPC-DS source", "${source_schema}: customer, item, date_dim, promotion")

  Container_Boundary(pipe, "Core Pipeline") {
    ComponentDb(bronze, "Bronze", "Raw ingest", "Streaming copies of the source dimensions.")
    ComponentDb(silver, "Silver", "Cleansed", "Business-named, quality-checked dimensions.")
    ComponentDb(gold, "Gold", "Conformed", "dim_customer, dim_item, dim_date, dim_promotion.")
  }

  Rel(src, bronze, "STREAM")
  Rel(bronze, silver, "Clean, rename")
  Rel(silver, gold, "Conform")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

## Components

| Component | What it builds |
|---|---|
| [bronze](../components/core/bronze.md) | Raw streaming copies of the shared TPC-DS dimension tables. |
| [silver](../components/core/silver.md) | Cleansed, business-named conformed dimensions. |
| [gold](../components/core/gold.md) | The conformed `dim_customer`, `dim_item`, `dim_date`, `dim_promotion`. |
