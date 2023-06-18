
SELECT
    *
FROM {{ source('cta', 'event_types_base') }}
;
