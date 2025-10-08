select *
from {{ source('cta', 'events_emailbodylog_base') }}
