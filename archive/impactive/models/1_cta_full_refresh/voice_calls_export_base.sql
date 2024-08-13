{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 2 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 3 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 4 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 5 day), day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 6 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('voice_calls_export_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_voice_calls_export_hashid
from {{ ref('voice_calls_export_ab3') }}
-- voice_calls_export from {{ source('cta', '_airbyte_raw_voice_calls_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}