select
    id,
    stats,
    header,
    email_id,
    created_at,
    total_sent,
    updated_at,
    actions_count,
    _airbyte_email_stats_hashid
from {{ source('cta','email_stats_base') }}