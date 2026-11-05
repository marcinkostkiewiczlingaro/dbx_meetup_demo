-- Silver: cleansed sales fact with business column names and measures.
-- Grain: one row per sales transaction (a single product purchase).
-- Drops cardNumber: raw card numbers never leave bronze (governance).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_sales (
  CONSTRAINT valid_customer_key  EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_franchise_key EXPECT (franchise_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity   EXPECT (quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed sales lines with business names. Source: bronze.sales_transactions.'
AS
SELECT
  transactionID                 AS sales_transaction_id,
  customerID                    AS customer_key,
  franchiseID                   AS franchise_key,
  product                       AS product_name,
  CAST(dateTime AS DATE)        AS sold_date,
  dateTime                      AS sold_at,
  quantity                      AS quantity,
  unitPrice                     AS unit_price,
  totalPrice                    AS sales_amount,
  paymentMethod                 AS payment_method
FROM bronze.sales_transactions;
