select *
from {{ source('cta', 'events_eventsignupfield_base') }}
