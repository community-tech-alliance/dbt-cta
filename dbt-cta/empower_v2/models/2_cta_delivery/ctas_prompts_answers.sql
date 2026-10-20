select *
from {{ source('cta', 'ctas_prompts_answers_base') }}
