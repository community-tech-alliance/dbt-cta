
SELECT
    *
FROM  {{ source('cta', 'entity_sync_cursors_base') }}