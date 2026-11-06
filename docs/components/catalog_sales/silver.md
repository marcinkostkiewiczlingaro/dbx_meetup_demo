---
c4_level: 3
module: catalog_sales
component: silver
entities: [DimCallCenter, DimCatalogPage, DimShipMode, FctCatalogSales, FctCatalogReturns]
tables: [silver.dim_call_center, silver.dim_catalog_page, silver.dim_ship_mode, silver.fct_catalog_sales, silver.fct_catalog_returns]
---
# Silver — Cleansed, Business-Named (Catalog)

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | silver | DimCallCenter · DimCatalogPage · DimShipMode · FctCatalogSales · FctCatalogReturns | silver.dim_call_center · silver.dim_catalog_page · silver.dim_ship_mode · silver.fct_catalog_sales · silver.fct_catalog_returns |

> **C4 Level 3 — Component.** Cleansed catalog facts and the catalog-only dimensions, with business column names and quality checks.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCallCenter` | `silver.dim_call_center` | — | Call center that takes the order, current records only. |
| `DimCatalogPage` | `silver.dim_catalog_page` | — | Catalog page the line was ordered from. |
| `DimShipMode` | `silver.dim_ship_mode` | — | Shipping method of the order. |
| `FctCatalogSales` | `silver.fct_catalog_sales` | — | Catalog-sales lines; sold date resolved through the core calendar. |
| `FctCatalogReturns` | `silver.fct_catalog_returns` | — | Catalog-return lines; returned date resolved through the core calendar. |

Each entity is one SQL file in `src/catalog_sales/silver/`. The grain of both facts is one
order line (`order_number` × `item_key`). `customer_key` is the billed customer on sales and
the returning customer on returns.
