{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_invoice_items_hashid',
    
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('invoice_items_ab3') }}
select
    id,
    date,
    plan,
    amount,
    object,
    period,
    invoice,
    currency,
    customer,
    livemode,
    metadata,
    quantity,
    proration,
    description,
    unit_amount,
    discountable,
    subscription,
    subscription_item,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_invoice_items_hashid
from {{ ref('invoice_items_ab3') }}
-- invoice_items from {{ source('cta', '_airbyte_raw_invoice_items') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

