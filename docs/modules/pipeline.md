---
c4_level: 2
type: container
module: pipeline
database: bronze / silver / gold
entry_point: resources/store_sales_pipeline.yml
---
# Pipeline — Store-Sales Medallion

↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [pipeline](./pipeline.md) | `bronze` · `silver` · `gold` | [store_sales_pipeline.yml](../../resources/store_sales_pipeline.yml) |

> **C4 Level 2 — Container.** The Lakeflow Declarative Pipeline that builds the store-sales model through bronze, silver, and gold, one SQL file per table.

The pipeline reads the TPC-DS source schema (`${source_schema}`) and writes three Unity
Catalog schemas in order: raw ingest, cleansed business-named tables, then the conformed
star schema and the wide consumption table.

```mermaid
C4Component
  title Store-Sales Medallion — Flow

  System_Ext(src, "TPC-DS source", "${source_schema}: store_sales + dimensions")

  Container_Boundary(pipe, "Store-Sales Pipeline") {
    ComponentDb(bronze, "Bronze", "Raw ingest", "Streaming copies of the source tables.")
    ComponentDb(silver, "Silver", "Cleansed", "Business-named, quality-checked tables.")
    ComponentDb(gold, "Gold", "Star + wide", "Conformed star schema and store_sales_enriched.")
  }

  Rel(src, bronze, "STREAM")
  Rel(bronze, silver, "Clean, rename")
  Rel(silver, gold, "Conform, widen")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

## Components

| Component | What it builds |
|---|---|
| [bronze](../components/pipeline/bronze.md) | Raw streaming copies of the TPC-DS source tables. |
| [silver](../components/pipeline/silver.md) | Cleansed, business-named dimensions and the store-sales fact. |
| [gold](../components/pipeline/gold.md) | The star schema and the wide `store_sales_enriched` table. |
