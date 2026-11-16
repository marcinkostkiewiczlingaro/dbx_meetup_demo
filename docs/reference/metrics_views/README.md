# Metric Views (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; ← [Tables](../tables/README.md) &nbsp;|&nbsp; → [Algorithms](../algorithms/README.md)

> **C4 Level 4 — Metric Views.** One file per Metric View: its measures, dimensions, and the authoritative YAML the backend creates it from.

Each file under this folder is both the documentation of a Metric View and the one source
of truth for its definition. There is no separate YAML file; the YAML lives in the file's
`## Definition` block, and the backend deploy extracts that block to run
`CREATE OR REPLACE VIEW {created_as} WITH METRICS LANGUAGE YAML AS $$ … $$`.

Every view reads the gold `fct_*`/`dim_*` tables directly and joins the dimensions on their
surrogate keys with explicit `on:` expressions. No pre-joined copy of the star schema exists
for a view to drift from.

| Metric View | Source table | Created as |
|---|---|---|
| [store_sales_metrics](./store_sales_metrics.md) | [gold.fct_store_sales](../tables/gold.fct_store_sales.md) | `workspace.gold.store_sales_metrics` |
| [catalog_sales_metrics](./catalog_sales_metrics.md) | [gold.fct_catalog_sales](../tables/gold.fct_catalog_sales.md) | `workspace.gold.catalog_sales_metrics` |
| [web_sales_metrics](./web_sales_metrics.md) | [gold.fct_web_sales](../tables/gold.fct_web_sales.md) | `workspace.gold.web_sales_metrics` |
| [store_returns_metrics](./store_returns_metrics.md) | [gold.fct_store_returns](../tables/gold.fct_store_returns.md) | `workspace.gold.store_returns_metrics` |
| [catalog_returns_metrics](./catalog_returns_metrics.md) | [gold.fct_catalog_returns](../tables/gold.fct_catalog_returns.md) | `workspace.gold.catalog_returns_metrics` |
| [web_returns_metrics](./web_returns_metrics.md) | [gold.fct_web_returns](../tables/gold.fct_web_returns.md) | `workspace.gold.web_returns_metrics` |
| [inventory_metrics](./inventory_metrics.md) | [gold.fct_inventory](../tables/gold.fct_inventory.md) | `workspace.gold.inventory_metrics` |
| [item_metrics](./item_metrics.md) | [gold.dim_item](../tables/gold.dim_item.md) | `workspace.gold.item_metrics` |
| [promotion_metrics](./promotion_metrics.md) | [gold.dim_promotion](../tables/gold.dim_promotion.md) | `workspace.gold.promotion_metrics` |
| [store_metrics](./store_metrics.md) | [gold.dim_store](../tables/gold.dim_store.md) | `workspace.gold.store_metrics` |
| [customer_metrics](./customer_metrics.md) | [gold.dim_customer](../tables/gold.dim_customer.md) | `workspace.gold.customer_metrics` |
