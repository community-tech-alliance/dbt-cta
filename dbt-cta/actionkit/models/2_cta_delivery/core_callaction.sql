select *
from {{ source('cta', 'core_callaction_base') }}
