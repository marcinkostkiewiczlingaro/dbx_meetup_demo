# Modules (L2 — Containers)

↑ [System Context](../README.md) &nbsp;|&nbsp; ↓ [Components](../components/README.md)

> **C4 Level 2 — Containers.** One core pipeline builds the conformed dimensions once; three sales-channel domains build their facts and read those shared dims.

```mermaid
C4Container
  title Sales-Channel Analytics — Containers

  System_Ext(src, "TPC-DS source", "${source_schema}")

  Container_Boundary(ws, "Databricks Workspace") {
    Container(core, "Core", "Lakeflow SQL", "Conformed dims: customer, item, date, promotion.")
    Container(store, "Store Sales", "Lakeflow SQL + Metric View", "Store facts and metrics.")
    Container(catalog, "Catalog Sales", "Lakeflow SQL + Metric View", "Catalog facts and metrics.")
    Container(web, "Web Sales", "Lakeflow SQL + Metric View", "Web facts and metrics.")
    Container(inv, "Inventory", "Lakeflow SQL", "Stock-snapshot fact and warehouse dim.")
  }

  Rel(src, core, "Read")
  Rel(src, store, "Read")
  Rel(src, catalog, "Read")
  Rel(src, web, "Read")
  Rel(src, inv, "Read")
  Rel(core, store, "Conformed dims")
  Rel(core, catalog, "Conformed dims")
  Rel(core, web, "Conformed dims")
  Rel(core, inv, "Conformed dims")
  UpdateLayoutConfig($c4ShapeInRow="2", $c4BoundaryInRow="1")
```

| Module | Role | Databases |
|---|---|---|
| [core](./core.md) | Builds the conformed dimensions once, read by every channel. | `bronze`, `silver`, `gold` |
| [store_sales](./store_sales.md) | Store sales-channel facts, enriched table, and Metric View. | `bronze`, `silver`, `gold` |
| [catalog_sales](./catalog_sales.md) | Catalog sales-channel facts, enriched table, and Metric View. | `bronze`, `silver`, `gold` |
| [web_sales](./web_sales.md) | Web sales-channel facts, enriched table, and Metric View. | `bronze`, `silver`, `gold` |
| [inventory](./inventory.md) | Periodic stock-snapshot fact and the warehouse dimension. | `bronze`, `silver`, `gold` |
