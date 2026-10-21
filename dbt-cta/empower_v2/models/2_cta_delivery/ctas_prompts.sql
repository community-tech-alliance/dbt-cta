select *
from {{ source('cta', 'ctas_prompts_base') }}
