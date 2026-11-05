---
opened: 2026-11-05
---

# F001 · Store sales runs end to end on TPC-DS, with one shared semantic foundation

## Outcome

A data engineer can point a Databricks workspace at the public TPC-DS sample and build a store-sales data model through bronze, silver, and gold layers in Unity Catalog. An analyst can read the same model through a Metric View that carries governed, named business metrics. The same business terms appear in three documentation views — a C4 architecture map, a Palantir-style ontology, and a semantic model — so code, data, and business meaning agree. This is the demo spine for the talk: Part 1 (engineers) and Part 2 (analysts) consume one foundation.

## Scope

- Ingest the store-sales slice of `samples.tpcds_sf1` — the `store_sales` fact and the `customer`, `item`, `store`, and `date_dim` dimensions.
- Model medallion layers as Unity Catalog schemas: `bronze` (raw copy), `silver` (cleansed, business-named, quality checks), `gold` (conformed star schema).
- Define store-sales metrics once, as a Databricks Metric View on the gold fact.
- Ship as a Databricks Asset Bundle with a Lakeflow Declarative Pipeline in declarative SQL; the seam is `databricks.yml` and `src/bronze/`.
- Document the same slice three ways under `docs/`: C4 (context, container, component), ontology (object and link types), semantic model (metric definitions).

## Out of scope

- The other TPC-DS subject areas (catalog sales, web sales, inventory). One star schema only.
- Databricks Pages, Genie Ontology, and Genie setup — later features that consume this foundation.
- Real incremental or streaming ingestion tuning; the sample is static.

## Acceptance

- `databricks bundle validate` passes against the repository.
- Every pipeline SQL file reads or writes a fully qualified `bronze`/`silver`/`gold` object and names one concept.
- The Metric View YAML lists named measures (net sales, net profit, quantity, order count, average order value) that resolve against the gold fact.
- A business term (for example net sales amount) has one spelling across silver columns, the gold fact, the Metric View, the ontology, and the semantic model.
- The C4 docs show context, container, and component levels; the ontology lists object types with definitions and source-column mappings.

## Notes

- Verify the exact sample path and table names (`samples.tpcds_sf1`) in the Free Edition workspace before the first run; adjust if the sample schema differs.
- Catalog name is `tpcds_demo` in one place (the bundle). Change it there to retarget.
