select *
from {{ source('cta', 'engagements_meetings_base') }}
