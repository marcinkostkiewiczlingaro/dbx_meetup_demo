---
c4_level: 2
type: container
module: semantic
database: gold
entry_point: docs/reference/metrics_views/store_sales_metrics.md
---
# Semantic — Governed Metrics and Consumption

↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [semantic](./semantic.md) | `gold` | [store_sales_metrics.md](../reference/metrics_views/store_sales_metrics.md) |

> **C4 Level 2 — Container.** The governed Metric View over the gold model, and the dashboard and Genie space that read it with one shared vocabulary.

The semantic layer turns the gold model into governed business metrics. It reads one table,
`gold.store_sales_enriched`, so there are no joins to reason about. Every measure and
dimension name matches the ontology, the Genie instructions, and the dashboard tiles.

```mermaid
C4Component
  title Semantic Layer — Flow

  ComponentDb(wide, "gold.store_sales_enriched", "Wide table", "One row per ticket line, with descriptive columns.")
  Component(metric, "store_sales_metrics", "Metric View", "Named measures and dimensions on the wide table.")
  Component(dash, "Store Sales Overview", "AI/BI dashboard", "Tiles via MEASURE().")
  System_Ext(genie, "Genie space", "Natural-language answers")

  Rel(wide, metric, "Source")
  Rel(metric, dash, "MEASURE()")
  Rel(wide, genie, "Reads, same vocabulary")
  UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
```

## Components

| Component | What it governs |
|---|---|
| [store-sales-metrics](../components/semantic/store-sales-metrics.md) | The named store-sales metrics and the Metric View that serves them. |
