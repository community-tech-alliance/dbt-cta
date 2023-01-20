{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('link_domain_ab3') }}
select
    id,
    domain,
    created_at,
    updated_at,
    cycled_out_at,
    max_usage_count,
    organization_id,
    current_usage_count,
    is_manually_disabled,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_link_domain_hashid
from {{ ref('link_domain_ab3') }}
-- link_domain from {{ source('public', '_airbyte_raw_link_domain') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

