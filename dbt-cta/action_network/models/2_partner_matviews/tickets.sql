select
    id,
    price,
    title,
    total,
    hidden,
    available,
    created_at,
    updated_at,
    description,
    ticketed_event_id,
    _airbyte_tickets_hashid
from {{ ref('tickets_base') }}