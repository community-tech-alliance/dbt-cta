select *
from {{ source('cta', 'timeline_events_base') }}
