select *
from {{ source('cta', 'core_eventmoderateaction_base') }}
