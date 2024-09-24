select *
from {{ source('cta', 'email_events_base') }}
