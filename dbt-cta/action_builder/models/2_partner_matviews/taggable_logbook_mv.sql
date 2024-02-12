
SELECT
    *
FROM  {{ source('cta', 'taggable_logbook_base') }}