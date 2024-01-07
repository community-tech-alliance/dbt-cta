
SELECT
    *
FROM  {{ source('cta', 'event_attendees_base') }}