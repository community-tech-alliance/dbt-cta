select *
from {{ source('cta', 'survey_result_base') }}
