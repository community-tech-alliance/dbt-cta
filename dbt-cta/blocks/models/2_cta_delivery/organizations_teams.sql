select *
from {{ source('cta', 'organizations_teams_base') }}
