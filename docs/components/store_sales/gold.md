---
c4_level: 3
module: store_sales
component: gold
entities: [FctStoreSales, FctStoreReturns, DimStore]
tables: [gold.fct_store_sales, gold.fct_store_returns, gold.dim_store]
---
# Gold — Star Schema (Store)

| module | component | entities | tables |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | gold | FctStoreSales · FctStoreReturns · DimStore | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) · [gold.fct_store_returns](../../reference/tables/gold.fct_store_returns.md) · [gold.dim_store](../../reference/tables/gold.dim_store.md) |

> **C4 Level 3 — Component.** The store star schema — sales and returns facts and the store dimension — that the governed Metric Views read directly, joined on surrogate keys.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctStoreSales` | [`gold.fct_store_sales`](../../reference/tables/gold.fct_store_sales.md) | — | Conformed sales fact. Grain: one ticket line. |
| `FctStoreReturns` | [`gold.fct_store_returns`](../../reference/tables/gold.fct_store_returns.md) | — | Conformed returns fact. Grain: one return line. |
| `DimStore` | [`gold.dim_store`](../../reference/tables/gold.dim_store.md) | — | Store dimension (store-domain only). |

```mermaid
C4Component
  title Store Star Schema — Components

  ContainerDb(fct, "gold.fct_store_sales", "Fact", "One row per ticket line.")
  ContainerDb(ret, "gold.fct_store_returns", "Fact", "One row per return line.")
  ComponentDb(core, "Core gold dims", "Conformed", "customer, item, date, promotion")
  ContainerDb(dims, "gold.dim_store", "Dimension", "One row per store.")

  Rel(fct, core, "customer/item/date/promo keys")
  Rel(fct, dims, "store_key")
  Rel(ret, core, "customer/item/date keys")
  Rel(ret, dims, "store_key")
  UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
```

Each entity is one SQL file in `src/store_sales/gold/`. The store dimension is owned by this
pipeline; the facts read the conformed core gold dims across pipelines. The governed Metric
Views read these facts and dimensions directly, joined on surrogate keys.
