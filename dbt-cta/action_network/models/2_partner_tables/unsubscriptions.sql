select
    id,
    reason,
    user_id,
    email_id,
    group_id,
    new_user,
    processed,
    created_at,
    subject_id,
    updated_at,
    source_code,
    http_referer,
    custom_fields,
    subscriber_id,
    source_action_id,
    source_action_type
from {{ source('cta','unsubscriptions_base') }}