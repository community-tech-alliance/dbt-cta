select
    id,
    stats,
    header,
    email_id,
    created_at,
    total_sent,
    updated_at,
    actions_count
from {{ source('cta','email_stats_base') }}