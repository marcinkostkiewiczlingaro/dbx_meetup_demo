-- Silver: cleansed supplier dimension with business column names.
-- A supplier provides one ingredient to franchises.
-- Business key: supplier_key (one row per supplier).
CREATE OR REFRESH MATERIALIZED VIEW silver.dim_supplier (
  CONSTRAINT valid_supplier_key EXPECT (supplier_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed suppliers with business names. Source: bronze.sales_suppliers.'
AS
SELECT
  supplierID   AS supplier_key,
  name         AS supplier_name,
  ingredient   AS ingredient,
  city         AS city,
  district     AS district,
  continent    AS continent,
  CAST(approved = 'Y' AS BOOLEAN) AS is_approved
FROM bronze.sales_suppliers;
