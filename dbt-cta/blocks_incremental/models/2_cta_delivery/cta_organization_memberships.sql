select *
from {{ source('cta', 'organization_memberships_base') }}
