
SELECT
    *
FROM {{ source('cta', 'quality_control_comments_users_base') }}
