select *
from {{ source('cta', 'core_callaction_checked_base') }}
