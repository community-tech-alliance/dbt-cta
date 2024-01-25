{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('tenant_blocks_ab3') }}
select
    tenant_id,
    updated_at,
    created_at,
    id,
    block_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    _airbyte_normalized_at,
    _airbyte_tenant_blocks_hashid
from {{ ref('tenant_blocks_ab3') }}
