-- Silver: cleansed catalog-returns fact with business column names and measures.
-- Grain: one catalog-return line (order_number x item_key). Resolves the returned-date
-- surrogate to a real date through the core bronze.date_dim. customer_key is the returning
-- customer. return_amount is the extended return amount (the net value returned).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_catalog_returns (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (return_quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed catalog-return lines with business names. Source: bronze.catalog_returns + bronze.date_dim.'
AS
SELECT
  cr.cr_order_number          AS order_number,
  cr.cr_item_sk               AS item_key,
  cr.cr_returning_customer_sk AS customer_key,
  cr.cr_call_center_sk        AS call_center_key,
  cr.cr_catalog_page_sk       AS catalog_page_key,
  cr.cr_ship_mode_sk          AS ship_mode_key,
  cr.cr_returned_date_sk      AS date_key,
  d.d_date                    AS returned_date,
  cr.cr_return_quantity       AS return_quantity,
  cr.cr_return_amount         AS return_amount,
  cr.cr_return_tax            AS return_tax,
  cr.cr_fee                   AS return_fee,
  cr.cr_net_loss              AS net_loss
FROM bronze.catalog_returns AS cr
LEFT JOIN bronze.date_dim AS d ON cr.cr_returned_date_sk = d.d_date_sk;
