{% set partitions_to_replace = [
    "timestamp_trunc(current_timestamp, day)",
    "timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)"
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    partitions = partitions_to_replace,
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('messages_export_ab3') }}
select
    sender_van_id,
    receiver_selected_voterbase_id,
    receiver_id,
    created_at,
    sender_name,
    body,
    sender_selected_voterbase_id,
    sender_id,
    receiver_type,
    aasm_message,
    updated_at,
    activity_type,
    activity_id,
    receiver_name,
    activity_published_at,
    activity_script_id,
    id,
    aasm_state,
    receiver_raw,
    twilio_segments,
    campaign_id,
    activity_title,
    sender_raw,
    sender_type,
    twilio_status,
    message_type,
    script_name,
    exported_at,
    sent_at,
    received_at,
    error_code,
    script_type,
    receiver_van_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_messages_export_hashid
from {{ ref('messages_export_ab3') }}
-- messages_export from {{ source('cta', '_airbyte_raw_messages_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}