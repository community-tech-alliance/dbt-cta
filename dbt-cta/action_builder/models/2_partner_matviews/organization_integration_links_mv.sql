select *
from {{ source('cta', 'organization_integration_links_base') }}
