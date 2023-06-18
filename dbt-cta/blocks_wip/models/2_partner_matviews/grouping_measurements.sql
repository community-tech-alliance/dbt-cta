
SELECT
    *
FROM {{ source('cta', 'grouping_measurements_base') }}
