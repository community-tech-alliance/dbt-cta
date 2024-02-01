select *
from {{ source('cta', 'locations_organizations_base') }}
