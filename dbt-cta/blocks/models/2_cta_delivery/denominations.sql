select *
from {{ source('cta', 'denominations_base') }}
