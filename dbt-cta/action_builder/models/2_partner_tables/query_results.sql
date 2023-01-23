select
    id,
    results,
    query_id,
    created_at,
    updated_at
from {{ source('cta','query_results_base') }}
