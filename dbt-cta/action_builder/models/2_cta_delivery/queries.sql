select *
from {{ source('cta', 'queries_base') }}
