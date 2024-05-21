CREATE OR REPLACE TABLE crouton.host_activity_reduced (
  host VARCHAR,
  metric_name VARCHAR,
  metric_array ARRAY(INTEGER),
  month_start_date VARCHAR
)
WITH (
  format = 'PARQUET',
  partitioned_by = ARRAY['metric_name', 'month_start_date']
)