
SELECT
    *
FROM {{ source('cta', 'schedules_base') }}
