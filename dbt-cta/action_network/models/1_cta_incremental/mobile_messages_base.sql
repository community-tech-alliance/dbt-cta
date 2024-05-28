{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_messages_ab4') }}
select
    id,
    body,
    uuid,
    stats,
    hidden,
    status,
    user_id,
    group_id,
    tag_list,
    media_url,
    permalink,
    send_date,
    timezones,
    created_at,
    is_sending,
    total_sent,
    updated_at,
    finish_send,
    delivered_at,
    actions_count,
    first_permalink,
    administrative_title,
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_messages_hashid
from {{ ref('mobile_messages_ab4') }}
