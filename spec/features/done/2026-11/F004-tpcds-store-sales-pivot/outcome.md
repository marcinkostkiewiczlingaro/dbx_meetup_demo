---
opened: 2026-11-06
landed: 2026-11-06
---

# F004 · The demo runs on the TPC-DS store-sales dataset under one documented semantic foundation

The demo no longer uses the bakehouse sample. It builds a store-sales medallion over the
public TPC-DS `store_sales` fact with the customer, item, date, store, and promotion
dimensions, through bronze, silver, and gold in Unity Catalog. The source schema is the
`source_schema` bundle variable; the default is `samples.tpcds_sf1` (1 GB, runs on Free
Edition) and `samples.tpcds_sf1000` (1 TB) is the scale-up option. The bundle deploys to
the shared folder `/Workspace/Shared/dbx_meetup_demo/${bundle.target}`, with the `users`
group granted manage access, so the demo is shareable. Landed in merge `73b21b4`.

The documentation now follows the prepared standard: L1 context, L2 modules, L3 components,
and L4 `reference/tables/` and `reference/metrics_views/`. The Metric View moved into
`docs/reference/metrics_views/store_sales_metrics.md` as a governed L4 reference whose
`## Definition` YAML block is the single source the backend creates the view from; the old
top-level `metrics/` folder is gone. The ontology, Genie space, and dashboard were rewritten
for store sales with one shared vocabulary (Net Sales, Ticket Count, Average Ticket Value).

Next reader: the pipeline was not run (no sf1 or sf1000 build), and the Metric View, Genie
space, and dashboard are Unity Catalog objects created outside the bundle, so their live
creation is unverified — that is the owner's demo-time step. `databricks bundle validate
--target dev --profile free` passes and shows the shared deploy path. The documentation
standard itself lives in the repo at `docs/engineering/documentation-standard.md`; the same
metric-view L4 type was added to the owner's source copy in `~/Downloads`.
