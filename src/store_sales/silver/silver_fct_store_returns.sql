-- Silver: cleansed store-returns fact with business column names and measures.
-- Grain: one store-return line (ticket_number x item_key). Resolves the returned-date
-- surrogate to a real date through the core bronze.date_dim.
-- return_amount is the extended return amount (the net value returned on the line).
CREATE OR REFRESH MATERIALIZED VIEW silver.fct_store_returns (
  CONSTRAINT valid_item_key     EXPECT (item_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT valid_customer_key EXPECT (customer_key IS NOT NULL) ON VIOLATION DROP ROW,
  CONSTRAINT positive_quantity  EXPECT (return_quantity > 0) ON VIOLATION DROP ROW
)
  COMMENT 'Cleansed store-return lines with business names. Source: bronze.store_returns + bronze.date_dim.'
AS
SELECT
  sr.sr_ticket_number       AS ticket_number,
  sr.sr_item_sk             AS item_key,
  sr.sr_customer_sk         AS customer_key,
  sr.sr_store_sk            AS store_key,
  sr.sr_returned_date_sk    AS date_key,
  d.d_date                  AS returned_date,
  sr.sr_return_quantity     AS return_quantity,
  sr.sr_return_amt          AS return_amount,
  sr.sr_return_tax          AS return_tax,
  sr.sr_fee                 AS return_fee,
  sr.sr_net_loss            AS net_loss
FROM bronze.store_returns AS sr
LEFT JOIN bronze.date_dim AS d ON sr.sr_returned_date_sk = d.d_date_sk;
