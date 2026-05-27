select *
from {{ source('cta', 'scripts_question_base') }}
