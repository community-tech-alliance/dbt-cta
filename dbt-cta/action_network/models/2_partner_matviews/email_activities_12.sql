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
    _airbyte_email_activities_12_hashid
from {{ source('cta','email_activities_12_base') }}