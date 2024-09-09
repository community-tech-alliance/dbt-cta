
SELECT
    *
FROM  {{ source('cta', 'line_items_base') }}