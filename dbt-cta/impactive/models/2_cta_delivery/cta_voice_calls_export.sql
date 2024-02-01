select
    last_any_error_at,
    selected_voterbase_id,
    user_last_name,
    created_at,
    type,
    contact_id,
    duration,
    van_id,
    user_first_name,
    updated_at,
    call_count,
    activity_id,
    no_answer_count,
    activity_published_at,
    id,
    aasm_state,
    first_name,
    campaign_id,
    activity_title,
    user_email,
    twilio_answered_by,
    last_busy_status_at,
    last_name,
    busy_count,
    answered_at,
    exported_at,
    queue_time,
    last_no_answer_status_at,
    user_id,
    _airbyte_emitted_at,
    _airbyte_voice_calls_export_hashid
from {{ source('cta','voice_calls_export_base') }}