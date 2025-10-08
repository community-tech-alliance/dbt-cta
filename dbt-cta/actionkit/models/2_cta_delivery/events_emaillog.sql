select *
from {{ source('cta', 'events_emaillog_base') }}
