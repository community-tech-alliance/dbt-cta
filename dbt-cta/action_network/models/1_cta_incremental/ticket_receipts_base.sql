{{ config(
    cluster_by = "_airbyte_extracted_at",
    partition_by = {"field": "_airbyte_extracted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = "id"
) }}
-- Final base SQL model
-- depends_on: {{ ref('ticket_receipts_ab4') }}
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
    _airbyte_raw_id,
    _airbyte_extracted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_ticket_receipts_hashid
from {{ ref('ticket_receipts_ab4') }}
