
SELECT
    *
FROM  {{ source('cta', 'customer_profiles_base') }}