select *
from {{ source('cta', 'public_event_links_base') }}
