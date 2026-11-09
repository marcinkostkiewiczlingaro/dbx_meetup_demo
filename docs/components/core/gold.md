---
c4_level: 3
module: core
component: gold
entities: [DimCustomer, DimItem, DimDate, DimPromotion, DimTime, DimReason, DimCustomerDemographics, DimHouseholdDemographics, DimIncomeBand]
tables: [gold.dim_customer, gold.dim_item, gold.dim_date, gold.dim_promotion, gold.dim_time, gold.dim_reason, gold.dim_customer_demographics, gold.dim_household_demographics, gold.dim_income_band]
---
# Gold — Conformed Dimensions

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | gold | DimCustomer · DimItem · DimDate · DimPromotion · DimTime · DimReason · DimCustomerDemographics · DimHouseholdDemographics · DimIncomeBand | [gold.dim_customer](../../reference/tables/gold.dim_customer.md) · [gold.dim_item](../../reference/tables/gold.dim_item.md) · [gold.dim_date](../../reference/tables/gold.dim_date.md) · [gold.dim_promotion](../../reference/tables/gold.dim_promotion.md) · [gold.dim_time](../../reference/tables/gold.dim_time.md) · [gold.dim_reason](../../reference/tables/gold.dim_reason.md) · [gold.dim_customer_demographics](../../reference/tables/gold.dim_customer_demographics.md) · [gold.dim_household_demographics](../../reference/tables/gold.dim_household_demographics.md) · [gold.dim_income_band](../../reference/tables/gold.dim_income_band.md) |

> **C4 Level 3 — Component.** The conformed dimensions, built once and read by every sales-channel pipeline. A dimension table is owned by this core pipeline; no channel rebuilds it.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCustomer` | [`gold.dim_customer`](../../reference/tables/gold.dim_customer.md) | — | Customer dimension; business-safe columns only. |
| `DimItem` | [`gold.dim_item`](../../reference/tables/gold.dim_item.md) | — | Item (product) dimension. |
| `DimDate` | [`gold.dim_date`](../../reference/tables/gold.dim_date.md) | — | Calendar dimension. |
| `DimPromotion` | [`gold.dim_promotion`](../../reference/tables/gold.dim_promotion.md) | — | Promotion dimension. |
| `DimTime` | [`gold.dim_time`](../../reference/tables/gold.dim_time.md) | — | Time-of-day dimension. |
| `DimReason` | [`gold.dim_reason`](../../reference/tables/gold.dim_reason.md) | — | Return-reason dimension. |
| `DimCustomerDemographics` | [`gold.dim_customer_demographics`](../../reference/tables/gold.dim_customer_demographics.md) | — | Customer-demographics dimension. |
| `DimHouseholdDemographics` | [`gold.dim_household_demographics`](../../reference/tables/gold.dim_household_demographics.md) | — | Household-demographics dimension. |
| `DimIncomeBand` | [`gold.dim_income_band`](../../reference/tables/gold.dim_income_band.md) | — | Income-band dimension. |

Each entity is one SQL file in `src/core/gold/`. The store, catalog, and web gold enriched
tables read these dims across pipelines (reads across pipelines are allowed; writes are not).
These are the shared links the ontology names
([`docs/ontology/link-types.md`](../../ontology/link-types.md)).
