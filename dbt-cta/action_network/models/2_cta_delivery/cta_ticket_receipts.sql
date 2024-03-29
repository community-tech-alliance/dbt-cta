select
    id,
    city,
    email,
    phone,
    state,
    amount,
    address,
    country,
    is_comp,
    is_free,
    payer_id,
    tag_list,
    zip_code,
    last_name,
    created_at,
    first_name,
    tip_amount,
    updated_at,
    checkout_id,
    custom_amount,
    custom_fields,
    checkout_status,
    stripe_charge_id,
    wepay_account_id,
    stripe_account_id,
    ticketed_event_id,
    originating_system,
    _airbyte_ticket_receipts_hashid
from {{ source('cta','ticket_receipts_base') }}
