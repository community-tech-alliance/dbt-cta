
SELECT
    *
FROM {{ source('cta', 'organizations_base') }}
;
