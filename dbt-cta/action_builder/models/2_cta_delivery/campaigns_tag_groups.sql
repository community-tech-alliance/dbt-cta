select *
from {{ source('cta', 'campaigns_tag_groups_base') }}
