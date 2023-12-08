
SELECT
    *
FROM  {{ source('cta', 'traffic_acquisition_session_source_platform_report_base') }}