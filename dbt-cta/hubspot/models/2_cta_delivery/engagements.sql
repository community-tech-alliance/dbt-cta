select *
from {{ source('cta', 'engagements_base') }}
