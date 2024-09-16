select *
from {{ source('cta', 'shifts_base') }}
