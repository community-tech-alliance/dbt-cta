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
    administrative_title
from {{ source('cta','mobile_messages_base') }}