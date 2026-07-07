select *
from {{ source('cta', 'people_lookup_base') }}
