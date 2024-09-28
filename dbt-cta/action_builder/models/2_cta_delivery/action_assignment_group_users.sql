select *
from {{ source('cta', 'action_assignment_group_users_base') }}
