---
c4_level: 4
type: table_schema
database: gold
table: dim_web_site
component: components/web_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_web_site

| module | component | table | pipeline |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | [gold](../../components/web_sales/gold.md) | gold.dim_web_site | ← [silver.dim_web_site](../../components/web_sales/silver.md) · → [gold.fct_web_sales](./gold.fct_web_sales.md) |

> **C4 Level 4 — Table.** Conformed web-site dimension, one row per web site (current records only).

## Columns

| Column | Type | Meaning |
|---|---|---|
| `web_site_key` | int | Business key, one per web site. |
| `web_site_id` | string | Natural web-site id. |
| `web_site_name` | string | Web-site name. |
| `web_site_class` | string | Class of the web site. |
| `web_site_manager` | string | Manager of the web site. |
| `web_site_city` | string | City of the web site. |
| `web_site_state` | string | State of the web site. |
| `web_site_country` | string | Country of the web site. |
| `web_site_company` | string | Company name. |
