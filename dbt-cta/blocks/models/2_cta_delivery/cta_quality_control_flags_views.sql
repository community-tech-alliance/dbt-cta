
SELECT
    *
FROM {{ source('cta', 'quality_control_flags_views_base') }}
