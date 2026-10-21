select *
from {{ source('cta', 'ctas_results_answers_base') }}
