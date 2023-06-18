
SELECT
    *
FROM {{ source('cta', 'voter_registration_scans_base') }}
;
