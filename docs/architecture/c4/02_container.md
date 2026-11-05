# C4 Level 2 — Containers

The system runs inside one Databricks workspace. Each container maps to a place in
this repository and an object in Unity Catalog.

```mermaid
C4Container
  title Bakery-Sales Analytics — Containers

  System_Ext(bakehouse, "Bakehouse Sample", "samples.bakehouse")

  Container_Boundary(ws, "Databricks Workspace") {
    Container(pipeline, "Lakeflow Pipeline", "SQL (DLT)", "Builds bronze, silver, gold. src/bronze, src/silver, src/gold.")
    ContainerDb(bronze, "Bronze schema", "Delta / Unity Catalog", "Raw copies of source tables.")
    ContainerDb(silver, "Silver schema", "Delta / Unity Catalog", "Cleansed, business-named, quality-checked.")
    ContainerDb(gold, "Gold schema", "Delta / Unity Catalog", "Conformed star schema.")
    Container(metric, "Metric View", "YAML on Unity Catalog", "Governed bakery-sales metrics on gold.sales_enriched. metrics/.")
    Container(page, "AI/BI Page", "Lakeview dashboard", "Headline numbers and charts for business users. dashboards/.")
  }

  System_Ext(genie, "Databricks Genie", "Reads the Metric View")

  Rel(bakehouse, pipeline, "Read")
  Rel(pipeline, bronze, "Write")
  Rel(bronze, silver, "Transform")
  Rel(silver, gold, "Conform")
  Rel(gold, metric, "Source of measures")
  Rel(metric, page, "Tiles via MEASURE()")
  Rel(metric, genie, "Named metrics")
```

The medallion layers are **separate Unity Catalog schemas** so the boundary stays
visible: raw, cleansed, conformed.
