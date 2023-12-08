
SELECT
    *
FROM  {{ source('cta', 'user_acquisition_first_user_source_platform_report_base') }}