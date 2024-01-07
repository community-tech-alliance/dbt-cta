
SELECT
    *
FROM  {{ source('cta', 'organization_memberships_base') }}