
SELECT
    *
FROM  {{ source('cta', 'quality_control_phone_verification_calls_base') }}