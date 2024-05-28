{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_messages_ab4') }}
select
    id,
    {{ adapter.quote('to') }},
    {{ adapter.quote('from') }},
    read,
    flagged,
    message,
    user_id,
    group_id,
    created_at,
    updated_at,
    message_type,
    twilio_message_id,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_messages_hashid
from {{ ref('sms_messages_ab4') }}