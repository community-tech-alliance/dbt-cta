select
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    third_parties_emails,
    notificate_third_parties,
    _airbyte_notification_settings_hashid
from {{ ref('notification_settings_base') }}