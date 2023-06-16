{{ config(
    cluster_by = ["_airbyte_emitted_at"],
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id",
    tags = [ "top-level" ]
) }}

-- Final base SQL model
-- depends_on: {{ ref('tenant_quick_links_ab3') }}
select
    tenant_id,
    updated_at,
    created_at,
    id,
    quick_link_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tenant_quick_links_hashid
from {{ ref('tenant_quick_links_ab3') }}
-- tenant_quick_links from {{ source('sv_blocks', '_airbyte_raw_tenant_quick_links') }}

