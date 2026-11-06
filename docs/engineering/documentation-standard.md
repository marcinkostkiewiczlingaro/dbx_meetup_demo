# Documentation Standard

> How to read, navigate, and contribute to this demo's documentation. Adapted from the OSA documentation standard, extended with the L4 `metric_view` type.

## Structure — C4 Levels

| Level | Folder | Purpose | Load when |
| ----- | ------ | ------- | --------- |
| L1 | `docs/README.md` | System context — demo overview, actors, external systems | Always load first |
| L2 | `docs/modules/*.md` | Containers — one file per module (`pipeline`, `semantic`) | Working in a specific module |
| L3 | `docs/components/{module}/*.md` | Components — entity groups with tables and business rules | Implementing a feature |
| L4 | `docs/reference/tables/*.md` | Code — full column-level table schemas | Need exact column names |
| L4 | `docs/reference/metrics_views/*.md` | Code — one file per Metric View: measures, dimensions, and the authoritative YAML the backend creates it from (see "L4 — Metric View reference files") | Need a governed metric definition |

**No per-module L3 index.** `docs/components/{module}/` holds only leaf component files
directly. Its L2 module file's own `## Components` section is the index for that module's
component files; the single global [`docs/components/README.md`](../components/README.md) is
the index across all modules.

Supporting views (outside the C4 L-structure):
- `docs/ontology/` — the business objects, their properties, and links.
- `docs/engineering/` — this standard and any other code standards.

## File Anatomy

Every L2/L3/L4 content file follows this layout — no exceptions:

```markdown
---
c4_level: 3
module: pipeline
component: gold
entities: [FctStoreSales, DimItem, StoreSalesEnriched]
tables: [gold.fct_store_sales, gold.dim_item, gold.store_sales_enriched]
---
# Gold — Star Schema and Consumption Table

| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | gold | FctStoreSales · DimItem · StoreSalesEnriched | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) |

> **C4 Level 3 — Component.** One-line description of the file's scope.

## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctStoreSales` | `gold.fct_store_sales` | — | One line grounding the entity in what it actually is |

## [Further content sections]
```

Rules:
- **Front-matter** (`---` block) is machine-readable metadata — always include `c4_level`, plus level-specific fields.
- **Inline table** directly below the title renders the front-matter fields as visible clickable links — this is the file's **only** navigation element.
- **Blockquote** `>` immediately follows the inline table — one sentence stating the file's C4 level and purpose.
- **No `## Navigation` sections** anywhere, at any level — see "Navigation Rule".
- **Every L3 component file has an `## Entities` body table** — see "Entities Rule".

L1 (`docs/README.md`) and index/`README.md` files don't have `module`/`component`/`table`
front-matter to render, so they use a short breadcrumb line instead of the inline table —
see "Navigation Rule".

## Entities Rule

Every L3 component file names its entities — the shorthand vocabulary used in diagrams and
prose to talk about a piece of business logic without repeating a full table name every
time. This applies **even when a component is "just" a group of tables** — invent one short,
well-named entity per meaningful table group rather than leaving `tables` as the only
identifier.

The rule that keeps this from becoming decorative: **an entity may only be listed in
front-matter/the top inline table if the file's own `## Entities` table defines it.** No
entity name may exist only in front-matter without a body definition, and no entity may be
invented that doesn't map to at least one real table.

`## Entities` columns:
- **Entity** — the short PascalCase name used in diagrams and cross-file prose.
- **Table(s)** — the real Delta table(s) backing it (or `—` if purely computed).
- **Algorithm(s)** — this demo documents no separate algorithms, so this is `—`.
- **Description** — one line grounding what the entity actually is.

## Navigation Rule

**One navigation element per file, always immediately under the title (and blockquote,
where present) — never a separate section, never at the bottom.** This applies uniformly
across all 4 C4 levels and every index/`README.md` file.

- **L3/L4 content files**: the inline metadata table (module/component/table + links) **is**
  the navigation — nothing else is added.
