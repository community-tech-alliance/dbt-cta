select
    id,
    reason,
    user_id,
    owner_id,
    processed,
    source_id,
    created_at,
    owner_type,
    updated_at,
    source_type,
    mobile_message_stat_id
from {{ source('cta','sms_unsubscriptions_base') }}