select *
from {{ source('cta','survey_response_base') }}
