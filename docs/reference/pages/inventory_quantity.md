---
c4_level: 4
type: page
page: Inventory Quantity
page_id: 92c8d09f-bcd1-4a79-a396-1bcf67bc59f1
domain: Retail Analytics
defines: `Inventory Quantity` measure
metric_views: [inventory_metrics]
synonyms: [on-hand quantity, stock on hand]
state: PUBLISHED
---
# Inventory Quantity

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Inventory Quantity | `Inventory Quantity` measure | [inventory_metrics](../metrics_views/inventory_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Inventory Quantity** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Stock on hand at a warehouse snapshot: SUM(quantity_on_hand) in workspace.gold.inventory_metrics.

## Definition
Stock on hand for an item at a warehouse snapshot date, aggregated as SUM(quantity_on_hand) in workspace.gold.inventory_metrics.

## Business use
Warehouse-level inventory position analysis by item and brand, complementing sales demand measures.

## Examples
SELECT `Warehouse Name`, MEASURE(`Inventory Quantity`) FROM workspace.gold.inventory_metrics GROUP BY ALL

## Synonyms

on-hand quantity, stock on hand

## Metric Views

- [inventory_metrics](../metrics_views/inventory_metrics.md)
