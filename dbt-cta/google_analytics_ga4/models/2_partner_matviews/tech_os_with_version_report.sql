
SELECT
    *
FROM  {{ source('cta', 'tech_os_with_version_report_base') }}