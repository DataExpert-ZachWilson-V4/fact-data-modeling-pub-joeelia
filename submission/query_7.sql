CREATE OR REPLACE TABLE crouton.host_activity_reduced (
  host VARCHAR,
  metric_name VARCHAR,
  metric_array ARRAY(INTEGER),
  month_start VARCHAR
  ) WITH
  (
    FORMAT = 'PARQUET',
    partitioning = ARRAY['metric_name','month_start']
  )