select *
from {{ source('cta', 'event_types_base') }}
