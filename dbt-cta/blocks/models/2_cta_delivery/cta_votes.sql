
SELECT
    *
FROM {{ source('cta', 'votes_base') }}
