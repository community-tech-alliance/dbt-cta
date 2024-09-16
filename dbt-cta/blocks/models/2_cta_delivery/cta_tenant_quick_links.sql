select *
from {{ source('cta', 'tenant_quick_links_base') }}
