select *
from {{ source('cta', 'core_action_base') }}
