-- Silver: cleansed web-sales fact with business column names and measures.
-- Grain: one web-sales order line (order_number x item_key). Resolves the sold-date
-- surrogate to a real date through the core bronze.date_dim. customer_key is the billed
-- customer. sales_amount is the extended sales price (the net revenue of the line).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_web_sales (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed web-sales lines with business names. Source: bronze.web_sales + bronze.date_dim.'
AS
SELECT
  ws.ws_order_number        AS order_number,
  ws.ws_item_sk             AS item_key,
  ws.ws_bill_customer_sk    AS customer_key,
  ws.ws_web_site_sk         AS web_site_key,
  ws.ws_web_page_sk         AS web_page_key,
  ws.ws_promo_sk            AS promo_key,
  ws.ws_sold_date_sk        AS date_key,
  d.d_date                  AS sold_date,
  ws.ws_quantity            AS quantity,
  ws.ws_list_price          AS list_price,
  ws.ws_sales_price         AS sales_price,
  ws.ws_wholesale_cost      AS wholesale_cost,
  ws.ws_ext_sales_price     AS sales_amount,
  ws.ws_ext_discount_amt    AS discount_amount,
  ws.ws_net_paid            AS net_paid,
  ws.ws_net_profit          AS net_profit
FROM bronze.web_sales AS ws
LEFT JOIN bronze.date_dim AS d ON ws.ws_sold_date_sk = d.d_date_sk;
