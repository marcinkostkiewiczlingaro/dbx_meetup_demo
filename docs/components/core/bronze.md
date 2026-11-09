---
c4_level: 3
module: core
component: bronze
entities: [CustomerRaw, ItemRaw, DateRaw, PromotionRaw, TimeRaw, ReasonRaw, CustomerDemographicsRaw, HouseholdDemographicsRaw, IncomeBandRaw]
tables: [bronze.customer, bronze.customer_address, bronze.item, bronze.date_dim, bronze.promotion, bronze.time_dim, bronze.reason, bronze.customer_demographics, bronze.household_demographics, bronze.income_band]
---
# Bronze — Raw Ingest (Core Dimensions)

| module | component | entities | tables |
|---|---|---|---|
| [core](../../modules/core.md) | bronze | CustomerRaw · ItemRaw · DateRaw · PromotionRaw · TimeRaw · ReasonRaw · CustomerDemographicsRaw · HouseholdDemographicsRaw · IncomeBandRaw | bronze.customer · bronze.customer_address · bronze.item · bronze.date_dim · bronze.promotion · bronze.time_dim · bronze.reason · bronze.customer_demographics · bronze.household_demographics · bronze.income_band |

> **C4 Level 3 — Component.** Streaming copies of the shared TPC-DS dimension tables, one per source, kept in the source shape for audit. The source schema is the `${source_schema}` pipeline configuration.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `CustomerRaw` | `bronze.customer`, `bronze.customer_address` | — | Raw customers and their addresses, joined in silver. |
| `ItemRaw` | `bronze.item` | — | Raw items (products) with slowly-changing history. |
| `DateRaw` | `bronze.date_dim` | — | Raw calendar; resolves every channel's sold-date surrogate to a real date. |
| `PromotionRaw` | `bronze.promotion` | — | Raw promotions a sales line may be attributed to. |
| `TimeRaw` | `bronze.time_dim` | — | Raw time-of-day grid; resolves time surrogates to a wall-clock time. |
| `ReasonRaw` | `bronze.reason` | — | Raw return reasons used by the returns facts. |
| `CustomerDemographicsRaw` | `bronze.customer_demographics` | — | Raw demographic profiles describing customers. |
| `HouseholdDemographicsRaw` | `bronze.household_demographics` | — | Raw household profiles, linked to an income band. |
| `IncomeBandRaw` | `bronze.income_band` | — | Raw lower/upper income bounds per band. |

Each entity is one SQL file in `src/core/bronze/`. Bronze does no renaming or typing; it
reads `FROM STREAM ${source_schema}.<table>`, so the same pipeline can target the 1 GB `sf1`
sample or the 1 TB `sf1000` sample. Every sales-channel pipeline reads the gold dims built
from these tables.
