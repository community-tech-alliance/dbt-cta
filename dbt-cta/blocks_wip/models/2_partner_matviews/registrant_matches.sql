
SELECT
    *
FROM {{ source('cta', 'registrant_matches_base') }}
;
