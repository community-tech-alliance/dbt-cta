{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_line_items_ab3') }}
select
    id,
    plan,
    type,
    amount,
    object,
    period,
    invoice,
    currency,
    livemode,
    metadata,
    quantity,
    proration,
    invoice_id,
    description,
    discountable,
    invoice_item,
    subscription,
    subscription_item,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_invoice_line_items_hashid
from {{ ref('invoice_line_items_ab3') }}
-- invoice_line_items from {{ source('stripe_partner_a', '_airbyte_raw_invoice_line_items') }}
where 1 = 1

