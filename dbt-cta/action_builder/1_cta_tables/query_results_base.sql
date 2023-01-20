{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('query_results_ab3') }}
select
    id,
    results,
    query_id,
    created_at,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_query_results_hashid
from {{ ref('query_results_ab3') }}
-- query_results from {{ source('cta', '_airbyte_raw_query_results') }}
where 1 = 1

