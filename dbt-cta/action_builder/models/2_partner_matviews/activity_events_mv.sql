
SELECT
    *
FROM  {{ source('cta', 'activity_events_base') }}