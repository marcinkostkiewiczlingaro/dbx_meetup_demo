# Ontology

A Palantir-style ontology names the business objects in the store-sales domain, their
properties, and the links between them. It is the shared vocabulary: every property maps
to one gold column, and every metric in the Metric View stands on these terms.

- **Object types** — the nouns of the business. One file each in `object-types/`.
- **Link types** — how objects relate. `link-types.md`.
- **Properties** — fields on an object, each mapped to a gold column and its source.

Rule: one name for one thing. A term here has the same spelling in the silver columns, the
gold fact, the Metric View, and Genie. If engineering and analytics would name it
differently, the ontology is where we unify it.

| Object type | Backed by | Business meaning |
|---|---|---|
| Customer | `gold.dim_customer` | A person who buys from a store. |
| Item | `gold.dim_item` | A product offered for sale. |
| Store | `gold.dim_store` | A physical store where sales happen. |
| Promotion | `gold.dim_promotion` | A marketing campaign a sale may be attributed to. |
| Store-Sales Line | `gold.fct_store_sales` | One ticket line: an item bought at a store. |
