---
c4_level: 4
type: page
page: Item Count
page_id: be5dbf9d-901e-44e7-adbe-5c1debdc3f4f
domain: Retail Analytics
defines: "`Item Count` measure"
metric_views: [item_metrics]
synonyms: [number of items, product count]
state: PUBLISHED
---
# Item Count

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Item Count | `Item Count` measure | [item_metrics](../metrics_views/item_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Item Count** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Distinct merchandise items in the product master: COUNT(item_key) in workspace.gold.item_metrics.

## Definition
Number of distinct merchandise items in the product master, computed as COUNT(item_key) in workspace.gold.item_metrics.

## Business use
Assortment size analysis; joins to facts via item_key for brand, manufacturer, category, and class reporting.

## Examples
SELECT `Category`, MEASURE(`Item Count`) FROM workspace.gold.item_metrics GROUP BY ALL

## Synonyms

number of items, product count

