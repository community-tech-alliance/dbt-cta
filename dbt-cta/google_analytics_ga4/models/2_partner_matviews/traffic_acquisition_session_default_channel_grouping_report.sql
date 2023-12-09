
SELECT
    *
FROM  {{ source('cta', 'traffic_acquisition_session_default_channel_grouping_report_base') }}