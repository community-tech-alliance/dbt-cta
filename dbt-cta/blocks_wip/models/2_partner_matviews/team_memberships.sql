
SELECT
    *
FROM {{ source('cta', 'team_memberships_base') }}
;
