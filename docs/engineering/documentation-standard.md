# Documentation Standard

> How to read, navigate, and contribute to this demo's documentation. Adapted from the OSA documentation standard, extended with the L4 `metric_view` and `algorithm` reference types. The ontology is not a separate folder or file set: each business object **is** its gold table's L4 reference file, which carries the object name, its source-column lineage, and its links.

## Structure — C4 Levels

| Level | Folder | Purpose | Load when |
| ----- | ------ | ------- | --------- |
| L1 | `docs/README.md` | System context — demo overview, actors, external systems | Always load first |
| L2 | `docs/modules/*.md` | Modules — one file per module (`pipeline`, `semantic`) | Working in a specific module |
| L3 | `docs/components/{module}/*.md` | Components — entity groups with tables and business rules | Implementing a feature |
| L4 | `docs/reference/tables/*.md` | Code — full column-level table schemas | Need exact column names |
| L4 | `docs/reference/metrics_views/*.md` | Code — one file per Metric View: measures, dimensions, and the authoritative YAML the backend creates it from (see "L4 — Metric View reference files") | Need a governed metric definition |
| L4 | `docs/reference/algorithms/*.md` | Code — one file per named computation or business-logic algorithm (see "L4 — Algorithm reference files") | Need the exact computation behind an entity |

**No per-module L3 index.** `docs/components/{module}/` holds only leaf component files
directly. Its L2 module file's own `## Components` section is the index for that module's
component files; the single global [`docs/components/README.md`](../components/README.md) is
the index across all modules.

**The ontology is folded into the L4 table files, not a separate folder.** A business
object (a Palantir-style object type) is the same thing as the gold table that backs it, so
there is no separate ontology file. A gold table that is a business object names it in the
`object_type` front-matter field, states its primary key and source of truth, maps each
column to its source column in the `## Columns` table, and lists its relationships in a
`## Links` section. The object types, their properties, and their links are therefore the
sum of these fields across the L4 table files. The star-schema relationship overview lives
in the L3 gold component's C4 diagram; `## Links` carries the per-table detail.

Supporting views (outside the C4 L-structure):
- `docs/domains/` — the governance map from every gold table to one business subdomain under the `Retail Analytics` domain (see "Domains and Subdomains").
- `docs/engineering/` — this standard and any other code standards.

## File Anatomy

Every L2/L3/L4 content file follows this layout — no exceptions:

```markdown
---
c4_level: 3
module: pipeline
component: gold
entities: [FctStoreSales, DimItem, DimStore]
tables: [gold.fct_store_sales, gold.dim_item, gold.dim_store]
---
# Gold — Star Schema

| module | component | entities | tables |
|---|---|---|---|
| [pipeline](../../modules/pipeline.md) | gold | FctStoreSales · DimItem · DimStore | [gold.fct_store_sales](../../reference/tables/gold.fct_store_sales.md) |

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
- **Algorithm(s)** — a link to the entity's [L4 algorithm reference file](#l4--algorithm-reference-files) when it has a named computation, else `—`. This demo documents no algorithms yet, so every row is `—` today; the column and the reference type are ready for the first one.
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
  # Modules (L2)

  ↑ [System Context](../README.md) &nbsp;|&nbsp; ↓ [Components](../components/README.md)

  > **C4 Level 2 — Modules.** ...
  ```
- A file never has both a top breadcrumb/inline table **and** a bottom `## Navigation`
  section — pick the one top element for the file's level.

## Diagrams — C4 Mermaid Format

Every **architecture** diagram in `docs/` uses mermaid's dedicated **C4 diagram types** —
never a generic `flowchart`/`graph` block. The one exception is the ontology object graph,
which uses `erDiagram` (see below). The canonical reference is the diagram in
`docs/README.md` (L1 — System Context).

| C4 level | Mermaid diagram type | Used for | Example |
|---|---|---|---|
| L1 — System Context | `C4Context` | Actors and external systems around the demo | `docs/README.md` |
| L2 — Module | `C4Container` | Modules and how they relate (build view) | `docs/modules/README.md` |
| L2 — Object graph | `erDiagram` | The ontology: object types and their links (semantic view) | `docs/modules/README.md` |
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

