select *
from {{ source('cta', 'import_lcv_base') }}
