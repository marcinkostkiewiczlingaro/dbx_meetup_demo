---
c4_level: 4
type: table_schema
database: gold
table: dim_catalog_page
component: components/catalog_sales/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
# gold.dim_catalog_page

| module | component | table | pipeline |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | [gold](../../components/catalog_sales/gold.md) | gold.dim_catalog_page | ← [silver.dim_catalog_page](../../components/catalog_sales/silver.md) · → [gold.fct_catalog_sales](./gold.fct_catalog_sales.md) |

> **C4 Level 4 — Table.** Conformed catalog-page dimension, one row per catalog page.

## Columns

| Column | Type | Meaning |
|---|---|---|
| `catalog_page_key` | int | Business key, one per catalog page. |
| `catalog_page_id` | string | Natural catalog-page id. |
| `catalog_department` | string | Department the page belongs to. |
| `catalog_number` | int | Catalog the page is in. |
| `catalog_page_number` | int | Page number within the catalog. |
| `page_type` | string | Type of the catalog page. |
| `page_description` | string | Description of the catalog page. |
