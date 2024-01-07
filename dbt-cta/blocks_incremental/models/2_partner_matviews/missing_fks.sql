select *
from {{ source('cta', 'missing_fks_base') }}
