select
    performed_at,
    user_email,
    user_last_name,
    user_fullname,
    type,
    exported_at,
    user_first_name,
    user_id,
    activity_id,
    user_phone,
    id,
    campaign_id,
    activity_title,
    _airbyte_emitted_at,
    _airbyte_user_activity_performances_export_hashid
from {{ source('cta','user_activity_performances_export_base') }}