select *
from {{ source('cta', 'activity_events_base') }}
