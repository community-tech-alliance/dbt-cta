select *
from {{ source('cta', 'tickets_base') }}
