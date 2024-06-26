{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('group_growth_by_source_actions_ab4') }}
select
    id,
    end_at,
    group_id,
    start_at,
    created_at,
    updated_at,
    total_count,
    new_users_count,
    source_action_id,
    source_action_type,
    last_subscription_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_group_growth_by_source_actions_hashid
from {{ ref('group_growth_by_source_actions_ab4') }}
