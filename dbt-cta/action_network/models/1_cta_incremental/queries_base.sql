{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('queries_ab4') }}
select
    id,
    name,
    uuid,
    params,
    user_id,
    group_id,
    created_at,
    creator_id,
    updated_at,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_queries_hashid
from {{ ref('queries_ab4') }}
