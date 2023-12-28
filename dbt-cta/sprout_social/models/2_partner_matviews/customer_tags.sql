
SELECT
    *
FROM  {{ source('cta', 'customer_tags_base') }}