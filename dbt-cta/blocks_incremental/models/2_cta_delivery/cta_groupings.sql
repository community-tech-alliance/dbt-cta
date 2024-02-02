select *
from {{ source('cta', 'groupings_base') }}
