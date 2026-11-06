# Modules (L2 — Containers)

↑ [System Context](../README.md) &nbsp;|&nbsp; ↓ [Components](../components/README.md)

> **C4 Level 2 — Containers.** The system's two modules and how they relate: the pipeline that builds the model, and the semantic layer that governs the metrics over it.

```mermaid
C4Container
  title Store-Sales Analytics — Containers

  System_Ext(src, "TPC-DS source", "${source_schema}")

  Container_Boundary(ws, "Databricks Workspace") {
    Container(pipeline, "Pipeline", "Lakeflow SQL", "Builds bronze, silver, gold.")
    Container(semantic, "Semantic", "Metric View, dashboard, Genie", "Governed metrics on the gold model.")
  }

  Rel(src, pipeline, "Read")
  Rel(pipeline, semantic, "Gold model")
  UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
```

| Module | Role | Databases |
|---|---|---|
| [pipeline](./pipeline.md) | Builds the store-sales model through the medallion. | `bronze`, `silver`, `gold` |
| [semantic](./semantic.md) | Governs the metrics and serves the dashboard and Genie. | `gold` |
