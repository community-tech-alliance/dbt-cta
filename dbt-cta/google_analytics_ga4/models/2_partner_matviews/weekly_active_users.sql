
SELECT
    *
FROM  {{ source('cta', 'weekly_active_users_base') }}