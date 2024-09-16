select *
from {{ source('cta', 'participants_base') }}
