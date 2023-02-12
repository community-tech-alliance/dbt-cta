{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('api_keys_ab3') }}
select
    id,
    target,
    api_key,
    created_at,
    revoked_at,
    updated_at,
    created_by_id,
    revoked_by_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_api_keys_hashid
from {{ ref('api_keys_ab3') }}
-- api_keys from {{ source('cta', '_airbyte_raw_api_keys') }}
where 1 = 1
