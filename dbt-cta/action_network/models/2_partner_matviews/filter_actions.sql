select
    id,
    user_id,
    group_id,
    action_id,
    created_at,
    updated_at,
    action_type,
    network_group_id,
    _airbyte_filter_actions_hashid
from {{ ref('filter_actions_base') }}