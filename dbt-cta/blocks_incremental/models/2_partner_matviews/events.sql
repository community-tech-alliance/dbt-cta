select *
from {{ source('cta', 'events_base') }}
