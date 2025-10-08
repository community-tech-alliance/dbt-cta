select *
from {{ source('cta', 'events_eventsignup_base') }}
