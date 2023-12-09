
SELECT
    *
FROM  {{ source('cta', 'traffic_acquisition_session_source_medium_report_base') }}