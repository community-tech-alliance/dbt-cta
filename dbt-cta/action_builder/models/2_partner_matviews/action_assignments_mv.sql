select *
from {{ source('cta', 'action_assignments_base') }}
