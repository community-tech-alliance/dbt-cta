select *
from {{ source('cta', 'events_eventfield_base') }}
