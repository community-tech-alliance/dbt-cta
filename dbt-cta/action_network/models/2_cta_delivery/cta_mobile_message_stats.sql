select
    id,
    stats,
    header,
    created_at,
    updated_at,
    actions_count,
    mobile_message_id,
    mobile_message_field_id,
    _airbyte_mobile_message_stats_hashid
from {{ source('cta','mobile_message_stats_base') }}
