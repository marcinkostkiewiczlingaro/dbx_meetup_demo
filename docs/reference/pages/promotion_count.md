---
c4_level: 4
type: page
page: Promotion Count
page_id: 43aabdd8-476d-4476-92c1-41ce0e136014
domain: Retail Analytics
defines: "`Promotion Count` measure"
metric_views: [promotion_metrics]
synonyms: [number of promotions]
state: PUBLISHED
---
# Promotion Count

| domain | page | defines | metric views |
|---|---|---|---|
| Retail Analytics | Promotion Count | `Promotion Count` measure | [promotion_metrics](../metrics_views/promotion_metrics.md) |

> **C4 Level 4 — Page.** Genie knowledge page **Promotion Count** (Databricks Knowledge Pages API, domain Retail Analytics). The governed business definition Genie reads for this term. Distinct promotions in the promotion master: COUNT(promo_key) in workspace.gold.promotion_metrics.

## Definition
Number of distinct promotions in the promotion master, computed as COUNT(promo_key) in workspace.gold.promotion_metrics. Gold models channels as boolean flags (Email Channel, TV Channel) rather than a single channel string.

## Business use
Promotional program analysis by purpose and channel; joins to sales facts via promo_key.

## Examples
SELECT `Purpose`, MEASURE(`Promotion Count`) FROM workspace.gold.promotion_metrics GROUP BY ALL

## Synonyms

number of promotions