- **L2 module files** (`docs/modules/{module}.md`): the first cell (`module`) self-links, a
  dead end with no way back to L1. So every L2 file also gets a one-line breadcrumb
  `↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)` directly under
  the title, above its `module | database | entry point` table. Both lines together are the
  file's single top navigation block.
- **L1 (`docs/README.md`) and index/`README.md` files** use a short breadcrumb instead,
  placed directly under the title/blockquote, e.g.:
  ```markdown
  # Modules (L2 — Containers)

  ↑ [System Context](../README.md) &nbsp;|&nbsp; ↓ [Components](../components/README.md)

  > **C4 Level 2 — Containers.** ...
  ```
- A file never has both a top breadcrumb/inline table **and** a bottom `## Navigation`
  section — pick the one top element for the file's level.

## Diagrams — C4 Mermaid Format

Every architecture/relationship diagram in `docs/` uses mermaid's dedicated **C4 diagram
types** — never a generic `flowchart`/`graph` block. The canonical reference is the diagram
in `docs/README.md` (L1 — System Context).

| C4 level | Mermaid diagram type | Used for | Example |
|---|---|---|---|
| L1 — System Context | `C4Context` | Actors and external systems around the demo | `docs/README.md` |
| L2 — Container | `C4Container` | Modules and how they relate | `docs/modules/README.md` |
| L2/L3 — internal flow | `C4Component` | Pipeline stages or entity groups within one module | `docs/modules/pipeline.md`, `docs/components/pipeline/gold.md` |

Rules:
- Use `Person`/`Person_Ext` for human actors, `System`/`System_Ext` for external systems,
  `Container`/`ContainerDb` for modules/databases, `Component`/`ComponentDb` for entities
  or steps inside a module.
- Group related elements with `Boundary(...)` / `Container_Boundary(...)` to mirror the real
  grouping.
- Every relationship is a `Rel(from, to, "label")` — never a bare `-->` arrow.
- Always end the diagram with `UpdateLayoutConfig(...)` to keep the layout readable.
- **No `click` directives** — the C4 diagram types reject them and GitHub strips them. Pair
  a diagram that needs navigation with a plain markdown-link table instead.

## Front-matter Fields

### L2 — Module files

```yaml
---
c4_level: 2
type: container
module: pipeline
database: bronze / silver / gold
entry_point: resources/store_sales_pipeline.yml
---
```

### L3 — Component files

```yaml
---
c4_level: 3
module: pipeline
component: gold
entities: [FctStoreSales, DimItem, StoreSalesEnriched]   # mandatory — every entity defined in the file's ## Entities table
tables: [gold.fct_store_sales, gold.dim_item, gold.store_sales_enriched]
---
```

`entities` is **never omitted**, even for a component that is really just a group of tables.

### L4 — Table schema files

```yaml
---
c4_level: 4
type: table_schema
database: gold
table: store_sales_enriched
component: components/pipeline/gold.md
partition_columns: []
data_layer: Gold (consumption)
---
```

### L4 — Metric View reference files

```yaml
---
c4_level: 4
type: metric_view
metric_view: store_sales_metrics            # Metric View object name, without catalog/schema
source: workspace.gold.store_sales_enriched # table/view the Metric View reads (no joins)
created_as: workspace.gold.store_sales_metrics # fully-qualified Unity Catalog object it is created as
component: components/semantic/store-sales-metrics.md  # L3 component that owns this metric definition
---
```

A Metric View is a Unity Catalog object created from a YAML `WITH METRICS` definition — not
a pipeline table, so it gets its own `type`. **The reference file is the single source of
truth.** It documents every measure and dimension in business terms and embeds the complete,
authoritative metric-view YAML in a `## Definition` fenced block. The backend deploy reads
that block to run `CREATE OR REPLACE VIEW {created_as} WITH METRICS LANGUAGE YAML AS $$ … $$`,
so the documented definition and the deployed object can never drift and there is no second
copy of the YAML anywhere.

## Inline Table Formats

