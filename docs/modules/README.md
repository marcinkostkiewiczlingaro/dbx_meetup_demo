# Modules (L2)

↑ [System Context](../README.md) &nbsp;|&nbsp; ↓ [Components](../components/README.md)

> **C4 Level 2 — Modules.** One core pipeline builds the conformed dimensions once; three sales-channel domains build their facts and read those shared dims.

```mermaid
C4Container
  title Sales-Channel Analytics — Modules

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
| [store_sales](./store_sales.md) | Store sales-channel facts, the store dimension, and the governed Metric Views. | `bronze`, `silver`, `gold` |
| [catalog_sales](./catalog_sales.md) | Catalog sales-channel facts, catalog dimensions, and the governed Metric Views. | `bronze`, `silver`, `gold` |
| [web_sales](./web_sales.md) | Web sales-channel facts, web dimensions, and the governed Metric Views. | `bronze`, `silver`, `gold` |
| [inventory](./inventory.md) | Periodic stock-snapshot fact and the warehouse dimension. | `bronze`, `silver`, `gold` |

**Semantic view.** The build diagram above shows which pipeline builds which module.
The business objects and the links between them — the ontology — are the object graph in
the [gold-table reference](../reference/tables/README.md#object-graph-ontology).
