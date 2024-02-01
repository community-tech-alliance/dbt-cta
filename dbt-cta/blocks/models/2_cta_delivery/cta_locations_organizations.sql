
SELECT
    *
FROM {{ source('cta', 'locations_organizations_base') }}
