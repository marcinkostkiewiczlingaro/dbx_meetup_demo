# C4 Level 1 — System Context

The store-sales analytics system turns the public TPC-DS sample into a governed data
model that two audiences share: data engineers who build pipelines and data analysts
who ask business questions through Genie.

```mermaid
C4Context
  title Store-Sales Analytics — System Context

  Person(engineer, "Data Engineer", "Builds and runs the medallion pipeline.")
  Person(analyst, "Data Analyst", "Asks business questions in natural language.")

  System_Ext(tpcds, "TPC-DS Sample", "Public Databricks sample data: samples.tpcds_sf1.")
  System(platform, "Store-Sales Analytics", "Medallion model, metrics, and semantic foundation in Unity Catalog.")
  System_Ext(genie, "Databricks Genie", "Answers questions using the Metric View and ontology.")

  Rel(tpcds, platform, "Source rows")
  Rel(engineer, platform, "Builds pipeline, docs, metrics")
  Rel(analyst, genie, "Asks questions")
  Rel(genie, platform, "Reads governed metrics and semantics")
```

The point of the talk: the engineer and the analyst stand on **one** semantic
foundation, not two separate understandings of the same data.
