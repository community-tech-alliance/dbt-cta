select *
from {{ source('cta', 'event_attendees_base') }}
