select
    id,
    amount,
    quantity,
    ticket_id,
    created_at,
    updated_at,
    ticket_price,
    ticket_receipt_id,
    _airbyte_user_tickets_hashid
from {{ ref('user_tickets_base') }}