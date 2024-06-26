select *
from {{ source('cta', 'quality_control_schedules_base') }}
