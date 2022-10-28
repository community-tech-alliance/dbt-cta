{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "stripe_partner_a",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('coupons_ab3') }}
select
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
    _airbyte_coupons_hashid
from {{ ref('coupons_ab3') }}
-- coupons from {{ source('stripe_partner_a', '_airbyte_raw_coupons') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

