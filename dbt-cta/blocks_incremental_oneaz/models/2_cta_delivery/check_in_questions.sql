select *
from {{ source('cta', 'check_in_questions_base') }}
