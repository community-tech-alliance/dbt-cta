
SELECT
    *
FROM {{ source('cta', 'user_profiles_base') }}
