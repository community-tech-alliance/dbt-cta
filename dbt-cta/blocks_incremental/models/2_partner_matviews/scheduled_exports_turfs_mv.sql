
SELECT
    *
FROM  {{ source('cta', 'scheduled_exports_turfs_base') }}