**Ontology object graph (the `erDiagram` exception).** The one Palantir-style object graph
lives at L2 in `docs/modules/README.md`, below the `C4Container` build diagram. It is the
semantic view that a `C4` type cannot draw: object types as boxes with their key properties,
and links as crow's-foot edges that carry cardinality. One object type per gold business
object; one edge per foreign key, labelled with the link's business verb; an open circle
(`|o`) marks an optional link. Keep it to key and identifying properties plus the fact's
measures — the full column list stays in each L4 table file. It is paired with a plain
markdown-link table from each object type to its gold table, because `erDiagram`, like the
C4 types, takes no `click` directives.

## Front-matter Fields

### L2 — Module files

The `C4Container` diagram type and the `Container(...)` / `ContainerDb(...)` /
`Container_Boundary(...)` elements are mermaid's own keywords, so they keep the word
"container" in diagram source. Everywhere else — headings, prose, the `type` field — this
project uses one word, **module**.

```yaml
---
c4_level: 2
type: module
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
entities: [FctStoreSales, DimItem, DimStore]   # mandatory — every entity defined in the file's ## Entities table
tables: [gold.fct_store_sales, gold.dim_item, gold.dim_store]
---
```

`entities` is **never omitted**, even for a component that is really just a group of tables.

### L4 — Table schema files

```yaml
---
c4_level: 4
type: table_schema
database: gold
table: dim_customer
domain: Retail Analytics/Shared Dimensions      # gold tables only — the subdomain tag_key from the domains registry
object_type: Customer                           # optional — the business object this table is, when it is one
primary_key: customer_key                       # optional — present with object_type
source_of_truth: ${source_schema}.customer      # optional — the source the table is built from
component: components/core/gold.md
partition_columns: []
data_layer: Gold (dimension)
---
```

**Every gold table carries its `domain`.** The `domain` field is the subdomain `tag_key`
from the [domains registry](../domains/README.md) (for example `Retail Analytics/Sales`) —
the one governance tag a table belongs to, spelled exactly as the registry, the on-table
`COMMENT` marker, and the Databricks Domain spell it (see "Domains and Subdomains"). It is
present on every gold table, object or not, and absent on bronze/silver tables. It is not an
ontology field: a pure reference dimension has a `domain` but no `object_type`.

**The ontology lives in these fields.** A gold table that is a business object (a dimension
or a fact an analyst names) carries three extra things; a pure reference or staging table
leaves them out:

- `object_type` front-matter — the one canonical business noun, named again in bold in the
  blockquote. Primary key and source of truth follow as bullets under the blockquote.
- A **`Source column`** column in the `## Columns` table — the source-to-gold lineage for
  each property, so a column traces back to the raw field it comes from.
- A **`## Links`** section — one row or bullet per foreign-key relationship, with the
  business verb that names it (a fact lists its dimension links; a dimension names the fact
  that references it). This is where "link types" live — in the tables, not a separate file.

**One name for one thing.** The `object_type` name and every property name are spelled
exactly as the gold column, the Metric View measure, the Genie space, and the dashboard
spell them. The table file is where engineering and analytics names are unified; it never
introduces a synonym.

### L4 — Metric View reference files

```yaml
---
c4_level: 4
type: metric_view
metric_view: store_sales_metrics            # Metric View object name, without catalog/schema
source: workspace.gold.fct_store_sales      # fact/dimension the Metric View reads; it joins the other dims in its ## Definition
created_as: workspace.gold.store_sales_metrics # fully-qualified Unity Catalog object it is created as
component: components/store_sales/metrics.md  # L3 component that owns this metric definition
---
```

A Metric View is a Unity Catalog object created from a YAML `WITH METRICS` definition — not
a pipeline table, so it gets its own `type`. **The reference file is the single source of
truth.** It documents every measure and dimension in business terms and embeds the complete,
authoritative metric-view YAML in a `## Definition` fenced block. The backend deploy reads
that block to run `CREATE OR REPLACE VIEW {created_as} WITH METRICS LANGUAGE YAML AS $$ … $$`,
so the documented definition and the deployed object can never drift and there is no second
copy of the YAML anywhere.

### L4 — Algorithm reference files

```yaml
---
c4_level: 4
type: algorithm
algorithm: net_margin_allocation          # algorithm name, snake_case, unique
implemented_in: src/store_sales/gold/fct_store_sales.sql  # the code that runs it
component: components/store_sales/gold.md  # L3 component whose entity uses it
produces: [net_margin]                     # the column(s) or measure(s) it computes
---
```

