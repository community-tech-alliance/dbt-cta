{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_messages_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_messages_hashid
from {{ ref('sms_messages_ab3') }}
-- sms_messages from {{ source('cta', '_airbyte_raw_sms_messages') }}
where 1 = 1

