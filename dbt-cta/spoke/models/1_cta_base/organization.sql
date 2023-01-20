{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('organization_ab3') }}
select
    id,
    name,
    uuid,
    features,
    created_at,
    deleted_at,
    deleted_by,
    updated_at,
    autosending_mps,
    texting_hours_end,
    default_texting_tz,
    texting_hours_start,
    monthly_message_limit,
    texting_hours_enforced,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_organization_hashid
from {{ ref('organization_ab3') }}
-- organization from {{ source('public', '_airbyte_raw_organization') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