An algorithm reference file documents one named computation or business rule that is not
obvious from a column name alone — an allocation, a weighting, a de-duplication, a
non-trivial derivation. It is the business-readable explanation of logic that lives in SQL
or pipeline code, so an agent or an analyst can trace a number back to its rule without
reading the code. The reference file never holds a second copy of the executable logic; it
describes and links to the code in `implemented_in`. An entity that uses an algorithm links
to it from the `Algorithm(s)` column of its `## Entities` table.

**This demo has no algorithms yet.** `docs/reference/algorithms/` holds only its index
README. The type exists so the first real computation — anything more than a one-line column
mapping — has a governed home instead of hiding inside a SQL file.

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
| [pipeline](../../modules/pipeline.md) | [gold](../../components/pipeline/gold.md) | gold.fct_store_sales | ← [silver.fct_store_sales](../../components/pipeline/silver.md) · → [store_sales_metrics](../metrics_views/store_sales_metrics.md) |
```

### L4 metric view
```markdown
| module | component | metric view | source |
|---|---|---|---|
| [semantic](../../modules/semantic.md) | [store-sales-metrics](../../components/semantic/store-sales-metrics.md) | `workspace.gold.store_sales_metrics` | [gold.fct_store_sales](../tables/gold.fct_store_sales.md) |
```

### L4 algorithm
```markdown
| module | component | algorithm | implemented in |
|---|---|---|---|
| [store_sales](../../modules/store_sales.md) | [gold](../../components/store_sales/gold.md) | `net_margin_allocation` | [fct_store_sales.sql](../../../src/store_sales/gold/fct_store_sales.sql) |
```

### L4 table `## Links` (object tables only)
```markdown
## Links

- **Makes** many [`gold.fct_store_sales`](./gold.fct_store_sales.md) via `customer_key` (one customer → many store-sales lines).
```

## File Naming

| Level | Pattern | Example |
|---|---|---|
| L2 module | `docs/modules/{module-name}.md` | `docs/modules/pipeline.md` |
| L3 component | `docs/components/{module}/{group}.md` | `docs/components/pipeline/gold.md` |
| L4 table | `docs/reference/tables/{db}.{table}.md` | `docs/reference/tables/gold.fct_store_sales.md` |
| L4 metric view | `docs/reference/metrics_views/{metric_view}.md` | `docs/reference/metrics_views/store_sales_metrics.md` |
| L4 algorithm | `docs/reference/algorithms/{algorithm}.md` | `docs/reference/algorithms/net_margin_allocation.md` |

## Adding a New Component File

1. Create `docs/components/{module}/{group}.md`.
2. Add front-matter with `c4_level: 3`, `module`, `component`, `entities`, `tables` — `entities` is never omitted.
3. Add the inline table (module → component → entities → tables).
4. Add the blockquote `>` with a one-line description.
5. Add the `## Entities` table — one row per name listed in front-matter `entities`.
6. Register the file in the `## Components` table of `docs/modules/{module}.md` and in the global [`docs/components/README.md`](../components/README.md).

## Adding a New Table Schema File

1. Create `docs/reference/tables/{db}.{table}.md`.
2. Add front-matter with `c4_level: 4`, `type: table_schema`, `database`, `table`, `component`, `partition_columns`, `data_layer`. For a gold table, also add `domain` — the subdomain `tag_key` from the [domains registry](../domains/README.md).
3. Add the inline table (module → component → table → pipeline neighbours).
4. List all columns grouped by logical area (keys, business columns, measures). Add a `Source column` column when the source-to-gold lineage is known.
5. If the table is a business object, add `object_type`, `primary_key`, and `source_of_truth` to the front-matter; name the object in bold in the blockquote; state primary key and source of truth as bullets; and add a `## Links` section with one row or bullet per foreign-key relationship and its business verb.
6. Update [`reference/tables/README.md`](../reference/tables/README.md).

## Adding a New Metric View Reference File

The file under `docs/reference/metrics_views/` is both the documentation of a Metric View and
the authoritative definition the backend creates it from. There is no separate YAML file.

1. Create `docs/reference/metrics_views/{metric_view}.md`.
2. Add front-matter with `c4_level: 4`, `type: metric_view`, `metric_view`, `source`, `created_as`, `component`.
3. Add the inline table (module → component → metric view → source).
4. Add the blockquote `>` stating it is the governed definition and the deploy source.
5. Add a `## Measures` table (Measure | Expression | Description) and a `## Dimensions` table (Dimension | Expression | Description) — one business name per row, spelled exactly as the backing table's `object_type` and columns spell it.
6. Add a `## Definition` section with the complete metric-view YAML in a fenced ```yaml block — the one authoritative copy; never keep a second copy elsewhere.
7. State the create command and that the backend extracts the `## Definition` block to run it.
8. Register the file in the owning L3 semantic component and update [`reference/metrics_views/README.md`](../reference/metrics_views/README.md).

