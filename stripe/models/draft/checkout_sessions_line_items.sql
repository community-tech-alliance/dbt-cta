{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_ab3') }}
select
    id,
    price,
    taxes,
    object,
    currency,
    quantity,
    discounts,
    description,
    amount_total,
    amount_subtotal,
    checkout_session_id,
    checkout_session_expires_at,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_checkout_sessions_line_items_hashid
from {{ ref('checkout_sessions_line_items_ab3') }}
-- checkout_sessions_line_items from {{ source('stripe_partner_a', '_airbyte_raw_checkout_sessions_line_items') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

