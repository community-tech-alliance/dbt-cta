select *
from {{ source('cta', 'questions_base') }}
