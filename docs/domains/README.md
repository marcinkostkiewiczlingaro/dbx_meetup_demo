# Business Domains — Gold Table Registry

↑ [System Context](../README.md) &nbsp;|&nbsp; → [Tables](../reference/tables/README.md)

> **Governance registry.** The authoritative map from every gold table to exactly one
> business **subdomain** under the `Retail Analytics` domain. Domains are a cross-cutting
> governance layer over the gold tables, not the same thing as the pipelines that build them.
> A table is built by exactly one pipeline and belongs to exactly one subdomain; the two
> layers are independent.

## Why this exists

A pipeline is the build-ownership layer: it says which code writes a table. A domain is the
governance layer: it says which business area owns the meaning of a table, regardless of which
pipeline built it. Part 2 of the demo lifts these groups straight into Databricks **Domain**
governance objects, so the registry here mirrors the governed domain tree already created in
the workspace — one name for one thing across code, catalog, and Genie.

## The domain tree (source: Databricks Domains API)

The workspace governs a single two-level tree. `tag_key` is the exact Unity Catalog tag the
Domain applies to a table; a child's `tag_key` is `parent/child`. The Databricks-managed
`system.general_domain` is the account default and holds none of our tables.

| Domain | Subdomain | `tag_key` | `domain_id` | What it governs |
|---|---|---|---|---|
| Retail Analytics | — | `Retail Analytics` | `c825d510-e0dc-478d-9321-c9fa8d83d7a6` | TPC-DS retail metrics across catalog, web, and store sales, returns, and shared dimensions. The parent; tables are tagged on a subdomain, not here. |
| Retail Analytics | Sales | `Retail Analytics/Sales` | `ddd2a002-362a-4e61-a952-f28b41045a4f` | The sales-channel facts across catalog, web, and store. |
| Retail Analytics | Returns | `Retail Analytics/Returns` | `9c4fd3f9-629d-40df-87d0-9f1dd1a80b31` | The return facts across catalog, web, and store. |
| Retail Analytics | Shared Dimensions | `Retail Analytics/Shared Dimensions` | `12ae15d6-98b4-4d3c-9720-f424a53885e9` | Customer, item, promotion, store, calendar, and reference dimensions, plus the inventory snapshot — everything shared across the sales and returns facts. |

Inventory is the one non-sales, non-returns fact in TPC-DS. The workspace groups it with the
shared dimensions (the `Shared Dimensions` subtitle names it), so it is tagged there rather
than in a subdomain of its own.

## How the subdomain is carried on the table

Each gold table carries its subdomain in its table `COMMENT` as a `domain=<tag_key>` marker —
the exact Databricks `tag_key`, for example `domain=Retail Analytics/Sales`. The marker is
written in the `COMMENT` rather than as a Unity Catalog tag because applying UC tags from
inside a Lakeflow declarative pipeline is not reliable — a pipeline defines a table with
`CREATE OR REFRESH ... COMMENT`, and `ALTER TABLE ... SET TAGS` is not part of that
definition. This registry stays the authoritative source; the `COMMENT` marker is the
on-table copy and must match the `tag_key` named here.

## Registry

Every gold table appears exactly once. The `tag_key` in the last column is the exact string
written in each table's `COMMENT` marker.

| Gold table | Pipeline | Subdomain `tag_key` |
|---|---|---|
| `gold.fct_store_sales` | store_sales | `Retail Analytics/Sales` |
| `gold.fct_catalog_sales` | catalog_sales | `Retail Analytics/Sales` |
| `gold.fct_web_sales` | web_sales | `Retail Analytics/Sales` |
| `gold.fct_store_returns` | store_sales | `Retail Analytics/Returns` |
| `gold.fct_catalog_returns` | catalog_sales | `Retail Analytics/Returns` |
| `gold.fct_web_returns` | web_sales | `Retail Analytics/Returns` |
| `gold.dim_customer` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_customer_demographics` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_household_demographics` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_income_band` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_date` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_time` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_item` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_promotion` | core | `Retail Analytics/Shared Dimensions` |
| `gold.dim_store` | store_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_call_center` | catalog_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_catalog_page` | catalog_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_web_site` | web_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_web_page` | web_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_warehouse` | inventory | `Retail Analytics/Shared Dimensions` |
| `gold.dim_ship_mode` | catalog_sales | `Retail Analytics/Shared Dimensions` |
| `gold.dim_reason` | core | `Retail Analytics/Shared Dimensions` |
| `gold.fct_inventory` | inventory | `Retail Analytics/Shared Dimensions` |
