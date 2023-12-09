
SELECT
    *
FROM  {{ source('cta', 'traffic_acquisition_session_source_report_base') }}