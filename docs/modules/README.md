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

## Object graph (ontology)

The diagram above is the **build view**: which pipeline builds which container. This one is
the **semantic view**: the business objects and the links between them, in the Palantir
ontology style. An object type is a gold table; a link is a foreign key in the star schema;
the crow's-foot end shows the cardinality, and an open circle shows an optional link. Each
object's full properties, source-column lineage, and links live in its L4 table file.

```mermaid
erDiagram
  CUSTOMER {
    int customer_key PK
    string customer_id
    string customer_state
  }
  ITEM {
    int item_key PK
    string item_name
    string category
  }
  STORE {
    int store_key PK
    string store_name
    string store_state
  }
  PROMOTION {
    int promo_key PK
    string promo_name
    boolean is_discount_active
  }
  DATE {
    int date_key PK
    date sold_date
  }
  STORE_SALES_LINE {
    long ticket_number PK
    int item_key FK
    int customer_key FK
    int store_key FK
    int promo_key FK
    int date_key FK
    decimal sales_amount
    decimal net_profit
  }
  CUSTOMER   ||--o{ STORE_SALES_LINE : "makes"
  ITEM       ||--o{ STORE_SALES_LINE : "is sold in"
  STORE      ||--o{ STORE_SALES_LINE : "hosts"
  PROMOTION  |o--o{ STORE_SALES_LINE : "applies to"
  DATE       ||--o{ STORE_SALES_LINE : "dates"
```

| Object type | Gold table | Built by |
|---|---|---|
| Customer | [`gold.dim_customer`](../reference/tables/gold.dim_customer.md) | core |
| Item | [`gold.dim_item`](../reference/tables/gold.dim_item.md) | core |
| Store | [`gold.dim_store`](../reference/tables/gold.dim_store.md) | store_sales |
| Promotion | [`gold.dim_promotion`](../reference/tables/gold.dim_promotion.md) | core |
| Date | [`gold.dim_date`](../reference/tables/gold.dim_date.md) | core |
| Store-Sales Line | [`gold.fct_store_sales`](../reference/tables/gold.fct_store_sales.md) | store_sales |
