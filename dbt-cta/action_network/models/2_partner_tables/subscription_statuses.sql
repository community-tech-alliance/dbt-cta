select
    _airbyte_emitted_at,
    id,
    status,
    user_id,
    group_id,
    join_date,
    created_at,
    updated_at,
    subscriber_id,
    source_action_id,
    source_action_type
from {{ source('cta','subscription_statuses_base') }}