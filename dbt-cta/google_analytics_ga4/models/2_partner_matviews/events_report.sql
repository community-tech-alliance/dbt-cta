
SELECT
    *
FROM  {{ source('cta', 'events_report_base') }}