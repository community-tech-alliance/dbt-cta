
SELECT
    *
FROM {{ source('cta', 'taggings_base') }}
