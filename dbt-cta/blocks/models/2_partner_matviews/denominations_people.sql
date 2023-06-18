
SELECT
    *
FROM {{ source('cta', 'denominations_people_base') }}
