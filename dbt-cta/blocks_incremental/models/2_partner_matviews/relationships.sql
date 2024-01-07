select *
from {{ source('cta', 'relationships_base') }}
