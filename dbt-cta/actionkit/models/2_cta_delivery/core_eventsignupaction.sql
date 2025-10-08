select *
from {{ source('cta', 'core_eventsignupaction_base') }}
