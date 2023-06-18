
SELECT
    *
FROM {{ source('cta', 'twilio_calls_base') }}
;
