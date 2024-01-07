
SELECT
    *
FROM  {{ source('cta', 'scans_qc_overview_base') }}