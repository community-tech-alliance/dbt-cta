select *
from {{ source('cta', 'events_customemail_base') }}