## Adding a New Algorithm Reference File

Add one only when an entity carries a named computation or business rule that a column name
does not explain. Do not create a file for a plain column mapping.

1. Create `docs/reference/algorithms/{algorithm}.md`.
2. Add front-matter with `c4_level: 4`, `type: algorithm`, `algorithm`, `implemented_in`, `component`, `produces`.
3. Add the inline table (module → component → algorithm → implemented in).
4. Add the blockquote `>` with a one-line statement of what the algorithm computes.
5. Describe the rule in business terms and link to the code in `implemented_in`; never paste a second copy of the executable logic.
6. Link the file from the `Algorithm(s)` column of the owning entity's `## Entities` table in its L3 component.
7. Update [`reference/algorithms/README.md`](../reference/algorithms/README.md).

## Adding a Business Object (Ontology)

There is no separate ontology file. A business object is its gold table's L4 reference file.
To add one, create or edit `docs/reference/tables/{db}.{table}.md` and follow steps 5 of
[Adding a New Table Schema File](#adding-a-new-table-schema-file): set `object_type`,
`primary_key`, and `source_of_truth`; map each column to its source column; and add the
`## Links` section. Name the object and every property exactly as the Metric View, the Genie
space, and the dashboard name them — one name for one thing.

## Domains and Subdomains

Domains are a two-level governance layer over the gold tables, independent of the pipeline
that builds a table. They mirror the Databricks **Domain** objects governed in the workspace,
so the documented tree and the deployed tree never drift — one name for one thing across code,
Unity Catalog, and Genie.

- **One domain, named subdomains.** The demo governs a single top domain, `Retail Analytics`,
  with named subdomains beneath it (`Sales`, `Returns`, `Shared Dimensions`). A gold table is
  tagged on a **subdomain**, never on the bare top domain.
- **`tag_key` is the canonical name.** Each subdomain's `tag_key` is `Parent/Child` (for
  example `Retail Analytics/Sales`) — the exact string the Databricks Domain applies as a Unity
  Catalog tag. It is spelled identically in the registry, the on-table marker, and the
  workspace.
- **The registry is the single source of truth.** [`docs/domains/README.md`](../domains/README.md)
  maps every gold table to exactly one subdomain and records each domain's `domain_id` and
  `tag_key` from the Databricks Domains API. Do not record a table's subdomain anywhere else as
  an authority; other mentions point back here.
- **On-table marker.** Each gold table carries its subdomain in its `COMMENT` as a
  `domain=<tag_key>` marker (for example `domain=Retail Analytics/Sales`), because applying UC
  tags from inside a Lakeflow declarative pipeline is not reliable. The marker is the on-table
  copy and must match the `tag_key` in the registry.

## Adding or Changing a Domain

The Databricks workspace is the source of the tree; the registry follows it, not the reverse.

1. Confirm the governed tree with the Databricks Domains API
   (`databricks api get /api/2.0/domains`): each domain's `tag_key`, `domain_id`, and
   `parent_domain_id`.
2. Update the domain tree table and the registry in [`docs/domains/README.md`](../domains/README.md)
   so every gold table maps to exactly one subdomain `tag_key`.
3. For any table whose subdomain changed, update three copies to the new `tag_key`: the
   `domain` front-matter field of its L4 table file, its `COMMENT` `domain=<tag_key>` marker in
   the pipeline code, and any `Business domain:` mention in its L4 table file and L3 component
   file.
4. Keep the names identical everywhere — registry, marker, L4/L3 prose, and the workspace Domain.

## AI Navigation Pattern

```
Load docs/README.md (L1)         ~200 tokens
  → Load docs/modules/{m}.md (L2)   ~400 tokens
    → Load docs/components/{m}/{g}.md (L3)   ~600 tokens
      → Load docs/reference/tables/{db}.{t}.md (L4)          on demand only
      → Load docs/reference/metrics_views/{mv}.md (L4)       for a governed metric
      → Load docs/reference/algorithms/{a}.md (L4)           for a named computation
```

Load an L4 table file only when you need exact column names, the source-column lineage, the
business object name, or its links; a metric-view file for the governed metric; an algorithm
file for the computation behind a number.
