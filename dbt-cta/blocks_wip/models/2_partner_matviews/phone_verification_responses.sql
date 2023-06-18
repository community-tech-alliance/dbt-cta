
SELECT
    *
FROM {{ source('cta', 'phone_verification_responses_base') }}
;
