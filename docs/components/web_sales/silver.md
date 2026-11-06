---
c4_level: 3
module: web_sales
component: silver
entities: [DimWebSite, DimWebPage, FctWebSales, FctWebReturns]
tables: [silver.dim_web_site, silver.dim_web_page, silver.fct_web_sales, silver.fct_web_returns]
---
# Silver — Cleansed, Business-Named (Web)

| module | component | entities | tables |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | silver | DimWebSite · DimWebPage · FctWebSales · FctWebReturns | silver.dim_web_site · silver.dim_web_page · silver.fct_web_sales · silver.fct_web_returns |

> **C4 Level 3 — Component.** Cleansed web facts and the web-only dimensions, with business column names and quality checks.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimWebSite` | `silver.dim_web_site` | — | Web site the order came through, current records only. |
| `DimWebPage` | `silver.dim_web_page` | — | Web page the line was ordered from. |
| `FctWebSales` | `silver.fct_web_sales` | — | Web-sales lines; sold date resolved through the core calendar. |
| `FctWebReturns` | `silver.fct_web_returns` | — | Web-return lines; returned date resolved through the core calendar. |

Each entity is one SQL file in `src/web_sales/silver/`. The grain of both facts is one
order line (`order_number` × `item_key`). `customer_key` is the billed customer on sales and
the returning customer on returns.
