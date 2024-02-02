select *
from {{ source('cta','team_members_assigned_locations_base') }}
