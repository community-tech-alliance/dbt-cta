{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('organization_ab3') }}
select
    features,
    texting_hours_start,
    texting_hours_enforced,
    name,
    created_at,
    texting_hours_end,
    id,
    uuid,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_hashid
from {{ ref('organization_ab3') }}
-- organization from {{ source('cta', '_airbyte_raw_organization') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

