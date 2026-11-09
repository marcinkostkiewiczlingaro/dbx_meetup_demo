---
c4_level: 3
module: core
component: silver
entities: [DimCustomer, DimItem, DimDate, DimPromotion, DimTime, DimReason, DimCustomerDemographics, DimHouseholdDemographics, DimIncomeBand]
tables: [silver.dim_customer, silver.dim_item, silver.dim_date, silver.dim_promotion, silver.dim_time, silver.dim_reason, silver.dim_customer_demographics, silver.dim_household_demographics, silver.dim_income_band]
---
# Silver — Cleansed, Business-Named (Core Dimensions)

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | silver | DimCustomer · DimItem · DimDate · DimPromotion · DimTime · DimReason · DimCustomerDemographics · DimHouseholdDemographics · DimIncomeBand | silver.dim_customer · silver.dim_item · silver.dim_date · silver.dim_promotion · silver.dim_time · silver.dim_reason · silver.dim_customer_demographics · silver.dim_household_demographics · silver.dim_income_band |

> **C4 Level 3 — Component.** Cleansed conformed dimensions with business column names and quality checks. This is where TPC-DS codes become the shared vocabulary every channel reads.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `DimCustomer` | `silver.dim_customer` | — | Customer joined to its current address; `email_address` kept here, not in gold. |
| `DimItem` | `silver.dim_item` | — | Item (product), current records only. |
| `DimDate` | `silver.dim_date` | — | Calendar keyed by the sold-date surrogate. |
| `DimPromotion` | `silver.dim_promotion` | — | Promotion with its purpose and channels. |
| `DimTime` | `silver.dim_time` | — | Time-of-day grid: hour, minute, shift, meal time. |
| `DimReason` | `silver.dim_reason` | — | Return reason with its business description. |
| `DimCustomerDemographics` | `silver.dim_customer_demographics` | — | Demographic profile: gender, marital and education status, credit rating. |
| `DimHouseholdDemographics` | `silver.dim_household_demographics` | — | Household profile; carries `income_band_key` to the income-band dim. |
| `DimIncomeBand` | `silver.dim_income_band` | — | Lower/upper income bounds per band. |

Each entity is one SQL file in `src/core/silver/`. Business keys carry `EXPECT` constraints
that drop referentially broken rows. These are the conformed dimensions: one definition,
read by the store, catalog, and web domains.
