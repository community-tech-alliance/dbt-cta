select *
from {{ source('cta', 'campaigns_teams_base') }}
