select *
from {{ source('cta', 'action_assignment_groups_base') }}
