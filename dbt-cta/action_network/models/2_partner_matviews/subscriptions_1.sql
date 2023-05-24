select
    id,
    amount,
    status,
    user_id,
    group_id,
    new_user,
    processed,
    created_at,
    salesforce,
    updated_at,
    source_code,
    http_referer,
    custom_fields,
    salesforce_id,
    subscriber_id,
    user_action_id,
    network_group_id,
    source_action_id,
    source_action_type,
    _airbyte_subscriptions_1_hashid
from {{ ref('subscriptions_1_base') }}