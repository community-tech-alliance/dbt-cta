
SELECT
    *
FROM  {{ source('cta', 'weekly_events_report_base') }}