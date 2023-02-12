{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('mobile_messages_ab3') }}
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
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_mobile_messages_hashid
from {{ ref('mobile_messages_ab3') }}
-- mobile_messages from {{ source('cta', '_airbyte_raw_mobile_messages') }}
where 1 = 1
