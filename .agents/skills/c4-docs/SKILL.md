---
name: c4-docs
description: How to read and write this project's C4 documentation under docs/. Use before adding or changing any file under docs/ — a table reference, a metric view, an algorithm, a component, a module, the ontology object graph, or the documentation standard itself.
---

# C4 documentation

The single source of truth is [`docs/engineering/documentation-standard.md`](../../../docs/engineering/documentation-standard.md). Read it before you touch `docs/`, and follow it. This skill only routes you there and names the rules that are easy to break; it never restates the standard.

## Before you edit

1. Open `docs/engineering/documentation-standard.md`.
2. Find the "Adding a New ..." section for what you are creating and follow its numbered steps.
3. Match the layout of a sibling file at the same C4 level.

## Invariants the standard enforces (check, do not re-specify)

- **One navigation element per file**, directly under the title — the inline metadata table (L2–L4 content files) or a breadcrumb (L1 and index files). Never a `## Navigation` section, never at the bottom.
- **Every L3 component file has an `## Entities` table**, and every entity named in front-matter is defined there.
- **The ontology is not a folder.** A business object is its gold table's L4 file: it carries `object_type`, `primary_key`, `source_of_truth`, a `Source column` in `## Columns`, and a `## Links` section. Do not create an `ontology/` folder.
- **One name for one thing.** An object type, a property, a measure, and a dimension are spelled the same in the table file, the Metric View, the Genie space, and the dashboard.
- **Diagrams use mermaid C4 types** (`C4Context`, `C4Container`, `C4Component`). The one exception is the ontology object graph in `docs/reference/tables/README.md` (the object types are the gold tables, so the semantic graph lives with them, not in the build-view `docs/modules/README.md`), which uses `erDiagram`. Never a generic `flowchart`/`graph`.
- **L4 types:** `table_schema`, `metric_view`, `algorithm`, `page`. A Metric View's YAML lives only in its `## Definition` block — never a second copy. A `page` (Genie knowledge page) is the business-term layer over a Metric View measure or dimension: it carries the definition and synonyms, never the measure expression as authority, and is spelled the same as the measure and gold column. Links are reciprocal — a page's inline-table `metric views` column and each view's/component's `## Pages`.
- **Every gold table and every Metric View carries one `domain`.** The subdomain `tag_key` (for example `Retail Analytics/Sales`) is spelled the same in the registry (`docs/domains/README.md`), the L4 front-matter `domain` field, the prose, and the on-object copy. The on-object copy differs by object: a gold table carries a `COMMENT` `domain=<tag_key>` marker (pipelines cannot set UC tags reliably); a Metric View carries a real UC tag the Genie Domain applies (tag name = `tag_key`, empty value), and its subdomain is that of the gold table it reads. The field is L4 only — an L3 gold component crosses subdomains, so it never carries one `domain`.

## The domains registry is the source of the domain tree

The domain tree is defined in the docs registry (`docs/domains/README.md`), not in the Databricks workspace. Edit the registry first, deploy it to the workspace, then recheck the two against each other:

- The registry authors each subdomain's `tag_key` (`Parent/Child` for a subdomain) and the parent-child shape. The `tag_key` is the one canonical name — the Unity Catalog tag the Domain applies to a table. The `domain_id` is assigned by the workspace when the deploy creates the domain; record it back in the registry for reconciliation. Ignore the Databricks-managed `system.general_domain`.
- Recheck with the Databricks CLI, both ways: `databricks api get /api/2.0/domains -p free` lists the live tree (the documented path `/api/domains/v1/domain` returns Not Found; `/api/2.0/domains` is the working REST path; reference: <https://docs.databricks.com/api/domains/v1/domain>). Compare it to the registry — anything the workspace has that the registry does not list, and anything the registry lists the workspace lacks — and resolve every difference back to the registry.
- Follow "Adding or Changing a Domain" in the standard to keep the registry, the on-table marker, the Metric View UC tag, and the workspace Domain in sync.

## The page files are the source of the Genie Knowledge Pages

A page file under `docs/reference/pages/` is the source of truth for a Genie **Knowledge Page**. Author the file first, deploy it to the workspace, then recheck the two against each other:

- Write the term's definition, business use, examples, and synonyms in the file. The deploy publishes it as a Knowledge Page attached to a Genie domain. The `page_id` is the page uuid the workspace assigns on first publish; record it back in the file for reconciliation.
- Recheck with the Databricks CLI, both ways: `databricks api get /api/2.0/knowledge/pages -p free` lists the live pages, and `databricks api get /api/2.0/knowledge/pages/<page_id> -p free` reads one (the documented path `/api/knowledge/v1/page` is the reference, not the REST route; `/api/2.0/knowledge/pages` is the working path; reference: <https://docs.databricks.com/api/knowledge/v1/page>). The per-page get returns `display_name`, `domain`, `description`, `body` (Definition, Business use, Examples), and `synonyms`; the `name` is `pages/<uuid>` and `domain` is `domains/<domain_id>`. Compare these to the file, both ways, and resolve every difference back to the file.
- A page names a measure or dimension that already lives in a Metric View. The page is the business-term layer; the Metric View file stays the source of truth for the expression and YAML. Follow "Adding a New Page Reference File" in the standard, and keep the links reciprocal (a page's inline-table `metric views` column, each view's and component's `## Pages`).

## After you edit

- Register the new file in its index (`docs/modules/README.md`, `docs/components/README.md`, or the matching `reference/*/README.md`).
- Check that every relative link resolves.
