{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('tag_ab3') }}
select
    is_deleted,
    updated_at,
    organization_id,
    name,
    created_at,
    description,
    id,
    {{ adapter.quote('group') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tag_hashid
from {{ ref('tag_ab3') }}
-- tag from {{ source('cta', '_airbyte_raw_tag') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}
