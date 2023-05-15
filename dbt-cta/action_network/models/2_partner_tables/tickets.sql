select
    _airbyte_emitted_at,
    id,
    price,
    title,
    total,
    hidden,
    available,
    created_at,
    updated_at,
    description,
    ticketed_event_id
from {{ source('cta','tickets_base') }}