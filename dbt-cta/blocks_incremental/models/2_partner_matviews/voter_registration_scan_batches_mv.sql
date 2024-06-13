
SELECT
    *
FROM  {{ source('cta', 'voter_registration_scan_batches_base') }}