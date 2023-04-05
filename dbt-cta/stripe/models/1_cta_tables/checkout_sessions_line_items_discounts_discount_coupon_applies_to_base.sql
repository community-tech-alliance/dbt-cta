{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_discounts_discount_coupon_applies_to_ab3') }}
select
    _airbyte_coupon_hashid,
    products,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_applies_to_hashid
from {{ ref('checkout_sessions_line_items_discounts_discount_coupon_applies_to_ab3') }}
-- applies_to at checkout_sessions_line_items/discounts/discount/coupon/applies_to from {{ ref('checkout_sessions_line_items_discounts_discount_coupon_base') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

