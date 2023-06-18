
SELECT
    *
FROM {{ source('cta', 'denominations_organizations_base') }}
;
