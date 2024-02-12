
SELECT
    *
FROM  {{ source('cta', 'electoral_districts_base') }}