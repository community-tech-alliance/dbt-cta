
SELECT
    *
FROM {{ source('cta', 'tags_base') }}
;
