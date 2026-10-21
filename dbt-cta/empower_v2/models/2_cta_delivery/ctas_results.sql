select *
from {{ source('cta', 'ctas_results_base') }}
