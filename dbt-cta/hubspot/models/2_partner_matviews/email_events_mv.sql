
SELECT
    *
FROM  {{ source('cta', 'email_events_base') }}