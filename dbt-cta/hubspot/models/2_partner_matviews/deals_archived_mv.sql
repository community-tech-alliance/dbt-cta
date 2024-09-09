
SELECT
    *
FROM  {{ source('cta', 'deals_archived_base') }}