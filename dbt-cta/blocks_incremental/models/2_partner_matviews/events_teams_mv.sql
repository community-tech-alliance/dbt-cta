select *
from {{ source('cta', 'events_teams_base') }}
