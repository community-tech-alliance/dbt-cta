select *
from {{ source('cta', 'tasks_base') }}
