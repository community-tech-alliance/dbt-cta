select *
from {{ source('cta', 'canvassers_base') }}
