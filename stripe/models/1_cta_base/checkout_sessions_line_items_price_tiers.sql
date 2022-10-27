{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('checkout_sessions_line_items_price_tiers_ab3') }}
select
    _airbyte_price_hashid,
    up_to,
    flat_amount,
    unit_amount,
    flat_amount_decimal,
    unit_amount_decimal,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_tiers_hashid
from {{ ref('checkout_sessions_line_items_price_tiers_ab3') }}
-- tiers at checkout_sessions_line_items/price/tiers from {{ ref('checkout_sessions_line_items_price') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

