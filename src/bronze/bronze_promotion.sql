-- Bronze: raw promotions, copied as-is from the TPC-DS sample.
-- Source of truth: ${source_schema}.promotion. A store-sales line may carry no promotion.
CREATE OR REFRESH STREAMING TABLE bronze.promotion
  COMMENT 'Raw promotions from the TPC-DS promotion dimension.'
AS SELECT * FROM STREAM ${source_schema}.promotion;
