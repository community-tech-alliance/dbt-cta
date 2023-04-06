{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('queries_ab3') }}
select
    id,
    body,
    name,
    public,
    user_id,
    temporary,
    created_at,
    query_type,
    updated_at,
    campaign_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_queries_hashid
from {{ ref('queries_ab3') }}
-- queries from {{ source('cta', '_airbyte_raw_queries') }}
where 1 = 1

