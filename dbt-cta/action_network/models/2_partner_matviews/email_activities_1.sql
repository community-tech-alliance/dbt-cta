select
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
    email_stat_id,
    _airbyte_email_activities_1_hashid
from {{ ref('email_activities_1_base') }}