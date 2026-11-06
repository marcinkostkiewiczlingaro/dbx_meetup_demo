# Tables (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; → [Metric Views](../metrics_views/README.md)

> **C4 Level 4 — Tables.** Column-level schemas of the gold star schema and the wide consumption table. Load one only when you need exact column names.

Core dimensions (built once, shared by all channels):

| Table | Role | Built from |
|---|---|---|
| [gold.dim_customer](./gold.dim_customer.md) | Dimension — one row per customer | `silver.dim_customer` |
| [gold.dim_item](./gold.dim_item.md) | Dimension — one row per item | `silver.dim_item` |
| [gold.dim_date](./gold.dim_date.md) | Dimension — one row per calendar day | `silver.dim_date` |
| [gold.dim_promotion](./gold.dim_promotion.md) | Dimension — one row per promotion | `silver.dim_promotion` |

Store channel:

| Table | Role | Built from |
|---|---|---|
| [gold.fct_store_sales](./gold.fct_store_sales.md) | Fact — one store-sales ticket line | `silver.fct_store_sales` + dims |
| [gold.fct_store_returns](./gold.fct_store_returns.md) | Fact — one store-return line | `silver.fct_store_returns` + dims |
| [gold.store_sales_enriched](./gold.store_sales_enriched.md) | Wide consumption table (Metric View, Genie) | `gold.fct_store_sales` + dims |
| [gold.dim_store](./gold.dim_store.md) | Dimension — one row per store | `silver.dim_store` |

Catalog channel:

| Table | Role | Built from |
|---|---|---|
| [gold.fct_catalog_sales](./gold.fct_catalog_sales.md) | Fact — one catalog-sales order line | `silver.fct_catalog_sales` + dims |
| [gold.fct_catalog_returns](./gold.fct_catalog_returns.md) | Fact — one catalog-return line | `silver.fct_catalog_returns` + dims |
| [gold.catalog_sales_enriched](./gold.catalog_sales_enriched.md) | Wide consumption table (Metric View, Genie) | `gold.fct_catalog_sales` + dims |
| [gold.dim_call_center](./gold.dim_call_center.md) | Dimension — one row per call center | `silver.dim_call_center` |
| [gold.dim_catalog_page](./gold.dim_catalog_page.md) | Dimension — one row per catalog page | `silver.dim_catalog_page` |
| [gold.dim_ship_mode](./gold.dim_ship_mode.md) | Dimension — one row per ship mode | `silver.dim_ship_mode` |

Web channel:

| Table | Role | Built from |
|---|---|---|
| [gold.fct_web_sales](./gold.fct_web_sales.md) | Fact — one web-sales order line | `silver.fct_web_sales` + dims |
| [gold.fct_web_returns](./gold.fct_web_returns.md) | Fact — one web-return line | `silver.fct_web_returns` + dims |
| [gold.web_sales_enriched](./gold.web_sales_enriched.md) | Wide consumption table (Metric View, Genie) | `gold.fct_web_sales` + dims |
| [gold.dim_web_site](./gold.dim_web_site.md) | Dimension — one row per web site | `silver.dim_web_site` |
| [gold.dim_web_page](./gold.dim_web_page.md) | Dimension — one row per web page | `silver.dim_web_page` |
