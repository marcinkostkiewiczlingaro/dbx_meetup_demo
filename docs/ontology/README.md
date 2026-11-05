# Ontology

A Palantir-style ontology names the business objects in the store-sales domain, their
properties, and the links between them. It is the shared vocabulary: every property
maps to one gold column, and every metric in the semantic model stands on these terms.

- **Object types** — the nouns of the business. One file each in `object-types/`.
- **Link types** — how objects relate. `link-types.md`.
- **Properties** — fields on an object, each mapped to a gold column and its source.

Rule: one name for one thing. A term here has the same spelling in the silver columns,
the gold fact, the Metric View, and Genie. If engineering and analytics would name it
differently, the ontology is where we unify it.

| Object type | Backed by | Business meaning |
|---|---|---|
| Customer | `gold.dim_customer` | A person who buys in a store. |
| Product | `gold.dim_item` | An item offered for sale. |
| Store | `gold.dim_store` | A physical retail location. |
| Sales Transaction | `gold.fct_store_sales` | One sold line: a product sold on a ticket. |
