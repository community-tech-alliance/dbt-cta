select *
from {{ source('cta', 'lists_people_base') }}
