select *
from {{ source('cta', 'projections_base') }}
