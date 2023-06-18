
SELECT
    *
FROM {{ source('cta', 'quality_control_phone_verification_question_translations_base') }}
;
