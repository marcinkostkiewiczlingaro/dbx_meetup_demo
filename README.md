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
public `samples.bakehouse` bakery sales dataset, so the demo runs on a Databricks Free
Edition workspace.

### What is built

| Layer | What it is | Where |
|---|---|---|
| Pipeline | Medallion (bronze, silver, gold) in declarative SQL, as a Lakeflow Declarative Pipeline | `src/bronze`, `src/silver`, `src/gold` |
| Deployment | Databricks Asset Bundle that deploys the pipeline and the dashboard | `databricks.yml`, `resources/` |
| Metrics | A governed Metric View; business metrics defined once | `metrics/` |
| Page | An AI/BI dashboard over the Metric View, for business users | `dashboards/` |
| Genie | A Genie space wired to the gold model, with the semantic model as instructions | `genie/` |
| Documentation | C4 architecture, a Palantir-style ontology, and the semantic model | `docs/` |

### The through-line

One business term keeps one name across every layer: the silver columns, the gold star
schema, the Metric View, the ontology, the semantic model, the AI/BI Page, and Genie.
That single vocabulary is the shared foundation — engineers and analysts read the same
meaning of the same data.

- **Part 1 (engineers):** the medallion pipeline, the dimensional model, and the governed
  Metric View, documented in C4, ontology, and a semantic model.
- **Part 2 (analysts):** the AI/BI Page, the Genie space, and a Unity Catalog **Sales**
  Domain, all reading the same governed gold model.

### Run it

```bash
# Authenticate to your workspace (one browser sign-in)
databricks auth login --host <your-workspace-url> --profile <name>

# Deploy and run the pipeline and dashboard
databricks bundle deploy --target dev
databricks bundle run bakehouse_sales
```

The Metric View (`metrics/`) and the Genie space (`genie/`) are Unity Catalog objects,
not bundle resources; each folder's README has the one command that creates it.

### Good to know

- **Catalog:** the medallion targets the `workspace` catalog, the one writable catalog in
  Free Edition. Change it in `databricks.yml`.
- **Metric View has no joins:** `using`-key joins hit a Free Edition engine error, so the
  gold fact is pre-widened into `gold.sales_enriched`, which the Metric View and Genie read.
- **Governance:** raw card numbers stop at bronze; email and phone stop at silver; only
  business-safe columns reach gold.
