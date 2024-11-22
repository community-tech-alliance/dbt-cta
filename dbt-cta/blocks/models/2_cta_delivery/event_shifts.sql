select *
from {{ source('cta', 'event_shifts_base') }}
