
SELECT
    *
FROM  {{ source('cta', 'conversions_report_base') }}