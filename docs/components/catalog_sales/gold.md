---
c4_level: 3
module: catalog_sales
component: gold
entities: [FctCatalogSales, FctCatalogReturns, DimCallCenter, DimCatalogPage, DimShipMode, CatalogSalesEnriched]
tables: [gold.fct_catalog_sales, gold.fct_catalog_returns, gold.dim_call_center, gold.dim_catalog_page, gold.dim_ship_mode, gold.catalog_sales_enriched]
---
# Gold — Star Schema and Consumption Table (Catalog)

| module | component | entities | tables |
|---|---|---|---|
| [catalog_sales](../../modules/catalog_sales.md) | gold | FctCatalogSales · FctCatalogReturns · DimCallCenter · DimCatalogPage · DimShipMode · CatalogSalesEnriched | [gold.fct_catalog_sales](../../reference/tables/gold.fct_catalog_sales.md) · [gold.catalog_sales_enriched](../../reference/tables/gold.catalog_sales_enriched.md) |

> **C4 Level 3 — Component.** The catalog star schema (sales and returns facts, three catalog dims) plus the wide `catalog_sales_enriched` table the Metric View reads.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctCatalogSales` | [`gold.fct_catalog_sales`](../../reference/tables/gold.fct_catalog_sales.md) | — | Conformed sales fact. Grain: one order line. |
| `FctCatalogReturns` | [`gold.fct_catalog_returns`](../../reference/tables/gold.fct_catalog_returns.md) | — | Conformed returns fact. Grain: one return line. |
| `DimCallCenter` | [`gold.dim_call_center`](../../reference/tables/gold.dim_call_center.md) | — | Call-center dimension. |
| `DimCatalogPage` | [`gold.dim_catalog_page`](../../reference/tables/gold.dim_catalog_page.md) | — | Catalog-page dimension. |
| `DimShipMode` | [`gold.dim_ship_mode`](../../reference/tables/gold.dim_ship_mode.md) | — | Ship-mode dimension. |
| `CatalogSalesEnriched` | [`gold.catalog_sales_enriched`](../../reference/tables/gold.catalog_sales_enriched.md) | — | Sales fact widened with core dims and the catalog dims; read by the Metric View and Genie with no joins. |

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

Each entity is one SQL file in `src/catalog_sales/gold/`. The enriched table reads the core
gold dims across pipelines; the catalog dims are owned by this pipeline.
