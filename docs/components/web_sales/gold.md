---
c4_level: 3
module: web_sales
component: gold
entities: [FctWebSales, FctWebReturns, DimWebSite, DimWebPage]
tables: [gold.fct_web_sales, gold.fct_web_returns, gold.dim_web_site, gold.dim_web_page]
---
# Gold — Star Schema (Web)

| module | component | entities | tables |
|---|---|---|---|
| [web_sales](../../modules/web_sales.md) | gold | FctWebSales · FctWebReturns · DimWebSite · DimWebPage | [gold.fct_web_sales](../../reference/tables/gold.fct_web_sales.md) · [gold.fct_web_returns](../../reference/tables/gold.fct_web_returns.md) · [gold.dim_web_site](../../reference/tables/gold.dim_web_site.md) |

> **C4 Level 3 — Component.** The web star schema — sales and returns facts and two web dims — that the governed Metric Views read directly, joined on surrogate keys.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctWebSales` | [`gold.fct_web_sales`](../../reference/tables/gold.fct_web_sales.md) | — | Conformed sales fact. Grain: one order line. |
| `FctWebReturns` | [`gold.fct_web_returns`](../../reference/tables/gold.fct_web_returns.md) | — | Conformed returns fact. Grain: one return line. |
| `DimWebSite` | [`gold.dim_web_site`](../../reference/tables/gold.dim_web_site.md) | — | Web-site dimension. |
| `DimWebPage` | [`gold.dim_web_page`](../../reference/tables/gold.dim_web_page.md) | — | Web-page dimension. |

```mermaid
C4Component
  title Web Star Schema — Components

  ContainerDb(fct, "gold.fct_web_sales", "Fact", "One row per order line.")
  ContainerDb(ret, "gold.fct_web_returns", "Fact", "One row per return line.")
  ComponentDb(core, "Core gold dims", "Conformed", "customer, item, date, promotion")
  ContainerDb(dws, "gold.dim_web_site", "Dimension", "One row per web site.")
  ContainerDb(dwp, "gold.dim_web_page", "Dimension", "One row per web page.")

  Rel(fct, core, "customer/item/date/promo keys")
  Rel(fct, dws, "web_site_key")
  Rel(fct, dwp, "web_page_key")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

Each entity is one SQL file in `src/web_sales/gold/`. The web dims are owned by this
pipeline; the facts read the conformed core gold dims across pipelines. The governed Metric
Views read these facts and dimensions directly, joined on surrogate keys.
