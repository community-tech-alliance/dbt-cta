select
    _airbyte_emitted_at,
    id,
    link_id,
    user_id,
    email_id,
    group_id,
    created_at,
    subject_id,
    updated_at,
    action_type,
    recipient_id,
    email_stat_id
from {{ source('cta','email_activities_9_base') }}