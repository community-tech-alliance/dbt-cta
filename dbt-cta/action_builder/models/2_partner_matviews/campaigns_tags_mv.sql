select *
from {{ source('cta', 'campaigns_tags_base') }}
