INSERT INTO crouton.host_activity_reduced
WITH yesterday AS (
    SELECT
        *
    FROM
        crouton.host_activity_reduced
    WHERE
        month_start = '2022-08-01'
),
today AS (
    SELECT
        *
    FROM
        crouton.daily_web_metrics
    WHERE
        date = DATE('2022-08-02')
)
SELECT
    COALESCE(t.host, y.host) AS host, 
    COALESCE(t.metric_name, y.metric_name) AS metric_name,
    COALESCE(y.metric_array, REPEAT(NULL, CAST(DATE_DIFF('day', DATE('2022-08-01'), t.date) AS INTEGER))) || ARRAY[t.metric_value] AS metric_array,
    '2022-08-01' AS month_start
FROM
    today t
    FULL OUTER JOIN yesterday y ON t.host = y.host
    AND t.metric_name = y.metric_name
WHERE
    CARDINALITY(
        COALESCE(y.metric_array, ARRAY[]) || ARRAY[t.metric_value]
    ) = 1