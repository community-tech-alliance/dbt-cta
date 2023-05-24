select
    id,
    link,
    links,
    link_id,
    user_id,
    group_id,
    created_at,
    updated_at,
    action_type,
    recipient_id,
    mobile_message_id,
    twilio_message_id,
    mobile_message_stat_id,
    mobile_message_field_id,
    _airbyte_sms_message_activities_hashid
from {{ ref('sms_message_activities_base') }}