
SELECT
    *
FROM  {{ source('cta', 'traffic_acquisition_session_medium_report_base') }}