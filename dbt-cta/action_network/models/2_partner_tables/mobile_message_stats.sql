select
    _airbyte_emitted_at,
    id,
    stats,
    header,
    created_at,
    updated_at,
    actions_count,
    mobile_message_id,
    mobile_message_field_id
from {{ source('cta','mobile_message_stats_base') }}