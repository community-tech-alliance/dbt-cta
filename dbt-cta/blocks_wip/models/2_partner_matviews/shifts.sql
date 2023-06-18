
SELECT
    *
FROM {{ source('cta', 'shifts_base') }}
;
