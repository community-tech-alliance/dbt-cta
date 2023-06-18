
SELECT
    *
FROM {{ source('cta', 'event_shifts_base') }}
