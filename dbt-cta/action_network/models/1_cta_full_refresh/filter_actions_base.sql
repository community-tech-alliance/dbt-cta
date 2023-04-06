{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('filter_actions_ab3') }}
select
    id,
    user_id,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    network_group_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_filter_actions_hashid
from {{ ref('filter_actions_ab3') }}
-- filter_actions from {{ source('cta', '_airbyte_raw_filter_actions') }}
where 1 = 1

