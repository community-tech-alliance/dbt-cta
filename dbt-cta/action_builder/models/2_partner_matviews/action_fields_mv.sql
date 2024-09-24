select *
from {{ source('cta', 'action_fields_base') }}
