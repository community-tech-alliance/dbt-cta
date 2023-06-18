
SELECT
    *
FROM {{ source('cta', 'phone_banking_phone_banks_base') }}
