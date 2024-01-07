select *
from {{ source('cta', 'teachers_base') }}
