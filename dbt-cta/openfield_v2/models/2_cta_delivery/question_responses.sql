select *
from {{ source('cta', 'question_responses_base') }}
