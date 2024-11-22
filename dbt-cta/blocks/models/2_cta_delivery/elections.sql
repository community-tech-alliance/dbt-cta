select *
from {{ source('cta', 'elections_base') }}
