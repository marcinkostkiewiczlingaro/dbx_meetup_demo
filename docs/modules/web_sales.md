---
c4_level: 2
type: module
module: web_sales
database: bronze / silver / gold
entry_point: resources/web_sales_pipeline.yml
---
# Web Sales — Channel Domain

↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [web_sales](./web_sales.md) | `bronze` · `silver` · `gold` | [web_sales_pipeline.yml](../../resources/web_sales_pipeline.yml) |

> **C4 Level 2 — Module.** The web sales-channel domain: the web-sales and web-returns facts, the web-only dimensions, and the governed Metric Views.

The web domain builds its facts and the web-site and web-page dimensions, then reads the
conformed core dims (customer, item, date, promotion). The governed Metric Views read the
gold star schema directly, joined on surrogate keys. `Gross Sales` and `Sales Quantity` mean
the same here as in the store and catalog domains.

```mermaid
C4Component
  title Web-Sales Domain — Flow

  System_Ext(src, "TPC-DS source", "${source_schema}: web_sales, web_returns, web_site, web_page")
  ComponentDb(core, "Core gold dims", "Conformed", "customer, item, date, promotion")

  Container_Boundary(pipe, "Web-Sales Pipeline") {
    ComponentDb(bronze, "Bronze", "Raw ingest", "Facts and web dimensions.")
    ComponentDb(silver, "Silver", "Cleansed", "Facts and web dims with business names.")
    ComponentDb(gold, "Gold", "Star", "Facts and web dims.")
    Component(metric, "web_sales_metrics", "Metric View", "Named measures joined on surrogate keys.")
  }

  Rel(src, bronze, "STREAM")
  Rel(bronze, silver, "Clean, rename")
  Rel(silver, gold, "Conform")
  Rel(core, gold, "Read dims")
  Rel(gold, metric, "Source + joins")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

## Components

| Component | What it builds |
|---|---|
| [bronze](../components/web_sales/bronze.md) | Raw streaming copies of the web facts and web dimensions. |
| [silver](../components/web_sales/silver.md) | Cleansed web-sales and web-returns facts and the web dims. |
| [gold](../components/web_sales/gold.md) | The web star schema: facts and web dims. |
| [metrics](../components/web_sales/metrics.md) | The governed web-sales and web-returns Metric Views. |
