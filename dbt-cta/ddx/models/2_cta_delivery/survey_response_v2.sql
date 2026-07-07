select *
from {{ source('cta','survey_response_v2_base') }}
