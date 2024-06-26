select *
from {{ source('cta', 'schedules_base') }}
