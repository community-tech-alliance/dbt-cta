select *
from {{ source('cta', 'entities_base') }}
