{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_ab3') }}
select
    _airbyte_discounts_hashid,
    id,
    {{ adapter.quote('end') }},
    start,
    coupon,
    object,
    invoice,
    customer,
    invoice_item,
    subscription,
    promotion_code,
    checkout_session,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_discount_hashid
from {{ ref('checkout_sessions_line_items_discounts_discount_ab3') }}
-- discount at checkout_sessions_line_items/discounts/discount from {{ ref('checkout_sessions_line_items_discounts_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

