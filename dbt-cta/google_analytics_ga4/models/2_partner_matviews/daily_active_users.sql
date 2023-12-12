
SELECT
    *
FROM  {{ source('cta', 'daily_active_users_base') }}