select
    id,
    results,
    query_id,
    created_at,
    updated_at,
    _airbyte_query_results_hashid
from {{ source('cta','query_results_base') }}