# Build

> Coordinator-maintained narrative board. TRACK, NEXT, PARKED and DROPPED are coordinator prose: keep them true in the change that moves feature state. NOW and PROVEN are generated from the feature lanes by `limen land`, `limen ticket done` and `limen board --write`; edit the tickets, not those lines.

TRACK at most three bullets. NEXT one clause per ticket. PROVEN names the last ten landed features, then one count line per month.

Status marks are prose only: 🟠 ACTIVE · 🔴 PLANNED · 🟢 PROVEN · ⚪ DROPPED. Nothing in `limen` treats them as workflow state.

## ENGINE

- Jobs run Pi with `--provider anthropic --model claude-opus-4-8 --thinking medium` for ordinary work, review, and planning. Only `anthropic` is authenticated on this seat; the package default `openai-codex/gpt-6-astra:high` has no key and fails at once. Always pass these flags explicitly on every spawn, continue, and review.

## TRACK

- Grow the demo from one subject area to three sales-channel domains (store, catalog, web) on one shared set of conformed dimensions, each its own pipeline and Metric View. Shows many pipelines held together by one semantic foundation.
- Pivot the demo off the bakehouse sample onto TPC-DS store sales (`samples.tpcds_sf1000`), under the prepared documentation standard, with the Metric View a governed `docs/reference/metrics_views/` reference. One vocabulary across pipeline, metrics, ontology, Genie, dashboard. Default `source_schema` is `samples.tpcds_sf1` (1 GB, runs on Free Edition); sf1000 (1 TB) is the scale-up option.

## NOW

<!-- Generated from spec/features/active/ by limen land, limen ticket done and limen board --write. Edit the tickets, not these lines. -->

## NEXT

- `F006-all-24-tpc-ds-tables-build-and-carry-a-business-domain-category` (🟠 ACTIVE): build the seven remaining TPC-DS tables, add an inventory domain, and tag every gold table with its business domain; one worker in flight.

## PROVEN

<!-- Generated from spec/features/done/ by limen land, limen ticket done and limen board --write. Edit the tickets, not these lines. -->

- `F006-all-24-tpc-ds-tables-build-and-carry-a-business-domain-category` (🟢 PROVEN): All 24 TPC-DS tables build, and every gold table carries a business-domain category; landed 2026-11-09
- `F005-multi-domain-sales-channels` (🟢 PROVEN): The demo spans three sales-channel domains on one shared set of conformed dimensions; landed 2026-11-06
- `F004-tpcds-store-sales-pivot` (🟢 PROVEN): The demo runs on the TPC-DS store-sales dataset under one documented semantic foundation; landed 2026-11-06
- `F003-genie-space` (🟢 PROVEN): Analysts ask bakery sales questions in natural language through Genie; landed 2026-11-05
- `F002-sales-overview-dashboard` (🟢 PROVEN): Analysts see bakery sales on a published AI/BI dashboard; landed 2026-11-05
- `F001-bakehouse-sales-medallion` (🟢 PROVEN): Bakery sales runs end to end on the bakehouse sample, with one shared semantic foundation; landed 2026-11-05
- 2026-11: 6 landed. spec/features/done/2026-11/
