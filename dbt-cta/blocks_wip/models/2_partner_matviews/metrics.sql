
SELECT
    *
FROM {{ source('cta', 'metrics_base') }}
