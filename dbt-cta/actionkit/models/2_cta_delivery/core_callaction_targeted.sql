select *
from {{ source('cta', 'core_callaction_targeted_base') }}
