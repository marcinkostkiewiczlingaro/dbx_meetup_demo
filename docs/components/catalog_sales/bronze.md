---
c4_level: 3
module: catalog_sales
component: bronze
entities: [CatalogSalesRaw, CatalogReturnsRaw, CallCenterRaw, CatalogPageRaw, ShipModeRaw]
tables: [bronze.catalog_sales, bronze.catalog_returns, bronze.call_center, bronze.catalog_page, bronze.ship_mode]
---
# Bronze — Raw Ingest (Catalog)

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | bronze | CatalogSalesRaw · CatalogReturnsRaw · CallCenterRaw · CatalogPageRaw · ShipModeRaw | bronze.catalog_sales · bronze.catalog_returns · bronze.call_center · bronze.catalog_page · bronze.ship_mode |

> **C4 Level 3 — Component.** Streaming copies of the catalog-sales, catalog-returns, and catalog-only dimension source tables, kept in the source shape for audit.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `CatalogSalesRaw` | `bronze.catalog_sales` | — | Raw catalog-sales lines; the grain the sales fact stands on. |
| `CatalogReturnsRaw` | `bronze.catalog_returns` | — | Raw catalog-return lines; the grain the returns fact stands on. |
| `CallCenterRaw` | `bronze.call_center` | — | Raw call centers with slowly-changing history. |
| `CatalogPageRaw` | `bronze.catalog_page` | — | Raw catalog pages. |
| `ShipModeRaw` | `bronze.ship_mode` | — | Raw ship modes. |

Each entity is one SQL file in `src/catalog_sales/bronze/`. The conformed customer, item,
date, and promotion dimensions are built by the [core](../core/bronze.md) pipeline, not here.
