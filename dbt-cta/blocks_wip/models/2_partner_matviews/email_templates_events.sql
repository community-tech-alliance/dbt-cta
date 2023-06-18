
SELECT
    *
FROM {{ source('cta', 'email_templates_events_base') }}
;
