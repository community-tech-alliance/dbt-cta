
SELECT
    *
FROM {{ source('cta', 'address_districts_base') }}
