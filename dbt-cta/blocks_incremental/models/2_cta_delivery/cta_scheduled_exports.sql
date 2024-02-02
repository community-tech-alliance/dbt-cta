select *
from {{ source('cta', 'scheduled_exports_base') }}
