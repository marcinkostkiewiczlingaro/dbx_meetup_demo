---
c4_level: 1
---
# Store-Sales Analytics — Documentation (L1 — System Context)

↓ [Modules](./modules/README.md) &nbsp;|&nbsp; [Ontology](./ontology/README.md) &nbsp;|&nbsp; [Doc standard](./engineering/documentation-standard.md)

> **C4 Level 1 — System Context.** One governed semantic foundation on the public TPC-DS store-sales dataset, shared by data engineers who build the pipeline and data analysts who ask Genie.

This documentation follows the C4 model. Load top-down: this page for context, a module
(L2) for a container, a component (L3) to implement a feature, a reference file (L4) for
exact column names or the governed metric definition. The rules are in
[engineering/documentation-standard.md](./engineering/documentation-standard.md).

```mermaid
C4Context
  title Store-Sales Analytics — System Context

  Person(engineer, "Data Engineer", "Builds and runs the medallion pipeline.")
  Person(analyst, "Data Analyst", "Asks business questions in natural language.")

  System_Ext(tpcds, "TPC-DS Sample", "Public Databricks sample data: samples.tpcds_sf1 / sf1000.")
  System(platform, "Store-Sales Analytics", "Medallion model, metrics, and semantic foundation in Unity Catalog.")
  System_Ext(genie, "Databricks Genie", "Answers questions using the Metric View and the shared vocabulary.")

  Rel(tpcds, platform, "Source rows")
  Rel(engineer, platform, "Builds pipeline, docs, metrics")
  Rel(analyst, genie, "Asks questions")
  Rel(genie, platform, "Reads governed metrics and semantics")
  UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
```

The point of the talk: the engineer and the analyst stand on **one** semantic foundation,
not two separate understandings of the same data. One business term keeps one name across
the silver columns, the gold star schema, the Metric View, the ontology, Genie, and the
dashboard.

## The documentation (C4 levels)

| Level | Where | What |
|---|---|---|
| L1 | this file | System context. |
| L2 | [modules/](./modules/README.md) | The pipeline and semantic containers. |
| L3 | [components/](./components/README.md) | Bronze, silver, gold, and the metrics component. |
| L4 | [reference/tables/](./reference/tables/README.md), [reference/metrics_views/](./reference/metrics_views/README.md) | Column schemas and the governed Metric View. |

## Other views

- [Ontology](./ontology/README.md) — the business objects, their properties, and links.
- [Documentation standard](./engineering/documentation-standard.md) — how these files are built.

## Data source and deployment

- **Source:** the `source_schema` bundle variable (`databricks.yml`) picks the TPC-DS
  schema. Default `samples.tpcds_sf1` (1 GB) builds on Databricks Free Edition; set
  `samples.tpcds_sf1000` (1 TB) for realistic volume.
- **Deploy location:** the `dev` target deploys to the shared folder
  `/Workspace/Shared/dbx_meetup_demo/${bundle.target}`, so the owner can share the demo
  with other workspace users.
