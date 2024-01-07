select *
from {{ source('cta', 'denominations_people_base') }}
