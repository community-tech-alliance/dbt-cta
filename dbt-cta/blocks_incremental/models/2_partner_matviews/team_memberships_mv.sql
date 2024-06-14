select *
from {{ source('cta', 'team_memberships_base') }}
