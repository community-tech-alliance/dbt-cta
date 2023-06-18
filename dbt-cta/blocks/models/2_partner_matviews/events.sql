
SELECT
    *
FROM {{ source('cta', 'events_base') }}
