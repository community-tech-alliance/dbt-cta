
SELECT
    *
FROM  {{ source('cta', 'missing_fks_base') }}