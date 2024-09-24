select *
from {{ source('cta', 'follow_ups_base') }}
