{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('customers_discount_coupon_ab3') }}
select
    _airbyte_discount_hashid,
    id,
    name,
    valid,
    object,
    created,
    currency,
    duration,
    livemode,
    metadata,
    redeem_by,
    amount_off,
    percent_off,
    times_redeemed,
    max_redemptions,
    duration_in_months,
    percent_off_precise,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_coupon_hashid
from {{ ref('customers_discount_coupon_ab3') }}
-- coupon at customers/discount/coupon from {{ ref('customers_discount') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

