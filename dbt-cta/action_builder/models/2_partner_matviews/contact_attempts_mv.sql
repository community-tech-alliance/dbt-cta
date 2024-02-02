
SELECT
    *
FROM  {{ source('cta', 'contact_attempts_base') }}