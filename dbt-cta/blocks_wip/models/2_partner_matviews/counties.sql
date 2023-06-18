
SELECT
    *
FROM {{ source('cta', 'counties_base') }}
;
