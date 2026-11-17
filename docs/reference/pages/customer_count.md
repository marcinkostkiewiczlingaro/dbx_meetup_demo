---
c4_level: 4
type: page
page: Customer Count
page_id: 91982ef6-c9ae-4c19-a081-d4efc90a1b87
domain: Retail Analytics
defines: "`Customer Count` measure"
metric_views: [customer_metrics]
synonyms: [customer base size, number of customers]
state: PUBLISHED
---
# Customer Count

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Customer Count | `Customer Count` measure | [customer_metrics](../metrics_views/customer_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Customer Count** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Distinct customers in the customer master: COUNT(customer_key) in workspace.gold.customer_metrics.

## Definition
Number of distinct customers in the customer master, computed as COUNT(customer_key) in workspace.gold.customer_metrics.

## Business use
Customer base size by city, state, country, or preferred-customer flag.

## Examples
SELECT `State`, MEASURE(`Customer Count`) FROM workspace.gold.customer_metrics GROUP BY ALL

## Synonyms

customer base size, number of customers

