
SELECT
    *
FROM  {{ source('cta', 'addresses_electoral_districts_base') }}