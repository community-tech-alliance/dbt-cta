select *
from {{ source('cta', 'meetings_base') }}
