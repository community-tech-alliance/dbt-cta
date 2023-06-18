
SELECT
    *
FROM {{ source('cta', 'phone_verification_questions_base') }}
;
