select *
from {{ source('cta', 'owners_base') }}
