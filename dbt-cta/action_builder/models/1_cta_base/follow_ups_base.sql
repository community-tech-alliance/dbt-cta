{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('follow_ups_ab3') }}
select
    id,
    entity_id,
    created_at,
    updated_at,
    campaign_id,
    completed_at,
    created_by_id,
    completed_by_id,
    assigned_user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_follow_ups_hashid
from {{ ref('follow_ups_ab3') }}
-- follow_ups from {{ source('cta', '_airbyte_raw_follow_ups') }}
where 1 = 1

