
SELECT
    *
FROM {{ source('cta', 'scheduled_exports_base') }}
