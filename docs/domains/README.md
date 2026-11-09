# Business Domains — Gold Table Registry

↑ [System Context](../README.md) &nbsp;|&nbsp; → [Tables](../reference/tables/README.md)

> **Governance registry.** The authoritative map from every gold table to exactly one named
> business domain. Domains are a cross-cutting governance layer over the gold tables, not the
> same thing as the pipelines that build them. A table is built by exactly one pipeline and
> belongs to exactly one domain; the two layers are independent.

## Why this exists

A pipeline is the build-ownership layer: it says which code writes a table. A domain is the
governance layer: it says which business area owns the meaning of a table, regardless of which
pipeline built it. For example, the Calendar domain holds `gold.dim_date` and `gold.dim_time`,
both built by the `core` pipeline; the Store Sales domain holds four tables built by the
`store_sales` pipeline. Part 2 of the demo lifts these groups straight into Unity Catalog
Domain governance objects without re-deciding what belongs where.

## How the domain is carried on the table

Each gold table carries its domain in its table `COMMENT` as a `domain=<Name>` marker (for
example, `domain=Store Sales`). The marker is written in the `COMMENT` rather than as a Unity
Catalog tag because applying UC tags from inside a Lakeflow declarative pipeline is not
reliable — a pipeline defines a table with `CREATE OR REFRESH ... COMMENT`, and `ALTER TABLE
... SET TAGS` is not part of that definition. This registry stays the authoritative source;
the `COMMENT` marker is the on-table copy and must match the domain named here.

## Registry

Every gold table appears exactly once. The domain name in the last column is the exact string
written in each table's `COMMENT` marker.

| Gold table | Pipeline | Domain |
|---|---|---|
| `gold.dim_customer` | core | Customer |
| `gold.dim_customer_demographics` | core | Customer |
| `gold.dim_household_demographics` | core | Customer |
| `gold.dim_income_band` | core | Customer |
| `gold.dim_date` | core | Calendar |
| `gold.dim_time` | core | Calendar |
| `gold.dim_item` | core | Product |
| `gold.dim_promotion` | core | Marketing |
| `gold.fct_store_sales` | store_sales | Store Sales |
| `gold.fct_store_returns` | store_sales | Store Sales |
| `gold.store_sales_enriched` | store_sales | Store Sales |
| `gold.dim_store` | store_sales | Store Sales |
| `gold.fct_catalog_sales` | catalog_sales | Catalog Sales |
| `gold.fct_catalog_returns` | catalog_sales | Catalog Sales |
| `gold.catalog_sales_enriched` | catalog_sales | Catalog Sales |
| `gold.dim_call_center` | catalog_sales | Catalog Sales |
| `gold.dim_catalog_page` | catalog_sales | Catalog Sales |
| `gold.fct_web_sales` | web_sales | Web Sales |
| `gold.fct_web_returns` | web_sales | Web Sales |
| `gold.web_sales_enriched` | web_sales | Web Sales |
| `gold.dim_web_site` | web_sales | Web Sales |
| `gold.dim_web_page` | web_sales | Web Sales |
| `gold.dim_warehouse` | inventory | Inventory |
| `gold.fct_inventory` | inventory | Inventory |
| `gold.dim_ship_mode` | catalog_sales | Shipping & Returns Reference |
| `gold.dim_reason` | core | Shipping & Returns Reference |

## Domains

| Domain | What it governs |
|---|---|
| Customer | Who buys: the customer and the demographic and income-band reference data that describe customers and households. |
| Calendar | When: the calendar-day and time-of-day dimensions shared by every fact. |
| Product | What is sold: the item dimension. |
| Marketing | The promotion dimension that explains why an item was offered at a price. |
| Store Sales | The store sales-channel facts, the store dimension, and the wide consumption table. |
| Catalog Sales | The catalog sales-channel facts, the catalog-only dimensions, and the wide consumption table. |
| Web Sales | The web sales-channel facts, the web-only dimensions, and the wide consumption table. |
| Inventory | The periodic stock snapshot and the warehouse dimension — TPC-DS's one non-sales subject area. |
| Shipping & Returns Reference | Shared reference data for fulfilment and returns: the ship-mode dimension and the return-reason dimension, used across channels. |
