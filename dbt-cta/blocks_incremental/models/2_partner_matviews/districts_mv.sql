select *
from {{ source('cta', 'districts_base') }}
