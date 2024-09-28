select *
from {{ source('cta', 'action_entities_base') }}
