---
c4_level: 3
module: web_sales
component: bronze
entities: [WebSalesRaw, WebReturnsRaw, WebSiteRaw, WebPageRaw]
tables: [bronze.web_sales, bronze.web_returns, bronze.web_site, bronze.web_page]
---
# Bronze — Raw Ingest (Web)

| module | component | entities | tables |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | bronze | WebSalesRaw · WebReturnsRaw · WebSiteRaw · WebPageRaw | bronze.web_sales · bronze.web_returns · bronze.web_site · bronze.web_page |

> **C4 Level 3 — Component.** Streaming copies of the web-sales, web-returns, and web-only dimension source tables, kept in the source shape for audit.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `WebSalesRaw` | `bronze.web_sales` | — | Raw web-sales lines; the grain the sales fact stands on. |
| `WebReturnsRaw` | `bronze.web_returns` | — | Raw web-return lines; the grain the returns fact stands on. |
| `WebSiteRaw` | `bronze.web_site` | — | Raw web sites with slowly-changing history. |
| `WebPageRaw` | `bronze.web_page` | — | Raw web pages. |

Each entity is one SQL file in `src/web_sales/bronze/`. The conformed customer, item,
date, and promotion dimensions are built by the [core](../core/bronze.md) pipeline, not here.
