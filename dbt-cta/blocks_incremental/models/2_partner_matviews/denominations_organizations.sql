select *
from {{ source('cta', 'denominations_organizations_base') }}
