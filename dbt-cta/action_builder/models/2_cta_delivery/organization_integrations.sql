select *
from {{ source('cta', 'organization_integrations_base') }}
