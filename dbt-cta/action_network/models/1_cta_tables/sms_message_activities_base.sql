{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_message_activities_ab3') }}
select
    id,
    link,
    links,
    link_id,
    user_id,
    group_id,
    created_at,
    updated_at,
    action_type,
    recipient_id,
    mobile_message_id,
    twilio_message_id,
    mobile_message_stat_id,
    mobile_message_field_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_message_activities_hashid
from {{ ref('sms_message_activities_ab3') }}
-- sms_message_activities from {{ source('cta', '_airbyte_raw_sms_message_activities') }}
where 1 = 1
