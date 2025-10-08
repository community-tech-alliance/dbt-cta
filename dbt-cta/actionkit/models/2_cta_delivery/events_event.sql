select *
from {{ source('cta', 'events_event_base') }}
