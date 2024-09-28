select *
from {{ source('cta', 'shift_times_base') }}
