
SELECT
    *
FROM {{ source('cta', 'public_event_links_base') }}
;
