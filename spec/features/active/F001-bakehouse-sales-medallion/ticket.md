---
opened: 2026-11-05
---

# F001 · Bakery sales runs end to end on the bakehouse sample, with one shared semantic foundation

## Outcome

A data engineer can point a Databricks Free Edition workspace at the public bakehouse
sample and build a bakery-sales data model through bronze, silver, and gold layers in
Unity Catalog. An analyst can read the same model through a Metric View that carries
governed, named business metrics. The same business terms appear in three documentation
views — a C4 architecture map, a Palantir-style ontology, and a semantic model — so code,
data, and business meaning agree. This is the demo spine for the talk: Part 1 (engineers)
and Part 2 (analysts) consume one foundation.

## Scope

- Ingest the sales slice of `samples.bakehouse` — `sales_transactions` with `sales_customers`, `sales_franchises`, and `sales_suppliers`.
- Model medallion layers as Unity Catalog schemas under the `workspace` catalog: `bronze` (raw copy), `silver` (cleansed, business-named, quality checks), `gold` (conformed star schema).
- Derive product and date dimensions from the fact; the sample has no table for either.
- Define bakery-sales metrics once, as a Databricks Metric View on the gold fact.
- Ship as a Databricks Asset Bundle with a Lakeflow Declarative Pipeline in declarative SQL; the seam is `databricks.yml` and `src/bronze/`.
- Document the same slice three ways under `docs/`: C4 (context, container, component), ontology (object and link types), semantic model (metric definitions).

## Out of scope

- The bakehouse review tables (`media_customer_reviews`, `media_gold_reviews_chunked`); unstructured review data is a later feature.
- Databricks Pages, Genie Ontology, and Genie setup — later features that consume this foundation.
- Real incremental or streaming ingestion tuning; the sample is static.

## Acceptance

- `databricks bundle validate` passes against the repository.
- Every pipeline SQL file reads or writes a fully qualified `bronze`/`silver`/`gold` object and names one concept.
- The Metric View YAML lists named measures (total revenue, quantity, transaction count, average transaction value) that resolve against the gold fact.
- A business term (for example sales amount) has one spelling across silver columns, the gold fact, the Metric View, the ontology, and the semantic model.
- The C4 docs show context, container, and component levels; the ontology lists object types with definitions and source-column mappings.

## Notes

- Free Edition shares no `tpcds_sf1`; the sample catalog holds `bakehouse`, `nyctaxi`, and `tpch` only. The demo uses `bakehouse` because it is a real retail store-sales model.
- `cardNumber` stays in bronze and is never published; `email_address` and `phone_number` stop at silver. A governance talking point.
- Catalog is `workspace` (the one writable catalog in Free Edition), set once in `databricks.yml`.
