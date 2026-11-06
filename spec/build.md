# Build

> Coordinator-maintained narrative board. TRACK, NEXT, PARKED and DROPPED are coordinator prose: keep them true in the change that moves feature state. NOW and PROVEN are generated from the feature lanes by `limen land`, `limen ticket done` and `limen board --write`; edit the tickets, not those lines.

TRACK at most three bullets. NEXT one clause per ticket. PROVEN names the last ten landed features, then one count line per month.

Status marks are prose only: 🟠 ACTIVE · 🔴 PLANNED · 🟢 PROVEN · ⚪ DROPPED. Nothing in `limen` treats them as workflow state.

## TRACK

- Pivot the demo off the bakehouse sample onto TPC-DS store sales (`samples.tpcds_sf1000`), under the prepared documentation standard, with the Metric View a governed `docs/reference/metrics_views/` reference. One vocabulary across pipeline, metrics, ontology, Genie, dashboard. Constraint: sf1000 is 1 TB, so `source_schema` is a variable with an sf1 fallback.

## NOW

<!-- Generated from spec/features/active/ by limen land, limen ticket done and limen board --write. Edit the tickets, not these lines. -->

## NEXT

- `F004-tpcds-store-sales-pivot` (🟠 ACTIVE): store-sales medallion on TPC-DS plus the full docs restructure; one worker in flight.

## PROVEN

<!-- Generated from spec/features/done/ by limen land, limen ticket done and limen board --write. Edit the tickets, not these lines. -->

- `F003-genie-space` (🟢 PROVEN): Analysts ask bakery sales questions in natural language through Genie; landed 2026-11-05
- `F002-sales-overview-dashboard` (🟢 PROVEN): Analysts see bakery sales on a published AI/BI dashboard; landed 2026-11-05
- `F001-bakehouse-sales-medallion` (🟢 PROVEN): Bakery sales runs end to end on the bakehouse sample, with one shared semantic foundation; landed 2026-11-05
- 2026-11: 3 landed. spec/features/done/2026-11/
