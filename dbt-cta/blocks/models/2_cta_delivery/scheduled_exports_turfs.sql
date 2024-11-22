select *
from {{ source('cta', 'scheduled_exports_turfs_base') }}
