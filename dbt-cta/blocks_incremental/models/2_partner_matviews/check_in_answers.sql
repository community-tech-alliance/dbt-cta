select *
from {{ source('cta', 'check_in_answers_base') }}
