{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    schema = "stripe_partner_a",
    tags = [ "nested" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('promotion_codes_coupon_ab3') }}
select
    _airbyte_promotion_codes_hashid,
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
    applies_to,
    percent_off,
    times_redeemed,
    max_redemptions,
    duration_in_months,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_coupon_hashid
from {{ ref('promotion_codes_coupon_ab3') }}
-- coupon at promotion_codes/coupon from {{ ref('promotion_codes') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at', this) }}