### L2 module
```markdown
↑ [System Context](../README.md) &nbsp;|&nbsp; ← [Modules](./README.md)

| module | database | entry point |
|---|---|---|
| [pipeline](./pipeline.md) | `bronze` · `silver` · `gold` | [store_sales_pipeline.yml](../../resources/store_sales_pipeline.yml) |
```

### L3 component
```markdown
| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | gold | FctStoreSales · DimItem | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) |
```

### L3 Entities body table (mandatory on every L3 file)
```markdown
## Entities

| Entity | Table(s) | Algorithm(s) | Description |
|---|---|---|---|
| `FctStoreSales` | `gold.fct_store_sales` | — | Conformed fact. Grain: one ticket line. |
```

### L4 table schema
```markdown
| module | component | table | pipeline |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.store_sales_enriched | ← [gold.fct_store_sales](./gold.fct_store_sales.md) · → [store_sales_metrics](../metrics_views/store_sales_metrics.md) |
```

### L4 metric view
```markdown
| module | component | metric view | source |
|---|---|---|---|
| [semantic](../../modules/semantic.md) | [store-sales-metrics](../../components/semantic/store-sales-metrics.md) | `workspace.gold.store_sales_metrics` | [gold.store_sales_enriched](../tables/gold.store_sales_enriched.md) |
```

## File Naming

| Level | Pattern | Example |
|---|---|---|
| L2 module | `docs/modules/{module-name}.md` | `docs/modules/pipeline.md` |
| L3 component | `docs/components/{module}/{group}.md` | `docs/components/pipeline/gold.md` |
| L4 table | `docs/reference/tables/{db}.{table}.md` | `docs/reference/tables/gold.store_sales_enriched.md` |
| L4 metric view | `docs/reference/metrics_views/{metric_view}.md` | `docs/reference/metrics_views/store_sales_metrics.md` |

## Adding a New Component File

1. Create `docs/components/{module}/{group}.md`.
2. Add front-matter with `c4_level: 3`, `module`, `component`, `entities`, `tables` — `entities` is never omitted.
3. Add the inline table (module → component → entities → tables).
4. Add the blockquote `>` with a one-line description.
5. Add the `## Entities` table — one row per name listed in front-matter `entities`.
6. Register the file in the `## Components` table of `docs/modules/{module}.md` and in the global [`docs/components/README.md`](../components/README.md).

## Adding a New Table Schema File

1. Create `docs/reference/tables/{db}.{table}.md`.
2. Add front-matter with `c4_level: 4`, `type: table_schema`, `database`, `table`, `component`, `partition_columns`, `data_layer`.
3. Add the inline table (module → component → table → pipeline neighbours).
4. List all columns grouped by logical area (keys, business columns, measures).
5. Update [`reference/tables/README.md`](../reference/tables/README.md).

## Adding a New Metric View Reference File

The file under `docs/reference/metrics_views/` is both the documentation of a Metric View and
the authoritative definition the backend creates it from. There is no separate YAML file.

1. Create `docs/reference/metrics_views/{metric_view}.md`.
2. Add front-matter with `c4_level: 4`, `type: metric_view`, `metric_view`, `source`, `created_as`, `component`.
3. Add the inline table (module → component → metric view → source).
4. Add the blockquote `>` stating it is the governed definition and the deploy source.
5. Add a `## Measures` table (Measure | Expression | Description) and a `## Dimensions` table (Dimension | Expression | Description) — one business name per row, spelled exactly as the ontology and the semantic component spell it.
6. Add a `## Definition` section with the complete metric-view YAML in a fenced ```yaml block — the one authoritative copy; never keep a second copy elsewhere.
7. State the create command and that the backend extracts the `## Definition` block to run it.
8. Register the file in the owning L3 semantic component and update [`reference/metrics_views/README.md`](../reference/metrics_views/README.md).

## AI Navigation Pattern

```
Load docs/README.md (L1)         ~200 tokens
  → Load docs/modules/{m}.md (L2)   ~400 tokens
    → Load docs/components/{m}/{g}.md (L3)   ~600 tokens
      → Load docs/reference/tables/{db}.{t}.md (L4)   on demand only
```

Load L4 only when exact column names or the governed metric definition are needed.
