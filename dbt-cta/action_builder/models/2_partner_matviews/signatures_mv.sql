select *
from {{ source('cta', 'signatures_base') }}
