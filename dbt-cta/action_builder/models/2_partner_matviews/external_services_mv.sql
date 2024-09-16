select *
from {{ source('cta', 'external_services_base') }}
