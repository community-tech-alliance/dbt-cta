
SELECT
    *
FROM  {{ source('cta', 'quality_control_flags_voter_registration_scans_base') }}