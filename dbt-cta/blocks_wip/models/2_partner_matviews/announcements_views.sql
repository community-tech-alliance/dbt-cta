
SELECT
    *
FROM {{ source('cta', 'announcements_views_base') }}
