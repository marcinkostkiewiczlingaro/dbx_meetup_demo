---
opened: 2026-11-06
---

# F004 · The demo runs on the TPC-DS store-sales dataset under one documented semantic foundation

## Outcome

A data engineer points the demo at the public `samples.tpcds_sf1000` dataset and builds a
store-sales data model through bronze, silver, and gold layers in Unity Catalog. An analyst
reads the same model through a governed Metric View whose definition lives with the docs.
Every business term keeps one name across the pipeline, the star schema, the Metric View,
the ontology, Genie, and the dashboard. The documentation follows the prepared
documentation standard (C4 levels, front-matter, navigation rules, `reference/` leaves),
and the Metric View is a governed `docs/reference/metrics_views/` reference file whose
embedded YAML is the one source the backend creates the view from. No bakery/bakehouse
content remains anywhere in the repository.

## Scope

- Replace the bakehouse sample with TPC-DS store sales. Source schema is a bundle variable
  `source_schema`, default `samples.tpcds_sf1000`. Start seam: `databricks.yml` and
  `resources/`.
- Medallion over `store_sales` (grain: one ticket line, `ss_ticket_number` × `ss_item_sk`)
  with dimensions `customer` + `customer_address`, `item`, `date_dim`, `store`, `promotion`.
  Bronze = typed ingest; silver = business-named clean columns; gold = star schema
  (`fct_store_sales` + dims) plus one wide `store_sales_enriched` consumption table.
- Carry the "no joins in the Metric View" pattern: the Metric View reads
  `gold.store_sales_enriched`, the pre-widened fact.
- Move the Metric View definition into `docs/reference/metrics_views/store_sales_metrics.md`
  as a governed L4 reference file; remove the top-level `metrics/` folder. Its README states
  the backend `CREATE OR REPLACE VIEW ... WITH METRICS LANGUAGE YAML` command that reads the
  file's `## Definition` block.
- Restructure `docs/` to the prepared standard: L1 context, L2 modules, L3 components, L4
  `reference/tables/` and `reference/metrics_views/`. Place the standard in the repo at
  `docs/engineering/documentation-standard.md`, adapted to this demo (not the OSA examples).
- Rewrite the ontology, Genie space, and dashboard for store sales, reading the new gold
  model and the same business vocabulary.

## Out of scope

- Catalog/web/returns facts (`web_sales`, `catalog_sales`, `store_returns`) — store sales only.
- Running the 1 TB sf1000 build in review; a live pipeline run is the owner's demo-time step.
- Changing `spec/vision.md` or the BMAD workflow narrative.

## Acceptance

- No match for `baker`, `bakehouse`, or `bakery` (case-insensitive) in tracked files
  outside `spec/features/done/`.
- `databricks bundle validate --target dev` passes; every `src/` SQL names only
  `source_schema` tables or prior medallion layers, fully qualified.
- `docs/` follows the standard: every L2/L3/L4 content file has the front-matter block, the
  inline navigation table, and the blockquote; every L3 file has an `## Entities` table.
- `docs/reference/metrics_views/store_sales_metrics.md` exists with `type: metric_view`
  front-matter and a `## Definition` YAML block; no metric-view YAML exists elsewhere.
- Measure and dimension names match across the Metric View reference file, the ontology, the
  semantic model, Genie instructions, and the dashboard tiles.
- `README.md` and `docs/README.md` describe the TPC-DS store-sales demo and the
  `source_schema` variable, including the sf1 fallback for a cheap run.

## Notes

- sf1000 is 1 TB and will not build cheaply on Databricks Free Edition; the `source_schema`
  variable lets a run target `samples.tpcds_sf1` (1 GB) instead. Flag kept visible in both
  READMEs; the owner decides which scale the live demo uses.
- Prepared standard: `/Users/karolmierzejewski/Downloads/documentation-standard.md` (already
  extended with the metric-view L4 type). Copy it into the repo and adapt its examples.
