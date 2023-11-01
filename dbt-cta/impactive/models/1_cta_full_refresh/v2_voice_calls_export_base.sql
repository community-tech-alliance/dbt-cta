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
-- depends_on: {{ ref('v2_voice_calls_export_ab3') }}
select
    selected_voterbase_id,
    user_last_name,
    created_at,
    source,
    contact_id,
    duration,
    reference,
    van_id,
    user_first_name,
    updated_at,
    stopped_reason,
    reported,
    activity_id,
    activity_published_at,
    id,
    stopped_at,
    first_name,
    campaign_id,
    activity_title,
    user_email,
    twilio_answered_by,
    last_name,
    answered_at,
    exported_at,
    pdi_id,
    phone,
    user_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_v2_voice_calls_export_hashid
from {{ ref('v2_voice_calls_export_ab3') }}
-- v2_voice_calls_export from {{ source('cta', '_airbyte_raw_v2_voice_calls_export') }}

{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(",") }})
{% endif %}