-- Silver: cleansed store-sales fact with business column names and measures.
-- Grain: one store-sales line (ticket_number x item_key). Resolves the sold-date
-- surrogate to a real date through bronze.date_dim.
-- sales_amount is the extended sales price (the net revenue of the line).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_store_sales (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed store-sales lines with business names. Source: bronze.store_sales + bronze.date_dim.'
AS
SELECT
  ss.ss_ticket_number       AS ticket_number,
  ss.ss_item_sk             AS item_key,
  ss.ss_customer_sk         AS customer_key,
  ss.ss_store_sk            AS store_key,
  ss.ss_promo_sk            AS promo_key,
  ss.ss_sold_date_sk        AS date_key,
  d.d_date                  AS sold_date,
  ss.ss_quantity            AS quantity,
  ss.ss_list_price          AS list_price,
  ss.ss_sales_price         AS sales_price,
  ss.ss_wholesale_cost      AS wholesale_cost,
  ss.ss_ext_sales_price     AS sales_amount,
  ss.ss_ext_discount_amt    AS discount_amount,
  ss.ss_net_paid            AS net_paid,
  ss.ss_net_profit          AS net_profit
FROM bronze.store_sales AS ss
LEFT JOIN bronze.date_dim AS d ON ss.ss_sold_date_sk = d.d_date_sk;
