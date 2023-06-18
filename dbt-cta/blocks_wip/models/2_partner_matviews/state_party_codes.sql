
SELECT
    *
FROM {{ source('cta', 'state_party_codes_base') }}
;
