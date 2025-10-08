select *
from {{ source('cta', 'core_eventcreateaction_base') }}
