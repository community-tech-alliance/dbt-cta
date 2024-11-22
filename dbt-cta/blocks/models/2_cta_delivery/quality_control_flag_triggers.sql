select *
from {{ source('cta', 'quality_control_flag_triggers_base') }}
