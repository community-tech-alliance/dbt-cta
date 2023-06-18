
SELECT
    *
FROM {{ source('cta', 'petitions_signatures_base') }}
