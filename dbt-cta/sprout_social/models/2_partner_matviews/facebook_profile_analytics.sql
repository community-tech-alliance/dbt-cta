
SELECT
    *
FROM  {{ source('cta', 'facebook_profile_analytics_base') }}