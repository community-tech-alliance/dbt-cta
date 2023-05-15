select
    _airbyte_emitted_at,
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
    last_subscription_id
from {{ source('cta','group_growth_by_source_actions_base') }}