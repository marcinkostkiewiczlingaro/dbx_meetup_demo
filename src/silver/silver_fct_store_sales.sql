-- Silver: cleansed store-sales fact with business column names and measures.
-- Grain: one row per sold line (ticket + item). Foreign keys point to silver dims.
-- Rows with no item or store key are dropped as unusable for the data model.
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_store_sales (
  CONSTRAINT valid_product_key EXPECT (product_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_store_key   EXPECT (store_key IS NOT NULL) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed store-sales lines with business names. Source: bronze.store_sales.'
AS
SELECT
  ss_ticket_number     AS sales_ticket_number,
  ss_item_sk           AS product_key,
  ss_customer_sk       AS customer_key,
  ss_store_sk          AS store_key,
  ss_sold_date_sk      AS date_key,
  ss_quantity          AS quantity,
  ss_sales_price       AS unit_sales_price,
  ss_ext_sales_price   AS gross_sales_amount,
  ss_ext_discount_amt  AS discount_amount,
  ss_net_paid          AS net_sales_amount,
  ss_net_profit        AS net_profit_amount
FROM bronze.store_sales;
