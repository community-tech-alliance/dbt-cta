select *
from {{ source('cta', 'campaigns_entities_base') }}
