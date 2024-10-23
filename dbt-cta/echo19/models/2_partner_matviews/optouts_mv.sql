select *
from {{ source('cta', 'optouts_base') }}
