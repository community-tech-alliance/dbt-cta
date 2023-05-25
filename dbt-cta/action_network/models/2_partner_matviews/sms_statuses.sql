select
    id,
    status,
    user_id,
    group_id,
    join_date,
    created_at,
    updated_at,
    subscriber_id,
    source_action_id,
    source_action_type,
    _airbyte_sms_statuses_hashid
from {{ ref('sms_statuses_base') }}