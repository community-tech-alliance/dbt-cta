select
    _airbyte_emitted_at,
    id,
    action_id,
    created_at,
    updated_at,
    action_type,
    third_parties_emails,
    notificate_third_parties
from {{ source('cta','notification_settings_base') }}