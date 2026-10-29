select *
from {{ source('cta', 'refvalues_base') }}
