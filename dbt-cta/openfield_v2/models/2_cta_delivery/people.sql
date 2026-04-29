select *
from {{ source('cta', 'people_base') }}
