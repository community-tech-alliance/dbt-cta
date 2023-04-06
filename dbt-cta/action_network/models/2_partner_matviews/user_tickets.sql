select
    id,
    amount,
    quantity,
    ticket_id,
    created_at,
    updated_at,
    ticket_price,
    ticket_receipt_id
from {{ source('cta','user_tickets_base') }}