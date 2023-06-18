
SELECT
    *
FROM {{ source('cta', 'events_teams_base') }}
;
