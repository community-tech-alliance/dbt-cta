select
    id,
    notes,
    stats,
    title,
    hidden,
    status,
    group_id,
    structure,
    created_at,
    creator_id,
    updated_at,
    auto_end_date,
    schedule_action,
    _airbyte_ladders_hashid
from {{ source('cta','ladders_base') }}