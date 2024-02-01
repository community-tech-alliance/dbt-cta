select *
from {{ source('cta', 'lists_base') }}
