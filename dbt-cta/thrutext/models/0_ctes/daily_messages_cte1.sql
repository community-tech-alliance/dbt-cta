{{ config(
    cluster_by = "timestamp",
    partition_by = {"field": "timestamp", "data_type": "timestamp", "granularity": "day"}
) }}

select
    timestamp,
    message_id,
    message_direction,
    message_body,
    sender_first_name,
    sender_last_name,
    sender_phone,
    sender_email,
    campaign_id,
    campaign_name,
    conversation_id,
    conversation_phone,
    contact_id,
    contact_first_name,
    contact_last_name,
    contact_phone,
    media_content,
    message_segment_count,
    message_error,
    "Polling Location" as polling_location,
    van_campaign_id,
    van_id,
   {{ dbt_utils.surrogate_key([
    'message_id',
    'conversation_id',
    'campaign_id',
    'contact_id',
    'van_id',
    'van_campaign_id'
    ]) }} as _daily_messages_hashid
from {{ source('cta', '_stg_daily_messages') }}
