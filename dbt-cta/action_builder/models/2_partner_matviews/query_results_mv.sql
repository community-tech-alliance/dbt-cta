select *
from {{ source('cta', 'query_results_base') }}
