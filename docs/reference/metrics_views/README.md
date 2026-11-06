# Metric Views (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; ← [Reference](../tables/README.md)

> **C4 Level 4 — Metric Views.** One file per Metric View: its measures, dimensions, and the authoritative YAML the backend creates it from.

Each file under this folder is both the documentation of a Metric View and the one source
of truth for its definition. There is no separate YAML file; the YAML lives in the file's
`## Definition` block, and the backend deploy extracts that block to run
`CREATE OR REPLACE VIEW {created_as} WITH METRICS LANGUAGE YAML AS $$ … $$`.

| Metric View | Source table | Created as |
|---|---|---|
| [store_sales_metrics](./store_sales_metrics.md) | [gold.store_sales_enriched](../tables/gold.store_sales_enriched.md) | `workspace.gold.store_sales_metrics` |
