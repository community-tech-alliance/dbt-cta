select *
from {{ source('cta', 'campaigns_base') }}
