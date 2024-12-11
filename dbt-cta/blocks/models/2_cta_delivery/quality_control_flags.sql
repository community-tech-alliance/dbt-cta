select *
from {{ source('cta', 'quality_control_flags_base') }}
