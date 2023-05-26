select
    id,
    status,
    user_id,
    group_id,
    new_user,
    processed,
    created_at,
    sms_opt_in,
    updated_at,
    subscriber_id,
    subscription_id,
    _airbyte_sms_status_logs_hashid
from {{ source('cta','sms_status_logs_base') }}