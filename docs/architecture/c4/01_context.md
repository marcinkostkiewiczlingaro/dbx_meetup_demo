# C4 Level 1 — System Context

The bakery-sales analytics system turns the public bakehouse sample into a governed data
model that two audiences share: data engineers who build pipelines and data analysts
who ask business questions through Genie.

```mermaid
C4Context
  title Bakery-Sales Analytics — System Context

  Person(engineer, "Data Engineer", "Builds and runs the medallion pipeline.")
  Person(analyst, "Data Analyst", "Asks business questions in natural language.")

  System_Ext(bakehouse, "Bakehouse Sample", "Public Databricks sample data: samples.bakehouse.")
  System(platform, "Bakery-Sales Analytics", "Medallion model, metrics, and semantic foundation in Unity Catalog.")
  System_Ext(genie, "Databricks Genie", "Answers questions using the Metric View and ontology.")

  Rel(bakehouse, platform, "Source rows")
  Rel(engineer, platform, "Builds pipeline, docs, metrics")
  Rel(analyst, genie, "Asks questions")
  Rel(genie, platform, "Reads governed metrics and semantics")
```

The point of the talk: the engineer and the analyst stand on **one** semantic
foundation, not two separate understandings of the same data.
