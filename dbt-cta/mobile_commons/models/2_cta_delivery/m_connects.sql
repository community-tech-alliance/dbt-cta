select *
from {{ source('cta', 'm_connects_base') }}
