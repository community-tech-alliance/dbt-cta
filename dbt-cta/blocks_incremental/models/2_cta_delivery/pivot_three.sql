select *
from {{ source('cta', 'pivot_three_base') }}
