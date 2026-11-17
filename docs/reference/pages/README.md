# Pages (L4 — Code)

↑ [System Context](../../README.md) &nbsp;|&nbsp; ← [Metric Views](../metrics_views/README.md)

> **C4 Level 4 — Pages.** One file per Genie knowledge page: the governed business definition
> Genie reads for a term, with its synonyms and the Metric Views that expose it.

Each file mirrors a Databricks **Knowledge Page** object (Knowledge Pages API,
`/api/2.0/knowledge/pages`) attached to the `Retail Analytics` Genie domain. The page carries
one business term's definition, business use, examples, and synonyms. A page names a measure
or dimension already defined in a Metric View; the page is the business-term layer over that
measure, so the two are spelled the same — one name for one thing. The Metric View reference
file stays the source of truth for the expression and the YAML.

| Page | Metric Views |
|---|---|
| [Gross Sales](./gross_sales.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |
| [Net Sales](./net_sales.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |
| [Net Paid](./net_paid.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |
| [Net Profit](./net_profit.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |
| [Sales Quantity](./sales_quantity.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) |
| [Return Amount](./return_amount.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Returned Quantity](./returned_quantity.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Return Tax](./return_tax.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Return Fee](./return_fee.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Net Loss](./net_loss.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Return Rate](./return_rate.md) | [store_sales_metrics](../metrics_views/store_sales_metrics.md) · [web_sales_metrics](../metrics_views/web_sales_metrics.md) · [catalog_sales_metrics](../metrics_views/catalog_sales_metrics.md) · [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Return Date](./return_date.md) | [store_returns_metrics](../metrics_views/store_returns_metrics.md) · [web_returns_metrics](../metrics_views/web_returns_metrics.md) · [catalog_returns_metrics](../metrics_views/catalog_returns_metrics.md) |
| [Inventory Quantity](./inventory_quantity.md) | [inventory_metrics](../metrics_views/inventory_metrics.md) |
| [Customer Count](./customer_count.md) | [customer_metrics](../metrics_views/customer_metrics.md) |
| [Item Count](./item_count.md) | [item_metrics](../metrics_views/item_metrics.md) |
| [Store Count](./store_count.md) | [store_metrics](../metrics_views/store_metrics.md) |
| [Promotion Count](./promotion_count.md) | [promotion_metrics](../metrics_views/promotion_metrics.md) |
