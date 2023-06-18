
SELECT
    *
FROM {{ source('cta', 'announcements_base') }}
;
