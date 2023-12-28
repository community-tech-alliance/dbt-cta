select *
from {{ source('cta', 'venues_base') }}
