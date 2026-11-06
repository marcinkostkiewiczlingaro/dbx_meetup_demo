# Tables (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; → [Metric Views](../metrics_views/README.md)

> **C4 Level 4 — Tables.** Column-level schemas of the gold star schema and the wide consumption table. Load one only when you need exact column names.

| Table | Role | Built from |
|---|---|---|
| [gold.fct_store_sales](./gold.fct_store_sales.md) | Fact — one store-sales ticket line | `silver.fct_store_sales` + dims |
| [gold.store_sales_enriched](./gold.store_sales_enriched.md) | Wide consumption table (Metric View, Genie) | `gold.fct_store_sales` + dims |
| [gold.dim_customer](./gold.dim_customer.md) | Dimension — one row per customer | `silver.dim_customer` |
| [gold.dim_item](./gold.dim_item.md) | Dimension — one row per item | `silver.dim_item` |
| [gold.dim_store](./gold.dim_store.md) | Dimension — one row per store | `silver.dim_store` |
| [gold.dim_date](./gold.dim_date.md) | Dimension — one row per calendar day | `silver.dim_date` |
| [gold.dim_promotion](./gold.dim_promotion.md) | Dimension — one row per promotion | `silver.dim_promotion` |
