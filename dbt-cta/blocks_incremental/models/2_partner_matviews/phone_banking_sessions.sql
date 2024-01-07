
SELECT
    *
FROM  {{ source('cta', 'phone_banking_sessions_base') }}