{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('external_system_ab3') }}
select
    id,
    name,
    type,
    username,
    synced_at,
    created_at,
    updated_at,
    api_key_ref,
    organization_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_external_system_hashid
from {{ ref('external_system_ab3') }}
-- external_system from {{ source('public', '_airbyte_raw_external_system') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

