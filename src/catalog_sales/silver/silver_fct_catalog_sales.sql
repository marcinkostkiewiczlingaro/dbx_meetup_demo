-- Silver: cleansed catalog-sales fact with business column names and measures.
-- Grain: one catalog-sales order line (order_number x item_key). Resolves the sold-date
-- surrogate to a real date through the core bronze.date_dim. customer_key is the billed
-- customer. sales_amount is the extended sales price (the net revenue of the line).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_catalog_sales (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed catalog-sales lines with business names. Source: bronze.catalog_sales + bronze.date_dim.'
AS
SELECT
  cs.cs_order_number        AS order_number,
  cs.cs_item_sk             AS item_key,
  cs.cs_bill_customer_sk    AS customer_key,
  cs.cs_call_center_sk      AS call_center_key,
  cs.cs_catalog_page_sk     AS catalog_page_key,
  cs.cs_ship_mode_sk        AS ship_mode_key,
  cs.cs_promo_sk            AS promo_key,
  cs.cs_sold_date_sk        AS date_key,
  d.d_date                  AS sold_date,
  cs.cs_quantity            AS quantity,
  cs.cs_list_price          AS list_price,
  cs.cs_sales_price         AS sales_price,
  cs.cs_wholesale_cost      AS wholesale_cost,
  cs.cs_ext_sales_price     AS sales_amount,
  cs.cs_ext_discount_amt    AS discount_amount,
  cs.cs_net_paid            AS net_paid,
  cs.cs_net_profit          AS net_profit
FROM bronze.catalog_sales AS cs
LEFT JOIN bronze.date_dim AS d ON cs.cs_sold_date_sk = d.d_date_sk;
