select *
from {{ source('cta', 'campaigns_people_base') }}
