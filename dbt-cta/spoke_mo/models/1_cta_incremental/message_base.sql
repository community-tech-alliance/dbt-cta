{% set partitions_to_replace = [
    'timestamp_trunc(current_timestamp, day)',
    'timestamp_trunc(timestamp_sub(current_timestamp, interval 1 day), day)'
] %}
{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "_airbyte_ab_id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('message_ab3') }}
select
    is_from_contact,
    campaign_contact_id,
    queued_at,
    created_at,
    media,
    send_before,
    contact_number,
    user_number,
    sent_at,
    assignment_id,
    user_id,
    service,
    service_id,
    send_status,
    messageservice_sid,
    error_code,
    id,
    text,
    service_response_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_message_hashid
from {{ ref('message_ab3') }}
-- message from {{ source('cta', '_airbyte_raw_message') }}
{% if is_incremental() %}
where timestamp_trunc(_airbyte_emitted_at, day) in ({{ partitions_to_replace | join(',') }})
{% endif %}

