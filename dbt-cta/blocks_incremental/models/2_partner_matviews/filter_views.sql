
SELECT
    *
FROM {{ source('cta', 'filter_views_base') }}
