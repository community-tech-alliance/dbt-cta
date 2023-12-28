
SELECT
    *
FROM  {{ source('cta', 'customer_users_base') }}