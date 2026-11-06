-- Silver: cleansed web-returns fact with business column names and measures.
-- Grain: one web-return line (order_number x item_key). Resolves the returned-date
-- surrogate to a real date through the core bronze.date_dim. customer_key is the returning
-- customer. return_amount is the extended return amount (the net value returned).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_web_returns (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (return_quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed web-return lines with business names. Source: bronze.web_returns + bronze.date_dim.'
AS
SELECT
  wr.wr_order_number          AS order_number,
  wr.wr_item_sk               AS item_key,
  wr.wr_returning_customer_sk AS customer_key,
  wr.wr_web_page_sk           AS web_page_key,
  wr.wr_returned_date_sk      AS date_key,
  d.d_date                    AS returned_date,
  wr.wr_return_quantity       AS return_quantity,
  wr.wr_return_amt            AS return_amount,
  wr.wr_return_tax            AS return_tax,
  wr.wr_fee                   AS return_fee,
  wr.wr_net_loss              AS net_loss
FROM bronze.web_returns AS wr
LEFT JOIN bronze.date_dim AS d ON wr.wr_returned_date_sk = d.d_date_sk;
