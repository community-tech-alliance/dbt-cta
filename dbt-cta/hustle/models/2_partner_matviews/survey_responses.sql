select *
from {{ source('cta','survey_responses_base') }}
