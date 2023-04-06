{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('collections_ab3') }}
select
    id,
    title,
    group_id,
    created_at,
    network_id,
    updated_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_collections_hashid
from {{ ref('collections_ab3') }}
-- collections from {{ source('cta', '_airbyte_raw_collections') }}
where 1 = 1

