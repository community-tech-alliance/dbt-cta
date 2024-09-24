select *
from {{ source('cta', 'counties_base') }}
