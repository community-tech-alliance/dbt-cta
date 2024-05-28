{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('sms_message_activities_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_sms_message_activities_hashid
from {{ ref('sms_message_activities_ab4') }}