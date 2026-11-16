---
c4_level: 3
module: catalog_sales
component: gold
entities: [FctCatalogSales, FctCatalogReturns, DimCallCenter, DimCatalogPage, DimShipMode]
tables: [gold.fct_catalog_sales, gold.fct_catalog_returns, gold.dim_call_center, gold.dim_catalog_page, gold.dim_ship_mode]
---
# Gold — Star Schema (Catalog)

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | gold | FctCatalogSales · FctCatalogReturns · DimCallCenter · DimCatalogPage · DimShipMode | [gold.fct_catalog_sales](../../reference/tables/gold.fct_catalog_sales.md) · [gold.fct_catalog_returns](../../reference/tables/gold.fct_catalog_returns.md) · [gold.dim_call_center](../../reference/tables/gold.dim_call_center.md) |

> **C4 Level 3 — Component.** The catalog star schema — sales and returns facts and three catalog dims — that the governed Metric Views read directly, joined on surrogate keys.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctCatalogSales` | [`gold.fct_catalog_sales`](../../reference/tables/gold.fct_catalog_sales.md) | — | Conformed sales fact. Grain: one order line. |
| `FctCatalogReturns` | [`gold.fct_catalog_returns`](../../reference/tables/gold.fct_catalog_returns.md) | — | Conformed returns fact. Grain: one return line. |
| `DimCallCenter` | [`gold.dim_call_center`](../../reference/tables/gold.dim_call_center.md) | — | Call-center dimension. |
| `DimCatalogPage` | [`gold.dim_catalog_page`](../../reference/tables/gold.dim_catalog_page.md) | — | Catalog-page dimension. |
| `DimShipMode` | [`gold.dim_ship_mode`](../../reference/tables/gold.dim_ship_mode.md) | — | Ship-mode dimension. |

```mermaid
C4Component
  title Catalog Star Schema — Components

  ContainerDb(fct, "gold.fct_catalog_sales", "Fact", "One row per order line.")
  ContainerDb(ret, "gold.fct_catalog_returns", "Fact", "One row per return line.")
  ComponentDb(core, "Core gold dims", "Conformed", "customer, item, date, promotion")
  ContainerDb(dcc, "gold.dim_call_center", "Dimension", "One row per call center.")
  ContainerDb(dcp, "gold.dim_catalog_page", "Dimension", "One row per catalog page.")
  ContainerDb(dsm, "gold.dim_ship_mode", "Dimension", "One row per ship mode.")

  Rel(fct, core, "customer/item/date/promo keys")
  Rel(fct, dcc, "call_center_key")
  Rel(fct, dcp, "catalog_page_key")
  Rel(fct, dsm, "ship_mode_key")
  UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

Each entity is one SQL file in `src/catalog_sales/gold/`. The catalog dims are owned by this
pipeline; the facts read the conformed core gold dims across pipelines. The governed Metric
Views read these facts and dimensions directly, joined on surrogate keys.
