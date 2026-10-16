select *
from {{ source('cta', 'action_facts_base') }}
