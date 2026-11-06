# Give AI a Brain. Building a Shared Semantic Foundation for AI Agents and Databricks Genie
AI can write code, generate SQL, and answer business questions. But does it truly understand your data platform — its architecture, data flows, business concepts, and metrics?
As AI becomes an integral part of Data Engineering and Analytics, the real challenge is no longer just choosing the right model. It's building the right context and semantic foundation behind it.
In this session, we'll explore two sides of the same challenge.

## Part 1 — AI for Data Engineers
Discover how architecture documentation, C4 models, code-derived data lineage, ontology, coding standards, and agent-driven workflows such as BMAD can transform an existing Databricks project into an AI-ready development environment.
We'll show how structured knowledge helps AI agents navigate complex data pipelines, understand dependencies, and implement features consistently with existing engineering standards.

## Part 2 — AI for Data Analysts
We'll take the same knowledge beyond the code and into Databricks' evolving semantic ecosystem: Unity Catalog, Metric Views, Domains, Pages, Genie Ontology, Genie One, and Genie Code.
Explore how business definitions, trusted metrics, and data relationships can provide AI with the context needed to generate more accurate, consistent, and explainable analytical answers.
The key message: AI for engineers and AI for analysts shouldn't operate with two different understandings of the same data platform.
The future of AI-ready data platforms is not just about better prompts or smarter models. It's about building a shared, governed semantic foundation that connects code, data, and business meaning.


---

## About this repository

This repository is the working demo for the talk. It builds one governed semantic
foundation on Databricks and shows both audiences consuming it. The sample data is the
public TPC-DS **store sales** dataset (`samples.tpcds_sf1` by default), so the demo runs on
a Databricks Free Edition workspace.

### What is built

| Layer | What it is | Where |
|---|---|---|
| Pipeline | Medallion (bronze, silver, gold) in declarative SQL, as a Lakeflow Declarative Pipeline | `src/bronze`, `src/silver`, `src/gold` |
| Deployment | Databricks Asset Bundle that deploys the pipeline and the dashboard | `databricks.yml`, `resources/` |
| Metrics | A governed Metric View; business metrics defined once | `docs/reference/metrics_views/store_sales_metrics.md` |
| Dashboard | An AI/BI dashboard over the Metric View, for business users | `dashboards/` |
| Genie | A Genie space wired to the gold model, with the shared vocabulary as instructions | `genie/` |
| Documentation | C4 architecture, a Palantir-style ontology, and a governed metric definition | `docs/` |

### The data model

The fact is `store_sales` — one row per ticket line (`ticket_number` × `item_key`). It is
surrounded by conformed dimensions: customer (with address), item, store, date, and
promotion. One wide gold table, `gold.store_sales_enriched`, pre-joins the fact and the
dimensions so the Metric View and Genie read one table with no joins.

### The through-line

One business term keeps one name across every layer: the silver columns, the gold star
schema, the Metric View, the ontology, the AI/BI dashboard, and Genie. That single
vocabulary is the shared foundation — engineers and analysts read the same meaning of the
same data.

- **Part 1 (engineers):** the medallion pipeline, the dimensional model, and the governed
  Metric View, documented in C4, ontology, and a governed metric definition.
- **Part 2 (analysts):** the AI/BI dashboard, the Genie space, and a Unity Catalog **Store
  Sales** Domain, all reading the same governed gold model.

### Run it

```bash
# Authenticate to your workspace (one browser sign-in)
databricks auth login --host <your-workspace-url> --profile <name>

# Deploy and run the pipeline and dashboard
databricks bundle deploy --target dev
databricks bundle run store_sales
```

The Metric View (`docs/reference/metrics_views/`) and the Genie space (`genie/`) are Unity
Catalog objects, not bundle resources; each one's README has the command that creates it.

### Good to know

- **Source data:** the `source_schema` bundle variable (`databricks.yml`) picks the TPC-DS
  schema. Default `samples.tpcds_sf1` (1 GB) builds on Free Edition. Set it to
  `samples.tpcds_sf1000` (1 TB) for realistic volume when the workspace has the capacity.
  The pipeline reads it as the `${source_schema}` configuration, so no SQL changes.
- **Deploy location:** the `dev` target deploys to the shared folder
  `/Workspace/Shared/dbx_meetup_demo/${bundle.target}` (and grants the `users` group manage
  access), so the owner can share the demo with other workspace users. `${bundle.target}`
  keeps `dev` separate from any other target.
- **Catalog:** the medallion targets the `workspace` catalog, the one writable catalog in
  Free Edition. Change it in `databricks.yml`.
- **Metric View has no joins:** `using`-key joins hit a Free Edition engine error, so the
  gold fact is pre-widened into `gold.store_sales_enriched`, which the Metric View and Genie
  read.
- **Governance:** `email_address` stops at silver; only business-safe columns reach gold.
